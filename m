From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Sanity check of access to SPDIF
	controls array
Date: Tue, 24 Apr 2018 17:06:01 +0200
Message-ID: <20180424150601.17910-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ADA9E2671C0
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 17:06:02 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 71EACAC12
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 15:06:02 +0000 (UTC)
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

Put WARN_ON() and bail out if the given index is over the allocated
array of the given SPDIF controls.  It's merely a sanity check to
catch any potential issues (if any).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0aa923d129f5..63f177d975fd 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2175,6 +2175,8 @@ static int snd_hda_spdif_default_get(struct snd_kcontrol *kcontrol,
 	int idx = kcontrol->private_value;
 	struct hda_spdif_out *spdif;
 
+	if (WARN_ON(codec->spdif_out.used <= idx))
+		return -EINVAL;
 	mutex_lock(&codec->spdif_mutex);
 	spdif = snd_array_elem(&codec->spdif_out, idx);
 	ucontrol->value.iec958.status[0] = spdif->status & 0xff;
@@ -2282,6 +2284,8 @@ static int snd_hda_spdif_default_put(struct snd_kcontrol *kcontrol,
 	unsigned short val;
 	int change;
 
+	if (WARN_ON(codec->spdif_out.used <= idx))
+		return -EINVAL;
 	mutex_lock(&codec->spdif_mutex);
 	spdif = snd_array_elem(&codec->spdif_out, idx);
 	nid = spdif->nid;
@@ -2308,6 +2312,8 @@ static int snd_hda_spdif_out_switch_get(struct snd_kcontrol *kcontrol,
 	int idx = kcontrol->private_value;
 	struct hda_spdif_out *spdif;
 
+	if (WARN_ON(codec->spdif_out.used <= idx))
+		return -EINVAL;
 	mutex_lock(&codec->spdif_mutex);
 	spdif = snd_array_elem(&codec->spdif_out, idx);
 	ucontrol->value.integer.value[0] = spdif->ctls & AC_DIG1_ENABLE;
@@ -2336,6 +2342,8 @@ static int snd_hda_spdif_out_switch_put(struct snd_kcontrol *kcontrol,
 	unsigned short val;
 	int change;
 
+	if (WARN_ON(codec->spdif_out.used <= idx))
+		return -EINVAL;
 	mutex_lock(&codec->spdif_mutex);
 	spdif = snd_array_elem(&codec->spdif_out, idx);
 	nid = spdif->nid;
@@ -2483,6 +2491,8 @@ void snd_hda_spdif_ctls_unassign(struct hda_codec *codec, int idx)
 {
 	struct hda_spdif_out *spdif;
 
+	if (WARN_ON(codec->spdif_out.used <= idx))
+		return;
 	mutex_lock(&codec->spdif_mutex);
 	spdif = snd_array_elem(&codec->spdif_out, idx);
 	spdif->nid = (u16)-1;
@@ -2503,6 +2513,8 @@ void snd_hda_spdif_ctls_assign(struct hda_codec *codec, int idx, hda_nid_t nid)
 	struct hda_spdif_out *spdif;
 	unsigned short val;
 
+	if (WARN_ON(codec->spdif_out.used <= idx))
+		return;
 	mutex_lock(&codec->spdif_mutex);
 	spdif = snd_array_elem(&codec->spdif_out, idx);
 	if (spdif->nid != nid) {
-- 
2.16.3
