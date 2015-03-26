From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Thu, 26 Mar 2015 12:39:53 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BDDBAF@SHSMSX101.ccr.corp.intel.com>
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
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDDB1D@SHSMSX101.ccr.corp.intel.com>
 <5513CBE3.2090908@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 07F32265747
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 13:39:59 +0100 (CET)
In-Reply-To: <5513CBE3.2090908@canonical.com>
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


OK, then I am thinking we can add jack kctls creating code like below: 

snd_jack_new(struct snd_card *card, const char *id, int type, struct snd_jack **jjack) {
...
	Switch(type | SND_JACK_HEADSET)
	{
		case SND_JACK_MICROPHONE:
			create "Mic Jack" kctl;
			break;
		case SND_JACK_HEADSET:
			if (id == "Headphone Mic Headset") {
				create " Headphone Mic Jack " kctl;
				create " Headset Mic Jack " kctl;
			} else {
				create " Headphone Jack " kctl;
				create " Headset Mic Jack " kctl;
			}
			break;
		case SND_JACK_HEADPHONE:
			if (id == "Headset Mic") {
				create " Headphone Jack " kctl;
			//	create " Headset Mic Phantom Jack " kctl;
			} else if (id == "Headphone Mic")  {
				create " Headphone Mic Jack " kctl;
			} else if (id == "Headset Headphone Mic")  {
				create " Headphone Mic Jack " kctl;
			//	create " Headset Mic Phantom Jack " kctl;
			} else {
				create " Headphone Jack " kctl;
			}
			break;
		default:
			create "Mic Jack" kctl;
			break;
	}
...
}


Jack Type			Jack name			kctls/switches name
SND_JACK_HEADPHONE	Headphone			Headphone Jack
SND_JACK_MICROPHONE	Mic				Mic Jack
SND_JACK_HEADSET		Headset			Headphone Jack
								Headset Mic Jack
SND_JACK_HEADPHONE	Headset Mic			Headphone Jack
								Headset Mic Phantom Jack
SND_JACK_HEADPHONE 	Headphone Mic		Headphone Mic Jack
SND_JACK_HEADPHONE 	Headset Headphone Mic	Headphone Mic Jack
								Headset Mic Phantom Jack
SND_JACK_HEADSET 		Headphone Mic Headset	Headphone Mic Jack
								Headset Mic Jack

