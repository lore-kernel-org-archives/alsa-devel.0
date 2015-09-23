From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: ALSA: core: check for underflow in snd_pcm_sw_params()
Date: Wed, 23 Sep 2015 12:42:28 +0300
Message-ID: <20150923094228.GA13867@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

As far as I can see, having an invalid ->tstamp_mode is harmless, but
adding a check silences a static checker warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 75888dd..4863af5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -650,7 +650,8 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
 	}
 	snd_pcm_stream_unlock_irq(substream);
 
-	if (params->tstamp_mode > SNDRV_PCM_TSTAMP_LAST)
+	if (params->tstamp_mode < 0 ||
+	    params->tstamp_mode > SNDRV_PCM_TSTAMP_LAST)
 		return -EINVAL;
 	if (params->proto >= SNDRV_PROTOCOL_VERSION(2, 0, 12) &&
 	    params->tstamp_type > SNDRV_PCM_TSTAMP_TYPE_LAST)
