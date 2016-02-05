From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v5 11/14] ASoC: hdac_hdmi: Don't fail in
 dai startup to make userland happy
Date: Fri, 5 Feb 2016 09:22:57 +0530
Message-ID: <20160205035251.GA25409@subhransu-desktop>
References: <1454161428-7896-1-git-send-email-subhransu.s.prusty@intel.com>
 <1454161428-7896-12-git-send-email-subhransu.s.prusty@intel.com>
 <448EE3572333F34FA53FF0820C7D130380E341@ORSMSX115.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 95839260577
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 04:51:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <448EE3572333F34FA53FF0820C7D130380E341@ORSMSX115.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Patel, Vedang" <vedang.patel@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Koul,
 Vinod" <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 05, 2016 at 07:57:17AM +0530, Patel, Vedang wrote:
> > 
> > -	if (dai->id > 0) {
> > -		dev_err(&hdac->hdac.dev, "Only one dai supported as of
> > now\n");
> > +	dai_map = &hdmi->dai_map[dai->id];
> > +	pin = dai_map->pin;
> > +
> > +	if (!pin)
> > +		return -ENODEV;
> > +
> > +	if ((!pin->eld.monitor_present) || (!pin->eld.eld_valid)) {
> > +		dev_err(&hdac->hdac.dev, "device is not configured for this
> > PIN: %d\n",
> 
> Don't you need the following fix anymore?
> 
>     ASoC: hdac_hdmi: Read pin sense detect during playback open
> 
>     If the monitor_present and eld_valid flags are not set due to some
>     controller error during notify_cb, try reading once more during
>     playback open.
>    Link: https://chromium-review.googlesource.com/320943

With fix in patch "ASoC: Intel: Skylake: Remove autosuspend delay", the
controller resume and codec power ON are synchronized. The jack detection
happens successfully with few retries in notify callback. So this check is
not required anymore.

~Subhransu

> 
> -Vedang
> > +								pin->nid);
> >  		return -ENODEV;
> >  	}
> > 
> > @@ -432,11 +442,6 @@ static int hdac_hdmi_playback_cleanup(struct
> > snd_pcm_substream *substream,
> > 
> >  	dai_map = &hdmi->dai_map[dai->id];
> > 
> > -	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
> > -				AC_VERB_SET_CHANNEL_STREAMID, 0);
> > -	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
> > -				AC_VERB_SET_STREAM_FORMAT, 0);
> > -
> >  	dd = (struct hdac_ext_dma_params
> > *)snd_soc_dai_get_dma_data(dai, substream);
> > 
> >  	if (dd) {
> > @@ -537,6 +542,11 @@ static struct hdac_hdmi_pin
> > *hdac_hdmi_get_pin_from_cvt(
> >  	return NULL;
> >  }
> > 
> > +/*
> > + * This tries to get a valid PIN and set the HW constraints based on
> > +the
> > + * ELD. Even if a valid PIN is not found return success so that device
> > +open
> > + * doesn't fail.
> > + */
> >  static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
> >  			struct snd_soc_dai *dai)
> >  {
> > @@ -551,17 +561,22 @@ static int hdac_hdmi_pcm_open(struct
> > snd_pcm_substream *substream,
> > 
> >  	cvt = dai_map->cvt;
> >  	pin = hdac_hdmi_get_pin_from_cvt(hdac, hdmi, cvt);
> > +
> > +	/*
> > +	 * To make PA and other userland happy.
> > +	 * userland scans devices so returning error does not help.
> > +	 */
> >  	if (!pin)
> > -		return -EIO;
> > +		return 0;
> > 
> >  	if ((!pin->eld.monitor_present) ||
> >  			(!pin->eld.eld_valid)) {
> > 
> > -		dev_err(&hdac->hdac.dev,
> > +		dev_warn(&hdac->hdac.dev,
> >  			"failed: montior present? %d eld valid?: %d for pin:
> > %d\n",
> >  			pin->eld.monitor_present, pin->eld.eld_valid, pin-
> > >nid);
> > 
> > -		return -ENODEV;
> > +		return 0;
> >  	}
> > 
> >  	dai_map->pin = pin;
> > @@ -588,12 +603,19 @@ static void hdac_hdmi_pcm_close(struct
> > snd_pcm_substream *substream,
> > 
> >  	dai_map = &hdmi->dai_map[dai->id];
> > 
> > -	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D3);
> > +	if (dai_map->pin && dai_map->pin->eld.monitor_present) {
> > +		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
> > +				AC_VERB_SET_CHANNEL_STREAMID, 0);
> > +		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
> > +				AC_VERB_SET_STREAM_FORMAT, 0);
> > +
> > +		hdac_hdmi_set_power_state(hdac, dai_map,
> > AC_PWRST_D3);
> > 
> > -	snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
> > +		snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
> >  			AC_VERB_SET_AMP_GAIN_MUTE,
> > AMP_OUT_MUTE);
> > 
> > -	dai_map->pin = NULL;
> > +		dai_map->pin = NULL;
> > +	}
> >  }
> > 
> >  static int
> > --
> > 1.9.1
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
