From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH 1/2] ALSA: hda - divide controller and
 codec dependency on i915 gfx power well
Date: Mon, 27 Apr 2015 07:20:36 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B8420FA@SHSMSX101.ccr.corp.intel.com>
References: <4530387c0b63ccfafb5dbb3399a39b4093651c48.1429880424.git.mengdong.lin@intel.com>
 <s5ha8xxocof.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A462A260538
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 09:20:41 +0200 (CEST)
In-Reply-To: <s5ha8xxocof.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, April 24, 2015 9:53 PM

> > Open questions:
> > - Move the hda_i915 to sound/hda at first? So both legacy and new drivers
> can
> >   use it as Takashi suggested?
> >   The PCI ID check in haswell_set_bclk will no longer be needed, since it's
> >   only called when chip's "need_i915_power" flag is set and so only called
> for
> >   Haswell & Broadwell.
> 
> I don't mind which comes first.

Okay. I'll keep hda_i915 under sound/pci/hda at first.

> > - move flag "need_i915_power" from struct hda_codec to hdac_device, for
> the
> >   same reason as above?
> 
> Yes, it makes sense, if the change shall happen sooner or later.

I'll move this flag to hdac_device.

> > - If the audio component moves from struct hda_intel to hdac_bus, how can
> the
> >   controller access the component? Need to add "bus" to struct azx?
> 
> There are more changes.  See my patch series.  The hda_bus itself is
> embedded into hda_bus.
> 
> Also, the hda_bus_ops was dropped.  It's just calling the corresponding
> function instead.

Okay.

> > - implement codec resume/suspend ops to get/put i915 power if only the
> codec
> >   needs the power?
> 
> I don't understand the question here.  Could you elaborate?

Please overlook my question here.

const struct dev_pm_ops hda_codec_driver_pm = {
	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
				pm_runtime_force_resume)
	SET_RUNTIME_PM_OPS(hda_codec_runtime_suspend, hda_codec_runtime_resume,
			   NULL)
};

I misunderstood the code above and had though we need to implement suspend/resume ops. 
Now I find pm_runtime_force_suspend/resume is good enough to make the codec device is runtime suspended before S3 and active after S3.
 
> One concern is that you'd likely need to implement a refcount for power switch.
> It makes our life easier.
> 
> A few more things:
> 
> 
> > Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> >
> > diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h index
> > 2a8aa9d..baa01a0 100644
> > --- a/include/sound/hdaudio.h
> > +++ b/include/sound/hdaudio.h
> > @@ -169,6 +169,8 @@ struct hdac_bus_ops {
> >  	/* get a response from the last command */
> >  	int (*get_response)(struct hdac_bus *bus, unsigned int addr,
> >  			    unsigned int *res);
> > +	/* request/release display power */
> > +	int (*display_power)(struct hdac_bus *bus, bool enable);
> >  };
> >
> >  #define HDA_UNSOL_QUEUE_SIZE	64
> > @@ -222,6 +224,11 @@ static inline void snd_hdac_codec_link_down(struct
> hdac_device *codec)
> >  	clear_bit(codec->addr, &codec->bus->codec_powered);  }
> >
> > +static inline int snd_hdac_display_power(struct hdac_device *codec,
> > +bool enable) {
> > +	return codec->bus->ops->display_power(codec->bus, enable); }
> 
> Please give the function description in kerneldoc style.

Okay.
 
> > +
> >  /*
> >   * generic array helpers
> >   */
> > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c old
> > mode 100755 new mode 100644 index 18a021a..034488e
> > --- a/sound/pci/hda/hda_codec.c
> > +++ b/sound/pci/hda/hda_codec.c
> > @@ -524,9 +524,21 @@ static int _hda_bus_get_response(struct hdac_bus
> *_bus, unsigned int addr,
> >  	return bus->rirb_error ? -EIO : 0;
> >  }
> >
> > +static int _hda_bus_display_power(struct hdac_bus *_bus, bool enable)
> > +{
> > +	struct hda_bus *bus = container_of(_bus, struct hda_bus, core);
> > +
> > +	if (bus->ops.display_power)
> > +		return bus->ops.display_power(bus, enable);
> 
> As mentioned, the bus_ops was dropped.  Rebase your patch with the latest
> topic/hda branch of sound git tree.

Okay. 
 
> > +	else
> > +		return -EINVAL;
> > +
> > +}
> > +
> >  static const struct hdac_bus_ops bus_ops = {
> >  	.command = _hda_bus_command,
> >  	.get_response = _hda_bus_get_response,
> > +	.display_power = _hda_bus_display_power,
> >  };
> >
> >  /**
> > @@ -949,6 +961,10 @@ void snd_hda_codec_register(struct hda_codec
> *codec)
> >  		return;
> >  	if (device_is_registered(hda_codec_dev(codec))) {
> >  		snd_hda_register_beep_device(codec);
> > +
> > +		if (codec->need_i915_power)
> > +			snd_hdac_display_power(&codec->core, true);
> 
> The question is whether doing here is appropriate.
> This assumes that the power well already enabled in the controller side during
> probing?  The verb accesses (reading through the whole topology, widget
> caps, etc) happened already before this point.  So the power well has to be
> enabled before this.

Yes, the power well already enabled in the controller side during probing. 
If AZX_DCAPS_I915_POWERWELL is set, azx_probe_continue will always request the power.
And if the controller is also in the power well, the power will not be released after probing.

 
> >  		pm_runtime_enable(hda_codec_dev(codec));
> >  		/* it was powered up in snd_hda_codec_new(), now all done */
> >  		snd_hda_power_down(codec);
> > @@ -3196,6 +3212,9 @@ static int hda_codec_runtime_suspend(struct
> device *dev)
> >  	if (codec_has_clkstop(codec) && codec_has_epss(codec) &&
> >  	    (state & AC_PWRST_CLK_STOP_OK))
> >  		snd_hdac_codec_link_down(&codec->core);
> > +
> > +	if (codec->need_i915_power)
> > +		snd_hdac_display_power(&codec->core, false);
> >  	return 0;
> >  }
> >
> > @@ -3205,6 +3224,9 @@ static int hda_codec_runtime_resume(struct
> > device *dev)
> >
> >  	printk("amanda: hda_codec_runtime_resume, codec addr %d \n",
> > codec->addr);
> >
> 
> I suppose you're working on a local modified tree?

Sorry. I were working on a snapshot of branch for-next two weeks ago. I'll move to the topic/hda branch and remove the printk.
> 
> Overall, the code should work well without CONFIG_SND_HDA_I915.
> Please check each commit whether it builds and works with and without it.

Okay, I will.

Thanks for your review!
Mengdong
