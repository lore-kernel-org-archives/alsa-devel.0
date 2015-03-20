From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Fri, 20 Mar 2015 13:49:24 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BDB993@SHSMSX101.ccr.corp.intel.com>
References: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
 <1426841719-14576-3-git-send-email-yang.jie@intel.com>
 <s5hd2446mt2.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB90F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbhv6eio.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
 <s5hr3sj6bzj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D21302654FC
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 14:49:30 +0100 (CET)
In-Reply-To: <s5hr3sj6bzj.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Tanu Kaskinen (tanu.kaskinen@linux.intel.com)" <tanu.kaskinen@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, March 20, 2015 9:21 PM
> To: Jie, Yang
> Cc: perex@perex.cz; broonie@kernel.org; alsa-devel@alsa-project.org;
> Girdwood, Liam R; Liam Girdwood; Tanu Kaskinen
> (tanu.kaskinen@linux.intel.com)
> Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols for every jack
> input device
> 
> At Fri, 20 Mar 2015 12:50:33 +0000,
> Jie, Yang wrote:
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Friday, March 20, 2015 8:27 PM
> > > To: Jie, Yang
> > > Cc: perex@perex.cz; broonie@kernel.org; alsa-devel@alsa-project.org;
> > > Girdwood, Liam R; Liam Girdwood
> > > Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols for
> > > every jack input device
> > >
> > > At Fri, 20 Mar 2015 12:22:10 +0000,
> > > Jie, Yang wrote:
> > > >
> > > > > > +}
> > > > > > +
> > > > > > +static int snd_jack_new_kctl(struct snd_card *card, struct
> > > > > > +snd_jack *jack, int type) {
> > > > > > +	struct snd_kcontrol *kctl;
> > > > > > +	struct snd_jack_kctl *jack_kctl;
> > > > > > +	int i, err, index, state = 0 /* use 0 for default state ??
> > > > > > +*/;
> > > > > > +
> > > > > > +	INIT_LIST_HEAD(&jack->kctl_list);
> > > > > > +	for (i = 0; i < fls(SND_JACK_BTN_0); i++) {
> > > > > > +		int testbit = 1 << i;
> > > > > > +		if (type & testbit) {
> > > > >
> > > > > With this implementation, you'll get multiple boolean kctls for
> > > > > a headset.  I thought we agreed with creating a single boolean for
> headset?
> > > > [Keyon] We agreed with creating multiple kctls for combo jack, e.g.
> > > headset.
> > > > Furthermore, e.g., imagine that type = SND_JACK_HEADSET  |
> > > > SND_JACK_BTN_0, we will create 3 kctls for the jack, when BTN_0 is
> > > > pressed, we will report to the 3rd kctl.
> > >
> > > Hm, I don't remember that I agreed with multiple kctls...
> > >
> > > The multiple kctls have a significant drawback (multiple event calls
> > > for a single
> > > headset) and its behavior is incompatible with the current code
> > > (both the name change and the behavior change).  That is, your patch
> > > will very likely break the existing applications.
> > [Keyon] I am not very clear with the existing applications that using
> > these kctl events(seems Android use input subsystem event? Which we
> > didn't Change here. If I understand correctly, Pulseaudio uses jack
> > switch controls, via the name, then we can use different name for
> > headphone and mic here.)
> 
> PA uses jack kctls.
> 
> If you rename, how would you guarantee that the existing application will
> work as expected?  PA doesn't have the definition of "Headset Speaker Jack"
> or such.
> 
> And, no, we have no option "fix PA".  Other way round: we are not allowed
> to break the current PA (or any user-space) behavior in general.
> 
> > we will generate 2 event calls(one headphone, one mic) when Headset
> > plug in/out, applications will receive these 2 events,  and they can
> > do anything, e.g. decide to switch on/off speaker/headphone.
> 
> Won't this break any user-space stuff?
> 
> > BTW, I haven't implemented the generating of combo jack kctls' name
> > yet, currently, they looked like below:
> > numid=12,iface=CARD,name='Headset Jack'
> > numid=13,iface=CARD,name='Headset Jack',index=1
> > numid=14,iface=CARD,name='Headset Jack',index=2
> >
> > once we have come to agreement, we can modify it in
> > snd_jack_new_kctl(), e.g., "Headset Jack Mic" and "Headset Jack
> Speakers".
> 
> .... and how the existing user-space works without changing its code?
> 
> 
> Keyon, the most important point at this moment is to keep the compatibility.
> HD-audio is no new driver.  It's a driver that has been present over a decade
> with (literally) thousands of variants.
> Please keep this in mind, and reconsider whether your patch will retain the
> compatibility, especially with PulseAudio.
[Keyon] understood. Then we should follow the HD-audio style, So, what do 
you suggest here? Should we create only one single Boolean kctls for headset,
and report true when status in headphone bit it true? Then we need a tricky
exception mapping here?

Sorry, I am a little confusing here, because Mark suggest to create multiple controls
for multiple bits jack, and you also agreed with that.  :(

> 
> 
> thanks,
> 
> Takashi
