From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add __printf attribute" to the asoc tree
Date: Wed, 24 Aug 2016 19:05:11 +0100
Message-ID: <E1bccY3-0005oc-Lo@debutante>
References: <20160823085122.5859-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160823085122.5859-1-nicolas.iooss_linux@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add __printf attribute

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

>From e5668caec5698f14f310fb06bb39595b21d2fe4a Mon Sep 17 00:00:00 2001
From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Date: Tue, 23 Aug 2016 10:51:22 +0200
Subject: [PATCH] ASoC: simple-card-utils: add __printf attribute

asoc_simple_card_set_dailink_name() uses devm_kvasprintf() to format
some of its arguments.  Adding a __printf attribute to this function
makes it possible to detect at compile-time errors related to format
strings.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 403ec92164fc..fd6412551145 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -27,6 +27,7 @@ int asoc_simple_card_parse_daifmt(struct device *dev,
 				  struct device_node *codec,
 				  char *prefix,
 				  unsigned int *retfmt);
+__printf(3, 4)
 int asoc_simple_card_set_dailink_name(struct device *dev,
 				      struct snd_soc_dai_link *dai_link,
 				      const char *fmt, ...);
-- 
2.8.1
