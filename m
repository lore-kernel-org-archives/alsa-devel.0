From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [RFC PATCH 4/4] ASoC: fsl_ssi: constrain bclk_ratio in
	i2s master mode
Date: Mon,  4 Mar 2019 11:59:55 -0500
Message-ID: <20190304165955.21696-4-TheSven73@gmail.com>
References: <20190304165955.21696-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACB37F896CE
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2019 18:00:07 +0100 (CET)
Received: by mail-it1-x144.google.com with SMTP id m137so8259447ita.0
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2019 09:00:07 -0800 (PST)
In-Reply-To: <20190304165955.21696-1-TheSven73@gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org

The fsl_ssi always has a bclk_ratio of 64 in ssi master
mode, no matter the configured word length.

Add a rule which constrains the bclk_ratio to 64 in
ssi master mode.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0a648229e643..1c5b674fe253 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -627,6 +627,29 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi *ssi)
 	regmap_write(regs, REG_SSI_SOR, SSI_SOR_WAIT(3));
 }
 
+static int fsl_ssi_hw_rule_i2s_master(struct snd_pcm_hw_params *params,
+						struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *it = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_BCLK_RATIO);
+	struct fsl_ssi *ssi = rule->private;
+	struct snd_interval t;
+
+	if (!fsl_ssi_is_i2s_master(ssi))
+		return 0;
+
+	/*
+	 * In i2s master mode, the ssi always generates 32 physical
+	 * bits/channel. This mode always has 2 channels.
+	 * This results in a fixed bclk_ratio of 64.
+	 */
+	memset(&t, 0, sizeof(t));
+	t.min = t.max = 64;
+	t.integer = 1;
+
+	return snd_interval_refine(it, &t);
+}
+
 static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
@@ -648,6 +671,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		snd_pcm_hw_constraint_step(substream->runtime, 0,
 					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 2);
 
+	snd_pcm_hw_rule_add(substream->runtime, 0,
+		SNDRV_PCM_HW_PARAM_BCLK_RATIO,
+		fsl_ssi_hw_rule_i2s_master, ssi,
+		SNDRV_PCM_HW_PARAM_FORMAT, SNDRV_PCM_HW_PARAM_CHANNELS,
+		-1);
+
 	return 0;
 }
 
-- 
2.17.1
