From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Lost dB volumes on USB headset between 2.6.38 and
 3.0
Date: Sat, 03 Sep 2011 13:11:14 +0200
Message-ID: <4E620B52.6060801@colin.guthr.ie>
References: <4E410361.7010808@canonical.com> <4E410E7D.8050903@ladisch.de>
	<4E4117C9.2090100@colin.guthr.ie> <s5hwremdagh.wl%tiwai@suse.de>
	<4E4A6338.6020309@colin.guthr.ie> <s5hfwkyu4su.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id 59C0F244B1
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Sep 2011 13:11:19 +0200 (CEST)
In-Reply-To: <s5hfwkyu4su.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Sorry I only just got around to looking at kernel stuff today, but when
I checked with my 3.0.4 kernel which is now installed it seems fixed!

Cheers!

Col

'Twas brillig, and Takashi Iwai at 18/08/11 17:18 did gyre and gimble:
> At Tue, 16 Aug 2011 13:31:52 +0100,
> Colin Guthrie wrote:
>>
>>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>>> index c04d7c7..cdd19d7 100644
>>> --- a/sound/usb/mixer.c
>>> +++ b/sound/usb/mixer.c
>>> @@ -152,6 +152,7 @@ static inline void check_mapped_dB(const struct usbmix_name_map *p,
>>>  	if (p && p->dB) {
>>>  		cval->dBmin = p->dB->min;
>>>  		cval->dBmax = p->dB->max;
>>> +		cval->initialized = 1;
>>>  	}
>>>  }
>>>  
>>> @@ -1092,7 +1093,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
>>>  				" Switch" : " Volume");
>>>  		if (control == UAC_FU_VOLUME) {
>>>  			check_mapped_dB(map, cval);
>>> -			if (cval->dBmin < cval->dBmax) {
>>> +			if (cval->dBmin < cval->dBmax || !cval->initialized) {
>>>  				kctl->tlv.c = mixer_vol_tlv;
>>>  				kctl->vd[0].access |= 
>>>  					SNDRV_CTL_ELEM_ACCESS_TLV_READ |
>>
>>
>>
>> Not had a chance to test this yet but I will when I get a moment.
> 
> Any chance to test the patch?
> 
> 
> Takashi


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
