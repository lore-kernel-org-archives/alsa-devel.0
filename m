From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Thu, 26 Mar 2015 08:29:49 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BDDB1D@SHSMSX101.ccr.corp.intel.com>
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
 <550FFE2B.7050008@canonical.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDD854@SHSMSX101.ccr.corp.intel.com>
 <5513AA46.2080804@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CC473260574
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 09:31:37 +0100 (CET)
In-Reply-To: <5513AA46.2080804@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


Thank you so much, David!

So, I summarized as below table:

Jack Type					kctls/switches name					detection																description

Headphone					Headphone Jack					HP plugged in/unplugged	

Mic						Mic Jack						Mic plugged in/unplugged	

Headset					Headphone Jack					Nothing plugged in:   ""Headphone Jack"" = false, ""Headset Mic Jack"" = false
						Headset Mic Jack"					Headphones plugged in:   ""Headphone Jack"" = true, ""Headset Mic Jack"" = false 
													Headset plugged in:   ""Headphone Jack"" = true, ""Headset Mic Jack"" = true
													Mic plugged in:   ""Headphone Jack"" = true ""Headset Mic Jack"" = false(should not plugged in Mic, detect wrongly)"		independent switches

Headset Mic					Headphone Jack					Nothing plugged in:   ""Headphone Jack"" = false, ""Headset Mic Phantom Jack"" = false
						Headset Mic Phantom Jack				Headphones plugged in:   ""Headphone Jack"" = true, ""Headset Mic Phantom Jack"" = false? 
													Headset plugged in:   ""Headphone Jack"" = false, ""Headset Mic Phantom Jack"" = true ?
													Mic plugged in:   ""Headphone Jack"" = true, ""Headset Mic Phantom Jack"" = false(should not plugged in Mic, detect wrongly)"    one hw switch only

Headphone Mic				Headphone Mic Jack					Nothing plugged in:   ""Headphone Mic Jack"" = false
													Headphones plugged in:   ""Headphone Mic Jack"" = true 
													Mic plugged in:   ""Headphone Mic Jack"" = true
													Headset plugged in:   ""Headphone Mic Jack"" = true?"											one hw switch

Headset Headphone Mic			Headphone Mic Jack					Nothing plugged in:   ""Headphone Mic Jack"" = false, ""Headset Mic Phantom Jack"" = false
						Headset Mic Phantom Jack				Headphones plugged in:   ""Headphone Mic Jack"" = true, ""Headset Mic Phantom Jack"" = false 
													Headset plugged in:   ""Headphone Mic Jack"" = false, ""Headset Mic Phantom Jack"" = true ?
													Mic plugged in:   ""Headphone Mic Jack"" = true, ""Headset Mic Phantom Jack"" = false"					one hw switch only

Headphone Mic Headset			Headphone Mic Jack					Nothing plugged in:   ""Headphone Mic Jack"" = false, ""Headset Mic Jack"" = false
						Headset Mic Jack					Headphones plugged in:   ""Headphone Mic Jack"" = true, ""Headset Mic Jack"" = false 
													Headset plugged in:   ""Headphone Mic Jack"" = true, ""Headset Mic Jack"" = true 
													Mic plugged in:   ""Headphone Mic Jack"" = true, ""Headset Mic Jack"" = false
																									one switch for hp/mic and the other for the headset mic

so, we may need extend snd_jack_types enum, by adding types:  Headset Mic, Headphone Mic, Headset Headphone Mic, Headphone Mic Headset.

enum snd_jack_types {
	SND_JACK_HEADPHONE	= 0x0001,
	SND_JACK_MICROPHONE	= 0x0002,
	SND_JACK_HEADSET	= SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
	SND_JACK_LINEOUT	= 0x0004,
	SND_JACK_MECHANICAL	= 0x0008, /* If detected separately */
	SND_JACK_VIDEOOUT	= 0x0010,
	SND_JACK_AVOUT		= SND_JACK_LINEOUT | SND_JACK_VIDEOOUT,
	SND_JACK_LINEIN		= 0x0020,

	SND_JACK_HEADSET_MIC	= 0x0040, /* one hw switch only */
	SND_JACK_HEADPHONE_MIC	= 0x0080, /* one hw switch only, headphone, or mic */
	SND_JACK_HEADSET_ HEADPHONE_MIC	= 0x0100, /* one hw switch only,  headset, headphone, or mic*/
	SND_JACK_ HEADPHONE_HEADSET_ MIC	= 0x0200, /* headset, headphone, or mic; one switch for hp/mic and the other for the headset mic  */

	/* Kept separate from switches to facilitate implementation */
	SND_JACK_BTN_0		= 0x8000,
	SND_JACK_BTN_1		= 0x4000,
	SND_JACK_BTN_2		= 0x2000,
	SND_JACK_BTN_3		= 0x1000,
	SND_JACK_BTN_4		= 0x0800,
	SND_JACK_BTN_5		= 0x0400,
};

