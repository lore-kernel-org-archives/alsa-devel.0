From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [22/29] ALSA: dice: get rate-dependent parameters
Date: Mon, 21 Oct 2013 21:33:26 +0200
Message-ID: <52658186.1080205@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In preparation for sample rate selection support, read the stream
parameters that might change when running at different sample rates.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 49b47ba..e6bba6d 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -6,10 +6,12 @@
  */

 #include <linux/compat.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/firewire.h>
 #include <linux/firewire-constants.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
@@ -37,11 +39,14 @@ struct dice {
 	unsigned int global_offset;
 	unsigned int rx_offset;
 	unsigned int clock_caps;
+	unsigned int rx_channels[3];
+	unsigned int rx_midi_ports[3];
 	struct fw_address_handler notification_handler;
 	int owner_generation;
 	int dev_lock_count; /* > 0 driver, < 0 userspace */
 	bool dev_lock_changed;
 	bool global_enabled;
+	struct completion clock_accepted;
 	wait_queue_head_t hwdep_wait;
 	u32 notification_bits;
 	struct fw_iso_resources resources;
@@ -53,15 +58,23 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");

 static const unsigned int dice_rates[] = {
+	/* mode 0 */
 	[0] =  32000,
 	[1] =  44100,
 	[2] =  48000,
+	/* mode 1 */
 	[3] =  88200,
 	[4] =  96000,
+	/* mode 2 */
 	[5] = 176400,
 	[6] = 192000,
 };

+static unsigned int rate_index_to_mode(unsigned int rate_index)
+{
+	return ((int)rate_index - 1) / 2;
+}
+
 static void dice_lock_changed(struct dice *dice)
 {
 	dice->dev_lock_changed = true;
@@ -264,6 +277,7 @@ static void dice_notification(struct fw_card *card, struct fw_request *request,
 			      void *data, size_t length, void *callback_data)
 {
 	struct dice *dice = callback_data;
+	u32 bits;
 	unsigned long flags;

 	if (tcode != TCODE_WRITE_QUADLET_REQUEST) {
@@ -274,10 +288,17 @@ static void dice_notification(struct fw_card *card, struct fw_request *request,
 		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
 		return;
 	}
+
+	bits = be32_to_cpup(data);
+
 	spin_lock_irqsave(&dice->lock, flags);
-	dice->notification_bits |= be32_to_cpup(data);
+	dice->notification_bits |= bits;
 	spin_unlock_irqrestore(&dice->lock, flags);
+
 	fw_send_response(card, request, RCODE_COMPLETE);
+
+	if (bits & NOTIFY_CLOCK_ACCEPTED)
+		complete(&dice->clock_accepted);
 	wake_up(&dice->hwdep_wait);
 }

@@ -457,6 +478,26 @@ static void dice_stream_stop(struct dice *dice)
 	fw_iso_resources_free(&dice->resources);
 }

+static int dice_change_rate(struct dice *dice, unsigned int clock_rate)
+{
+	__be32 value;
+	int err;
+
+	INIT_COMPLETION(dice->clock_accepted);
+
+	value = cpu_to_be32(clock_rate | CLOCK_SOURCE_ARX1);
+	err = snd_fw_transaction(dice->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 global_address(dice, GLOBAL_CLOCK_SELECT),
+				 &value, 4, 0);
+	if (err < 0)
+		return err;
+
+	wait_for_completion_timeout(&dice->clock_accepted,
+				    msecs_to_jiffies(100));
+
+	return 0;
+}
+
 static int dice_hw_params(struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *hw_params)
 {
@@ -831,11 +872,51 @@ static int dice_interface_check(struct fw_unit *unit)
 	return 0;
 }

+static int highest_supported_mode_rate(struct dice *dice, unsigned int mode)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(dice_rates) - 1; i >= 0; --i)
+		if ((dice->clock_caps & (1 << i)) &&
+		    rate_index_to_mode(i) == mode)
+			return i;
+
+	return -1;
+}
+
+static int dice_read_mode_params(struct dice *dice, unsigned int mode)
+{
+	__be32 values[2];
+	int rate_index, err;
+
+	rate_index = highest_supported_mode_rate(dice, mode);
+	if (rate_index < 0) {
+		dice->rx_channels[mode] = 0;
+		dice->rx_midi_ports[mode] = 0;
+		return 0;
+	}
+
+	err = dice_change_rate(dice, rate_index << CLOCK_RATE_SHIFT);
+	if (err < 0)
+		return err;
+
+	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
+				 rx_address(dice, RX_NUMBER_AUDIO),
+				 values, 2 * 4, 0);
+	if (err < 0)
+		return err;
+
+	dice->rx_channels[mode]   = be32_to_cpu(values[0]);
+	dice->rx_midi_ports[mode] = be32_to_cpu(values[1]);
+
+	return 0;
+}
+
 static int dice_read_params(struct dice *dice)
 {
 	__be32 pointers[6];
 	__be32 value;
-	int err;
+	int mode, err;

 	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
 				 DICE_PRIVATE_SPACE,
@@ -863,6 +944,12 @@ static int dice_read_params(struct dice *dice)
 				   CLOCK_CAP_SOURCE_INTERNAL;
 	}

+	for (mode = 2; mode >= 0; --mode) {
+		err = dice_read_mode_params(dice, mode);
+		if (err < 0)
+			return err;
+	}
+
 	return 0;
 }

@@ -922,6 +1009,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	spin_lock_init(&dice->lock);
 	mutex_init(&dice->mutex);
 	dice->unit = unit;
+	init_completion(&dice->clock_accepted);
 	init_waitqueue_head(&dice->hwdep_wait);

 	dice->notification_handler.length = 4;

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
