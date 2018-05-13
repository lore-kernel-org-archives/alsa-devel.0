From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: hda: use position offset macro of
	TLV data
Date: Mon, 14 May 2018 07:09:52 +0900
Message-ID: <20180513220953.15118-4-o-takashi@sakamocchi.jp>
References: <20180513220953.15118-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f65.google.com (mail-pl0-f65.google.com
 [209.85.160.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 695EC26769E
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 00:10:31 +0200 (CEST)
Received: by mail-pl0-f65.google.com with SMTP id az12-v6so6199254plb.8
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 15:10:30 -0700 (PDT)
In-Reply-To: <20180513220953.15118-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A series of SNDRV_CTL_TLVO_XXX macro was introduced for position offset
of TLV data. This commit applies a code optimization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/pci/hda/hda_codec.c   | 22 +++++++++++-----------
 sound/pci/hda/hda_generic.c |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 63f177d975fd..08151f3c0b13 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1493,10 +1493,10 @@ static void get_ctl_amp_tlv(struct snd_kcontrol *kcontrol, unsigned int *tlv)
 	val1 = ((int)val1) * ((int)val2);
 	if (min_mute || (caps & AC_AMPCAP_MIN_MUTE))
 		val2 |= TLV_DB_SCALE_MUTE;
-	tlv[0] = SNDRV_CTL_TLVT_DB_SCALE;
-	tlv[1] = 2 * sizeof(unsigned int);
-	tlv[2] = val1;
-	tlv[3] = val2;
+	tlv[SNDRV_CTL_TLVO_TYPE] = SNDRV_CTL_TLVT_DB_SCALE;
+	tlv[SNDRV_CTL_TLVO_LEN] = 2 * sizeof(unsigned int);
+	tlv[SNDRV_CTL_TLVO_DB_SCALE_MIN] = val1;
+	tlv[SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP] = val2;
 }
 
 /**
@@ -1544,10 +1544,10 @@ void snd_hda_set_vmaster_tlv(struct hda_codec *codec, hda_nid_t nid, int dir,
 	nums = (caps & AC_AMPCAP_NUM_STEPS) >> AC_AMPCAP_NUM_STEPS_SHIFT;
 	step = (caps & AC_AMPCAP_STEP_SIZE) >> AC_AMPCAP_STEP_SIZE_SHIFT;
 	step = (step + 1) * 25;
-	tlv[0] = SNDRV_CTL_TLVT_DB_SCALE;
-	tlv[1] = 2 * sizeof(unsigned int);
-	tlv[2] = -nums * step;
-	tlv[3] = step;
+	tlv[SNDRV_CTL_TLVO_TYPE] = SNDRV_CTL_TLVT_DB_SCALE;
+	tlv[SNDRV_CTL_TLVO_LEN] = 2 * sizeof(unsigned int);
+	tlv[SNDRV_CTL_TLVO_DB_SCALE_MIN] = -nums * step;
+	tlv[SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP] = step;
 }
 EXPORT_SYMBOL_GPL(snd_hda_set_vmaster_tlv);
 
@@ -1845,10 +1845,10 @@ static int init_slave_0dB(struct snd_kcontrol *slave,
 	} else if (kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_READ)
 		tlv = kctl->tlv.p;
 
-	if (!tlv || tlv[0] != SNDRV_CTL_TLVT_DB_SCALE)
+	if (!tlv || tlv[SNDRV_CTL_TLVO_TYPE] != SNDRV_CTL_TLVT_DB_SCALE)
 		return 0;
 
-	step = tlv[3];
+	step = tlv[SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP];
 	step &= ~TLV_DB_SCALE_MUTE;
 	if (!step)
 		return 0;
@@ -1860,7 +1860,7 @@ static int init_slave_0dB(struct snd_kcontrol *slave,
 	}
 
 	arg->step = step;
-	val = -tlv[2] / step;
+	val = -tlv[SNDRV_CTL_TLVO_DB_SCALE_MIN] / step;
 	if (val > 0) {
 		put_kctl_with_value(slave, val);
 		return val;
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 51030f040745..db773e219aaa 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2065,7 +2065,7 @@ static int parse_output_paths(struct hda_codec *codec)
 			snd_hda_set_vmaster_tlv(codec, spec->vmaster_nid,
 						HDA_OUTPUT, spec->vmaster_tlv);
 			if (spec->dac_min_mute)
-				spec->vmaster_tlv[3] |= TLV_DB_SCALE_MUTE;
+				spec->vmaster_tlv[SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP] |= TLV_DB_SCALE_MUTE;
 		}
 	}
 
-- 
2.14.1
