From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Fri, 27 Mar 2015 09:01:29 +0100
Message-ID: <55150E59.8080803@canonical.com>
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
 <5514FDA6.1000705@canonical.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDE7F0@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 62725260410
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 09:01:35 +0100 (CET)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BDE7F0@SHSMSX101.ccr.corp.intel.com>
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



On 2015-03-27 08:45, Jie, Yang wrote:
>> -----Original Message-----
>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>> Sent: Friday, March 27, 2015 2:50 PM
>> To: Jie, Yang; Tanu Kaskinen; Takashi Iwai
>> Cc: perex@perex.cz; broonie@kernel.org; alsa-devel@alsa-project.org;
>> Girdwood, Liam R; Liam Girdwood
>> Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols for every jack
>> input device
>>
>>
>>
>> On 2015-03-26 13:43, Jie, Yang wrote:
>>>
>>> Sorry, Correct a typo(removing line "create "Mic Jack" kctl;" in
>>> default case)
>>
>> It looks like your code can be simplified as:
> [Keyon] thanks, I will try simplify them.
>>
>> switch (type | SND_JACK_HEADSET) {
>> 	case SND_JACK_HEADSET:
>> 		create "Headset Mic Jack" kctl;
>> 		/* fall through */
>> 	case SND_JACK_MICROPHONE:
>> 	case SND_JACK_HEADPHONE:
>> 		create format("%s Jack", id) kctl;
> [Keyon] I don't want to fill "id" to kctl name, because sometimes it can be
> string which can't be understood by PA, such as:
>
> soc/intel/mfld_machine.c:       ret_val = snd_soc_card_jack_new(runtime->card,
> soc/intel/mfld_machine.c-                       "Intel(R) MID Audio Jack", SND_JACK_HEADSET |
> soc/intel/mfld_machine.c-                       SND_JACK_BTN_0 | SND_JACK_BTN_1, &mfld_jack,
>
> soc/omap/ams-delta.c:   ret = snd_soc_card_jack_new(card, "hook_switch", SND_JACK_HEADSET,
> soc/omap/ams-delta.c-                               &ams_delta_hook_switch, NULL, 0);

Ok, good point. It's a matter of different conventions between ASoC and 
HDA. In ASoC, naming is wild west. In HDA, naming is (mostly) consistent 
and we depend on the exact naming for userspace to know exactly how the 
jack functions.

Another example is HDMI/DisplayPort, where the hw often supports several 
ports and we need to know which jack belongs to which PCM device, and we 
use the name of the jack to determine that.

I would very much prefer that all the ASoC jack names (and mixer control 
names!) would be fixed up to be consistent to the extent that makes 
sense, but the ASoC people haven't really agreed to do that, but instead 
prefer to use a large database of UCM files. :-( And seen from a UCM 
context, that the ASoC jacks are labelled terribly inconsistent, isn't 
that big of a deal given that UCM will specify the jack name anyhow.

>> }
>>
>> ...that way, prefixes such as "Front Headphone Jack" are preserved too,
> [Keyon] if PA can recognize "Front Headphone Jack" and "Rear Headphone Jack", then I
> prefer to add a determine here:
>
> 	if (!strcmp(id, "Front Headphone Jack") || !strcmp(id, "Rear Headphone Jack"))
> 		create format("%s Jack", id) kctl;

This will not scale, there are too many variants.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
