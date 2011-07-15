From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Handle spurious wm_hubs DC servo done
	interrupts
Date: Fri, 15 Jul 2011 18:01:52 +0900
Message-ID: <1310720512-9813-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AA068103A28
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jul 2011 11:02:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Don't assume the first fire indicates that we're done.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index ced41e8..4de6794 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -66,8 +66,8 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, unsigned int op)
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg;
 	int count = 0;
+	int timeout;
 	unsigned int val;
-	unsigned long timeout;
 
 	val = op | WM8993_DCS_ENA_CHAN_0 | WM8993_DCS_ENA_CHAN_1;
 
@@ -76,21 +76,23 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, unsigned int op)
 
 	dev_dbg(codec->dev, "Waiting for DC servo...\n");
 
-	if (hubs->dcs_done_irq) {
-		timeout = wait_for_completion_timeout(&hubs->dcs_done,
-						      msecs_to_jiffies(500));
-		if (timeout == 0)
-			dev_warn(codec->dev, "No DC servo interrupt\n");
+	if (hubs->dcs_done_irq)
+		timeout = 4;
+	else
+		timeout = 400;
 
-		reg = snd_soc_read(codec, WM8993_DC_SERVO_0);
-	} else {
-		do {
-			count++;
+	do {
+		count++;
+
+		if (hubs->dcs_done_irq)
+			wait_for_completion_timeout(&hubs->dcs_done,
+						    msecs_to_jiffies(250));
+		else
 			msleep(1);
-			reg = snd_soc_read(codec, WM8993_DC_SERVO_0);
-			dev_dbg(codec->dev, "DC servo: %x\n", reg);
-		} while (reg & op && count < 400);
-	}
+
+		reg = snd_soc_read(codec, WM8993_DC_SERVO_0);
+		dev_dbg(codec->dev, "DC servo: %x\n", reg);
+	} while (reg & op && count < timeout);
 
 	if (reg & op)
 		dev_err(codec->dev, "Timed out waiting for DC Servo %x\n",
-- 
1.7.5.4
