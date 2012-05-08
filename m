From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 01/11] sound: core: Add debug-print helper
	function
Date: Tue, 8 May 2012 15:56:25 +0200
Message-ID: <1336485385-27077-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog115.obsmtp.com (eu1sys200aog115.obsmtp.com
	[207.126.144.139])
	by alsa0.perex.cz (Postfix) with ESMTP id A77991043BD
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 15:56:57 +0200 (CEST)
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
 include/sound/pcm.h |    2 ++
 sound/core/pcm.c    |   10 ++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 0d11128..8a153e6 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1073,4 +1073,6 @@ static inline void snd_pcm_limit_isa_dma_size(int dma, size_t *max)
 
 const char *snd_pcm_format_name(snd_pcm_format_t format);
 
+const char *snd_pcm_stream_str(struct snd_pcm_substream *substream);
+
 #endif /* __SOUND_PCM_H */
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 1a3070b..9e83f00 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1187,6 +1187,16 @@ static void snd_pcm_proc_done(void)
 #define snd_pcm_proc_done()
 #endif /* CONFIG_PROC_FS */
 
+/**
+ * Get a string naming the direction of a stream
+ */
+const char *snd_pcm_stream_str(struct snd_pcm_substream *substream)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return "Playback";
+	else
+		return "Capture";
+}
 
 /*
  *  ENTRY functions
-- 
1.7.8.3
