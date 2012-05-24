From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 1/5] ALSA: pcm: Add debug-print helper function
Date: Thu, 24 May 2012 15:26:03 +0200
Message-ID: <1337865963-26040-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
	[207.126.144.121])
	by alsa0.perex.cz (Postfix) with ESMTP id 73D9A24495
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2012 15:26:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Adds a function getting the stream-name as a string for
a specific stream.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 include/sound/pcm.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 0d11128..a55d5db 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1073,4 +1073,15 @@ static inline void snd_pcm_limit_isa_dma_size(int dma, size_t *max)
 
 const char *snd_pcm_format_name(snd_pcm_format_t format);
 
+/**
+ * Get a string naming the direction of a stream
+ */
+static inline const char *snd_pcm_stream_str(struct snd_pcm_substream *substream)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return "Playback";
+	else
+		return "Capture";
+}
+
 #endif /* __SOUND_PCM_H */
-- 
1.7.8.3
