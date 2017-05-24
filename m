From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4271: Remove unnecessary additional
	variable definition" to the asoc tree
Date: Wed, 24 May 2017 18:42:01 +0100
Message-ID: <E1dDaIL-0002rf-IZ@debutante>
References: <1495551819-17040-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E6D1F26737C
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:42:10 +0200 (CEST)
In-Reply-To: <1495551819-17040-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4271: Remove unnecessary additional variable definition

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

>From 177e27133ae9c9f5cbc306feaaa53d8fbc75e45f Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 23 May 2017 16:03:39 +0100
Subject: [PATCH] ASoC: cs4271: Remove unnecessary additional variable
 definition

The function already defines a ret variable at the top and makes
no particular use of the shadowed definition, as such remove the
redundant definition.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4271.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index e78b5f055f25..d8824773dc29 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -674,8 +674,6 @@ static int cs4271_common_probe(struct device *dev,
 		cs4271->gpio_nreset = cs4271plat->gpio_nreset;
 
 	if (gpio_is_valid(cs4271->gpio_nreset)) {
-		int ret;
-
 		ret = devm_gpio_request(dev, cs4271->gpio_nreset,
 					"CS4271 Reset");
 		if (ret < 0)
-- 
2.11.0
