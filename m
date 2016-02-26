From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: remove unused variable" to the
	asoc tree
Date: Fri, 26 Feb 2016 11:46:57 +0900
Message-ID: <E1aZ8Qj-0006Jl-Au@finisterre>
References: <4678926.Vc1QsAaFQ0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 762C926523B
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 03:47:01 +0100 (CET)
In-Reply-To: <4678926.Vc1QsAaFQ0@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: remove unused variable

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

>From aa3e838869d494c437c693b54d12fe02b96a0aa1 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 25 Feb 2016 23:02:04 +0100
Subject: [PATCH] ASoC: pxa: remove unused variable

As pointed out by Zhangfei Gao, the sspa_div variable in
brownstone_wm8994_hw_params() is completely unused, so as a cleanup
following a prior patch, this removes both the variable and the division.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/brownstone.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 416ea646c3b1..ec522e94b0e2 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -52,7 +52,6 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int freq_out, sspa_mclk, sysclk;
-	int sspa_div;
 
 	if (params_rate(params) > 11025) {
 		freq_out  = params_rate(params) * 512;
@@ -63,7 +62,6 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
 		sysclk    = params_rate(params) * 512;
 		sspa_mclk = params_rate(params) * 64;
 	}
-	sspa_div = freq_out / sspa_mclk;
 
 	snd_soc_dai_set_sysclk(cpu_dai, MMP_SSPA_CLK_AUDIO, freq_out, 0);
 	snd_soc_dai_set_pll(cpu_dai, MMP_SYSCLK, 0, freq_out, sysclk);
-- 
2.7.0
