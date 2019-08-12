From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: ti: davinci-mcasp: Protect hw_params
	callback against race
Date: Mon, 12 Aug 2019 12:53:04 +0300
Message-ID: <20190812095304.19030-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D48BF805FB
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 11:52:56 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

If the playback and capture of the same McASP is connected to different
dai link (non duplex PCM links, like with pcm3168a codec) then there is
a high probability of race between the two direction leaving McASP in a
confused state.

Protect the hw_params() with a mutex to make sure that this is not
happening.

The concurrent execution of hw_params for capture and playback can be
easily triggered with custom .asoundrc file (for pcm3168a codec):

pcm.dmixed8 {
    type dmix
    ipc_key 2048
    ipc_perm 0666
    slave {
        pcm "hw:0,0"
        format S24_LE
        channels 8
        rate 96000
    }
    bindings {
        0 0
        1 1
        2 2
        3 3
        4 4
        5 5
        6 6
        7 7
    }
}

pcm.cpb-headset-1 {
    type plug
    slave.pcm dmixed8

    hint {
         show on
         description "Headset 1 jack"
    }
    ttable.0.0 1
    ttable.1.4 1
}

pcm.dsnooped6 {
    type dsnoop
    ipc_key 2049
    ipc_perm 0666
    slave {
        pcm "hw:0,1"
        format S24_LE
        channels 6
        rate 96000
    }
    bindings {
        0 0
        1 1
        2 2
        3 3
        4 4
        5 5
    }
}

pcm.cpb-mic-1 {
    type plug
    slave.pcm "dsnooped6"

    hint {
         show on
         description "Microphone 1 jack"
    }
    ttable.0.0 1
    ttable.1.3 1
}

Then running:
arecord -D cpb-mic-1 -f S24_LE -c2 -r48000 | aplay -D cpb-headset-1 -f S24_LE -c2 -r48000

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 7aa3c32e4a49..fe7a0b3572e2 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -111,6 +111,7 @@ struct davinci_mcasp {
 	u32	channels;
 	int	max_format_width;
 	u8	active_serializers[2];
+	struct mutex mutex;
 
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip gpio_chip;
@@ -1169,6 +1170,8 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	int period_size = params_period_size(params);
 	int ret;
 
+	mutex_lock(&mcasp->mutex);
+
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_U8:
 	case SNDRV_PCM_FORMAT_S8:
@@ -1197,12 +1200,13 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 
 	default:
 		printk(KERN_WARNING "davinci-mcasp: unsupported PCM format");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	ret = davinci_mcasp_set_dai_fmt(cpu_dai, mcasp->dai_fmt);
 	if (ret)
-		return ret;
+		goto out;
 
 	/*
 	 * If mcasp is BCLK master, and a BCLK divider was not provided by
@@ -1223,7 +1227,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	ret = mcasp_common_hw_param(mcasp, substream->stream,
 				    period_size * channels, channels);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
 		ret = mcasp_dit_hw_param(mcasp, params_rate(params));
@@ -1232,7 +1236,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					 channels);
 
 	if (ret)
-		return ret;
+		goto out;
 
 	davinci_config_channel_size(mcasp, word_length);
 
@@ -1242,7 +1246,10 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 			mcasp->max_format_width = word_length;
 	}
 
-	return 0;
+out:
+	mutex_unlock(&mcasp->mutex);
+
+	return ret;
 }
 
 static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
@@ -2335,6 +2342,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (ret)
 		return -EINVAL;
 
+	mutex_init(&mcasp->mutex);
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					&davinci_mcasp_component,
 					&davinci_mcasp_dai[pdata->op_mode], 1);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
