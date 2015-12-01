From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 03/15] ASoC: hdac_hdmi - Use list to add
 pins and converters
Date: Wed, 2 Dec 2015 04:20:50 +0530
Message-ID: <20151201225050.GE5624@subhransu-desktop>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-3-git-send-email-subhransu.s.prusty@intel.com>
 <s5htwo2pc8n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 74F59261AFF
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 18:20:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htwo2pc8n.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 01, 2015 at 01:47:04PM +0100, Takashi Iwai wrote:
> On Tue, 01 Dec 2015 18:46:59 +0100,
> Subhransu S. Prusty wrote:
> > 
> > +static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
> > +{
> > +	struct hdac_hdmi_priv *hdmi = edev->private_data;
> > +	struct hdac_hdmi_cvt *cvt;
> > +
> > +	cvt = devm_kzalloc(&edev->hdac.dev, sizeof(*cvt), GFP_KERNEL);
> 
> Be careful about devm_*() usage here.  The devres resources may be
> freed before the release callback is called for the assigned device
> object.  See drivers/base/core.c:device_release().
> 
> For the top-level object, usually it's OK, because the top-level
> object itself won't be released but only the driver is detached.
> Then devres_release_all() is called in device_release_driver() while
> the device itself is still present.

Not sure if I understood it correctly. But as the devres_release_all is
called after the driver remove and the above resource is not expected to
be used outside the scope of driver. So should't deleting the list entries
be good enough during driver remove?

> 
> I'm not sure whether this would be actually OK with hdac_device.  You
> need to double-check, not only check whether the driver appears to
> work, but track all object lifetime properly.

Will testing driver load/unload be helpful here with CONFIG_DEBUG_DEVRES
enabled?

Regards,
Subhransu
> 
> 
> Takashi
> 
> > +	if (!cvt)
> > +		return -ENOMEM;
> > +
> > +	cvt->nid = nid;
> > +
> > +	list_add_tail(&cvt->head, &hdmi->cvt_list);
> > +	hdmi->num_cvt++;
> > +
> > +	return hdac_hdmi_query_cvt_params(&edev->hdac, cvt);
> > +}
> > +
> > +static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
> > +{
> > +	struct hdac_hdmi_priv *hdmi = edev->private_data;
> > +	struct hdac_hdmi_pin *pin;
> > +
> > +	pin = devm_kzalloc(&edev->hdac.dev, sizeof(*pin), GFP_KERNEL);
> > +	if (!pin)
> > +		return -ENOMEM;
> > +
> > +	pin->nid = nid;
> > +
> > +	list_add_tail(&pin->head, &hdmi->pin_list);
> > +	hdmi->num_pin++;
> > +
> > +	return 0;
> >  }
> >  
> >  /*
> > @@ -414,7 +459,7 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
> >  	int i;
> >  	struct hdac_device *hdac = &edev->hdac;
> >  	struct hdac_hdmi_priv *hdmi = edev->private_data;
> > -	int cvt_nid = 0, pin_nid = 0;
> > +	int ret;
> >  
> >  	hdac->num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
> >  	if (!nid || hdac->num_nodes <= 0) {
> > @@ -437,29 +482,25 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
> >  		switch (type) {
> >  
> >  		case AC_WID_AUD_OUT:
> > -			hdmi->cvt_nid[cvt_nid] = nid;
> > -			cvt_nid++;
> > +			ret = hdac_hdmi_add_cvt(edev, nid);
> > +			if (ret < 0)
> > +				return ret;
> >  			break;
> >  
> >  		case AC_WID_PIN:
> > -			hdmi->pin_nid[pin_nid] = nid;
> > -			pin_nid++;
> > +			ret = hdac_hdmi_add_pin(edev, nid);
> > +			if (ret < 0)
> > +				return ret;
> >  			break;
> >  		}
> >  	}
> >  
> >  	hdac->end_nid = nid;
> >  
> > -	if (!pin_nid || !cvt_nid)
> > +	if (!hdmi->num_pin || !hdmi->num_cvt)
> >  		return -EIO;
> >  
> > -	/*
> > -	 * Currently on board only 1 pin and 1 converter is enabled for
> > -	 * simplification, more will be added eventually
> > -	 * So using fixed map for dai_id:pin:cvt
> > -	 */
> > -	return hdac_hdmi_init_dai_map(edev, &hdmi->dai_map[0], hdmi->pin_nid[0],
> > -			hdmi->cvt_nid[0], 0);
> > +	return hdac_hdmi_init_dai_map(edev);
> >  }
> >  
> >  static int hdmi_codec_probe(struct snd_soc_codec *codec)
> > @@ -543,6 +584,9 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
> >  
> >  	dev_set_drvdata(&codec->dev, edev);
> >  
> > +	INIT_LIST_HEAD(&hdmi_priv->pin_list);
> > +	INIT_LIST_HEAD(&hdmi_priv->cvt_list);
> > +
> >  	ret = hdac_hdmi_parse_and_map_nid(edev);
> >  	if (ret < 0)
> >  		return ret;
> > -- 
> > 1.9.1
> > 

-- 
