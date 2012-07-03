From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: hda - Move beep helper functions to
	hda_beep.c
Date: Tue,  3 Jul 2012 18:03:15 +0200
Message-ID: <1341331397-21182-3-git-send-email-tiwai@suse.de>
References: <1341331397-21182-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id AD352244EA
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

Move snd_hda_mixer_amp_switch_put_beep() to hda_beep.c as a clean up
to remove one more ifdef.

Also add the corresponding get callback to return consistently the
digital beep state independently from the mixer amp value.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c  |   28 ++++++++++++++++++++++++++++
 sound/pci/hda/hda_codec.c |   19 -------------------
 sound/pci/hda/hda_local.h |    4 +++-
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 662de6e..336b4b3 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -231,3 +231,31 @@ void snd_hda_detach_beep_device(struct hda_codec *codec)
 	}
 }
 EXPORT_SYMBOL_HDA(snd_hda_detach_beep_device);
+
+/* get/put callbacks for beep mute mixer switches */
+int snd_hda_mixer_amp_switch_get_beep(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_beep *beep = codec->beep;
+	if (beep) {
+		ucontrol->value.integer.value[0] =
+			ucontrol->value.integer.value[1] =
+			beep->enabled;
+		return 0;
+	}
+	return snd_hda_mixer_amp_switch_get(kcontrol, ucontrol);
+}
+EXPORT_SYMBOL_HDA(snd_hda_mixer_amp_switch_get_beep);
+
+int snd_hda_mixer_amp_switch_put_beep(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_beep *beep = codec->beep;
+	if (beep)
+		snd_hda_enable_beep_device(codec,
+					   *ucontrol->value.integer.value);
+	return snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
+}
+EXPORT_SYMBOL_HDA(snd_hda_mixer_amp_switch_put_beep);
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 51cb2a2..ddac428 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2676,25 +2676,6 @@ int snd_hda_mixer_amp_switch_put(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_HDA(snd_hda_mixer_amp_switch_put);
 
-#ifdef CONFIG_SND_HDA_INPUT_BEEP
-/**
- * snd_hda_mixer_amp_switch_put_beep - Put callback for a beep AMP switch
- *
- * This function calls snd_hda_enable_beep_device(), which behaves differently
- * depending on beep_mode option.
- */
-int snd_hda_mixer_amp_switch_put_beep(struct snd_kcontrol *kcontrol,
-				      struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	long *valp = ucontrol->value.integer.value;
-
-	snd_hda_enable_beep_device(codec, *valp);
-	return snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
-}
-EXPORT_SYMBOL_HDA(snd_hda_mixer_amp_switch_put_beep);
-#endif /* CONFIG_SND_HDA_INPUT_BEEP */
-
 /*
  * bound volume controls
  *
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 9a096a8..1b4c129 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -89,7 +89,7 @@
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xcidx, \
 	  .subdevice = HDA_SUBDEV_AMP_FLAG, \
 	  .info = snd_hda_mixer_amp_switch_info, \
-	  .get = snd_hda_mixer_amp_switch_get, \
+	  .get = snd_hda_mixer_amp_switch_get_beep, \
 	  .put = snd_hda_mixer_amp_switch_put_beep, \
 	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, xindex, direction) }
 #else
@@ -121,6 +121,8 @@ int snd_hda_mixer_amp_switch_get(struct snd_kcontrol *kcontrol,
 int snd_hda_mixer_amp_switch_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol);
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
+int snd_hda_mixer_amp_switch_get_beep(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol);
 int snd_hda_mixer_amp_switch_put_beep(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol);
 #endif
-- 
1.7.10.4
