From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [21/29] ALSA: dice: allow notifications during initialization
Date: Mon, 21 Oct 2013 21:32:52 +0200
Message-ID: <52658164.5060601@ladisch.de>
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

Reorganize the initialization order so that the driver can receive
notifications earlier.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 06fef47..49b47ba 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -924,10 +924,6 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	dice->unit = unit;
 	init_waitqueue_head(&dice->hwdep_wait);

-	err = dice_read_params(dice);
-	if (err < 0)
-		goto err_mutex;
-
 	dice->notification_handler.length = 4;
 	dice->notification_handler.address_callback = dice_notification;
 	dice->notification_handler.callback_data = dice;
@@ -936,9 +932,17 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	if (err < 0)
 		goto err_mutex;

-	err = fw_iso_resources_init(&dice->resources, unit);
+	err = dice_owner_set(dice);
 	if (err < 0)
 		goto err_notification_handler;
+
+	err = dice_read_params(dice);
+	if (err < 0)
+		goto err_owner;
+
+	err = fw_iso_resources_init(&dice->resources, unit);
+	if (err < 0)
+		goto err_owner;
 	dice->resources.channels_mask = 0x00000000ffffffffuLL;

 	err = amdtp_out_stream_init(&dice->stream, unit,
@@ -946,10 +950,6 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	if (err < 0)
 		goto err_resources;

-	err = dice_owner_set(dice);
-	if (err < 0)
-		goto err_stream;
-
 	card->private_free = dice_card_free;

 	dice_card_strings(dice);
@@ -983,10 +983,10 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)

 	return 0;

-err_stream:
-	amdtp_out_stream_destroy(&dice->stream);
 err_resources:
 	fw_iso_resources_destroy(&dice->resources);
+err_owner:
+	dice_owner_clear(dice);
 err_notification_handler:
 	fw_core_remove_address_handler(&dice->notification_handler);
 err_mutex:

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
