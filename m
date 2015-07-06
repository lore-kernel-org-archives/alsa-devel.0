From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Lock during userspace access" to the asoc tree
Date: Mon, 06 Jul 2015 21:43:14 +0100
Message-ID: <E1ZCDEQ-0002mA-98@debutante>
References: <1436194884-1874-1-git-send-email-lars@metafoo.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1436194884-1874-1-git-send-email-lars@metafoo.de>
Sender: stable-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Lock during userspace access

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e50b1e06b79e9d51efbff9627b4dd407184ef43f Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 6 Jul 2015 17:01:24 +0200
Subject: [PATCH] ASoC: dapm: Lock during userspace access

The DAPM lock must be held when accessing the DAPM graph status through
sysfs or debugfs, otherwise concurrent changes to the graph can result in
undefined behaviour.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-dapm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a47a8ce7a5ea..1779430013ea 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1952,6 +1952,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 					   size_t count, loff_t *ppos)
 {
 	struct snd_soc_dapm_widget *w = file->private_data;
+	struct snd_soc_card *card = w->dapm->card;
 	char *buf;
 	int in, out;
 	ssize_t ret;
@@ -1961,6 +1962,8 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
+	mutex_lock(&card->dapm_mutex);
+
 	/* Supply widgets are not handled by is_connected_{input,output}_ep() */
 	if (w->is_supply) {
 		in = 0;
@@ -2007,6 +2010,8 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 					p->sink->name);
 	}
 
+	mutex_unlock(&card->dapm_mutex);
+
 	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
 
 	kfree(buf);
@@ -2281,11 +2286,15 @@ static ssize_t dapm_widget_show(struct device *dev,
 	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
 	int i, count = 0;
 
+	mutex_lock(&rtd->card->dapm_mutex);
+
 	for (i = 0; i < rtd->num_codecs; i++) {
 		struct snd_soc_codec *codec = rtd->codec_dais[i]->codec;
 		count += dapm_widget_show_codec(codec, buf + count);
 	}
 
+	mutex_unlock(&rtd->card->dapm_mutex);
+
 	return count;
 }
 
-- 
2.1.4
