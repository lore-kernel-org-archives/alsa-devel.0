From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/15] ALSA: hda - Protect SPDIF-related stuff
	via spdif_mutex
Date: Mon, 14 May 2012 17:32:03 +0200
Message-ID: <1337009526-26256-13-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id A20E224A2E
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 08557910A1
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
In-Reply-To: <1337009526-26256-1-git-send-email-tiwai@suse.de>
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

Add the missing mutex protection or move into the protected part for
SPDIF access codes for codecs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c  |   35 +++++++++++++++++++++++++----------
 sound/pci/hda/patch_hdmi.c |    4 ++--
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 731f850..5e7c4bf 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2864,12 +2864,15 @@ static int snd_hda_spdif_default_get(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
-	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
+	struct hda_spdif_out *spdif;
 
+	mutex_lock(&codec->spdif_mutex);
+	spdif = snd_array_elem(&codec->spdif_out, idx);
 	ucontrol->value.iec958.status[0] = spdif->status & 0xff;
 	ucontrol->value.iec958.status[1] = (spdif->status >> 8) & 0xff;
 	ucontrol->value.iec958.status[2] = (spdif->status >> 16) & 0xff;
 	ucontrol->value.iec958.status[3] = (spdif->status >> 24) & 0xff;
+	mutex_unlock(&codec->spdif_mutex);
 
 	return 0;
 }
@@ -2955,12 +2958,14 @@ static int snd_hda_spdif_default_put(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
-	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
-	hda_nid_t nid = spdif->nid;
+	struct hda_spdif_out *spdif;
+	hda_nid_t nid;
 	unsigned short val;
 	int change;
 
 	mutex_lock(&codec->spdif_mutex);
+	spdif = snd_array_elem(&codec->spdif_out, idx);
+	nid = spdif->nid;
 	spdif->status = ucontrol->value.iec958.status[0] |
 		((unsigned int)ucontrol->value.iec958.status[1] << 8) |
 		((unsigned int)ucontrol->value.iec958.status[2] << 16) |
@@ -2982,9 +2987,12 @@ static int snd_hda_spdif_out_switch_get(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
-	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
+	struct hda_spdif_out *spdif;
 
+	mutex_lock(&codec->spdif_mutex);
+	spdif = snd_array_elem(&codec->spdif_out, idx);
 	ucontrol->value.integer.value[0] = spdif->ctls & AC_DIG1_ENABLE;
+	mutex_unlock(&codec->spdif_mutex);
 	return 0;
 }
 
@@ -3004,12 +3012,14 @@ static int snd_hda_spdif_out_switch_put(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
-	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
-	hda_nid_t nid = spdif->nid;
+	struct hda_spdif_out *spdif;
+	hda_nid_t nid;
 	unsigned short val;
 	int change;
 
 	mutex_lock(&codec->spdif_mutex);
+	spdif = snd_array_elem(&codec->spdif_out, idx);
+	nid = spdif->nid;
 	val = spdif->ctls & ~AC_DIG1_ENABLE;
 	if (ucontrol->value.integer.value[0])
 		val |= AC_DIG1_ENABLE;
@@ -3097,6 +3107,9 @@ int snd_hda_create_spdif_out_ctls(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_HDA(snd_hda_create_spdif_out_ctls);
 
+/* get the hda_spdif_out entry from the given NID
+ * call within spdif_mutex lock
+ */
 struct hda_spdif_out *snd_hda_spdif_out_of_nid(struct hda_codec *codec,
 					       hda_nid_t nid)
 {
@@ -3113,9 +3126,10 @@ EXPORT_SYMBOL_HDA(snd_hda_spdif_out_of_nid);
 
 void snd_hda_spdif_ctls_unassign(struct hda_codec *codec, int idx)
 {
-	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
+	struct hda_spdif_out *spdif;
 
 	mutex_lock(&codec->spdif_mutex);
+	spdif = snd_array_elem(&codec->spdif_out, idx);
 	spdif->nid = (u16)-1;
 	mutex_unlock(&codec->spdif_mutex);
 }
@@ -3123,10 +3137,11 @@ EXPORT_SYMBOL_HDA(snd_hda_spdif_ctls_unassign);
 
 void snd_hda_spdif_ctls_assign(struct hda_codec *codec, int idx, hda_nid_t nid)
 {
-	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
+	struct hda_spdif_out *spdif;
 	unsigned short val;
 
 	mutex_lock(&codec->spdif_mutex);
+	spdif = snd_array_elem(&codec->spdif_out, idx);
 	if (spdif->nid != nid) {
 		spdif->nid = nid;
 		val = spdif->ctls;
@@ -4747,11 +4762,11 @@ int snd_hda_multi_out_analog_prepare(struct hda_codec *codec,
 {
 	const hda_nid_t *nids = mout->dac_nids;
 	int chs = substream->runtime->channels;
-	struct hda_spdif_out *spdif =
-			snd_hda_spdif_out_of_nid(codec, mout->dig_out_nid);
+	struct hda_spdif_out *spdif;
 	int i;
 
 	mutex_lock(&codec->spdif_mutex);
+	spdif = snd_hda_spdif_out_of_nid(codec, mout->dig_out_nid);
 	if (mout->dig_out_nid && mout->share_spdif &&
 	    mout->dig_out_used != HDA_DIG_EXCLUSIVE) {
 		if (chs == 2 &&
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 83f345f..ad319d4 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1592,10 +1592,10 @@ static int nvhdmi_8ch_7x_pcm_prepare(struct hda_pcm_stream *hinfo,
 	unsigned int dataDCC2, channel_id;
 	int i;
 	struct hdmi_spec *spec = codec->spec;
-	struct hda_spdif_out *spdif =
-		snd_hda_spdif_out_of_nid(codec, spec->cvts[0].cvt_nid);
+	struct hda_spdif_out *spdif;
 
 	mutex_lock(&codec->spdif_mutex);
+	spdif = snd_hda_spdif_out_of_nid(codec, spec->cvts[0].cvt_nid);
 
 	chs = substream->runtime->channels;
 
-- 
1.7.9.2