And then, we may create corresponding kctls during jack creating.

Any comment?

~Keyon


> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Thursday, March 26, 2015 2:42 PM
> To: Jie, Yang; Tanu Kaskinen; Takashi Iwai
> Cc: perex@perex.cz; broonie@kernel.org; alsa-devel@alsa-project.org;
> Girdwood, Liam R; Liam Girdwood
> Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols for every jack
> input device
> 
> 
> 
> On 2015-03-25 14:53, Jie, Yang wrote:
> >
> > Thank you for comprehensive summarizing, David.
> > Can you help give more description as below?
> >
> > ~Keyon
> >
> >> -----Original Message-----
> >> From: David Henningsson [mailto:david.henningsson@canonical.com]
> >> Sent: Monday, March 23, 2015 7:51 PM
> >> To: Tanu Kaskinen; Takashi Iwai
> >> Cc: Jie, Yang; perex@perex.cz; broonie@kernel.org; alsa-devel@alsa-
> >> project.org; Girdwood, Liam R; Liam Girdwood
> >> Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols for
> >> every jack input device
> >>
> >>
> >>
> >> On 2015-03-23 11:56, Tanu Kaskinen wrote:
> >>> One thing that is unclear for me is that how are those jacks
> >>> represented that support any of headsets/headphones/microphones,
> but
> >>> don't provide information about which device type has been plugged in.
> >>
> >> For headphone or headset, independent switches:
> >>
> >>    * "Headphone Jack"
> >>    * "Headset Mic Jack"
> > [Keyon] here for the most common headset jack (SND_JACK_HEADPHONE
> |
> > SND_JACK_MICROPHONE), we should create two independent
> > kctls/switches--"Headphone Jack" + "Headset Mic Jack", right?
> >
> > so, is it possible that there is only "Mic Jack" in this case? I mean
> > that only input(no output, no physical headphone/speaker jack) jack exist.
> >
> > If yes, then we may need change "Headset Mic Jack" to "Mic Jack"?
> 
> I'm not sure I understand your question - of course there are input only jacks,
> but they would then be SND_JACK_MICROPHONE only, and also labelled
> "Mic Jack". But that's not a headset jack, that's a microphone jack.
> 
> >> For headphone or headset, one hw switch only:
> > [Keyon] I am sorry I am not familiar with the jack HW circuit. What
> > "one hw switch only" here means? Does it means that -- for headset
> > Jack, the
> > status(connected/disconnected) of HP pin is always exactly same with
> > that of Mic pin?
> 
> There is only one jack detection input from HW. Regardless of whether you
> plug in headphone or a headset, the HW switch would detect "plugged in".
> When the jack is unplugged, the HW switch would detect "unplugged".
> 
> The HW cannot tell us whether you plugged in a headphone or headset.
> 
> >>    * "Headphone Jack"
> >>    * "Headset Mic Phantom Jack"
> > [Keyon] for Headset of this type, do we need create only "Headset Mic
> > Phantom Jack" kctl, or "Headphone Jack" kctl is also needed?
> 
> We need both kctls.
> 
> >> Headphone or mic, one hw switch:
> > [Keyon]I am fresh about this kind of hw jack, it should use different
> > segment of the plug, seems we don't need check the actual connected
> > status at the jack creation stage, just creating "Headphone Mic Jack"
> > should works, right?
> 
> It is not very common. It was used on some Asus netbooks a while ago.
> But yes, we should just create a "Headphone Mic Jack".
> 
> >>
> >>    * "Headphone Mic Jack"
> >>
> >> Headphone, headset, or mic, one hw switch only:
> > [Keyon] how many kctls should we create for this?
> >>
> >>    * "Headphone Mic Jack"
> >>    * "Headset Mic Phantom Jack"
> 
> Same as today, two: "Headphone Mic Jack" and "Headset Mic Phantom Jack".
> 
> >> Headphone, headset, or mic, one switch for hp/mic and the other for
> >> the headset mic:
> > [Keyon] I can't imagine how this works, it's too messy for me. :(
> >>
> >>    * "Headphone Mic Jack"
> >>    * "Headset Mic Jack"
> 
> Nothing plugged in:
>    "Headphone Mic Jack" = false, "Headset Mic Jack" = false Headphones
> plugged in:
>    "Headphone Mic Jack" = true, "Headset Mic Jack" = false Headset plugged
> in:
>    "Headphone Mic Jack" = true, "Headset Mic Jack" = true Mic plugged in:
>    "Headphone Mic Jack" = true, "Headset Mic Jack" = false
> 
> As you can see, "Headphones" and "Mic" results in the same output, hence
> userspace needs to ask the user if (s)he plugged in a headphone or mic.
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
