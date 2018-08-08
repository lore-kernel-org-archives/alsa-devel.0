From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [RESEND PATCH] ASoC: Intel: Skylake: Mark expected switch
 fall-through
Date: Wed, 8 Aug 2018 14:16:56 -0500
Message-ID: <20180808191656.GA27465@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1357418 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 823e391..62d6f2f 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -494,6 +494,7 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 							stream->lpib);
 			snd_hdac_ext_stream_set_lpib(stream, stream->lpib);
 		}
+		/* fall through */
 
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-- 
2.7.4
