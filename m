From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8962: mark cache_dirty flag after
	software reset in pm_resume" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:40 +0900
Message-ID: <E1ZpOzM-0008TB-IK@finisterre>
References: <1445309232-24094-2-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C100266B43
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:53 +0200 (CEST)
In-Reply-To: <1445309232-24094-2-git-send-email-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8962: mark cache_dirty flag after software reset in pm_resume

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

>From 4eb0f7abcefad2d4c127aa7502d3122635eddab0 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Tue, 20 Oct 2015 11:47:11 +0900
Subject: [PATCH] ASoC: wm8962: mark cache_dirty flag after software reset in
 pm_resume

By doing software reset of wm8962 in pm_resume, all registers which
have already been set will be reset to default value without regmap
interface be involved, thus driver need to mark cache_dirty flag,
to let regcache can be updated by regcache_sync().

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b4eb975..45f06d5f 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3804,6 +3804,8 @@ static int wm8962_runtime_resume(struct device *dev)
 
 	wm8962_reset(wm8962);
 
+	regcache_mark_dirty(wm8962->regmap);
+
 	/* SYSCLK defaults to on; make sure it is off so we can safely
 	 * write to registers if the device is declocked.
 	 */
-- 
2.6.1
