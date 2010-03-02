From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 2/4] ASoC: core: Add delay operation to
	snd_soc_dai_ops
Date: Tue,  2 Mar 2010 15:39:49 +0200
Message-ID: <1267537191-25254-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BAB11038EA
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:40:01 +0100 (CET)
In-Reply-To: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The delay calback can be used by the core to query the delay
on the dais caused by FIFO.
In case if both CPU and CODEC dai has FIFO the delay reported
by each will be added to form the full delay on the chain.
If none of the dai has FIFO, than the delay will be kept as
zero.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/soc-dai.h |    6 ++++++
 sound/soc/soc-core.c    |   15 +++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 061f16d..be9cd47 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -182,6 +182,12 @@ struct snd_soc_dai_ops {
 		struct snd_soc_dai *);
 	int (*trigger)(struct snd_pcm_substream *, int,
 		struct snd_soc_dai *);
+	/*
+	 * For hardware based FIFO caused delay reporting.
+	 * Optional.
+	 */
+	snd_pcm_sframes_t (*delay)(struct snd_pcm_substream *,
+		struct snd_soc_dai *);
 };
 
 /*
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6e35741..feaf03b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -806,11 +806,26 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_platform *platform = card->platform;
+	struct snd_soc_dai_link *machine = rtd->dai;
+	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
+	struct snd_soc_dai *codec_dai = machine->codec_dai;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t offset = 0;
+	snd_pcm_sframes_t delay = 0;
 
 	if (platform->pcm_ops->pointer)
 		offset = platform->pcm_ops->pointer(substream);
 
+	/* Query the delay only for playback stream */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (cpu_dai->ops->delay)
+			delay += cpu_dai->ops->delay(substream, cpu_dai);
+
+		if (codec_dai->ops->delay)
+			delay += codec_dai->ops->delay(substream, codec_dai);
+
+		runtime->delay = delay;
+	}
 	return offset;
 }
 
-- 
1.7.0
