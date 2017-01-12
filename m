From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ASoC: rt5660: use msleep() for long delay
Date: Thu, 12 Jan 2017 11:47:45 +0100
Message-ID: <1484218065-28637-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

ulseep_range() uses hrtimers and provides no advantage over msleep()
for larger delays. For this large delay msleep() is preferable.

Link: http://lkml.org/lkml/2017/1/11/377
Fixes: commit 2b26dd4c1fc5 ("ASoC: rt5660: add rt5660 codec driver")
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem was found by cocinelle script.

Patch was compile tested with: x86_64_defconfig + CONFIG_COMPILE_TEST=y
SND_SOC=m + SND_SOC_ALL_CODECS=m (implies SND_SOC_RT5660=m)
(2 sparse warnings - fix in a seperate patch)

Patch is aginast 4.10-rc3 (localversion-next is next-20170112)

 sound/soc/codecs/rt5660.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index 76cf76a..78a77bc 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -1152,7 +1152,7 @@ static int rt5660_resume(struct snd_soc_codec *codec)
 	struct rt5660_priv *rt5660 = snd_soc_codec_get_drvdata(codec);
 
 	if (rt5660->pdata.poweroff_codec_in_suspend)
-		usleep_range(350000, 400000);
+		msleep(350);
 
 	regcache_cache_only(rt5660->regmap, false);
 	regcache_sync(rt5660->regmap);
-- 
2.1.4
