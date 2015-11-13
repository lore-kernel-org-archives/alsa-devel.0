From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: fix rockchip 64-bit build warning
Date: Fri, 13 Nov 2015 18:15:56 +0100
Message-ID: <5376543.c9BV6sJg6q@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 583D2265D3C
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2015 18:15:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The rk_spdif_probe uses the device match data as a token to identify a
particular device, but accidentally casts a pointer to 'int', which is
not portable, as gcc points out in this warning on arm64:

rockchip_spdif.c: In function 'rk_spdif_probe':
rockchip_spdif.c:283:6: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

This changes the logic to compare two pointer values instead, using
the same cast that was used for initializing the value in the first
place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
