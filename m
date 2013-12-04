From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v2 1/2] ASoC: soc-pcm: Use valid condition for
	snd_soc_dai_digital_mute() in hw_free()
Date: Wed, 4 Dec 2013 11:18:36 +0800
Message-ID: <6bf200dcb47ffcf3ab342e4cc3a278e9ed010553.1386126119.git.b42378@freescale.com>
References: <cover.1386126119.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 84C5A265308
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 04:18:19 +0100 (CET)
In-Reply-To: <cover.1386126119.git.b42378@freescale.com>
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
 sound/soc/soc-pcm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index eb340a8..3774471 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -689,7 +689,7 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = rtd->codec;
+	bool playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -707,7 +707,8 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	}
 
 	/* apply codec digital mute */
-	if (!codec->active)
+	if ((playback && codec_dai->playback_active == 1) ||
+	    (!playback && codec_dai->capture_active == 1))
 		snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);
 
 	/* free any machine hw params */
-- 
1.8.4
