From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 2/3] ASoC: stm32: i2s: improve channel capabilities handling
Date: Mon, 11 Mar 2019 16:26:29 +0100
Message-ID: <1552317990-24219-3-git-send-email-olivier.moysan@st.com>
References: <1552317990-24219-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552317990-24219-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Use alsa snd_pcm_hw_constraint_single service to manage
channels restriction. This provides better status on driver
limitations, to the application.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 783b33497435..06bbbef74b3a 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -496,12 +496,6 @@ static int stm32_i2s_configure(struct snd_soc_dai *cpu_dai,
 	unsigned int fthlv;
 	int ret;
 
-	if ((params_channels(params) == 1) &&
-	    ((i2s->fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_DSP_A)) {
-		dev_err(cpu_dai->dev, "Mono mode supported only by DSP_A\n");
-		return -EINVAL;
-	}
-
 	switch (format) {
 	case 16:
 		cfgr = I2S_CGFR_DATLEN_SET(I2S_I2SMOD_DATLEN_16);
@@ -551,6 +545,10 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 	i2s->substream = substream;
 	spin_unlock_irqrestore(&i2s->irq_lock, flags);
 
+	if ((i2s->fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_DSP_A)
+		snd_pcm_hw_constraint_single(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+
 	ret = clk_prepare_enable(i2s->i2sclk);
 	if (ret < 0) {
 		dev_err(cpu_dai->dev, "Failed to enable clock: %d\n", ret);
-- 
2.7.4
