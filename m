From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 1/5] ASoC: Blackfin AC97: add a few missing
	multichannel define handling
Date: Wed, 16 Sep 2009 20:25:08 -0400
Message-ID: <1253147112-5801-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B7EE1038F0
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 02:25:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Somewhere along the line, most of SND_BF5XX_MULTICHAN_SUPPORT handling was
merged, but two places were missed (the probe/resume functions).  Restore
handling of this option so it gets initialized properly.

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-ac97.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 2758b90..e693229 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -277,7 +277,11 @@ static int bf5xx_ac97_resume(struct snd_soc_dai *dai)
 	if (!dai->active)
 		return 0;
 
+#if defined(CONFIG_SND_BF5XX_MULTICHAN_SUPPORT)
+	ret = sport_set_multichannel(sport, 16, 0x3FF, 1);
+#else
 	ret = sport_set_multichannel(sport, 16, 0x1F, 1);
+#endif
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		return -EBUSY;
@@ -334,7 +338,11 @@ static int bf5xx_ac97_probe(struct platform_device *pdev,
 		goto sport_err;
 	}
 	/*SPORT works in TDM mode to simulate AC97 transfers*/
+#if defined(CONFIG_SND_BF5XX_MULTICHAN_SUPPORT)
+	ret = sport_set_multichannel(sport_handle, 16, 0x3FF, 1);
+#else
 	ret = sport_set_multichannel(sport_handle, 16, 0x1F, 1);
+#endif
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		ret = -EBUSY;
-- 
1.6.5.rc1
