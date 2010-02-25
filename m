From: jassisinghbrar@gmail.com
Subject: [PATCH] ASoC: soc_pcm_open: Add missing bailout tag
Date: Thu, 25 Feb 2010 11:24:53 +0900
Message-ID: <1267064693-1228-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 29CD2103803
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 03:33:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

The codec_dai needs to be shutdown should the machine startup fails.
This patch adds another bailout tag for that case and rename the tag
for configuration failures.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/soc-core.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a03bac9..c81eb59 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -427,24 +427,24 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	if (!runtime->hw.rates) {
 		printk(KERN_ERR "asoc: %s <-> %s No matching rates\n",
 			codec_dai->name, cpu_dai->name);
-		goto machine_err;
+		goto config_err;
 	}
 	if (!runtime->hw.formats) {
 		printk(KERN_ERR "asoc: %s <-> %s No matching formats\n",
 			codec_dai->name, cpu_dai->name);
-		goto machine_err;
+		goto config_err;
 	}
 	if (!runtime->hw.channels_min || !runtime->hw.channels_max) {
 		printk(KERN_ERR "asoc: %s <-> %s No matching channels\n",
 			codec_dai->name, cpu_dai->name);
-		goto machine_err;
+		goto config_err;
 	}
 
 	/* Symmetry only applies if we've already got an active stream. */
 	if (cpu_dai->active || codec_dai->active) {
 		ret = soc_pcm_apply_symmetry(substream);
 		if (ret != 0)
-			goto machine_err;
+			goto config_err;
 	}
 
 	pr_debug("asoc: %s <-> %s info:\n", codec_dai->name, cpu_dai->name);
@@ -464,10 +464,14 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	mutex_unlock(&pcm_mutex);
 	return 0;
 
-machine_err:
+config_err:
 	if (machine->ops && machine->ops->shutdown)
 		machine->ops->shutdown(substream);
 
+machine_err:
+	if (codec_dai->ops->shutdown)
+		codec_dai->ops->shutdown(substream, codec_dai);
+
 codec_dai_err:
 	if (platform->pcm_ops->close)
 		platform->pcm_ops->close(substream);
-- 
1.6.2.5
