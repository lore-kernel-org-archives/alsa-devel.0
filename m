From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: WM8990: msleep() takes milliseconds not
	jiffies
Date: Fri, 14 Jan 2011 15:59:13 +0000
Message-ID: <1295020753-1453-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C3F7524371
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 16:59:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8990.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 5c87a63..100aeee 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1183,7 +1183,7 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 				     WM8990_VMIDTOG);
 
 			/* Delay to allow output caps to discharge */
-			msleep(msecs_to_jiffies(300));
+			msleep(300);
 
 			/* Disable VMIDTOG */
 			snd_soc_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
@@ -1195,17 +1195,17 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 			/* Enable outputs */
 			snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1b00);
 
-			msleep(msecs_to_jiffies(50));
+			msleep(50);
 
 			/* Enable VMID at 2x50k */
 			snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f02);
 
-			msleep(msecs_to_jiffies(100));
+			msleep(100);
 
 			/* Enable VREF */
 			snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f03);
 
-			msleep(msecs_to_jiffies(600));
+			msleep(600);
 
 			/* Enable BUFIOEN */
 			snd_soc_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
@@ -1250,7 +1250,7 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 		/* Disable VMID */
 		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f01);
 
-		msleep(msecs_to_jiffies(300));
+		msleep(300);
 
 		/* Enable all output discharge bits */
 		snd_soc_write(codec, WM8990_ANTIPOP1, WM8990_DIS_LLINE |
-- 
1.7.3.5
