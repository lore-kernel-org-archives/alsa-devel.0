From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Fix typo in comment" to the
	asoc tree
Date: Mon,  1 Apr 2019 09:53:04 +0100 (BST)
Message-ID: <20190401085304.C0D6B440085@finisterre.ee.mobilebroadband>
References: <20190327152451.2870-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF297F8962D
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 10:53:09 +0200 (CEST)
In-Reply-To: <20190327152451.2870-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Fix typo in comment

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

>From 809589a94dcce27cb5f2081280d1155c71ae45f7 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 27 Mar 2019 15:24:51 +0000
Subject: [PATCH] ASoC: wm_adsp: Fix typo in comment

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 5e615fbddf9a..0aa62b26f61c 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3263,7 +3263,7 @@ static void wm_halo_stop_core(struct wm_adsp *dsp)
 	regmap_update_bits(dsp->regmap, dsp->base + HALO_CCM_CORE_CONTROL,
 			   HALO_CORE_EN, 0);
 
-	/* reset halo core with CORE_SOFT_REEST */
+	/* reset halo core with CORE_SOFT_RESET */
 	regmap_update_bits(dsp->regmap, dsp->base + HALO_CORE_SOFT_RESET,
 			   HALO_CORE_SOFT_RESET_MASK, 1);
 }
-- 
2.20.1
