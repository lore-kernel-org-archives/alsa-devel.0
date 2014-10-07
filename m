From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ASoC: soc-pcm: fix sig_bits determination in
	soc_pcm_apply_msb()
Date: Tue,  7 Oct 2014 14:33:46 +0200
Message-ID: <1412685226-7935-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 032D126048B
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 14:33:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

In the SNDRV_PCM_STREAM_CAPTURE branch in soc_pcm_apply_msb(), look at
sig_bits of the capture stream, not the playback one.

Spotted by coverity.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 642c862..002311a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -352,7 +352,7 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
 	} else {
 		for (i = 0; i < rtd->num_codecs; i++) {
 			codec_dai = rtd->codec_dais[i];
-			if (codec_dai->driver->playback.sig_bits == 0) {
+			if (codec_dai->driver->capture.sig_bits == 0) {
 				bits = 0;
 				break;
 			}
-- 
2.1.0
