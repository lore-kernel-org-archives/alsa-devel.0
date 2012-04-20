From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 3/8] ASoC: core: Add debug-print helper function
Date: Fri, 20 Apr 2012 11:32:52 +0200
Message-ID: <1334914372-27409-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FF7210B95D
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2012 11:33:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

Adds a function getting the stream-name as a string for
a specific stream.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 include/sound/soc.h |    1 +
 sound/soc/soc-pcm.c |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index bda0cd2..e89d309 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -345,6 +345,7 @@ int snd_soc_platform_read(struct snd_soc_platform *platform,
 int snd_soc_platform_write(struct snd_soc_platform *platform,
 					unsigned int reg, unsigned int val);
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
+const char *snd_soc_stream_str(struct snd_pcm_substream *substream);
 
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0ad8dca..6bec24f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -705,3 +705,12 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 		cpu_dai->name);
 	return ret;
 }
+
+/* Get a string naming the direction of a stream */
+const char *snd_soc_stream_str(struct snd_pcm_substream *substream)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return "Playback";
+	else
+		return "Capture";
+}
-- 
1.7.8.3
