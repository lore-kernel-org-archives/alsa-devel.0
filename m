From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: helper functions to fix tdm
	runtime params" to the asoc tree
Date: Tue, 12 Apr 2016 07:31:04 +0100
Message-ID: <E1aprqq-0008G3-P4@debutante>
References: <1460021136-27822-6-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5308E265335
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 08:31:09 +0200 (CEST)
In-Reply-To: <1460021136-27822-6-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: helper functions to fix tdm runtime params

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 72199787662612a7747248f8b56bc5d42694538f Mon Sep 17 00:00:00 2001
From: Moise Gergaud <moise.gergaud@st.com>
Date: Thu, 7 Apr 2016 11:25:34 +0200
Subject: [PATCH] ASoC: sti: helper functions to fix tdm runtime params

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/sti_uniperif.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/sti/uniperif.h     |  6 ++++++
 2 files changed, 52 insertions(+)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 0c2474c16c11..d49badec9e62 100644
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
index fb8e427754b6..17d5d1030741 100644
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
2.8.0.rc3
