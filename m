From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fix rockchip 64-bit build warning" to
	the asoc tree
Date: Mon, 16 Nov 2015 17:02:45 +0000
Message-ID: <E1ZyNAz-0005kj-4s@debutante>
References: <5376543.c9BV6sJg6q@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DC2F2604E4
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 18:02:54 +0100 (CET)
In-Reply-To: <5376543.c9BV6sJg6q@wuerfel>
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

   ASoC: fix rockchip 64-bit build warning

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

>From 0e18d457b31e98e68f6918e41c85ad3b736c4789 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 13 Nov 2015 18:15:56 +0100
Subject: [PATCH] ASoC: fix rockchip 64-bit build warning

The rk_spdif_probe uses the device match data as a token to identify a
particular device, but accidentally casts a pointer to 'int', which is
not portable, as gcc points out in this warning on arm64:

rockchip_spdif.c: In function 'rk_spdif_probe':
rockchip_spdif.c:283:6: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

This changes the logic to compare two pointer values instead, using
the same cast that was used for initializing the value in the first
place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index a38a3029062c..ac72ff5055bb 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -280,7 +280,7 @@ static int rk_spdif_probe(struct platform_device *pdev)
 	int ret;
 
 	match = of_match_node(rk_spdif_match, np);
-	if ((int) match->data == RK_SPDIF_RK3288) {
+	if (match->data == (void *)RK_SPDIF_RK3288) {
 		struct regmap *grf;
 
 		grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
-- 
2.6.2
