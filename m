From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v8 2/2] ASoC: hdac_hdmi: Add PM support
Date: Mon, 22 Feb 2016 07:40:24 +0530
Message-ID: <20160222021019.GA13083@subhransu-desktop>
References: <1456034444-10606-1-git-send-email-subhransu.s.prusty@intel.com>
 <1456034444-10606-2-git-send-email-subhransu.s.prusty@intel.com>
 <s5hziuuwk61.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 76D5226057F
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 03:09:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hziuuwk61.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

> >  
> > +#ifdef CONFIG_PM
> > +static int hdmi_codec_resume(struct snd_soc_codec *codec)
> > +{
> > +	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
> > +	struct hdac_hdmi_priv *hdmi = edev->private_data;
> > +	struct hdac_hdmi_pin *pin;
> > +	struct hdac_device *hdac = &edev->hdac;
> > +	struct hdac_bus *bus = hdac->bus;
> > +	int err;
> > +
> > +	hdac_hdmi_skl_enable_all_pins(&edev->hdac);
> > +	hdac_hdmi_skl_enable_dp12(&edev->hdac);
> > +
> > +	/* Power up afg */
> > +	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D0))
> > +		snd_hdac_codec_write(hdac, hdac->afg, 0,
> > +			AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
> 
> You don't have to wait for D0 power up unlike runtime resume?

Didn't see any issue yet. But yes, we should wait.

> 
> > +	/*
> > +	 * As the ELD notify callback request is not entertained while the
> > +	 * device is in suspend state. Need to manually check detection of
> > +	 * all pins here.
> > +	 */
> > +	list_for_each_entry(pin, &hdmi->pin_list, head)
> > +		hdac_hdmi_present_sense(pin, 1);
> > +
> > +	/* Codec power is turned ON during controller resume */
> > +	err = snd_hdac_display_power(bus, false);
> > +	if (err < 0) {
> > +		dev_err(bus->dev, "Cannot turn on display power on i915\n");
> 
> Make clear whether you're turning on or off...

Will fix it.

> 
> 
> Takashi

-- 
