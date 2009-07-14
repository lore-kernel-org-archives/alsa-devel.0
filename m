From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/2] ASoC: Blackfin I2S: fix resume handling
Date: Tue, 14 Jul 2009 10:01:40 -0400
Message-ID: <1247580100-15726-2-git-send-email-vapier@gentoo.org>
References: <1247580100-15726-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E1BE243BC
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jul 2009 16:01:46 +0200 (CEST)
In-Reply-To: <1247580100-15726-1-git-send-email-vapier@gentoo.org>
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
 sound/soc/blackfin/bf5xx-i2s.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index af06904..876abad 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -259,22 +259,18 @@ static int bf5xx_i2s_resume(struct snd_soc_dai *dai)
 	if (!dai->active)
 		return 0;
 
-	ret = sport_config_rx(sport_handle, RFSR | RCKFE, RSFSE|0x1f, 0, 0);
+	ret = sport_config_rx(sport, RFSR | RCKFE, RSFSE|0x1f, 0, 0);
 	if (ret) {
 		pr_err("SPORT is busy!\n");
 		return -EBUSY;
 	}
 
-	ret = sport_config_tx(sport_handle, TFSR | TCKFE, TSFSE|0x1f, 0, 0);
+	ret = sport_config_tx(sport, TFSR | TCKFE, TSFSE|0x1f, 0, 0);
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
