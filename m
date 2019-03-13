From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: i2s: improve channel capabilities handling" to
 the asoc tree
Date: Wed, 13 Mar 2019 15:38:48 +0000 (GMT)
Message-ID: <20190313153848.88A7B1128B97@debutante.sirena.org.uk>
References: <1552317990-24219-3-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1552317990-24219-3-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, perex@perex.cz, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: i2s: improve channel capabilities handling

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c2dc8b2c114c22d7a04cf26a7c7d04faaa757143 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 11 Mar 2019 16:26:29 +0100
Subject: [PATCH] ASoC: stm32: i2s: improve channel capabilities handling

Use alsa snd_pcm_hw_constraint_single service to manage
channels restriction. This provides better status on driver
limitations, to the application.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
