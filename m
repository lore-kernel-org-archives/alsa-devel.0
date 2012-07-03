From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: hda - Remove beep_mode=2
Date: Tue,  3 Jul 2012 18:03:14 +0200
Message-ID: <1341331397-21182-2-git-send-email-tiwai@suse.de>
References: <1341331397-21182-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id B06AD244F2
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 18:03:29 +0200 (CEST)
In-Reply-To: <1341331397-21182-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The beep_mode=2 option was introduced to make the beep mixer
controlling the beep input allocation/deallocation dynamically, so
that a user can switch between HD-audio codec digital beep and the
system beep only via mixer API.  This was necessary because the
keyboard driver took only the first input beep instance at that time.

However, the recent keyboard driver already processes the multiple
input instances, thus there is no point to keep this mode.

Let's remove it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/ALSA-Configuration.txt |    3 +-
 sound/pci/hda/Kconfig                           |    7 ++---
 sound/pci/hda/hda_beep.c                        |   37 +----------------------
 sound/pci/hda/hda_beep.h                        |    4 ---
 sound/pci/hda/hda_intel.c                       |    6 ++--
 5 files changed, 8 insertions(+), 49 deletions(-)

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index 221b810..4e4d0bc 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -875,8 +875,7 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
     		setup before initializing the codecs.  This option is
 		available only when CONFIG_SND_HDA_PATCH_LOADER=y is set.
 		See HD-Audio.txt for details.
-    beep_mode	- Selects the beep registration mode (0=off, 1=on, 2=
-		dynamic registration via mute switch on/off); the default
+    beep_mode	- Selects the beep registration mode (0=off, 1=on); default
 		value is set via CONFIG_SND_HDA_INPUT_BEEP_MODE kconfig.
     
     [Single (global) options]
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index d030797..194d625 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -53,15 +53,14 @@ config SND_HDA_INPUT_BEEP
 	  driver. This interface is used to generate digital beeps.
 
 config SND_HDA_INPUT_BEEP_MODE
-	int "Digital beep registration mode (0=off, 1=on, 2=mute sw on/off)"
+	int "Digital beep registration mode (0=off, 1=on)"
 	depends on SND_HDA_INPUT_BEEP=y
 	default "1"
-	range 0 2
+	range 0 1
 	help
 	  Set 0 to disable the digital beep interface for HD-audio by default.
 	  Set 1 to always enable the digital beep interface for HD-audio by
-	  default. Set 2 to control the beep device registration to input
-	  layer using a "Beep Switch" in mixer applications.
+	  default.
 
 config SND_HDA_INPUT_JACK
 	bool "Support jack plugging notification via input layer"
diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 60738e5..662de6e 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -162,28 +162,6 @@ static int snd_hda_do_attach(struct hda_beep *beep)
 	return 0;
 }
 
-static void snd_hda_do_register(struct work_struct *work)
-{
-	struct hda_beep *beep =
-		container_of(work, struct hda_beep, register_work);
-
-	mutex_lock(&beep->mutex);
-	if (beep->enabled && !beep->dev)
-		snd_hda_do_attach(beep);
-	mutex_unlock(&beep->mutex);
-}
-
-static void snd_hda_do_unregister(struct work_struct *work)
-{
-	struct hda_beep *beep =
-		container_of(work, struct hda_beep, unregister_work.work);
-
-	mutex_lock(&beep->mutex);
-	if (!beep->enabled && beep->dev)
-		snd_hda_do_detach(beep);
-	mutex_unlock(&beep->mutex);
-}
-
 int snd_hda_enable_beep_device(struct hda_codec *codec, int enable)
 {
 	struct hda_beep *beep = codec->beep;
@@ -197,15 +175,6 @@ int snd_hda_enable_beep_device(struct hda_codec *codec, int enable)
 			snd_hda_codec_write(beep->codec, beep->nid, 0,
 						  AC_VERB_SET_BEEP_CONTROL, 0);
 		}
-		if (beep->mode == HDA_BEEP_MODE_SWREG) {
-			if (enable) {
-				cancel_delayed_work(&beep->unregister_work);
-				schedule_work(&beep->register_work);
-			} else {
-				schedule_delayed_work(&beep->unregister_work,
-									   HZ);
-			}
-		}
 		return 1;
 	}
 	return 0;
@@ -235,12 +204,10 @@ int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 	beep->mode = codec->beep_mode;
 	codec->beep = beep;
 
-	INIT_WORK(&beep->register_work, &snd_hda_do_register);
-	INIT_DELAYED_WORK(&beep->unregister_work, &snd_hda_do_unregister);
 	INIT_WORK(&beep->beep_work, &snd_hda_generate_beep);
 	mutex_init(&beep->mutex);
 
-	if (beep->mode == HDA_BEEP_MODE_ON) {
+	if (beep->mode) {
 		int err = snd_hda_do_attach(beep);
 		if (err < 0) {
 			kfree(beep);
@@ -257,8 +224,6 @@ void snd_hda_detach_beep_device(struct hda_codec *codec)
 {
 	struct hda_beep *beep = codec->beep;
 	if (beep) {
-		cancel_work_sync(&beep->register_work);
-		cancel_delayed_work(&beep->unregister_work);
 		if (beep->dev)
 			snd_hda_do_detach(beep);
 		codec->beep = NULL;
diff --git a/sound/pci/hda/hda_beep.h b/sound/pci/hda/hda_beep.h
index 55f0647..30e79d1 100644
--- a/sound/pci/hda/hda_beep.h
+++ b/sound/pci/hda/hda_beep.h
@@ -26,7 +26,6 @@
 
 #define HDA_BEEP_MODE_OFF	0
 #define HDA_BEEP_MODE_ON	1
-#define HDA_BEEP_MODE_SWREG	2
 
 /* beep information */
 struct hda_beep {
@@ -37,10 +36,7 @@ struct hda_beep {
 	int tone;
 	hda_nid_t nid;
 	unsigned int enabled:1;
-	unsigned int request_enable:1;
 	unsigned int linear_tone:1;	/* linear tone for IDT/STAC codec */
-	struct work_struct register_work; /* registration work */
-	struct delayed_work unregister_work; /* unregistration work */
 	struct work_struct beep_work; /* scheduled task for beep event */
 	struct mutex mutex;
 };
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7757536..334c0ba 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -72,7 +72,7 @@ static int enable_msi = -1;
 static char *patch[SNDRV_CARDS];
 #endif
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
-static int beep_mode[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] =
+static bool beep_mode[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] =
 					CONFIG_SND_HDA_INPUT_BEEP_MODE};
 #endif
 
@@ -103,9 +103,9 @@ module_param_array(patch, charp, NULL, 0444);
 MODULE_PARM_DESC(patch, "Patch file for Intel HD audio interface.");
 #endif
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
-module_param_array(beep_mode, int, NULL, 0444);
+module_param_array(beep_mode, bool, NULL, 0444);
 MODULE_PARM_DESC(beep_mode, "Select HDA Beep registration mode "
-			    "(0=off, 1=on, 2=mute switch on/off) (default=1).");
+			    "(0=off, 1=on) (default=1).");
 #endif
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
-- 
1.7.10.4
