From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Fix spacing" to the asoc
	tree
Date: Mon,  8 Apr 2019 14:23:47 +0700 (+07)
Message-ID: <20190408072347.8D473441D3B@finisterre.ee.mobilebroadband>
References: <20190405215430.27419-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D35EF896DE
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2019 09:24:04 +0200 (CEST)
In-Reply-To: <20190405215430.27419-1-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: team@nwdigitalradio.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Fix spacing

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

>From daae4c583534a3e20f08701ef6659066ebf60ca7 Mon Sep 17 00:00:00 2001
From: Annaliese McDermond <nh6z@nh6z.net>
Date: Fri, 5 Apr 2019 14:54:30 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Fix spacing

Fix some cosmetic spacing issues reported by Julia Lawall
<julia.lawall@lip6.fr>.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 667ec2c03508..9e4899eb1d8e 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -165,8 +165,8 @@ static int clk_aic32x4_pll_calc_muldiv(struct clk_aic32x4_pll_muldiv *settings,
 	 * of the multiplier.	This is because we can't do floating point
 	 * math in the kernel.
 	 */
-	 multiplier = (u64) rate * settings->p * 10000;
-	 do_div(multiplier, parent_rate);
+	multiplier = (u64) rate * settings->p * 10000;
+	do_div(multiplier, parent_rate);
 
 	/*
 	 * J can't be over 64, so R can scale this.
-- 
2.20.1
