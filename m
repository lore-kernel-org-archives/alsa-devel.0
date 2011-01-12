From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: Blackfin TDM: fix missed snd_soc_dai_get_drvdata update
Date: Tue, 11 Jan 2011 23:08:19 -0500
Message-ID: <1294805299-5265-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, stable@kernel.org, stable-review@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

One spot was missed in this driver when converting from
snd_soc_dai.private_data to snd_soc_dai_get_drvdata.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-tdm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index 1251239..b2cf239 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -210,7 +210,7 @@ static int bf5xx_tdm_set_channel_map(struct snd_soc_dai *dai,
 #ifdef CONFIG_PM
 static int bf5xx_tdm_suspend(struct snd_soc_dai *dai)
 {
-	struct sport_device *sport = dai->private_data;
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
 
 	if (!dai->active)
 		return 0;
-- 
1.7.4.rc1
