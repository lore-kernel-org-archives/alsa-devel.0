From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: sound: bebop: strncmp length oddity
Date: Fri, 18 Nov 2016 05:07:47 +0900
Message-ID: <ecac8bec-ade6-0dc6-08b5-e8be06531e0c@sakamocchi.jp>
References: <1477777020.23018.8.camel@perches.com>
 <s5hr36awcow.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr36awcow.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Joe Perches <joe@perches.com>, nicolas.iooss_linux@m4x.org
Cc: alsa-devel <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

s/bebop/bebob/
(BeBoB is 'BridgeCo enhanced Breakout Box'.)

I'm sorry to miss this post, Joe. I was busy to prepare for Audio 
mini-conference on Linux Plumber Conference. I realized that Nicolas 
posted a patch for this issue.

[alsa-devel] [PATCH 1/1] ALSA: bebob: use the right string length in 
check_audiophile_booted()
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-October/114073.html

On Nov 17 2016 20:47, Takashi Iwai wrote:
> On Sat, 29 Oct 2016 23:37:00 +0200,
> Joe Perches wrote:
>>
>> 15 isn't the length of the string, is that really what's desired?
>>
>> linux/next/sound/firewire/bebob/bebop.c
>>
>> -----------------------------
>>
>> static bool
>> check_audiophile_booted(struct fw_unit *unit)
>> {
>> 	char name[24] = {0};
>>
>> 	if (fw_csr_string(unit->directory, CSR_MODEL, name, sizeof(name)) < 0)
>> 		return false;
>>
>> 	return strncmp(name, "FW Audiophile Bootloader", 15) != 0;
>> }
>
> Indeed it looks bogus.  Even "FW...." string is already 24 letters, so
> it's over name[] array size.
>
> Sakamoto-san, could you fix it properly?

It's OK just to compare first a few characters, while I left whole 
string for our information because model-specific information is easily 
lost.

For M-Audio's FireWire Audiophile, modalias of 
'ieee1394:ven00000D6Cmo00010060sp' hits this unit only. However the unit 
has two states relevant to loaded firmware. Initial firmware returns 'FW 
Audiophile Bootloader', while functional firmware returns 'FW 
Audiophile'. Just comparing the first 15 characters is the shortest way 
to defferentiate them. (Actually 14 characters. I guess that I did avoid 
comparison based on LWS...)

Therefore, changing comparison range is not for bug fix, just for 
readers. But I agree with these patches because the code is a bit 
confusing. I'll post a patch soon for this aim with appropriate 
information, sorry for Nicolas.


Thanks

Takashi Sakamoto
