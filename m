From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] ALSA: declare snd_kcontrol_new structures as const
Date: Tue, 30 May 2017 14:26:23 +0530
Message-ID: <CAOH+1jEahJz3XYhopE8t=nhMX0a7Ref+U9Qg39fWy3-g2KHjxQ@mail.gmail.com>
References: <1495896375-30855-1-git-send-email-bhumirks@gmail.com> <s5hvaoiencx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hvaoiencx.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org, clemens@ladisch.de, Julia Lawall <julia.lawall@lip6.fr>, linuxppc-dev@lists.ozlabs.org, perex@perex.cz, Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 30, 2017 at 2:24 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 27 May 2017 16:46:15 +0200,
> Bhumika Goyal wrote:
>>
>> Declare snd_kcontrol_new structures as const as they are only passed an
>> argument to the function snd_ctl_new1. This argument is of type const,
>> so snd_kcontrol_new structures having this property can be made const.
>> Done using Coccinelle:
>>
>> @r disable optional_qualifier@
>> identifier x;
>> position p;
>> @@
>> static struct snd_kcontrol_new x@p={...};
>>
>> @ok@
>> identifier r.x;
>> position p;
>> @@
>> snd_ctl_new1(&x@p,...)
>>
>> @bad@
>> position p != {r.p,ok.p};
>> identifier r.x;
>> @@
>> x@p
>>
>> @depends on !bad disable optional_qualifier@
>> identifier r.x;
>> @@
>> +const
>> struct snd_kcontrol_new x;
>>
>> Cross compiled these files:
>> sound/aoa/codecs/tas.c - powerpc
>> sound/mips/{hal2.c/sgio2audio.c} - mips
>> sound/ppc/{awacs.c/beep.c/tumbler.c} - powerpc
>> sound/soc/sh/siu_dai.c - sh
>> Could not find an architecture to compile sound/sh/aica.c.
>>
>> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>
> Applied now, as it looks safe enough.  But I prefer splitting to
> individual patches, so please try to do that at the next time.
>
>

Okay :)

Thanks,
Bhumika

> thanks,
>
> Takashi
