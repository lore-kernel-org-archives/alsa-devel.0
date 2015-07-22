From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4349: Fix up setting PWR_DWN bit" to
	the asoc tree
Date: Wed, 22 Jul 2015 10:57:28 +0100
Message-ID: <E1ZHqmG-00077W-Ms@debutante>
References: <1437531753.3325.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E629426528F
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 11:57:39 +0200 (CEST)
In-Reply-To: <1437531753.3325.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4349: Fix up setting PWR_DWN bit

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

>From ec12693e5d03c7e6399ba1e9150908527b809f33 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 22 Jul 2015 10:22:33 +0800
Subject: [PATCH] ASoC: cs4349: Fix up setting PWR_DWN bit

The PWR_DWN is Bit 7, so current code does not set the PWR_DWN bit. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4349.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 852be858bb9f..0d010c2b6021 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -326,7 +326,7 @@ static int cs4349_runtime_suspend(struct device *dev)
 	struct cs4349_private *cs4349 = dev_get_drvdata(dev);
 	int ret;
 
-	ret = regmap_update_bits(cs4349->regmap, CS4349_MISC, PWR_DWN, 1);
+	ret = regmap_update_bits(cs4349->regmap, CS4349_MISC, PWR_DWN, PWR_DWN);
 	if (ret < 0)
 		return ret;
 
-- 
2.1.4
