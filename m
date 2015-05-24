From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: bebob: add Digidesign Mbox 2 Pro support
Date: Sun, 24 May 2015 20:51:45 +0900
Message-ID: <1432468305-29451-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1432352196-16157-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EF9C260668
 for <alsa-devel@alsa-project.org>; Sun, 24 May 2015 13:51:49 +0200 (CEST)
In-Reply-To: <1432352196-16157-1-git-send-email-o-takashi@sakamocchi.jp>
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

This device is based on DM1000E, and BeBoB version 1 firmware is
installed.

$ cat /proc/asound/cards
 0 [Pro            ]: BeBoB - Mbox 2 Pro
                      DIGIDESIGN Mbox 2 Pro (id:1, rev:1),
		      GUID 00a07e0100a90000 at fw1.0, S400

$ cat /proc/asound/Pro/firewire/firmware
Manufacturer:	bridgeCo
Protocol Ver:	1
Build Ver:		0
GUID:		0x00A07E0100A90000
Model ID:		0x01
Model Rev:		1
Firmware Date:	20071031
Firmware Time:	034402
Firmware ID:	0xA9
Firmware Ver:	16777215
Base Addr:		0x20080000
Max Size:		1572864
Loader Date:	20051207
Loader Time:	205554

With this patch, ALSA BeBoB driver can start packet streaming to/from
this model, while as a default, internal multiplexer of this model is
not initialized and generates no sound even if the driver transfers
any packets with PCM samples. To hear any sounds from this model,
userspace applications should be developed to set parameters to the
internal multiplexer. You can see raw information in FFADO website:
http://subversion.ffado.org/wiki/AvcModels/DigiDesignMboxPro2

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig       | 1 +
 sound/firewire/bebob/bebob.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index ecec547..2a0a9aa 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -114,6 +114,7 @@ config SND_BEBOB
 	  * M-Audio FireWire410/AudioPhile/Solo
 	  * M-Audio Ozonic/NRV10/ProfireLightBridge
 	  * M-Audio FireWire 1814/ProjectMix IO
+	  * Digidesign Mbox 2 Pro
 
           To compile this driver as a module, choose M here: the module
           will be called snd-bebob.
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 611b7da..e71bd35 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -57,6 +57,7 @@ static DECLARE_BITMAP(devices_used, SNDRV_CARDS);
 #define VEN_FOCUSRITE	0x0000130e
 #define VEN_MAUDIO1	0x00000d6c
 #define VEN_MAUDIO2	0x000007f5
+#define VEN_DIGIDESIGN	0x00a07e
 
 #define MODEL_FOCUSRITE_SAFFIRE_BOTH	0x00000000
 #define MODEL_MAUDIO_AUDIOPHILE_BOTH	0x00010060
@@ -433,6 +434,8 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	/* M-Audio ProjectMix */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_PROJECTMIX,
 			    &maudio_special_spec),
+	/* Digidesign Mbox 2 Pro */
+	SND_BEBOB_DEV_ENTRY(VEN_DIGIDESIGN, 0x0000a9, &spec_normal),
 	/* IDs are unknown but able to be supported */
 	/*  Apogee, Mini-ME Firewire */
 	/*  Apogee, Mini-DAC Firewire */
-- 
2.1.4
