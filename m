From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: DP MST audio support
Date: Mon, 10 Aug 2015 08:57:17 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D196E0AB4@SHSMSX103.ccr.corp.intel.com>
References: <CAPM=9tx74D8SaghkuY7qcJ5emAXdtQeZOQf8N6e=FEy9VsLJvA@mail.gmail.com>
 <CAPM=9tyc70Xd4us2LFCCYNYT8MfgqNKFxG-f=Ne7dJ_cVNYjXw@mail.gmail.com>
 <CAPM=9twBGjXmW854avAySJCdhbRSWA88aj40JNOFNn7GG1WWRg@mail.gmail.com>
 <s5hwq061btc.wl-tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B894EEE@SHSMSX101.ccr.corp.intel.com>
 <CAPM=9txDN=sSx8bs-ZX0XaBqbcDPVDj7B9O8re1ibyLRU9PVNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 836EB2652E7
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 10:57:33 +0200 (CEST)
In-Reply-To: <CAPM=9txDN=sSx8bs-ZX0XaBqbcDPVDj7B9O8re1ibyLRU9PVNQ@mail.gmail.com>
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
To: Dave Airlie <airlied@gmail.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Dave,

Sorry for interrupt.

I'm currently testing the MST audio with HSW.

Could you please help tell how I can say DP1.2 works?

I connect a DP1.2 monitor to HSW and a DP1.1 monitor to DP1.2 monitor output.

In this mode, can I make the 2 monitors show different contents? Thanks.

Regards,
Libin


> -----Original Message-----
> From: Dave Airlie [mailto:airlied@gmail.com]
> Sent: Friday, June 19, 2015 6:38 PM
> To: Lin, Mengdong
> Cc: Takashi Iwai; Yang, Libin; Lu, Han; alsa-devel@alsa-project.org; intel-
> gfx@lists.freedesktop.org; Girdwood, Liam R
> Subject: Re: [alsa-devel] DP MST audio support
> 
> Just to fill in the info on this one.
> 
> > We don't have Haswell Lenovo t440s atm, so could you share more
> info?
> > - Dell U2410 should support both HDMI and DP input. But I guess it
> cannot
> >  support DP MST, right?
> > - Are you connecting this monitor a DP cable?
> >  Which DDI port is used? DDI B, C or D?
> > - Does audio fail after i915 enables DP MST?
> > - Is patch "snd/hdmi: hack out haswell codec workaround" the only
> change
> >  on audio driver side?
> 
> Yes its a DP SST input on the U2410, and I'm using that for the audio.
> 
> It's connected to the Lenovo dock with DP cable. The dock is an MST
> device.
> 
> The dock is connected to DDI C I think, and if the dock is operated in
> SST
> mode audio works, but in MST mode audio fails. (operating the dock in
> SST
> mode isn't useful though since only one of the multiple outputs works
> then).
> 
> >> > The graphics side patches are fairly trivial, also it would be good to
> >> > get a good explaination of how the hw works,
> >> >
> >> > from what I can see devices get connections not pins on this hw,
> and I
> >> > notice that I don't always get 3 devices, so I'm not sure if devices
> >> > are a dynamic thing we should be reprobing on some signal.
> >
> > Do you mean 3 PCM devices here, like pcmC0D3p, pcmC0D7p,
> pcmC0D8p?
> > Now the devices are not dynamic, a PCM device is created on each pin.
> > It seems we need to revise this for DP MST, since a pin can be used to
> send
> > up to 3 independent streams on Intel GPU which has 3 display
> pipelines.
> >
> 
> No I mean the "Devices" from snd_hda_get_devices.
> 
> Dave.
