From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: add missing \n to end of pr_err messages" to the asoc tree
Date: Sat, 24 Sep 2016 22:58:11 -0700
Message-ID: <E1bo2S3-0002rS-9Z@finisterre>
References: <20160916173053.13138-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160916173053.13138-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, trivial@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: add missing \n to end of pr_err messages

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

>From 5f6af6a75ef3fed8eb220217ecd7d1c7ef8571d9 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 16 Sep 2016 18:30:53 +0100
Subject: [PATCH] ASoC: samsung: add missing \n to end of pr_err messages

Trival fix, some pr_err messages are missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/ac97.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 5eafb6667a3b..97d6700b1009 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -74,7 +74,7 @@ static void s3c_ac97_activate(struct snd_ac97 *ac97)
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
 	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		pr_err("AC97: Unable to activate!");
+		pr_err("AC97: Unable to activate!\n");
 }
 
 static unsigned short s3c_ac97_read(struct snd_ac97 *ac97,
@@ -100,7 +100,7 @@ static unsigned short s3c_ac97_read(struct snd_ac97 *ac97,
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
 	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		pr_err("AC97: Unable to read!");
+		pr_err("AC97: Unable to read!\n");
 
 	stat = readl(s3c_ac97.regs + S3C_AC97_STAT);
 	addr = (stat >> 16) & 0x7f;
@@ -137,7 +137,7 @@ static void s3c_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
 	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		pr_err("AC97: Unable to write!");
+		pr_err("AC97: Unable to write!\n");
 
 	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
 	ac_codec_cmd |= S3C_AC97_CODEC_CMD_READ;
-- 
2.9.3
