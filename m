From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH v2 5/7] ASoC: sti: helper functions to fix tdm
	runtime params
Date: Thu, 7 Apr 2016 11:25:34 +0200
Message-ID: <1460021136-27822-6-git-send-email-moise.gergaud@st.com>
References: <1460021136-27822-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 11667266432
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 11:26:03 +0200 (CEST)
In-Reply-To: <1460021136-27822-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/sti_uniperif.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/sti/uniperif.h     |  6 ++++++
 2 files changed, 52 insertions(+)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 0c2474c..d49bade 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -59,6 +59,52 @@ int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	return 0;
 }
 
+int sti_uniperiph_fix_tdm_chan(struct snd_pcm_hw_params *params,
+			       struct snd_pcm_hw_rule *rule)
+{
+	struct uniperif *uni = rule->private;
+	struct snd_interval t;
+
+	t.min = uni->tdm_slot.avail_slots;
+	t.max = uni->tdm_slot.avail_slots;
+	t.openmin = 0;
+	t.openmax = 0;
+	t.integer = 0;
+
+	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
+}
+
+int sti_uniperiph_fix_tdm_format(struct snd_pcm_hw_params *params,
+				 struct snd_pcm_hw_rule *rule)
+{
+	struct uniperif *uni = rule->private;
+	struct snd_mask *maskp = hw_param_mask(params, rule->var);
+	u64 format;
+
+	switch (uni->tdm_slot.slot_width) {
+	case 16:
+		format = SNDRV_PCM_FMTBIT_S16_LE;
+		break;
+	case 32:
+		format = SNDRV_PCM_FMTBIT_S32_LE;
+		break;
+	default:
+		dev_err(uni->dev, "format not supported: %d bits\n",
+			uni->tdm_slot.slot_width);
+		return -EINVAL;
+	}
+
+	maskp->bits[0] &= (u_int32_t)format;
+	maskp->bits[1] &= (u_int32_t)(format >> 32);
+	/* clear remaining indexes */
+	memset(maskp->bits + 2, 0, (SNDRV_MASK_MAX - 64) / 8);
+
+	if (!maskp->bits[0] && !maskp->bits[1])
+		return -EINVAL;
+
+	return 0;
+}
+
 int sti_uniperiph_get_tdm_word_pos(struct uniperif *uni,
 				   unsigned int *word_pos)
 {
diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index fb8e427..17d5d10 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1396,4 +1396,10 @@ int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 int sti_uniperiph_get_tdm_word_pos(struct uniperif *uni,
 				   unsigned int *word_pos);
 
+int sti_uniperiph_fix_tdm_chan(struct snd_pcm_hw_params *params,
+			       struct snd_pcm_hw_rule *rule);
+
+int sti_uniperiph_fix_tdm_format(struct snd_pcm_hw_params *params,
+				 struct snd_pcm_hw_rule *rule);
+
 #endif
-- 
1.9.1
