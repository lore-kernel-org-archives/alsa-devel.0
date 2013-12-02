From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: HD-Audio: How to reduce driver initializaton time
 if multiple codecs present on the bus?
Date: Mon, 2 Dec 2013 11:27:55 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F801422121@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F80141EEE6@SHSMSX101.ccr.corp.intel.com>
 <52983498.606@canonical.com>	<s5hmwkng17c.wl%tiwai@suse.de>
 <529842EF.8070800@canonical.com>	<s5h8uw7fxzv.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F80141FC29@SHSMSX101.ccr.corp.intel.com>
 <s5h61rbfx5s.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F801421CD5@SHSMSX101.ccr.corp.intel.com>
 <s5hfvqbek4e.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F801421ED7@SHSMSX101.ccr.corp.intel.com>
 <s5hr49v8trz.wl%tiwai@suse.de> <s5hfvqbo8s4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 86642261673
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:28:00 +0100 (CET)
In-Reply-To: <s5hfvqbo8s4.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thanks again for your clarification and patch!
Will these two patches enter sound.git or sound-unstable.git at the moment?

Regards
Mengdong

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, December 02, 2013 6:19 PM
> To: Lin, Mengdong
> Cc: David Henningsson; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] HD-Audio: How to reduce driver initializaton time
> if multiple codecs present on the bus?
> 
> At Mon, 02 Dec 2013 10:52:00 +0100,
> Takashi Iwai wrote:
> >
> > At Mon, 2 Dec 2013 09:48:24 +0000,
> > Lin, Mengdong wrote:
> > >
> > > > -----Original Message-----
> > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > Sent: Monday, December 02, 2013 4:24 PM
> > >
> > >
> > > > > > > > > Btw, using a deferred azx_probe_continue (like we do if
> > > > > > > > > there's a firmware file), would one get more
> > > > > > > > > parallelization with
> > > > other drivers?
> > > > > > > > > If so we could consider making that the default.
> > > > > > > >
> > > > > > > > This sounds like a good idea as we have already that code.
> > > > > > > > The patch would be just a few-liners.
> > > > > > >
> > > > > > > If azx_probe_continue() is delayed, could user space get
> > > > > > > incomplete
> > > > > > audio information after boot?
> > > > > > > I mean is it possible that azx_probe_continue() does not
> > > > > > > complete
> > > > > > before user space check ALSA info?
> > > > > >
> > > > > > Not impossible.  But then user-space should be triggered in
> > > > > > event driven way by udev or such.
> > > > >
> > > > > Hi Takashi/David,
> > > > >
> > > > > So is it okay to defer azx_probe_continue() by default?
> > > >
> > > > Yes.
> > > >
> > > > > If yes, is it also necessary to defer snd_card_create() at the
> > > > > end of
> > > > azx_probe_continue()?
> > > >
> > > > No, that's a significant difference.  The snd_card_create()
> > > > invocation isn't related with the hardware access itself, thus
> > > > it's no point to delay.  If you delay the card instance creation,
> > > > this may result in races between the card order, which we'd like to
> avoid.
> > > >
> > > > > So user space can only see the sound card when
> > > > > azx_probe_continue()
> > > > completes.
> > > >
> > > > The completion of the card creation is notified only after
> > > > snd_card_register(), so it doesn't matter when to call
> snd_card_create().
> > > >
> > > > The below is an untested patch.  I should have added in the
> > > > previous reply...
> > >
> > > Hi Takashi,
> > >
> > > Many thanks for the patch and information!
> > >
> > > Is my understanding below is right?
> > > snd_card_register() will create the device files under
> > > /sys/devices/pci0000:00/0000:00:1b.0/sound/cardx
> > > (or /sys/devices/pci0000:00/0000:00:03.0/sound/cardx for Haswell
> display audio), and trigger uevent to notify user space that an audio
> device is ready.
> > >
> > > And for the patch,
> >
> > Yes.
> >
> > > >  #ifdef CONFIG_SND_HDA_PATCH_LOADER
> > > >  	if (patch[dev] && *patch[dev]) { @@ -3855,25 +3855,17 @@
> static
> > > > int azx_probe(struct pci_dev *pci,
> > > >  					      azx_firmware_cb);
> > > >  		if (err < 0)
> > > >  			goto out_free;
> > > > -		probe_now = false; /* continued in azx_firmware_cb() */
> > > > +		schedule_probe = false; /* continued in azx_firmware_cb()
> */
> > > >  	}
> > >
> > > Should it be 'schedule_probe = true'?
> > > I guess the driver intends to defer firmware loading.
> >
> > No, in the case of f/w loading, f/w loader itself calls
> > azx_probe_continue(), thus you don't need to schedule it manually.
> >
> > We may move the f/w loading into azx_probe_continue() for simplicity,
> > though, after applying the always-deferred-probe patch.  Then it can
> > be back to request_firmware() again (not _nowait()).
> 
> BTW, while checking my previous patch, I noticed that the
> complete_all() should be put in the delayed probe part, too.
> The following patch fixes it.
> 
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Fix complete_all() timing in deferred probes
> 
> When the probe of snd-hda-intel driver is deferred due to f/w loading or
> the nested module loading, complete_all() should be also delayed until
> the initialization really finished.  Otherwise, vga-switcheroo client would
> start switching before the actual init is done.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_intel.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c index
> c6d230193da6..27aa14007cbd 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -3876,7 +3876,8 @@ static int azx_probe(struct pci_dev *pci,
>  	}
> 
>  	dev++;
> -	complete_all(&chip->probe_wait);
> +	if (chip->disabled)
> +		complete_all(&chip->probe_wait);
>  	return 0;
> 
>  out_free:
> @@ -3953,10 +3954,10 @@ static int azx_probe_continue(struct azx
> *chip)
>  	if ((chip->driver_caps & AZX_DCAPS_PM_RUNTIME) ||
> chip->use_vga_switcheroo)
>  		pm_runtime_put_noidle(&pci->dev);
> 
> -	return 0;
> -
>  out_free:
> -	chip->init_failed = 1;
> +	if (err < 0)
> +		chip->init_failed = 1;
> +	complete_all(&chip->probe_wait);
>  	return err;
>  }
> 
> --
> 1.8.4.4
