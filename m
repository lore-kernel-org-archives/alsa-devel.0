From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: Re: sound: bebop: strncmp length oddity
Date: Thu, 17 Nov 2016 22:34:39 +0100
Message-ID: <6ad63c31-5faf-41e9-525b-b9bf089439ef@m4x.org>
References: <1477777020.23018.8.camel@perches.com>
 <s5hr36awcow.wl-tiwai@suse.de>
 <ecac8bec-ade6-0dc6-08b5-e8be06531e0c@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ecac8bec-ade6-0dc6-08b5-e8be06531e0c@sakamocchi.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Takashi Iwai <tiwai@suse.de>, Joe Perches <joe@perches.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 17/11/16 21:07, Takashi Sakamoto wrote:
> On Nov 17 2016 20:47, Takashi Iwai wrote:
>> On Sat, 29 Oct 2016 23:37:00 +0200,
>> Joe Perches wrote:
>>>
>>> 15 isn't the length of the string, is that really what's desired?
>>>
>>> linux/next/sound/firewire/bebob/bebop.c
>>>
>>> -----------------------------
>>>
>>> static bool
>>> check_audiophile_booted(struct fw_unit *unit)
>>> {
>>>     char name[24] = {0};
>>>
>>>     if (fw_csr_string(unit->directory, CSR_MODEL, name, sizeof(name))
>>> < 0)
>>>         return false;
>>>
>>>     return strncmp(name, "FW Audiophile Bootloader", 15) != 0;
>>> }
>>
>> Indeed it looks bogus.  Even "FW...." string is already 24 letters, so
>> it's over name[] array size.
>>
>> Sakamoto-san, could you fix it properly?
> 
> It's OK just to compare first a few characters, while I left whole
> string for our information because model-specific information is easily
> lost.
> 
> For M-Audio's FireWire Audiophile, modalias of
> 'ieee1394:ven00000D6Cmo00010060sp' hits this unit only. However the unit
> has two states relevant to loaded firmware. Initial firmware returns 'FW
> Audiophile Bootloader', while functional firmware returns 'FW
> Audiophile'. Just comparing the first 15 characters is the shortest way
> to defferentiate them. (Actually 14 characters. I guess that I did avoid
> comparison based on LWS...)
> 
> Therefore, changing comparison range is not for bug fix, just for
> readers. But I agree with these patches because the code is a bit
> confusing. I'll post a patch soon for this aim with appropriate
> information, sorry for Nicolas.

All right, so long as the code is modified in a way that makes it more
consistent, I am all right. It is one patch less I need to care about :)

Nicolas
