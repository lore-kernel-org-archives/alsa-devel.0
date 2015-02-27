From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 8/9] ALSA: hda - Build PCMs and controls at
	codec driver probe
Date: Fri, 27 Feb 2015 23:55:43 +0100
Message-ID: <1425077744-4553-9-git-send-email-tiwai@suse.de>
References: <1425077744-4553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 09B5D2651CE
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 23:55:47 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6D439AC47
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:55:46 +0000 (UTC)
In-Reply-To: <1425077744-4553-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This makes the code flow easier -- instead of the controller driver
calling snd_hda_build_pcms() and snd_hda_build_controls() explicitly,
the codec driver itself builds PCMs and controls at probe time.  Then
the controller driver only needs to call snd_card_register().

Also, this allows us the full bind/unbind control, too.  Even when a
codec driver is bound later, it automatically registers the new PCM
and controls by itself.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_bind.c  | 22 ++++++++++++----
 sound/pci/hda/hda_codec.c | 67 -----------------------------------------------
 sound/pci/hda/hda_codec.h |  2 --
 sound/pci/hda/hda_intel.c | 10 -------
 sound/pci/hda/hda_tegra.c | 10 -------
 5 files changed, 17 insertions(+), 94 deletions(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 114320864cea..ba1adbf0f85f 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -110,16 +110,28 @@ static int hda_codec_driver_probe(struct device *dev)
 	if (err < 0)
 		goto error;
 	err = codec->preset->patch(codec);
-	if (err < 0) {
-		module_put(owner);
-		goto error;
+	if (err < 0)
+		goto error_module;
+
+	err = snd_hda_codec_build_pcms(codec);
+	if (err < 0)
+		goto error_module;
+	err = snd_hda_codec_build_controls(codec);
+	if (err < 0)
+		goto error_module;
+	if (codec->card->registered) {
+		err = snd_card_register(codec->card);
+		if (err < 0)
+			goto error_module;
 	}
 
 	return 0;
 
+ error_module:
+	module_put(owner);
+
  error:
-	codec->preset = NULL;
-	memset(&codec->patch_ops, 0, sizeof(codec->patch_ops));
+	snd_hda_codec_cleanup_for_unbind(codec);
 	snd_hda_regmap_exit(codec);
 	return err;
 }
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index a87b247a172a..c78b1603849b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3593,36 +3593,6 @@ const struct dev_pm_ops hda_codec_driver_pm = {
 			   NULL)
 };
 
-/**
- * snd_hda_build_controls - build mixer controls
- * @bus: the BUS
- *
- * Creates mixer controls for each codec included in the bus.
- *
- * Returns 0 if successful, otherwise a negative error code.
- */
-int snd_hda_build_controls(struct hda_bus *bus)
-{
-	struct hda_codec *codec;
-
-	list_for_each_entry(codec, &bus->codec_list, list) {
-		int err = snd_hda_codec_build_controls(codec);
-		if (err < 0) {
-			codec_err(codec,
-				  "cannot build controls for #%d (error %d)\n",
-				  codec->addr, err);
-			err = snd_hda_codec_reset(codec);
-			if (err < 0) {
-				codec_err(codec,
-					  "cannot revert codec\n");
-				return err;
-			}
-		}
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hda_build_controls);
-
 /*
  * add standard channel maps if not specified
  */
@@ -4241,43 +4211,6 @@ int snd_hda_codec_build_pcms(struct hda_codec *codec)
 }
 
 /**
- * snd_hda_build_pcms - build PCM information
- * @bus: the BUS
- *
- * Create PCM information for each codec included in the bus.
- *
- * The build_pcms codec patch is requested to create and assign new
- * hda_pcm objects.  The codec is responsible to call snd_hda_codec_pcm_new()
- * and fills the fields.  Later they are instantiated by this function.
- *
- * At least, substreams, channels_min and channels_max must be filled for
- * each stream.  substreams = 0 indicates that the stream doesn't exist.
- * When rates and/or formats are zero, the supported values are queried
- * from the given nid.  The nid is used also by the default ops.prepare
- * and ops.cleanup callbacks.
- *
- * The driver needs to call ops.open in its open callback.  Similarly,
- * ops.close is supposed to be called in the close callback.
- * ops.prepare should be called in the prepare or hw_params callback
- * with the proper parameters for set up.
- * ops.cleanup should be called in hw_free for clean up of streams.
- *
- * This function returns 0 if successful, or a negative error code.
- */
-int snd_hda_build_pcms(struct hda_bus *bus)
-{
-	struct hda_codec *codec;
-
-	list_for_each_entry(codec, &bus->codec_list, list) {
-		int err = snd_hda_codec_build_pcms(codec);
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hda_build_pcms);
-
-/**
  * snd_hda_add_new_ctls - create controls from the array
  * @codec: the HDA codec
  * @knew: the array of struct snd_kcontrol_new
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 07001797cece..dab1c4ca8351 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -489,13 +489,11 @@ void snd_hda_spdif_ctls_assign(struct hda_codec *codec, int idx, hda_nid_t nid);
 /*
  * Mixer
  */
-int snd_hda_build_controls(struct hda_bus *bus);
 int snd_hda_codec_build_controls(struct hda_codec *codec);
 
 /*
  * PCM
  */
-int snd_hda_build_pcms(struct hda_bus *bus);
 int snd_hda_codec_parse_pcms(struct hda_codec *codec);
 int snd_hda_codec_build_pcms(struct hda_codec *codec);
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index f7fb1b51d446..e81461a413b8 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1895,16 +1895,6 @@ static int azx_probe_continue(struct azx *chip)
 			goto out_free;
 	}
 
-	/* create PCM streams */
-	err = snd_hda_build_pcms(chip->bus);
-	if (err < 0)
-		goto out_free;
-
-	/* create mixer controls */
-	err = snd_hda_build_controls(chip->bus);
-	if (err < 0)
-		goto out_free;
-
 	err = snd_card_register(chip->card);
 	if (err < 0)
 		goto out_free;
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 1359fdd20f02..7586abe91dfb 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -497,16 +497,6 @@ static int hda_tegra_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto out_free;
 
-	/* create PCM streams */
-	err = snd_hda_build_pcms(chip->bus);
-	if (err < 0)
-		goto out_free;
-
-	/* create mixer controls */
-	err = snd_hda_build_controls(chip->bus);
-	if (err < 0)
-		goto out_free;
-
 	err = snd_card_register(chip->card);
 	if (err < 0)
 		goto out_free;
-- 
2.3.0
