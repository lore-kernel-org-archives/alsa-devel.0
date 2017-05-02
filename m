From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ASoC: hisilicon: localize functions
	without external linkage
Date: Tue,  2 May 2017 22:33:02 +0900
Message-ID: <20170502133303.19622-4-o-takashi@sakamocchi.jp>
References: <20170502133303.19622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 4B697266BC9
 for <alsa-devel@alsa-project.org>; Tue,  2 May 2017 15:33:08 +0200 (CEST)
In-Reply-To: <20170502133303.19622-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Andy Green <andy.green@linaro.org>, John Stultz <john.stultz@linaro.org>
List-Id: alsa-devel@alsa-project.org

A driver for hi6210 sound interface on hi6220 boards includes some
functions which has no external linkage. These functions should have
static qualifier.

This commit adds the qualifier to localize the functions. This issue is
detected by sparse:

hi6210-i2s.c:100:5: warning: symbol 'hi6210_i2s_startup' was not declared. Should it be static?
hi6210-i2s.c:178:6: warning: symbol 'hi6210_i2s_shutdown' was not declared. Should it be static?
hi6210-i2s.c:527:27: warning: symbol 'hi6210_i2s_dai_init' was not declared. Should it be static?

Cc: John Stultz <john.stultz@linaro.org>
Cc: Andy Green <andy.green@linaro.org>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/hisilicon/hi6210-i2s.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 45163e5..b193d3b 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -97,8 +97,8 @@ static inline u32 hi6210_read_reg(struct hi6210_i2s *i2s, int reg)
 	return readl(i2s->base + reg);
 }
 
-int hi6210_i2s_startup(struct snd_pcm_substream *substream,
-		     struct snd_soc_dai *cpu_dai)
+static int hi6210_i2s_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *cpu_dai)
 {
 	struct hi6210_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
 	int ret, n;
@@ -175,8 +175,9 @@ int hi6210_i2s_startup(struct snd_pcm_substream *substream,
 
 	return 0;
 }
-void hi6210_i2s_shutdown(struct snd_pcm_substream *substream,
-		       struct snd_soc_dai *cpu_dai)
+
+static void hi6210_i2s_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *cpu_dai)
 {
 	struct hi6210_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
 	int n;
@@ -524,7 +525,7 @@ static struct snd_soc_dai_ops hi6210_i2s_dai_ops = {
 	.shutdown	= hi6210_i2s_shutdown,
 };
 
-struct snd_soc_dai_driver hi6210_i2s_dai_init = {
+static const struct snd_soc_dai_driver hi6210_i2s_dai_init = {
 	.probe		= hi6210_i2s_dai_probe,
 	.playback = {
 		.channels_min = 2,
-- 
2.9.3