~Keyon

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Thursday, March 26, 2015 5:06 PM
> To: Jie, Yang; Tanu Kaskinen; Takashi Iwai
> Cc: perex@perex.cz; broonie@kernel.org; alsa-devel@alsa-project.org;
> Girdwood, Liam R; Liam Girdwood
> Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols for every jack
> input device
> 
> 
> 
> On 2015-03-26 09:29, Jie, Yang wrote:
> >
> > Thank you so much, David!
> >
> > So, I summarized as below table:
> 
> I've added how I see them with the new API, see below for further
> comments:
> 
> >
> > Jack Type					kctls/switches name
> 				detection
> 
> 			description
> >
> > Headphone					Headphone Jack
> 				HP plugged in/unplugged
> 
> SND_JACK_HEADPHONE
> 
> >
> > Mic						Mic Jack
> 				Mic plugged in/unplugged
> 
> SND_JACK_MICROPHONE
> 
> >
> > Headset					Headphone Jack
> 				Nothing plugged in:   ""Headphone Jack"" =
> false, ""Headset Mic Jack"" = false
> > 						Headset Mic Jack"
> 				Headphones plugged in:   ""Headphone
> Jack"" = true, ""Headset Mic Jack"" = false
> >
> 				Headset plugged in:   ""Headphone Jack"" =
> true, ""Headset Mic Jack"" = true
> >
> 				Mic plugged in:   ""Headphone Jack"" = true
> ""Headset Mic Jack"" = false(should not plugged in Mic, detect wrongly)"
> 		independent switches
> 
> SND_JACK_HEADSET
> 
> "Mic plugged in" case is irrelevant - not supported by hw
> 
> >
> > Headset Mic					Headphone Jack
> 				Nothing plugged in:   ""Headphone Jack"" =
> false, ""Headset Mic Phantom Jack"" = false
> > 						Headset Mic Phantom Jack
> 				Headphones plugged in:   ""Headphone
> Jack"" = true, ""Headset Mic Phantom Jack"" = false?
> >
> 				Headset plugged in:   ""Headphone Jack"" =
> false, ""Headset Mic Phantom Jack"" = true ?
> >
> 				Mic plugged in:   ""Headphone Jack"" = true,
> ""Headset Mic Phantom Jack"" = false(should not plugged in Mic, detect
> wrongly)"    one hw switch only
> 
> SND_JACK_HEADPHONE, the "Headset Mic Phantom Jack" is created
> manually
> 
> > Headphone Mic				Headphone Mic Jack
> 				Nothing plugged in:   ""Headphone Mic Jack""
> = false
> >
> 				Headphones plugged in:   ""Headphone Mic
> Jack"" = true
> >
> 				Mic plugged in:   ""Headphone Mic Jack"" =
> true
> >
> 				Headset plugged in:   ""Headphone Mic
> Jack"" = true?"
> 			one hw switch
> 
> SND_JACK_HEADPHONE (probably)
> 
> > Headset Headphone Mic			Headphone Mic Jack
> 				Nothing plugged in:   ""Headphone Mic Jack""
> = false, ""Headset Mic Phantom Jack"" = false
> > 						Headset Mic Phantom Jack
> 				Headphones plugged in:   ""Headphone Mic
> Jack"" = true, ""Headset Mic Phantom Jack"" = false
> >
> 				Headset plugged in:   ""Headphone Mic
> Jack"" = false, ""Headset Mic Phantom Jack"" = true ?
> >
> 				Mic plugged in:   ""Headphone Mic Jack"" =
> true, ""Headset Mic Phantom Jack"" = false"
> 	one hw switch only
> 
> SND_JACK_HEADPHONE (probably), the "Headset Mic Phantom Jack" is
> created manually
> 
> > Headphone Mic Headset			Headphone Mic Jack
> 				Nothing plugged in:   ""Headphone Mic Jack""
> = false, ""Headset Mic Jack"" = false
> > 						Headset Mic Jack
> 				Headphones plugged in:   ""Headphone Mic
> Jack"" = true, ""Headset Mic Jack"" = false
> >
> 				Headset plugged in:   ""Headphone Mic
> Jack"" = true, ""Headset Mic Jack"" = true
> >
> 				Mic plugged in:   ""Headphone Mic Jack"" =
> true, ""Headset Mic Jack"" = false
> >
> 
> 							one switch for hp/mic
> and the other for the
> > headset mic
> 
> SND_JACK_HEADSET (probably)
> 
> >
> > so, we may need extend snd_jack_types enum, by adding types:  Headset
> Mic, Headphone Mic, Headset Headphone Mic, Headphone Mic Headset.
> >
> > enum snd_jack_types {
> > 	SND_JACK_HEADPHONE	= 0x0001,
> > 	SND_JACK_MICROPHONE	= 0x0002,
> > 	SND_JACK_HEADSET	= SND_JACK_HEADPHONE |
> SND_JACK_MICROPHONE,
> > 	SND_JACK_LINEOUT	= 0x0004,
> > 	SND_JACK_MECHANICAL	= 0x0008, /* If detected separately */
> > 	SND_JACK_VIDEOOUT	= 0x0010,
> > 	SND_JACK_AVOUT		= SND_JACK_LINEOUT |
> SND_JACK_VIDEOOUT,
> > 	SND_JACK_LINEIN		= 0x0020,
> >
> > 	SND_JACK_HEADSET_MIC	= 0x0040, /* one hw switch only */
> > 	SND_JACK_HEADPHONE_MIC	= 0x0080, /* one hw switch only,
> headphone, or mic */
> > 	SND_JACK_HEADSET_ HEADPHONE_MIC	= 0x0100, /* one hw
> switch only,  headset, headphone, or mic*/
> > 	SND_JACK_ HEADPHONE_HEADSET_ MIC	= 0x0200, /* headset,
> headphone, or mic; one switch for hp/mic and the other for the headset mic
> */
> 
> This seems overly complex. I don't think we really need to add all of that.
> 
> First, for the phantom jacks. We'll need phantom jacks not only for "Headset
> Mic Phantom Jack" but also for "Internal Speaker Phantom Jack"
> and "Internal Mic Phantom Jack", and probably some others as well. So that
> means that the HDA driver needs to still create some kctls using the current
> kctl API instead of your new unified API.
> 
> A phantom jack is merely a marker to userspace indicating what hardware is
> present. It always returns "plugged in" when trying to read it.
> 
> With the phantom jacks dealt with separately, the question remains about
> the Headphone Mic stuff. If the name remains the way it is, maybe all we
> need is a SND_JACK_HEADPHONE (or SND_JACK_HEADSET) jack with the
> "Headphone Mic Jack" name and then userspace would know that this jack
> could potentially accomodate a microphone too. Otherwise we might need
> to add a SND_JACK_HEADPHONE_OR_MIC constant, but I prefer that the
> names are kept properly, because there might be other relevant info added
> to the name too (e g "Front Headphone Jack" instead of "Headphone Jack").
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
