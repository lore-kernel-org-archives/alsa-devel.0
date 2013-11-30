From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Set SNDRV_PCM_INFO_JOINT_DUPLEX for PCMs
	with symmetry constraints
Date: Sat, 30 Nov 2013 17:38:58 +0100
Message-ID: <1385829538-26355-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-136.synserver.de (smtp-out-237.synserver.de
 [212.40.185.237])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F12F2616E1
 for <alsa-devel@alsa-project.org>; Sat, 30 Nov 2013 17:53:21 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Florian Meier <florian.meier@koalo.de>
List-Id: alsa-devel@alsa-project.org

If there are symmetry constraints between the playback and the capture channel
set the SNDRV_PCM_INFO_JOINT_DUPLEX flag to let userspace know about this.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-pcm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 22af038..eb340a8 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -180,6 +180,21 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static bool soc_pcm_has_symmetry(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai_driver *cpu_driver = rtd->cpu_dai->driver;
+	struct snd_soc_dai_driver *codec_driver = rtd->codec_dai->driver;
+	struct snd_soc_dai_link *link = rtd->dai_link;
+
+	return cpu_driver->symmetric_rates || codec_driver->symmetric_rates ||
+		link->symmetric_rates || cpu_driver->symmetric_channels ||
+		codec_driver->symmetric_channels || link->symmetric_channels ||
+		cpu_driver->symmetric_samplebits ||
+		codec_driver->symmetric_samplebits ||
+		link->symmetric_samplebits;
+}
+
 /*
  * List of sample sizes that might go over the bus for parameter
  * application.  There ought to be a wildcard sample size for things
@@ -316,6 +331,9 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			&cpu_dai_drv->capture);
 	}
 
+	if (soc_pcm_has_symmetry(substream))
+		runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
+
 	ret = -EINVAL;
 	if (!runtime->hw.rates) {
 		printk(KERN_ERR "ASoC: %s <-> %s No matching rates\n",
-- 
1.8.0
