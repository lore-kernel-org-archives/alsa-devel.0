From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/8] ASoC: Convert core to use standard debug
	print macros
Date: Thu, 30 Oct 2008 15:58:24 +0000
Message-ID: <1225382309-1827-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081030155718.GA1418@rakim.wolfsonmicro.main>
	<1225382309-1827-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B07F62448F
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 16:58:31 +0100 (CET)
In-Reply-To: <1225382309-1827-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   36 ++++++++++++++----------------------
 1 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 411fd3b..8f384df 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -35,14 +35,6 @@
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
-/* debug */
-#define SOC_DEBUG 0
-#if SOC_DEBUG
-#define dbg(format, arg...) printk(format, ## arg)
-#else
-#define dbg(format, arg...)
-#endif
-
 static DEFINE_MUTEX(pcm_mutex);
 static DEFINE_MUTEX(io_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(soc_pm_waitq);
@@ -229,12 +221,12 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		goto machine_err;
 	}
 
-	dbg("asoc: %s <-> %s info:\n", codec_dai->name, cpu_dai->name);
-	dbg("asoc: rate mask 0x%x\n", runtime->hw.rates);
-	dbg("asoc: min ch %d max ch %d\n", runtime->hw.channels_min,
-		runtime->hw.channels_max);
-	dbg("asoc: min rate %d max rate %d\n", runtime->hw.rate_min,
-		runtime->hw.rate_max);
+	pr_debug("asoc: %s <-> %s info:\n", codec_dai->name, cpu_dai->name);
+	pr_debug("asoc: rate mask 0x%x\n", runtime->hw.rates);
+	pr_debug("asoc: min ch %d max ch %d\n", runtime->hw.channels_min,
+		 runtime->hw.channels_max);
+	pr_debug("asoc: min rate %d max rate %d\n", runtime->hw.rate_min,
+		 runtime->hw.rate_max);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		cpu_dai->playback.active = codec_dai->playback.active = 1;
@@ -279,18 +271,18 @@ static void close_delayed_work(struct work_struct *work)
 	for (i = 0; i < codec->num_dai; i++) {
 		codec_dai = &codec->dai[i];
 
-		dbg("pop wq checking: %s status: %s waiting: %s\n",
-			codec_dai->playback.stream_name,
-			codec_dai->playback.active ? "active" : "inactive",
-			codec_dai->pop_wait ? "yes" : "no");
+		pr_debug("pop wq checking: %s status: %s waiting: %s\n",
+			 codec_dai->playback.stream_name,
+			 codec_dai->playback.active ? "active" : "inactive",
+			 codec_dai->pop_wait ? "yes" : "no");
 
 		/* are we waiting on this codec DAI stream */
 		if (codec_dai->pop_wait == 1) {
 
 			/* Reduce power if no longer active */
 			if (codec->active == 0) {
-				dbg("pop wq D1 %s %s\n", codec->name,
-					codec_dai->playback.stream_name);
+				pr_debug("pop wq D1 %s %s\n", codec->name,
+					 codec_dai->playback.stream_name);
 				snd_soc_dapm_set_bias_level(socdev,
 					SND_SOC_BIAS_PREPARE);
 			}
@@ -302,8 +294,8 @@ static void close_delayed_work(struct work_struct *work)
 
 			/* Fall into standby if no longer active */
 			if (codec->active == 0) {
-				dbg("pop wq D3 %s %s\n", codec->name,
-					codec_dai->playback.stream_name);
+				pr_debug("pop wq D3 %s %s\n", codec->name,
+					 codec_dai->playback.stream_name);
 				snd_soc_dapm_set_bias_level(socdev,
 					SND_SOC_BIAS_STANDBY);
 			}
-- 
1.5.6.5
