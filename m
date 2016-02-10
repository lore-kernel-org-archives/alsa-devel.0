From: "Yang, Libin" <libin.yang@intel.com>
Subject: RE: [BUG] [REGRESSION] [BISECTED] -rc1 breaks audio over HDMI for
 i915
Date: Wed, 10 Feb 2016 14:47:10 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190465F0C0@SHSMSX103.ccr.corp.intel.com>
References: <56B98888.5000702@posteo.de> <s5h4mdixg4n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h4mdixg4n.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Martin Kepplinger <martink@posteo.de>
Cc: "david.henningsson@canonical.com" <david.henningsson@canonical.com>, "Lu, Han" <han.lu@intel.com>, "treding@nvidia.com" <treding@nvidia.com>, "perex@perex.cz" <perex@perex.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

It may be the audio component binding error? I met the audio component binding error in our internal kernel before. It is because the audio component name are duplicating with another i915 component and so match() function doesn't work well. But I'm not sure the ALSA kernel have the same issue. I will check it after my holiday.

Regards,
Libin

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, February 09, 2016 7:44 PM
> To: Martin Kepplinger
> Cc: david.henningsson@canonical.com; Lu, Han; Yang, Libin;
> treding@nvidia.com; perex@perex.cz; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [BUG] [REGRESSION] [BISECTED] -rc1 breaks audio over
> HDMI for i915
> 
> On Tue, 09 Feb 2016 07:34:48 +0100,
> Martin Kepplinger wrote:
> >
> > The following change:
> >
> > 788d441 ALSA: hda - Use component ops for i915 HDMI/DP audio jack
> handling
> >
> > breaks audio over HDMI on my snd_hda_intel laptop. It is the first bad
> > commit.
> >
> > This was merged for -rc1 and isn't fixed until now, so I got nervous.
> > There are
> > no errors in the log that stand out. I'm no sound or alsa developer, and
> > just reverting it isn't easy since there is stuff depending on this.
> >
> > I'm happy to test possible fixes and hope v4.5 not to ship with such a big
> > regression ;)
> 
> Could you give a bit more detail about your hardware?  At best, give
> alsa-info.sh output (run with --no-upload option).  Also, give the
> output of dmesg, too.
> 
> In addition, what shows /proc/asound/card*/eld#*.* files?  Does any of
> it show the proper connection state and ELD?
> 
> A simple revert of the commit is a patch like below.  Does it make the
> HDMI audio working again?
> 
> 
> thanks,
> 
> Takashi
> 
> ---
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -156,7 +156,7 @@ struct hdmi_spec {
>  	bool i915_bound; /* was i915 bound in this driver? */
>  };
> 
> -#ifdef CONFIG_SND_HDA_I915
> +#if 0
>  #define codec_has_acomp(codec) \
>  	((codec)->bus->core.audio_component != NULL)
>  #else
