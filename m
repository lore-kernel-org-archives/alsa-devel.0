From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: soc-pcm: Use valid condition for
	snd_soc_dai_digital_mute() in hw_free()
Date: Mon, 2 Dec 2013 17:34:34 +0800
Message-ID: <1385976874-30755-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 26CA0261B36
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 10:34:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The snd_soc_dai_digital_mute() here will be never executed because we only
decrease codec->active in snd_soc_close(). Thus correct it.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 22af038..7d19117 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -689,7 +689,7 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	}
 
 	/* apply codec digital mute */
-	if (!codec->active)
+	if (codec->active == 1)
 		snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);
 
 	/* free any machine hw params */
-- 
1.8.4
