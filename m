From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 16/17] ALSA: oxfw: obsolete scs1x module
Date: Sun,  6 Dec 2015 13:18:24 +0900
Message-ID: <1449375505-2704-17-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 52B7F265327
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:33 +0100 (CET)
In-Reply-To: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
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

Now ALSA oxfw driver gains functionalities which scs1x module has.

This commit obsoletes the scs1x module, and adds a line of MODULE_ALIAS
to load oxfw module instead of scs1x module.

In scs1x module, the name of 'shortname' field is fixed as 'SCS1x'. This
field is used to name MIDI ports for both of SCS.1m and SCS.1d. This is
not good because typically some SCS.1m and SCS.1d are used in the same
system. It's better to distinguish them according to name of the ports.
This commit applies model name in config ROM to the 'shortname'.

For the name of 'driver' and 'longname', this commit uses the same way
applied to the other models. This change may not bring disadvantages to
users because userspace applications use ALSA rawmidi or seq interface
and these interfaces are not influenced by them directly.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig     | 12 +-----------
 sound/firewire/Makefile    |  2 --
 sound/firewire/oxfw/oxfw.c | 26 ++++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index e92a6d9..2a779c2 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -39,6 +39,7 @@ config SND_OXFW
 	   * Mackie(Loud) d.2 pro/d.4 pro
 	   * Mackie(Loud) U.420/U.420d
 	   * TASCAM FireOne
+	   * Stanton Controllers & Systems 1 Deck/Mixer
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-oxfw.
@@ -53,17 +54,6 @@ config SND_ISIGHT
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-isight.
 
-config SND_SCS1X
-	tristate "Stanton Control System 1 MIDI"
-	select SND_FIREWIRE_LIB
-	help
-	  Say Y here to include support for the MIDI ports of the Stanton
-	  SCS.1d/SCS.1m DJ controllers.  (SCS.1m audio is still handled
-	  by FFADO.)
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called snd-scs1x.
-
 config SND_FIREWORKS
 	tristate "Echo Fireworks board module support"
 	select SND_FIREWIRE_LIB
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index f5fb625..003c090 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -1,13 +1,11 @@
 snd-firewire-lib-objs := lib.o iso-resources.o packets-buffer.o \
 			 fcp.o cmp.o amdtp-stream.o amdtp-am824.o
 snd-isight-objs := isight.o
-snd-scs1x-objs := scs1x.o
 
 obj-$(CONFIG_SND_FIREWIRE_LIB) += snd-firewire-lib.o
 obj-$(CONFIG_SND_DICE) += dice/
 obj-$(CONFIG_SND_OXFW) += oxfw/
 obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
-obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
 obj-$(CONFIG_SND_FIREWORKS) += fireworks/
 obj-$(CONFIG_SND_BEBOB) += bebob/
 obj-$(CONFIG_SND_FIREWIRE_DIGI00X) += digi00x/
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index b20e496..e7f2698 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -19,6 +19,7 @@
 #define VENDOR_BEHRINGER	0x001564
 #define VENDOR_LACIE		0x00d04b
 #define VENDOR_TASCAM		0x00022e
+#define OUI_STANTON		0x001260
 
 #define MODEL_SATELLITE		0x00200f
 
@@ -29,6 +30,7 @@ MODULE_DESCRIPTION("Oxford Semiconductor FW970/971 driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("snd-firewire-speakers");
+MODULE_ALIAS("snd-scs1x");
 
 struct compat_info {
 	const char *driver_name;
@@ -159,6 +161,13 @@ static int detect_quirks(struct snd_oxfw *oxfw)
 		return snd_oxfw_add_spkr(oxfw, true);
 
 	/*
+	 * Stanton models supports asynchronous transactions for unique MIDI
+	 * messages.
+	 */
+	if (oxfw->entry->vendor_id == OUI_STANTON)
+		return snd_oxfw_scs1x_add(oxfw);
+
+	/*
 	 * TASCAM FireOne has physical control and requires a pair of additional
 	 * MIDI ports.
 	 */
@@ -275,6 +284,9 @@ static void oxfw_bus_reset(struct fw_unit *unit)
 		snd_oxfw_stream_update_simplex(oxfw, &oxfw->tx_stream);
 
 	mutex_unlock(&oxfw->mutex);
+
+	if (oxfw->entry->vendor_id == OUI_STANTON)
+		snd_oxfw_scs1x_update(oxfw);
 }
 
 static void oxfw_remove(struct fw_unit *unit)
@@ -352,6 +364,20 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 		.vendor_id	= VENDOR_TASCAM,
 		.model_id	= 0x800007,
 	},
+	/* Stanton, Stanton Controllers & Systems 1 Mixer (SCS.1m) */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_STANTON,
+		.model_id	= 0x001000,
+	},
+	/* Stanton, Stanton Controllers & Systems 1 Deck (SCS.1d) */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_STANTON,
+		.model_id	= 0x002000,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, oxfw_id_table);
-- 
2.5.0
