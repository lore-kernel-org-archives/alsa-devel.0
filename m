From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [20/29] ALSA: dice: get clock capabilities
Date: Mon, 21 Oct 2013 21:32:17 +0200
Message-ID: <52658141.7060009@ladisch.de>
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

In preparation for sample rate selection support, ensure that the driver
knows about the device's clock capabilities.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 2d3a04e..06fef47 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -36,6 +36,7 @@ struct dice {
 	struct mutex mutex;
 	unsigned int global_offset;
 	unsigned int rx_offset;
+	unsigned int clock_caps;
 	struct fw_address_handler notification_handler;
 	int owner_generation;
 	int dev_lock_count; /* > 0 driver, < 0 userspace */
@@ -830,9 +831,10 @@ static int dice_interface_check(struct fw_unit *unit)
 	return 0;
 }

-static int dice_init_offsets(struct dice *dice)
+static int dice_read_params(struct dice *dice)
 {
 	__be32 pointers[6];
+	__be32 value;
 	int err;

 	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
@@ -844,6 +846,23 @@ static int dice_init_offsets(struct dice *dice)
 	dice->global_offset = be32_to_cpu(pointers[0]) * 4;
 	dice->rx_offset = be32_to_cpu(pointers[4]) * 4;

+	/* some very old firmwares don't tell about their clock support */
+	if (be32_to_cpu(pointers[1]) * 4 >= GLOBAL_CLOCK_CAPABILITIES + 4) {
+		err = snd_fw_transaction(
+				dice->unit, TCODE_READ_QUADLET_REQUEST,
+				global_address(dice, GLOBAL_CLOCK_CAPABILITIES),
+				&value, 4, 0);
+		if (err < 0)
+			return err;
+		dice->clock_caps = be32_to_cpu(value);
+	} else {
+		/* this should be supported by any device */
+		dice->clock_caps = CLOCK_CAP_RATE_44100 |
+				   CLOCK_CAP_RATE_48000 |
+				   CLOCK_CAP_SOURCE_ARX1 |
+				   CLOCK_CAP_SOURCE_INTERNAL;
+	}
+
 	return 0;
 }

@@ -905,7 +924,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	dice->unit = unit;
 	init_waitqueue_head(&dice->hwdep_wait);

-	err = dice_init_offsets(dice);
+	err = dice_read_params(dice);
 	if (err < 0)
 		goto err_mutex;


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
