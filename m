From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove one extraneous 'const'" to the asoc tree
Date: Tue, 14 Jun 2016 16:09:22 +0100
Message-ID: <E1bCpxy-0001Yn-DT@finisterre>
References: <5926900.hCFXH4RQH6@wuerfel>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5926900.hCFXH4RQH6@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Nikesh Oswal <Nikesh.Oswal@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.orgCharles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove one extraneous 'const'

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

>From 8f273aacc070490f2d5e02e52bbaa35d53a4df15 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Jun 2016 12:17:52 +0200
Subject: [PATCH] ASoC: remove one extraneous 'const'

A recent commit made a few arrays 'const', but also added the
same attribute to a function return type, where it makes no
sense, and we get a warning when building with W=1:

sound/soc/codecs/arizona.c:1725:27: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
 static const char * const arizona_dai_clk_str(int clk_id)

This removes it again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 73eab6c462ac..1ff0ed2d8de9 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1711,7 +1711,7 @@ restore_aif:
 	return ret;
 }
 
-static const char * const arizona_dai_clk_str(int clk_id)
+static const char *arizona_dai_clk_str(int clk_id)
 {
 	switch (clk_id) {
 	case ARIZONA_CLK_SYSCLK:
-- 
2.8.1
