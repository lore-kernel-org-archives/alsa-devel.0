From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH v2]ASoC:blackfin:add ad73311 card driver name
Date: Tue, 13 Sep 2011 14:59:26 -0400
Message-ID: <1315940366-20515-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DF12244E4
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 09:02:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add driver_name in snd_soc_card, asoc will copy this name to driver field of snd_card.
ALSA lib need this info to load the proper card config.

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/blackfin/bf5xx-ad73311.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 732a247..975c6e8 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -192,6 +192,7 @@ static struct snd_soc_dai_link bf5xx_ad73311_dai[] = {
 
 static struct snd_soc_card bf5xx_ad73311 = {
 	.name = "bfin-ad73311",
+	.driver_name = "AD73311",
 	.probe = bf5xx_probe,
 	.dai_link = &bf5xx_ad73311_dai[CONFIG_SND_BF5XX_SPORT_NUM],
 	.num_links = 1,
-- 
1.7.0.4
