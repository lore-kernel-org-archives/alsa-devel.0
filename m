From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Convert s3c-ac97 to pr_() macros
Date: Thu, 23 Sep 2010 19:41:09 +0100
Message-ID: <1285267270-22426-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F706244D5
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 20:41:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Could use dev_() but we'd have to remember the struct device somewhere
and it wouldn't make the logging clearer.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-ac97.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-ac97.c b/sound/soc/s3c24xx/s3c-ac97.c
index 26f4ed9..31e2b3d 100644
--- a/sound/soc/s3c24xx/s3c-ac97.c
+++ b/sound/soc/s3c24xx/s3c-ac97.c
@@ -89,7 +89,7 @@ static void s3c_ac97_activate(struct snd_ac97 *ac97)
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
 	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		printk(KERN_ERR "AC97: Unable to activate!");
+		pr_err("AC97: Unable to activate!");
 }
 
 static unsigned short s3c_ac97_read(struct snd_ac97 *ac97,
@@ -115,14 +115,15 @@ static unsigned short s3c_ac97_read(struct snd_ac97 *ac97,
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
 	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		printk(KERN_ERR "AC97: Unable to read!");
+		pr_err("AC97: Unable to read!");
 
 	stat = readl(s3c_ac97.regs + S3C_AC97_STAT);
 	addr = (stat >> 16) & 0x7f;
 	data = (stat & 0xffff);
 
 	if (addr != reg)
-		printk(KERN_ERR "s3c-ac97: req addr = %02x, rep addr = %02x\n", reg, addr);
+		pr_err("s3c-ac97: req addr = %02x, rep addr = %02x\n",
+			reg, addr);
 
 	mutex_unlock(&s3c_ac97.lock);
 
@@ -151,7 +152,7 @@ static void s3c_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
 	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		printk(KERN_ERR "AC97: Unable to write!");
+		pr_err("AC97: Unable to write!");
 
 	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
 	ac_codec_cmd |= S3C_AC97_CODEC_CMD_READ;
@@ -442,7 +443,7 @@ static __devinit int s3c_ac97_probe(struct platform_device *pdev)
 	ret = request_irq(irq_res->start, s3c_ac97_irq,
 					IRQF_DISABLED, "AC97", NULL);
 	if (ret < 0) {
-		printk(KERN_ERR "s3c-ac97: interrupt request failed.\n");
+		dev_err(&pdev->dev, "s3c-ac97: interrupt request failed.\n");
 		goto err4;
 	}
 
-- 
1.7.1
