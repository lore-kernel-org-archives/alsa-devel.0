From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/6] ALSA: hda - Remove the use of set_fs()
Date: Tue, 16 May 2017 09:23:48 +0200
Message-ID: <20170516072350.25070-5-tiwai@suse.de>
References: <20170516072350.25070-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E3262674CE
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 09:23:52 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2DF36ABBD
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 07:23:52 +0000 (UTC)
In-Reply-To: <20170516072350.25070-1-tiwai@suse.de>
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

set_fs() is used in HD-audio vmaster code to retrieve the TLV data of
each slave kctl.  Since the slave is supposed to be a standard amp
kctl, we can call directly the supposed tlv callback instead of the
indirect call, so that we can remove the set_fs() hack.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 59 +++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 187a9c717fb5..ff9c7968b562 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1477,18 +1477,8 @@ int snd_hda_mixer_amp_volume_put(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_volume_put);
 
-/**
- * snd_hda_mixer_amp_volume_put - TLV callback for a standard AMP mixer volume
- * @kcontrol: ctl element
- * @op_flag: operation flag
- * @size: byte size of input TLV
- * @_tlv: TLV data
- *
- * The control element is supposed to have the private_value field
- * set up via HDA_COMPOSE_AMP_VAL*() or related macros.
- */
-int snd_hda_mixer_amp_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			  unsigned int size, unsigned int __user *_tlv)
+/* inquiry the amp caps and convert to TLV */
+static void get_ctl_amp_tlv(struct snd_kcontrol *kcontrol, unsigned int *tlv)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	hda_nid_t nid = get_amp_nid(kcontrol);
@@ -1497,8 +1487,6 @@ int snd_hda_mixer_amp_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	bool min_mute = get_amp_min_mute(kcontrol);
 	u32 caps, val1, val2;
 
-	if (size < 4 * sizeof(unsigned int))
-		return -ENOMEM;
 	caps = query_amp_caps(codec, nid, dir);
 	val2 = (caps & AC_AMPCAP_STEP_SIZE) >> AC_AMPCAP_STEP_SIZE_SHIFT;
 	val2 = (val2 + 1) * 25;
@@ -1507,13 +1495,31 @@ int snd_hda_mixer_amp_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	val1 = ((int)val1) * ((int)val2);
 	if (min_mute || (caps & AC_AMPCAP_MIN_MUTE))
 		val2 |= TLV_DB_SCALE_MUTE;
-	if (put_user(SNDRV_CTL_TLVT_DB_SCALE, _tlv))
-		return -EFAULT;
-	if (put_user(2 * sizeof(unsigned int), _tlv + 1))
-		return -EFAULT;
-	if (put_user(val1, _tlv + 2))
-		return -EFAULT;
-	if (put_user(val2, _tlv + 3))
+	tlv[0] = SNDRV_CTL_TLVT_DB_SCALE;
+	tlv[1] = 2 * sizeof(unsigned int);
+	tlv[2] = val1;
+	tlv[3] = val2;
+}
+
+/**
+ * snd_hda_mixer_amp_volume_put - TLV callback for a standard AMP mixer volume
+ * @kcontrol: ctl element
+ * @op_flag: operation flag
+ * @size: byte size of input TLV
+ * @_tlv: TLV data
+ *
+ * The control element is supposed to have the private_value field
+ * set up via HDA_COMPOSE_AMP_VAL*() or related macros.
+ */
+int snd_hda_mixer_amp_tlv(struct snd_kcontrol *kcontrol, int op_flag,
+			  unsigned int size, unsigned int __user *_tlv)
+{
+	unsigned int tlv[4];
+
+	if (size < 4 * sizeof(unsigned int))
+		return -ENOMEM;
+	get_ctl_amp_tlv(kcontrol, tlv);
+	if (copy_to_user(_tlv, tlv, sizeof(tlv)))
 		return -EFAULT;
 	return 0;
 }
@@ -1807,13 +1813,10 @@ static int get_kctl_0dB_offset(struct hda_codec *codec,
 	const int *tlv = NULL;
 	int val = -1;
 
-	if (kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
-		/* FIXME: set_fs() hack for obtaining user-space TLV data */
-		mm_segment_t fs = get_fs();
-		set_fs(get_ds());
-		if (!kctl->tlv.c(kctl, 0, sizeof(_tlv), _tlv))
-			tlv = _tlv;
-		set_fs(fs);
+	if ((kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) &&
+	    kctl->tlv.c == snd_hda_mixer_amp_tlv) {
+		get_ctl_amp_tlv(kctl, _tlv);
+		tlv = _tlv;
 	} else if (kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_READ)
 		tlv = kctl->tlv.p;
 	if (tlv && tlv[0] == SNDRV_CTL_TLVT_DB_SCALE) {
-- 
2.12.2
