From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 1/2] ASoC: Blackfin AC97: fix resume handling
Date: Tue, 14 Jul 2009 10:01:39 -0400
Message-ID: <1247580100-15726-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 58F8B243B5
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jul 2009 16:01:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

There is no need to manually start playback/capture ourselves as the PCM
driver will handle things for us.

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-ac97.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index b1ed423..2758b90 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -277,28 +277,24 @@ static int bf5xx_ac97_resume(struct snd_soc_dai *dai)
 	if (!dai->active)
 		return 0;
 
-	ret = sport_set_multichannel(sport_handle, 16, 0x1F, 1);
+	ret = sport_set_multichannel(sport, 16, 0x1F, 1);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		return -EBUSY;
 	}
 
-	ret = sport_config_rx(sport_handle, IRFS, 0xF, 0, (16*16-1));
+	ret = sport_config_rx(sport, IRFS, 0xF, 0, (16*16-1));
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		return -EBUSY;
 	}
 
-	ret = sport_config_tx(sport_handle, ITFS, 0xF, 0, (16*16-1));
+	ret = sport_config_tx(sport, ITFS, 0xF, 0, (16*16-1));
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		return -EBUSY;
 	}
 
-	if (dai->capture.active)
-		sport_rx_start(sport);
-	if (dai->playback.active)
-		sport_tx_start(sport);
 	return 0;
 }
 
-- 
1.6.3.3
