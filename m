From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42xx8: Add regcache mask dirty" to
	the asoc tree
Date: Fri, 17 May 2019 11:34:39 +0100 (BST)
Message-ID: <20190517103439.467241126D72@debutante.sirena.org.uk>
References: <e6fb6598dd863b74241e10d14652d12fe701845d.1557986478.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7F3EF8972A
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2019 12:34:53 +0200 (CEST)
In-Reply-To: <e6fb6598dd863b74241e10d14652d12fe701845d.1557986478.git.shengjiu.wang@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com, linux-kernel@vger.kernel.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42xx8: Add regcache mask dirty

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From ad6eecbfc01c987e0253371f274c3872042e4350 Mon Sep 17 00:00:00 2001
From: "S.j. Wang" <shengjiu.wang@nxp.com>
Date: Thu, 16 May 2019 06:04:29 +0000
Subject: [PATCH] ASoC: cs42xx8: Add regcache mask dirty

Add regcache_mark_dirty before regcache_sync for power
of codec may be lost at suspend, then all the register
need to be reconfigured.

Fixes: 0c516b4ff85c ("ASoC: cs42xx8: Add codec driver
support for CS42448/CS42888")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42xx8.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index ebb9e0cf8364..28a4ac36c4f8 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -558,6 +558,7 @@ static int cs42xx8_runtime_resume(struct device *dev)
 	msleep(5);
 
 	regcache_cache_only(cs42xx8->regmap, false);
+	regcache_mark_dirty(cs42xx8->regmap);
 
 	ret = regcache_sync(cs42xx8->regmap);
 	if (ret) {
-- 
2.20.1
