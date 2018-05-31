From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98088: use match_string() helper" to the asoc tree
Date: Thu, 31 May 2018 17:09:45 +0100
Message-ID: <E1fOQ93-0003CU-AS@debutante>
References: <1527765086-19873-17-git-send-email-xieyisheng1@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527765086-19873-17-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Yisheng Xie <xieyisheng1@huawei.com>Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.orgYisheng Xie <xieyisheng1@huawei.com>alsa-devel@alsa-project.orgTakashi Iwai <tiwai@suse.com>Liam Girdwood <lgirdwood@gmail.com>, andy.shevchenko@gmail.comMark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98088: use match_string() helper

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

>From 3470631510fa383feac5969b436499ca9bad03b8 Mon Sep 17 00:00:00 2001
From: Xie Yisheng <xieyisheng1@huawei.com>
Date: Thu, 31 May 2018 19:11:21 +0800
Subject: [PATCH] ASoC: max98088: use match_string() helper

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98088.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 865f64c40b79..fb515aaa54fc 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1382,15 +1382,12 @@ static const char *eq_mode_name[] = {"EQ1 Mode", "EQ2 Mode"};
 
 static int max98088_get_channel(struct snd_soc_component *component, const char *name)
 {
-	int i;
+	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(eq_mode_name); i++)
-		if (strcmp(name, eq_mode_name[i]) == 0)
-			return i;
-
-	/* Shouldn't happen */
-	dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
-	return -EINVAL;
+	ret = match_string(eq_mode_name, ARRAY_SIZE(eq_mode_name), name);
+	if (ret < 0)
+		dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
+	return ret;
 }
 
 static void max98088_setup_eq1(struct snd_soc_component *component)
-- 
2.17.0
