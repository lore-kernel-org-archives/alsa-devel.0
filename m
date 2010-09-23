From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Add debug logging for s3c-ac97 resets
Date: Thu, 23 Sep 2010 19:41:10 +0100
Message-ID: <1285267270-22426-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1285267270-22426-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5640C244DA
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 20:41:14 +0200 (CEST)
In-Reply-To: <1285267270-22426-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Helps tracing errors further up the stack.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-ac97.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-ac97.c b/sound/soc/s3c24xx/s3c-ac97.c
index 31e2b3d..f891eb7 100644
--- a/sound/soc/s3c24xx/s3c-ac97.c
+++ b/sound/soc/s3c24xx/s3c-ac97.c
@@ -163,6 +163,7 @@ static void s3c_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 
 static void s3c_ac97_cold_reset(struct snd_ac97 *ac97)
 {
+	pr_debug("AC97: Cold reset\n");
 	writel(S3C_AC97_GLBCTRL_COLDRESET,
 			s3c_ac97.regs + S3C_AC97_GLBCTRL);
 	msleep(1);
@@ -179,6 +180,8 @@ static void s3c_ac97_warm_reset(struct snd_ac97 *ac97)
 	if (stat == S3C_AC97_GLBSTAT_MAINSTATE_ACTIVE)
 		return; /* Return if already active */
 
+	pr_debug("AC97: Warm reset\n");
+
 	writel(S3C_AC97_GLBCTRL_WARMRESET, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 	msleep(1);
 
-- 
1.7.1
