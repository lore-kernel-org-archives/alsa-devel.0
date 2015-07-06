From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: dapm: Lock during userspace access
Date: Mon,  6 Jul 2015 17:01:24 +0200
Message-ID: <1436194884-1874-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-092.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id A150726065E
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 17:01:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DAPM lock must be held when accessing the DAPM graph status through
sysfs or debugfs, otherwise concurrent changes to the graph can result in
undefined behaviour.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a47a8ce..1779430 100644
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
