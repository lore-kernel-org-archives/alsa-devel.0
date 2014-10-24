From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv5 7/9] ASOC: wm8971: use msleep to replace work
	queue
Date: Fri, 24 Oct 2014 14:00:33 +0800
Message-ID: <1414130435-14183-7-git-send-email-xavier.hsu@linaro.org>
References: <1414130435-14183-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 1597426043E
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 08:01:13 +0200 (CEST)
In-Reply-To: <1414130435-14183-1-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: Xavier Hsu <xavier.hsu@linaro.org>, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

We use msleep to replace work queue.
"As suggested by Mark Brown"

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 sound/soc/codecs/wm8971.c |   27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 7663de4..85314fb 100755
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -36,8 +36,6 @@
 
 #define WM8971_REG_COUNT	43
 
-static struct workqueue_struct *wm8971_workq;
-
 /* codec private data */
 struct wm8971_priv {
 	/* MCLK */
@@ -779,16 +777,6 @@ static struct snd_soc_dai_driver wm8971_dai = {
 	.ops = &wm8971_dai_ops,
 };
 
-static void wm8971_work(struct work_struct *work)
-{
-	struct snd_soc_dapm_context *dapm =
-		container_of(work, struct snd_soc_dapm_context,
-			     delayed_work.work);
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
-
-	wm8971_set_bias_level(codec, codec->dapm.bias_level);
-}
-
 static int wm8971_suspend(struct snd_soc_codec *codec)
 {
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
@@ -806,8 +794,8 @@ static int wm8971_resume(struct snd_soc_codec *codec)
 		reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
 		snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
 		codec->dapm.bias_level = SND_SOC_BIAS_ON;
-		queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
-				   msecs_to_jiffies(1000));
+		msleep(1000);
+		wm8971_set_bias_level(codec, codec->dapm.bias_level);
 	}
 
 	return 0;
@@ -818,19 +806,14 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	int ret = 0;
 	u16 reg;
 
-	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8971_work);
-	wm8971_workq = create_workqueue("wm8971");
-	if (wm8971_workq == NULL)
-		return -ENOMEM;
-
 	wm8971_reset(codec);
 
 	/* charge output caps - set vmid to 5k for quick power up */
 	reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
 	snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
 	codec->dapm.bias_level = SND_SOC_BIAS_STANDBY;
-	queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
-			   msecs_to_jiffies(1000));
+	msleep(1000);
+	wm8971_set_bias_level(codec, codec->dapm.bias_level);
 
 	/* set the update bits */
 	snd_soc_update_bits(codec, WM8971_LDAC, 0x0100, 0x0100);
@@ -850,8 +833,6 @@ static int wm8971_remove(struct snd_soc_codec *codec)
 {
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	if (wm8971_workq)
-		destroy_workqueue(wm8971_workq);
 	return 0;
 }
 
-- 
1.7.9.5
