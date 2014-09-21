From: Clemens Ladisch <clemens@ladisch.de>
Subject: ALSA: pcm: fix fifo_size frame calculation
Date: Sun, 21 Sep 2014 22:50:57 +0200
Message-ID: <541F3A31.3080604@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 6B8B92625DB
 for <alsa-devel@alsa-project.org>; Sun, 21 Sep 2014 22:50:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The calculated frame size was wrong because snd_pcm_format_physical_width()
actually returns the number of bits, not bytes.

Use snd_pcm_format_size() instead, which not only returns bytes, but also
simplifies the calculation.

Fixes: 8bea869c5e56 ("ALSA: PCM midlevel: improve fifo_size handling")
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/core/pcm_lib.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index b03c7ae..dfc2854 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1784,14 +1784,16 @@ static int snd_pcm_lib_ioctl_fifo_size(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_hw_params *params = arg;
 	snd_pcm_format_t format;
-	int channels, width;
+	int channels;
+	ssize_t frame_size;

 	params->fifo_size = substream->runtime->hw.fifo_size;
 	if (!(substream->runtime->hw.info & SNDRV_PCM_INFO_FIFO_IN_FRAMES)) {
 		format = params_format(params);
 		channels = params_channels(params);
-		width = snd_pcm_format_physical_width(format);
-		params->fifo_size /= width * channels;
+		frame_size = snd_pcm_format_size(format, channels);
+		if (frame_size > 0)
+			params->fifo_size /= (unsigned)frame_size;
 	}
 	return 0;
 }
