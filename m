From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Fri, 27 Mar 2015 07:50:14 +0100
Message-ID: <5514FDA6.1000705@canonical.com>
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
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDDBCA@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DFFFA2606AF
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 07:50:20 +0100 (CET)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BDDBCA@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org



On 2015-03-26 13:43, Jie, Yang wrote:
>
> Sorry, Correct a typo(removing line "create "Mic Jack" kctl;" in default case)

It looks like your code can be simplified as:

switch (type | SND_JACK_HEADSET) {
	case SND_JACK_HEADSET:
		create "Headset Mic Jack" kctl;
		/* fall through */
	case SND_JACK_MICROPHONE:
	case SND_JACK_HEADPHONE:
		create format("%s Jack", id) kctl;
}

...that way, prefixes such as "Front Headphone Jack" are preserved too, 
which is a good thing.

// David

>
> snd_jack_new(struct snd_card *card, const char *id, int type, struct snd_jack **jjack) { ...
> 	Switch(type | SND_JACK_HEADSET)
> 	{
> 		case SND_JACK_MICROPHONE:
> 			create "Mic Jack" kctl;
> 			break;
> 		case SND_JACK_HEADSET:
> 			if (id == "Headphone Mic Headset") {
> 				create " Headphone Mic Jack " kctl;
> 				create " Headset Mic Jack " kctl;
> 			} else {
> 				create " Headphone Jack " kctl;
> 				create " Headset Mic Jack " kctl;
> 			}
> 			break;
> 		case SND_JACK_HEADPHONE:
> 			if (id == "Headset Mic") {
> 				create " Headphone Jack " kctl;
> 			//	create " Headset Mic Phantom Jack " kctl;
> 			} else if (id == "Headphone Mic")  {
> 				create " Headphone Mic Jack " kctl;
> 			} else if (id == "Headset Headphone Mic")  {
> 				create " Headphone Mic Jack " kctl;
> 			//	create " Headset Mic Phantom Jack " kctl;
> 			} else {
> 				create " Headphone Jack " kctl;
> 			}
> 			break;
> 		default:
> 			break;
> 	}
> ...
> }
>
>
> Jack Type			Jack name			kctls/switches name
> SND_JACK_HEADPHONE	Headphone			Headphone Jack
> SND_JACK_MICROPHONE	Mic				Mic Jack
> SND_JACK_HEADSET		Headset			Headphone Jack
> 								Headset Mic Jack
> SND_JACK_HEADPHONE	Headset Mic			Headphone Jack
> 								Headset Mic Phantom Jack
> SND_JACK_HEADPHONE 	Headphone Mic		Headphone Mic Jack
> SND_JACK_HEADPHONE 	Headset Headphone Mic	Headphone Mic Jack
> 								Headset Mic Phantom Jack
> SND_JACK_HEADSET 		Headphone Mic Headset	Headphone Mic Jack
> 								Headset Mic Jack
>
> ~Keyon
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
