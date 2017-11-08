From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] ASoC: amd: use do_div rather than 64 bit
	division to fix 32 bit builds
Date: Wed,  8 Nov 2017 16:34:54 -0500
Message-ID: <20171108213454.7048-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F56826768E
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:38:19 +0100 (CET)
Received: by mail-it0-f68.google.com with SMTP id r127so8244247itb.5
 for <alsa-devel@alsa-project.org>; Wed, 08 Nov 2017 13:38:19 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, Vijendar.Mukunda@amd.com
Cc: tiwai@suse.de, Guenter Roeck <groeck@chromium.org>, Alex Deucher <alexander.deucher@amd.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Guenter Roeck <groeck@chromium.org>

ERROR: "__aeabi_uldivmod" [sound/soc/amd/snd-soc-acp-pcm.ko] undefined!

64-bit divides require special operations to avoid build errors on 32-bit
systems.

[Reword the commit message to make it clearer - Alex]

fixes: 61add8147942 (ASoC: amd: Report accurate hw_ptr during dma)
Signed-off-by: Guenter Roeck <groeck@chromium.org>
Reviewed-on: https://chromium-review.googlesource.com/678919
Reviewed-by: Jason Clinton <jclinton@chromium.org>
(cherry picked from commit 7ca726e80f21abdbaed9a5a70def1c33a26f8533)
Reviewed-on: https://chromium-review.googlesource.com/681618
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 13d040a4d26f..ef7e98ad960c 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -856,12 +856,11 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (bytescount > rtd->renderbytescount)
 			bytescount = bytescount - rtd->renderbytescount;
-		pos =  bytescount % buffersize;
 	} else {
 		if (bytescount > rtd->capturebytescount)
 			bytescount = bytescount - rtd->capturebytescount;
-		pos = bytescount % buffersize;
 	}
+	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(runtime, pos);
 }
 
-- 
2.13.6
