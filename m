From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add delay information for Samsung IISv2
	DAIs
Date: Thu,  4 Mar 2010 12:05:58 +0000
Message-ID: <1267704358-31501-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5677710382A
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 13:06:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Jassi <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Report the current FIFO depth when delay is queried. The FIFO is only
16 frames deep so the latency will be at most a couple of miliseconds
(and we tend to end up reporting zero most of the time) but it may
help some applications.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index e994d83..04a00fa 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -550,6 +550,21 @@ static int s3c2412_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
+static long s3c2412_i2s_delay(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	struct s3c_i2sv2_info *i2s = to_info(dai);
+	u32 reg = readl(i2s->regs + S3C2412_IISFIC);
+	int delay;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		delay = S3C2412_IISFIC_TXCOUNT(reg);
+	else
+		delay = S3C2412_IISFIC_RXCOUNT(reg);
+
+	return delay;
+}
+
 /* default table of all avaialable root fs divisors */
 static unsigned int iis_fs_tab[] = { 256, 512, 384, 768 };
 
@@ -736,6 +751,10 @@ int s3c_i2sv2_register_dai(struct snd_soc_dai *dai)
 	ops->set_fmt = s3c2412_i2s_set_fmt;
 	ops->set_clkdiv = s3c2412_i2s_set_clkdiv;
 
+	/* Allow overriding by (for example) IISv4 */
+	if (!ops->delay)
+		ops->delay = s3c2412_i2s_delay,
+
 	dai->suspend = s3c2412_i2s_suspend;
 	dai->resume = s3c2412_i2s_resume;
 
-- 
1.7.0
