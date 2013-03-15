From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ALSA: at73c213: Use dev_pm_ops
Date: Fri, 15 Mar 2013 13:25:36 +0100
Message-ID: <1363350336-9537-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-220.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 14A5F264ED5
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 13:23:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: alsa-devel@alsa-project.org

Use dev_pm_ops instead of the deprecated legacy suspend/resume callbacks.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/spi/at73c213.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index 4dd60d8..a1a24b9 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -1075,10 +1075,11 @@ out:
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int snd_at73c213_suspend(struct spi_device *spi, pm_message_t msg)
+#ifdef CONFIG_PM_SLEEP
+
+static int snd_at73c213_suspend(struct device *dev)
 {
-	struct snd_card *card = dev_get_drvdata(&spi->dev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_at73c213 *chip = card->private_data;
 
 	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXDIS));
@@ -1087,9 +1088,9 @@ static int snd_at73c213_suspend(struct spi_device *spi, pm_message_t msg)
 	return 0;
 }
 
-static int snd_at73c213_resume(struct spi_device *spi)
+static int snd_at73c213_resume(struct device *dev)
 {
-	struct snd_card *card = dev_get_drvdata(&spi->dev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_at73c213 *chip = card->private_data;
 
 	clk_enable(chip->board->dac_clk);
@@ -1097,18 +1098,21 @@ static int snd_at73c213_resume(struct spi_device *spi)
 
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(at73c213_pm_ops, snd_at73c213_suspend,
+		snd_at73c213_resume);
+#define AT73C213_PM_OPS (&at73c213_pm_ops)
+
 #else
-#define snd_at73c213_suspend NULL
-#define snd_at73c213_resume NULL
+#define AT73C213_PM_OPS NULL
 #endif
 
 static struct spi_driver at73c213_driver = {
 	.driver		= {
 		.name	= "at73c213",
+		.pm	= AT73C213_PM_OPS,
 	},
 	.probe		= snd_at73c213_probe,
-	.suspend	= snd_at73c213_suspend,
-	.resume		= snd_at73c213_resume,
 	.remove		= snd_at73c213_remove,
 };
 
-- 
1.8.0
