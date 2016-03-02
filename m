From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - hdmi defer to register acomp
	eld notifier
Date: Wed, 2 Mar 2016 07:48:52 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190467E35D@SHSMSX103.ccr.corp.intel.com>
References: <1456895983-46529-1-git-send-email-libin.yang@linux.intel.com>
 <s5h1t7ttjdp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 485552606F5
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 08:48:56 +0100 (CET)
In-Reply-To: <s5h1t7ttjdp.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, March 02, 2016 3:43 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> Subject: Re: [PATCH] ALSA: hda - hdmi defer to register acomp eld notifier
> 
> On Wed, 02 Mar 2016 06:19:43 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > Defer to register acomp eld notifier until hdmi audio driver
> > is fully ready.
> 
> When you submit a patch, especially fixing something, please give
> always "why".  This is the most important information.

Get it. Thanks. I will explain it. 

Regards,
Libin

> 
> 
> thanks,
> 
> Takashi
> 
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c
> b/sound/pci/hda/patch_hdmi.c
> > index aa2d6a2..a3de50b 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -2936,13 +2936,6 @@ static int patch_generic_hdmi(struct
> hda_codec *codec)
> >  			is_broxton(codec))
> >  		codec->core.link_power_control = 1;
> >
> > -	if (codec_has_acomp(codec)) {
> > -		codec->depop_delay = 0;
> > -		spec->i915_audio_ops.audio_ptr = codec;
> > -		spec->i915_audio_ops.pin_eld_notify =
> intel_pin_eld_notify;
> > -		snd_hdac_i915_register_notifier(&spec-
> >i915_audio_ops);
> > -	}
> > -
> >  	if (hdmi_parse_codec(codec) < 0) {
> >  		if (spec->i915_bound)
> >  			snd_hdac_i915_exit(&codec->bus->core);
> > @@ -2964,6 +2957,13 @@ static int patch_generic_hdmi(struct
> hda_codec *codec)
> >
> >  	init_channel_allocations();
> >
> > +	if (codec_has_acomp(codec)) {
> > +		codec->depop_delay = 0;
> > +		spec->i915_audio_ops.audio_ptr = codec;
> > +		spec->i915_audio_ops.pin_eld_notify =
> intel_pin_eld_notify;
> > +		snd_hdac_i915_register_notifier(&spec-
> >i915_audio_ops);
> > +	}
> > +
> >  	WARN_ON(spec->dyn_pcm_assign
> && !codec_has_acomp(codec));
> >  	return 0;
> >  }
> > --
> > 1.9.1
> >
