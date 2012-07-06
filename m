From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: pcm: Clean up logging in soc_new_pcm()
Date: Fri,  6 Jul 2012 16:54:52 +0100
Message-ID: <1341590092-20713-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 03F5C104566
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 17:55:00 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so6706197wgb.32
	for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2012 08:54:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Use dev_ style logging throughout soc_new_pcm()

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-pcm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 48fd15b..7063b8f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2003,7 +2003,6 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 /* create a new pcm */
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 {
-	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
@@ -2042,7 +2041,8 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			capture, &pcm);
 	}
 	if (ret < 0) {
-		printk(KERN_ERR "asoc: can't create pcm for codec %s\n", codec->name);
+		dev_err(rtd->card->dev, "can't create pcm for %s\n",
+			rtd->dai_link->name);
 		return ret;
 	}
 	dev_dbg(rtd->card->dev, "registered pcm #%d %s\n",num, new_name);
@@ -2099,14 +2099,14 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	if (platform->driver->pcm_new) {
 		ret = platform->driver->pcm_new(rtd);
 		if (ret < 0) {
-			pr_err("asoc: platform pcm constructor failed\n");
+			dev_err(platform->dev, "pcm constructor failed\n");
 			return ret;
 		}
 	}
 
 	pcm->private_free = platform->driver->pcm_free;
 out:
-	printk(KERN_INFO "asoc: %s <-> %s mapping ok\n", codec_dai->name,
+	dev_info(rtd->card->dev, " %s <-> %s mapping ok\n", codec_dai->name,
 		cpu_dai->name);
 	return ret;
 }
-- 
1.7.9.5
