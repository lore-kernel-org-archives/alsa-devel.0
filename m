From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 059/112] ALSA: hda - Add
	snd_hda_codec_flush_*_cache() aliases
Date: Tue,  8 Jan 2013 12:38:52 +0100
Message-ID: <1357645185-7645-60-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 22DA52651DC
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 3B980A52D9
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

It makes easier to understand although these are identical with
snd_hda_codec_resume_*() functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.h     | 4 ++++
 sound/pci/hda/hda_local.h     | 4 ++++
 sound/pci/hda/patch_realtek.c | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index a1cb28f..2d9a51c 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -970,6 +970,10 @@ int snd_hda_codec_update_cache(struct hda_codec *codec, hda_nid_t nid,
 			      int direct, unsigned int verb, unsigned int parm);
 void snd_hda_codec_resume_cache(struct hda_codec *codec);
 
+/* it's alias but a bit clearer meaning */
+#define snd_hda_codec_flush_cmd_cache(codec) \
+	snd_hda_codec_resume_cache(codec)
+
 /* the struct for codec->pin_configs */
 struct hda_pincfg {
 	hda_nid_t nid;
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index de12dcc..fec0e2d 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -139,6 +139,10 @@ int snd_hda_codec_amp_init_stereo(struct hda_codec *codec, hda_nid_t nid,
 				  int dir, int idx, int mask, int val);
 void snd_hda_codec_resume_amp(struct hda_codec *codec);
 
+/* it's alias but a bit clearer meaning */
+#define snd_hda_codec_flush_amp_cache(codec) \
+	snd_hda_codec_resume_amp(codec)
+
 void snd_hda_set_vmaster_tlv(struct hda_codec *codec, hda_nid_t nid, int dir,
 			     unsigned int *tlv);
 struct snd_kcontrol *snd_hda_find_mixer_ctl(struct hda_codec *codec,
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 20e657b..0b32729 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -634,7 +634,7 @@ static void alc_inv_dmic_sync_adc(struct hda_codec *codec, int adc_idx)
 		(dir == HDA_OUTPUT ? AC_AMP_SET_OUTPUT : AC_AMP_SET_INPUT);
 
 	/* flush all cached amps at first */
-	snd_hda_codec_resume_amp(codec);
+	snd_hda_codec_flush_amp_cache(codec);
 
 	/* we care only right channel */
 	val = snd_hda_codec_amp_read(codec, nid, 1, dir, 0);
-- 
1.8.0.1
