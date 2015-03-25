From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Wed, 25 Mar 2015 07:53:46 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BDD72E@SHSMSX101.ccr.corp.intel.com>
References: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
 <1426841719-14576-3-git-send-email-yang.jie@intel.com>
 <s5hd2446mt2.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB90F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbhv6eio.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
 <s5hr3sj6bzj.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB993@SHSMSX101.ccr.corp.intel.com>
 <s5hegoj69bs.wl-tiwai@suse.de>
 <1427108203.2968.57.camel@tkkaskin-mobl3.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BD8B7261B0E
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 08:53:52 +0100 (CET)
In-Reply-To: <1427108203.2968.57.camel@tkkaskin-mobl3.ger.corp.intel.com>
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
To: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Tanu Kaskinen [mailto:tanu.kaskinen@linux.intel.com]
> Sent: Monday, March 23, 2015 6:57 PM
> To: Takashi Iwai
> Cc: Jie, Yang; perex@perex.cz; broonie@kernel.org; alsa-devel@alsa-
> project.org; Girdwood, Liam R; Liam Girdwood; David Henningsson
> Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols for every jack
> input device
> 
> On Fri, 2015-03-20 at 15:18 +0100, Takashi Iwai wrote:
> > At Fri, 20 Mar 2015 13:49:24 +0000,
> > Jie, Yang wrote:
> > >
> > > > -----Original Message-----
> > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > Sent: Friday, March 20, 2015 9:21 PM
> > > > To: Jie, Yang
> > > > Cc: perex@perex.cz; broonie@kernel.org;
> > > > alsa-devel@alsa-project.org; Girdwood, Liam R; Liam Girdwood; Tanu
> > > > Kaskinen
> > > > (tanu.kaskinen@linux.intel.com)
> > > > Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols for
> > > > every jack input device
> > > >
> > > > At Fri, 20 Mar 2015 12:50:33 +0000, Jie, Yang wrote:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > > Sent: Friday, March 20, 2015 8:27 PM
> > > > > > To: Jie, Yang
> > > > > > Cc: perex@perex.cz; broonie@kernel.org;
> > > > > > alsa-devel@alsa-project.org; Girdwood, Liam R; Liam Girdwood
> > > > > > Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
> > > > > > for every jack input device
> > > > > >
> > > > > > At Fri, 20 Mar 2015 12:22:10 +0000, Jie, Yang wrote:
> > > > > > >
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int snd_jack_new_kctl(struct snd_card *card,
> > > > > > > > > +struct snd_jack *jack, int type) {
> > > > > > > > > +	struct snd_kcontrol *kctl;
> > > > > > > > > +	struct snd_jack_kctl *jack_kctl;
> > > > > > > > > +	int i, err, index, state = 0 /* use 0 for default state ??
> > > > > > > > > +*/;
> > > > > > > > > +
> > > > > > > > > +	INIT_LIST_HEAD(&jack->kctl_list);
> > > > > > > > > +	for (i = 0; i < fls(SND_JACK_BTN_0); i++) {
> > > > > > > > > +		int testbit = 1 << i;
> > > > > > > > > +		if (type & testbit) {
> > > > > > > >
> > > > > > > > With this implementation, you'll get multiple boolean
> > > > > > > > kctls for a headset.  I thought we agreed with creating a
> > > > > > > > single boolean for
> > > > headset?
> > > > > > > [Keyon] We agreed with creating multiple kctls for combo jack, e.g.
> > > > > > headset.
> > > > > > > Furthermore, e.g., imagine that type = SND_JACK_HEADSET  |
> > > > > > > SND_JACK_BTN_0, we will create 3 kctls for the jack, when
> > > > > > > BTN_0 is pressed, we will report to the 3rd kctl.
> > > > > >
> > > > > > Hm, I don't remember that I agreed with multiple kctls...
> > > > > >
> > > > > > The multiple kctls have a significant drawback (multiple event
> > > > > > calls for a single
> > > > > > headset) and its behavior is incompatible with the current
> > > > > > code (both the name change and the behavior change).  That is,
> > > > > > your patch will very likely break the existing applications.
> > > > > [Keyon] I am not very clear with the existing applications that
> > > > > using these kctl events(seems Android use input subsystem event?
> > > > > Which we didn't Change here. If I understand correctly,
> > > > > Pulseaudio uses jack switch controls, via the name, then we can
> > > > > use different name for headphone and mic here.)
> > > >
> > > > PA uses jack kctls.
> > > >
> > > > If you rename, how would you guarantee that the existing
> > > > application will work as expected?  PA doesn't have the definition of
> "Headset Speaker Jack"
> > > > or such.
> > > >
> > > > And, no, we have no option "fix PA".  Other way round: we are not
> > > > allowed to break the current PA (or any user-space) behavior in general.
> > > >
> > > > > we will generate 2 event calls(one headphone, one mic) when
> > > > > Headset plug in/out, applications will receive these 2 events,
> > > > > and they can do anything, e.g. decide to switch on/off
> speaker/headphone.
> > > >
> > > > Won't this break any user-space stuff?
> > > >
> > > > > BTW, I haven't implemented the generating of combo jack kctls'
> > > > > name yet, currently, they looked like below:
> > > > > numid=12,iface=CARD,name='Headset Jack'
> > > > > numid=13,iface=CARD,name='Headset Jack',index=1
> > > > > numid=14,iface=CARD,name='Headset Jack',index=2
> > > > >
> > > > > once we have come to agreement, we can modify it in
> > > > > snd_jack_new_kctl(), e.g., "Headset Jack Mic" and "Headset Jack
> > > > Speakers".
> > > >
> > > > .... and how the existing user-space works without changing its code?
> > > >
> > > >
> > > > Keyon, the most important point at this moment is to keep the
> compatibility.
> > > > HD-audio is no new driver.  It's a driver that has been present
> > > > over a decade with (literally) thousands of variants.
> > > > Please keep this in mind, and reconsider whether your patch will
> > > > retain the compatibility, especially with PulseAudio.
> > > [Keyon] understood. Then we should follow the HD-audio style, So,
> > > what do you suggest here? Should we create only one single Boolean
> > > kctls for headset, and report true when status in headphone bit it
> > > true? Then we need a tricky exception mapping here?
> > >
> > > Sorry, I am a little confusing here, because Mark suggest to create
> > > multiple controls for multiple bits jack, and you also agreed with
> > > that.  :(
> >
> > Just prepare two exceptions for SND_JACK_HEADSET and
> SND_JACK_VIDEOUT.
> > These are already defined as single types in sound/jack.h.  The code
> > can't be so tricky if you write properly :)
> 
> Can someone clarify what is the current plan? Will there be changes to the
> control naming or behaviour for existing hardware?
[Keyon] Hi Tanu, currently we plan to create kctls/switches at jack creating
stage, and attached them to the jack.
So, we need to decide the naming of these kctls/switches and make sure
they will be understood by PA correctly. 
At the same time, we create jacks with snd_jack_types as parameter passed
in, so, we need decision about what kctls/switches do we need create, for
each separate or combo(bits) type jack:
enum snd_jack_types {
        SND_JACK_HEADPHONE      = 0x0001,
        SND_JACK_MICROPHONE     = 0x0002,
        SND_JACK_HEADSET        = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
        SND_JACK_LINEOUT        = 0x0004,
        SND_JACK_MECHANICAL     = 0x0008, /* If detected separately */
        SND_JACK_VIDEOOUT       = 0x0010,
        SND_JACK_AVOUT          = SND_JACK_LINEOUT | SND_JACK_VIDEOOUT,
        SND_JACK_LINEIN         = 0x0020,

        /* Kept separate from switches to facilitate implementation */
        SND_JACK_BTN_0          = 0x4000,
        SND_JACK_BTN_1          = 0x2000,
        SND_JACK_BTN_2          = 0x1000,
        SND_JACK_BTN_3          = 0x0800,
        SND_JACK_BTN_4          = 0x0400,
        SND_JACK_BTN_5          = 0x0200,
};

So, 
1. we need these naming, what you summarized below, that's quite helpful.
2. I am a little concern if the exist snd_jack_types enum can indicate all diverse
existing hardware, e.g. " Headphone Mic Jack " as you mentioned below, can
we use any bits combination for this kind of jack?
SND_JACK_HEADPHONE | SND_JACK_MICROPHONE seems can't tell difference
With "Headset Mic Jack" + "Headphone Jack"?

> 
> PulseAudio's jack handling seems somewhat messy to me, so it may be
> difficult to understand what kind of changes will break things and what won't.
> I think these are the jack controls that PulseAudio currently recognizes that
> are most important in this discussion:
> 
>  * Headset Mic Jack
>  * Headphone Mic Jack
>  * Mic Jack
>  * Headphone Jack
> 
> "Headset Mic Jack" indicates the availability of a headset mic. In PulseAudio it
> doesn't imply anything about the headset speaker availability, even though
> logically, if there's a headset mic plugged in, surely the headset speakers are
> available too.
> 
> "Headphone Mic Jack" indicates the availability of either headphones or a
> microphone. There's no information about which of those is plugged in, just
> that one of those devices is plugged in. This control is *not* for headsets,
> according to the commit that added the support for that control to
> PulseAudio[1].
> 
> "Mic Jack" indicates the availability of a standalone microphone. I don't know
> if the kernel currently exposes both "Headset Mick Jack" and "Mic Jack" if
> there's one physical jack that is able to distinguish between the two device
> types, but I suppose it would be good to have both controls in that case, so
> that applications know what kind of device has been plugged in.
> 
> "Headphone Jack" indicates the availability of headphones. PulseAudio
> doesn't currently have support for any kind of "Headset Speaker Jack"
> control, so I guess the kernel currently uses "Headphone Jack" also with
> physical jacks that support headsets.
> 
> One thing that is unclear for me is that how are those jacks represented that
> support any of headsets/headphones/microphones, but don't provide
> information about which device type has been plugged in. I know David has
> made a UI for Ubuntu for selecting the device type once something has been
> plugged in to such jack, but I don't remember how the UI can know that the
> jack supports all of those three device types.
> 
> [1]
> http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=7369a53ab5
> f606e87a3cd1cd4eebd40226bab090
> 
> --
> Tanu
