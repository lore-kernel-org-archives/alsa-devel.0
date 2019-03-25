From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8810: fix the issue of 64 bits
	division" to the asoc tree
Date: Mon, 25 Mar 2019 12:22:10 +0000 (GMT)
Message-ID: <20190325122210.B3C3311288F1@debutante.sirena.org.uk>
References: <20190322042535.30650-1-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E3DAF80C15
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 13:22:12 +0100 (CET)
In-Reply-To: <20190322042535.30650-1-KCHSU0@nuvoton.com>
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

   ASoC: nau8810: fix the issue of 64 bits division

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

>From 3a9ce0f1b2961f6c3ad2a49dcf85449784c18bb5 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Fri, 22 Mar 2019 12:25:35 +0800
Subject: [PATCH] ASoC: nau8810: fix the issue of 64 bits division

Do division with div_u64 for the PLL calculation.
These errors are fixed and list as follows:
1."__udivdi3" [sound/soc/codecs/snd-soc-nau8810.ko] undefined!
2."__aeabi_uldivmod" [sound/soc/codecs/snd-soc-nau8810.ko] undefined!
3. nau8810.c:(.text.nau8810_calc_pll+0xd8): undefined reference to
`__udivdi3'

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8810.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index 125e205e6687..dd82c65cfa7f 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -505,7 +505,8 @@ static int nau8810_calc_pll(unsigned int pll_in,
 	f2_max = 0;
 	scal_sel = ARRAY_SIZE(nau8810_mclk_scaler);
 	for (i = 0; i < ARRAY_SIZE(nau8810_mclk_scaler); i++) {
-		f2 = 256ULL * fs * 4 * nau8810_mclk_scaler[i] / 10;
+		f2 = 256ULL * fs * 4 * nau8810_mclk_scaler[i];
+		f2 = div_u64(f2, 10);
 		if (f2 > NAU_PLL_FREQ_MIN && f2 < NAU_PLL_FREQ_MAX &&
 			f2_max < f2) {
 			f2_max = f2;
-- 
2.20.1
