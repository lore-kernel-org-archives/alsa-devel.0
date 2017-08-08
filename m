From: Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH v2] ASoC: compress: Set reasonable compress id
	string
Date: Tue, 8 Aug 2017 11:31:21 +0800
Message-ID: <CAErzpmsV-q5dN8ukdWxgNbGTaDq=MeKNf=AXKQKoHtrdMuzvxg@mail.gmail.com>
References: <20170808032829.11859-1-pengdonglin137@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id D6FE4267352
 for <alsa-devel@alsa-project.org>; Tue,  8 Aug 2017 05:31:22 +0200 (CEST)
Received: by mail-qk0-f195.google.com with SMTP id d136so2197879qkg.3
 for <alsa-devel@alsa-project.org>; Mon, 07 Aug 2017 20:31:22 -0700 (PDT)
In-Reply-To: <20170808032829.11859-1-pengdonglin137@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, liam.r.girdwood@linux.intel.com, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

For dynamic compress rtd, the codec_dai may not have any
actual meaning(like snd-soc-dummy-dai), so compress id
can just use the value of dai_link->stream_name. But for
others, its codec_dai has actual meaning, so compress id
can include codec_dai name.

Signed-off-by: pengdonglin <pengdonglin137@163.com>
---
 sound/soc/soc-compress.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 206f36bf43e8..b6a071461b10 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -737,9 +737,6 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime
*rtd, int num)
        }

        /* check client and interface hw capabilities */
-       snprintf(new_name, sizeof(new_name), "%s %s-%d",
-                       rtd->dai_link->stream_name, codec_dai->name, num);
-
        if (codec_dai->driver->playback.channels_min)
                playback = 1;
        if (codec_dai->driver->capture.channels_min)
@@ -758,7 +755,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime
*rtd, int num)
                return -EINVAL;
        }

-       if(playback)
+       if (playback)
                direction = SND_COMPRESS_PLAYBACK;
        else
                direction = SND_COMPRESS_CAPTURE;
@@ -797,19 +794,18 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime
*rtd, int num)
                else if (rtd->dai_link->dpcm_capture)
                        be_pcm->streams[SNDRV_PCM_STRE
AM_CAPTURE].substream->private_data = rtd;
                memcpy(compr->ops, &soc_compr_dyn_ops,
sizeof(soc_compr_dyn_ops));
-       } else
+       } else {
+               snprintf(new_name, sizeof(new_name), "%s %s-%d",
+                       rtd->dai_link->stream_name, codec_dai->name, num);
+
                memcpy(compr->ops, &soc_compr_ops, sizeof(soc_compr_ops));
+       }

        /* Add copy callback for not memory mapped DSPs */
        if (platform->driver->compr_ops && platform->driver->compr_ops->c
opy)
                compr->ops->copy = soc_compr_copy;

        mutex_init(&compr->lock);
-
-       snprintf(new_name, sizeof(new_name), "%s %s-%d",
-                rtd->dai_link->stream_name,
-                rtd->codec_dai->name, num);
-
        ret = snd_compress_new(rtd->card->snd_card, num, direction,
                                new_name, compr);
        if (ret < 0) {
--
2.11.0
