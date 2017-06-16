From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: sai: manage master clock" to the
	asoc tree
Date: Fri, 16 Jun 2017 18:49:51 +0100
Message-ID: <E1dLvNX-0005bY-5x@debutante>
References: <1497615334-7156-8-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B026267545
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 19:51:50 +0200 (CEST)
In-Reply-To: <1497615334-7156-8-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mark.rutland@arm.com, robh@kernel.org, alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: sai: manage master clock

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

>From 12093366981de5060379ad7fa173a1d459c49572 Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Fri, 16 Jun 2017 14:15:34 +0200
Subject: [PATCH] ASoC: stm32: sai: manage master clock

Disable master clock by default, and activate
it only when requested.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 2466af0343db..ce48c02db051 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -220,8 +220,15 @@ static int stm32_sai_set_sysclk(struct snd_soc_dai *cpu_dai,
 				int clk_id, unsigned int freq, int dir)
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
 
 	if ((dir == SND_SOC_CLOCK_OUT) && sai->master) {
+		ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
+					 SAI_XCR1_NODIV,
+					 (unsigned int)~SAI_XCR1_NODIV);
+		if (ret < 0)
+			return ret;
+
 		sai->mclk_rate = freq;
 		dev_dbg(cpu_dai->dev, "SAI MCLK frequency is %uHz\n", freq);
 	}
@@ -356,6 +363,10 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	}
 	cr1_mask |= SAI_XCR1_SLAVE;
 
+	/* do not generate master by default */
+	cr1 |= SAI_XCR1_NODIV;
+	cr1_mask |= SAI_XCR1_NODIV;
+
 	ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, cr1_mask, cr1);
 	if (ret < 0) {
 		dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
@@ -652,6 +663,9 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(sai->regmap, STM_SAI_IMR_REGX, SAI_XIMR_MASK, 0);
 
+	regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, SAI_XCR1_NODIV,
+			   SAI_XCR1_NODIV);
+
 	clk_disable_unprepare(sai->sai_ck);
 	sai->substream = NULL;
 }
-- 
2.11.0
