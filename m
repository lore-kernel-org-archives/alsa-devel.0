From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8810: fix the typo of function name"
	to the asoc tree
Date: Wed, 13 Mar 2019 15:38:26 +0000 (GMT)
Message-ID: <20190313153826.DBC2B1128B97@debutante.sirena.org.uk>
References: <20190313070416.15917-1-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72990F896F3
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 16:38:29 +0100 (CET)
In-Reply-To: <20190313070416.15917-1-KCHSU0@nuvoton.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8810: fix the typo of function name

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

>From 709a9b8a1f4ff6c34c0a6e6fefb31cfb23b19bf5 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Wed, 13 Mar 2019 15:04:16 +0800
Subject: [PATCH] ASoC: nau8810: fix the typo of function name

Correct the typo at the function name.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8810.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index e7fd0b2645ea..39512a78a556 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -493,7 +493,7 @@ static int nau8810_set_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int nau88l0_calc_pll(unsigned int pll_in,
+static int nau8810_calc_pll(unsigned int pll_in,
 	unsigned int fs, struct nau8810_pll *pll_param)
 {
 	u64 f2, f2_max, pll_ratio;
@@ -542,7 +542,7 @@ static int nau8810_set_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	int ret, fs;
 
 	fs = freq_out / 256;
-	ret = nau88l0_calc_pll(freq_in, fs, pll_param);
+	ret = nau8810_calc_pll(freq_in, fs, pll_param);
 	if (ret < 0) {
 		dev_err(nau8810->dev, "Unsupported input clock %d\n", freq_in);
 		return ret;
-- 
2.20.1
