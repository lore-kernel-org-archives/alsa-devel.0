From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: firewire-digi00x: add support for
	console models of Digi00x series
Date: Sun,  2 Apr 2017 23:48:24 +0900
Message-ID: <20170402144827.32497-2-o-takashi@sakamocchi.jp>
References: <20170402144827.32497-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 21AE026686A
 for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2017 16:48:32 +0200 (CEST)
In-Reply-To: <20170402144827.32497-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Digi00x series includes two types of unit; rack and console. As long as
reading information on config rom of Digi 002 console, 'MODEL_ID' field
has a different value from the one on Digi 002 rack.

We've already got a test report from users with Digi 003 rack. We can
assume that console type and rack type has different value in the field.

This commit adds a device entry for console type. For following commits,
this commit also adds a member to 'struct snd_digi00x' to identify console
type.

$ cd linux-firewire-utils/src
$ python2 ./crpp < /sys/bus/firewire/devices/fw1/config_rom
               ROM header and bus information block
               -----------------------------------------------------------------
400  0404f9d0  bus_info_length 4, crc_length 4, crc 63952
404  31333934  bus_name "1394"
408  60647002  irmc 0, cmc 1, isc 1, bmc 0, cyc_clk_acc 100, max_rec 7 (256)
40c  00a07e00  company_id 00a07e     |
410  00a30000  device_id 0000a30000  | EUI-64 00a07e0000a30000

               root directory
               -----------------------------------------------------------------
414  00058a39  directory_length 5, crc 35385
418  0c0043a0  node capabilities
41c  04000001  hardware version
420  0300a07e  vendor
424  81000007  --> descriptor leaf at 440
428  d1000001  --> unit directory at 42c

               unit directory at 42c
               -----------------------------------------------------------------
42c  00046674  directory_length 4, crc 26228
430  120000a3  specifier id
434  13000001  version
438  17000001  model
43c  81000007  --> descriptor leaf at 458

               descriptor leaf at 440
               -----------------------------------------------------------------
440  00055913  leaf_length 5, crc 22803
444  000050f2  descriptor_type 00, specifier_ID 50f2
448  80000000
44c  44696769
450  64657369
454  676e0000

               descriptor leaf at 458
               -----------------------------------------------------------------
458  0004a6fd  leaf_length 4, crc 42749
45c  00000000  textual descriptor
460  00000000  minimal ASCII
464  44696769  "Digi"
468  20303032  " 002"

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x.c | 13 +++++++++++--
 sound/firewire/digi00x/digi00x.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index cc4776c..1f5e1d2 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -13,7 +13,8 @@ MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
 MODULE_LICENSE("GPL v2");
 
 #define VENDOR_DIGIDESIGN	0x00a07e
-#define MODEL_DIGI00X		0x000002
+#define MODEL_CONSOLE		0x000001
+#define MODEL_RACK		0x000002
 
 static int name_card(struct snd_dg00x *dg00x)
 {
@@ -129,6 +130,8 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	spin_lock_init(&dg00x->lock);
 	init_waitqueue_head(&dg00x->hwdep_wait);
 
+	dg00x->is_console = entry->model_id == MODEL_CONSOLE;
+
 	/* Allocate and register this sound card later. */
 	INIT_DEFERRABLE_WORK(&dg00x->dwork, do_registration);
 	snd_fw_schedule_registration(unit, &dg00x->dwork);
@@ -183,7 +186,13 @@ static const struct ieee1394_device_id snd_dg00x_id_table[] = {
 		.match_flags = IEEE1394_MATCH_VENDOR_ID |
 			       IEEE1394_MATCH_MODEL_ID,
 		.vendor_id = VENDOR_DIGIDESIGN,
-		.model_id = MODEL_DIGI00X,
+		.model_id = MODEL_CONSOLE,
+	},
+	{
+		.match_flags = IEEE1394_MATCH_VENDOR_ID |
+			       IEEE1394_MATCH_MODEL_ID,
+		.vendor_id = VENDOR_DIGIDESIGN,
+		.model_id = MODEL_RACK,
 	},
 	{}
 };
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 9dc761b..4aefe45d 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -61,6 +61,7 @@ struct snd_dg00x {
 	/* For asynchronous MIDI controls. */
 	struct snd_rawmidi_substream *in_control;
 	struct snd_fw_async_midi_port out_control;
+	bool is_console;
 };
 
 #define DG00X_ADDR_BASE		0xffffe0000000ull
-- 
2.9.3
