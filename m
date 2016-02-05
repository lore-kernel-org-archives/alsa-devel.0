From: "Patel, Vedang" <vedang.patel@intel.com>
Subject: Re: [PATCH v5 11/14] ASoC: hdac_hdmi: Don't fail in
 dai	startup to make userland happy
Date: Fri, 5 Feb 2016 02:27:17 +0000
Message-ID: <448EE3572333F34FA53FF0820C7D130380E341@ORSMSX115.amr.corp.intel.com>
References: <1454161428-7896-1-git-send-email-subhransu.s.prusty@intel.com>
 <1454161428-7896-12-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B604260577
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 03:27:22 +0100 (CET)
In-Reply-To: <1454161428-7896-12-git-send-email-subhransu.s.prusty@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of Subhransu S. Prusty
> Sent: Saturday, January 30, 2016 5:44 AM
> To: alsa-devel@alsa-project.org
> Cc: tiwai@suse.de; lgirdwood@gmail.com; Patches Audio;
> broonie@kernel.org; Koul, Vinod; Prusty, Subhransu S
> Subject: [alsa-devel] [PATCH v5 11/14] ASoC: hdac_hdmi: Don't fail in dai
> startup to make userland happy
> 
> In dai startup, driver was checking for ELD and would fail if no monitor is
> connected. This causes userland like PA, CRAS to be unhappy as they scan
> the device list at bootup.
> 
> So move the ELD check to hw_params and fail, if valid ELD is not found.
> 
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  sound/soc/codecs/hdac_hdmi.c | 48
> ++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/codecs/hdac_hdmi.c
> b/sound/soc/codecs/hdac_hdmi.c index dde76f4..6c2505c 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -398,10 +398,20 @@ static int hdac_hdmi_set_hw_params(struct
> snd_pcm_substream *substream,
>  	struct snd_pcm_hw_params *hparams, struct snd_soc_dai *dai)  {
>  	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
> +	struct hdac_hdmi_priv *hdmi = hdac->private_data;
> +	struct hdac_hdmi_dai_pin_map *dai_map;
> +	struct hdac_hdmi_pin *pin;
>  	struct hdac_ext_dma_params *dd;
> 
> -	if (dai->id > 0) {
> -		dev_err(&hdac->hdac.dev, "Only one dai supported as of
> now\n");
> +	dai_map = &hdmi->dai_map[dai->id];
> +	pin = dai_map->pin;
> +
> +	if (!pin)
> +		return -ENODEV;
> +
> +	if ((!pin->eld.monitor_present) || (!pin->eld.eld_valid)) {
> +		dev_err(&hdac->hdac.dev, "device is not configured for this
> PIN: %d\n",

Don't you need the following fix anymore?

    ASoC: hdac_hdmi: Read pin sense detect during playback open

    If the monitor_present and eld_valid flags are not set due to some
    controller error during notify_cb, try reading once more during
    playback open.
   Link: https://chromium-review.googlesource.com/320943

-Vedang
> +								pin->nid);
>  		return -ENODEV;
>  	}
> 
> @@ -432,11 +442,6 @@ static int hdac_hdmi_playback_cleanup(struct
> snd_pcm_substream *substream,
> 
>  	dai_map = &hdmi->dai_map[dai->id];
> 
> -	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
> -				AC_VERB_SET_CHANNEL_STREAMID, 0);
> -	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
> -				AC_VERB_SET_STREAM_FORMAT, 0);
> -
>  	dd = (struct hdac_ext_dma_params
> *)snd_soc_dai_get_dma_data(dai, substream);
> 
>  	if (dd) {
> @@ -537,6 +542,11 @@ static struct hdac_hdmi_pin
> *hdac_hdmi_get_pin_from_cvt(
>  	return NULL;
>  }
> 
> +/*
> + * This tries to get a valid PIN and set the HW constraints based on
> +the
> + * ELD. Even if a valid PIN is not found return success so that device
> +open
> + * doesn't fail.
> + */
>  static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
>  			struct snd_soc_dai *dai)
>  {
> @@ -551,17 +561,22 @@ static int hdac_hdmi_pcm_open(struct
> snd_pcm_substream *substream,
> 
>  	cvt = dai_map->cvt;
>  	pin = hdac_hdmi_get_pin_from_cvt(hdac, hdmi, cvt);
> +
> +	/*
> +	 * To make PA and other userland happy.
> +	 * userland scans devices so returning error does not help.
> +	 */
>  	if (!pin)
> -		return -EIO;
> +		return 0;
> 
>  	if ((!pin->eld.monitor_present) ||
>  			(!pin->eld.eld_valid)) {
> 
> -		dev_err(&hdac->hdac.dev,
> +		dev_warn(&hdac->hdac.dev,
>  			"failed: montior present? %d eld valid?: %d for pin:
> %d\n",
>  			pin->eld.monitor_present, pin->eld.eld_valid, pin-
> >nid);
> 
> -		return -ENODEV;
> +		return 0;
>  	}
> 
>  	dai_map->pin = pin;
> @@ -588,12 +603,19 @@ static void hdac_hdmi_pcm_close(struct
> snd_pcm_substream *substream,
> 
>  	dai_map = &hdmi->dai_map[dai->id];
> 
> -	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D3);
> +	if (dai_map->pin && dai_map->pin->eld.monitor_present) {
> +		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
> +				AC_VERB_SET_CHANNEL_STREAMID, 0);
> +		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
> +				AC_VERB_SET_STREAM_FORMAT, 0);
> +
> +		hdac_hdmi_set_power_state(hdac, dai_map,
> AC_PWRST_D3);
> 
> -	snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
> +		snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
>  			AC_VERB_SET_AMP_GAIN_MUTE,
> AMP_OUT_MUTE);
> 
> -	dai_map->pin = NULL;
> +		dai_map->pin = NULL;
> +	}
>  }
> 
>  static int
> --
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
