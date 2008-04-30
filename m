From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/6] soc - s3c2443-ac97 - Fix checkpatch
	warnings
Date: Wed, 30 Apr 2008 10:10:15 +0100
Message-ID: <1209546619-14389-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1209546619-14389-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C07A6103873
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 11:10:21 +0200 (CEST)
In-Reply-To: <1209546619-14389-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c2443-ac97.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c2443-ac97.c b/sound/soc/s3c24xx/s3c2443-ac97.c
index 1c1ddbf..e81d9a6 100644
--- a/sound/soc/s3c24xx/s3c2443-ac97.c
+++ b/sound/soc/s3c24xx/s3c2443-ac97.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
@@ -30,7 +31,6 @@
 #include <sound/soc.h>
 
 #include <asm/hardware.h>
-#include <asm/io.h>
 #include <asm/plat-s3c/regs-ac97.h>
 #include <asm/arch/regs-gpio.h>
 #include <asm/arch/regs-clock.h>
@@ -47,7 +47,7 @@ struct s3c24xx_ac97_info {
 };
 static struct s3c24xx_ac97_info s3c24xx_ac97;
 
-DECLARE_COMPLETION(ac97_completion);
+static DECLARE_COMPLETION(ac97_completion);
 static u32 codec_ready;
 static DECLARE_MUTEX(ac97_mutex);
 
@@ -290,7 +290,7 @@ static int s3c2443_ac97_trigger(struct snd_pcm_substream *substream, int cmd)
 	u32 ac_glbctrl;
 
 	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
-	switch(cmd) {
+	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
@@ -333,7 +333,7 @@ static int s3c2443_ac97_mic_trigger(struct snd_pcm_substream *substream,
 	u32 ac_glbctrl;
 
 	ac_glbctrl = readl(s3c24xx_ac97.regs + S3C_AC97_GLBCTRL);
-	switch(cmd) {
+	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
@@ -391,7 +391,6 @@ struct snd_soc_cpu_dai s3c2443_ac97_dai[] = {
 		.trigger = s3c2443_ac97_mic_trigger,},
 },
 };
-
 EXPORT_SYMBOL_GPL(s3c2443_ac97_dai);
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
-- 
1.5.5.1
