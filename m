From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Simplify phantom jack handling for
	HDMI/DP
Date: Thu, 12 Nov 2015 12:42:11 +0100
Message-ID: <1447328531-28289-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 84FF62606C7
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 12:42:14 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 007A1AAF4
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 11:41:51 +0000 (UTC)
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

The HDMI codec parser may create a phantom jack, but the helper
function snd_hda_jack_add_kctl() treats always as a normal jack.  This
is superfluous as the jack query is executed at each time the jack
sync is performed.

Since the HDMI codec parser is the only caller of this function, it's
easier to change back this directly calling the original
__snd_hda_jack_add_kctl() with phantom_jack parameter.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_jack.c   | 18 ++----------------
 sound/pci/hda/hda_jack.h   |  2 +-
 sound/pci/hda/patch_hdmi.c |  7 +++++--
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 366efbf87d41..c945e257d368 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -383,7 +383,7 @@ static void hda_free_jack_priv(struct snd_jack *jack)
  * This assigns a jack-detection kctl to the given pin.  The kcontrol
  * will have the given name and index.
  */
-static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
+int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 			  const char *name, bool phantom_jack)
 {
 	struct hda_jack_tbl *jack;
@@ -410,20 +410,6 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 
 	return 0;
 }
-
-/**
- * snd_hda_jack_add_kctl - Add a jack kctl for the given pin
- * @codec: the HDA codec
- * @nid: pin NID
- * @name: the name string for the jack ctl
- *
- * This is a simple helper calling __snd_hda_jack_add_kctl().
- */
-int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name)
-{
-	return __snd_hda_jack_add_kctl(codec, nid, name, false);
-}
 EXPORT_SYMBOL_GPL(snd_hda_jack_add_kctl);
 
 static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
@@ -451,7 +437,7 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 	if (phantom_jack)
 		/* Example final name: "Internal Mic Phantom Jack" */
 		strncat(name, " Phantom", sizeof(name) - strlen(name) - 1);
-	err = __snd_hda_jack_add_kctl(codec, nid, name, phantom_jack);
+	err = snd_hda_jack_add_kctl(codec, nid, name, phantom_jack);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 387d30984dfe..858708a044f5 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -82,7 +82,7 @@ static inline bool snd_hda_jack_detect(struct hda_codec *codec, hda_nid_t nid)
 bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid);
 
 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name);
+			  const char *name, bool phantom_jack);
 int snd_hda_jack_add_kctls(struct hda_codec *codec,
 			   const struct auto_pin_cfg *cfg);
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 309274bd1858..60cd9e700909 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2097,14 +2097,17 @@ static int generic_hdmi_build_jack(struct hda_codec *codec, int pin_idx)
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
 	int pcmdev = get_pcm_rec(spec, pin_idx)->device;
+	bool phantom_jack;
 
 	if (pcmdev > 0)
 		sprintf(hdmi_str + strlen(hdmi_str), ",pcm=%d", pcmdev);
-	if (!is_jack_detectable(codec, per_pin->pin_nid))
+	phantom_jack = !is_jack_detectable(codec, per_pin->pin_nid);
+	if (phantom_jack)
 		strncat(hdmi_str, " Phantom",
 			sizeof(hdmi_str) - strlen(hdmi_str) - 1);
 
-	return snd_hda_jack_add_kctl(codec, per_pin->pin_nid, hdmi_str);
+	return snd_hda_jack_add_kctl(codec, per_pin->pin_nid, hdmi_str,
+				     phantom_jack);
 }
 
 static int generic_hdmi_build_controls(struct hda_codec *codec)
-- 
2.6.3
