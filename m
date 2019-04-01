From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: remove set but not
	used variable 'dai_name'" to the asoc tree
Date: Mon,  1 Apr 2019 09:52:54 +0100 (BST)
Message-ID: <20190401085254.CF405440082@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56B04F89610
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 10:53:00 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: remove set but not used variable 'dai_name'

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

>From 35146467bd43704c52d1d5760af9839a10ad5b12 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 25 Mar 2019 03:17:40 +0000
Subject: [PATCH] ASoC: simple-card-utils: remove set but not used variable
 'dai_name'

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_parse_clk':
sound/soc/generic/simple-card-utils.c:164:18: warning:
 parameter 'dai_name' set but not used [-Wunused-but-set-parameter]

It's not used since commit 0580dde59438 ("ASoC: simple-card-utils: add
asoc_simple_debug_info()"), so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 4ed68348f939..db1458a19985 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -173,10 +173,8 @@ int asoc_simple_parse_clk(struct device *dev,
 	 * see
 	 *	soc-core.c :: snd_soc_init_multicodec()
 	 */
-	if (dlc) {
+	if (dlc)
 		dai_of_node	= dlc->of_node;
-		dai_name	= dlc->dai_name;
-	}
 
 	/*
 	 * Parse dai->sysclk come from "clocks = <&xxx>"
-- 
2.20.1
