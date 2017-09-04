From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Fix error handling path
	in i2s_set_sysclk()" to the asoc tree
Date: Mon,  4 Sep 2017 13:46:38 +0100 (BST)
Message-ID: <20170904124638.DB4C44400FC@finisterre.ee.mobilebroadband>
References: <20170903122902.3591-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 16D1D267026
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 14:46:40 +0200 (CEST)
In-Reply-To: <20170903122902.3591-1-christophe.jaillet@wanadoo.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, linux-kernel@vger.kernel.org, tiwai@suse.com, kernel-janitors@vger.kernel.org, lgirdwood@gmail.com, krzk@kernel.org, broonie@kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, s.nawrocki@samsung.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Fix error handling path in i2s_set_sysclk()

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

>From 6431a7e36652517df82855ee79c8240001812a55 Mon Sep 17 00:00:00 2001
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Date: Sun, 3 Sep 2017 14:29:02 +0200
Subject: [PATCH] ASoC: samsung: i2s: Fix error handling path in
 i2s_set_sysclk()

If 'clk_prepare_enable()' fails, we must 'put' the corresponding clock.
Othewise, there is a resource leak.

Fixes: f5c97c7b0438 ("ASoC: samsung: i2s: Handle return value of clk_prepare_enable.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 10a4da06c0a1..d7e7f4244d38 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -552,8 +552,11 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 			}
 
 			ret = clk_prepare_enable(i2s->op_clk);
-			if (ret)
+			if (ret) {
+				clk_put(i2s->op_clk);
+				i2s->op_clk = NULL;
 				goto err;
+			}
 			i2s->rclk_srcrate = clk_get_rate(i2s->op_clk);
 
 			/* Over-ride the other's */
-- 
2.13.2
