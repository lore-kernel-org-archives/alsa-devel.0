From: "Klaas De Craemer" <klaasdc@gmail.com>
Subject: Re: [PATCH] Sigmatel stac92hd71b7 low HP volume
Date: Wed, 8 Oct 2008 00:41:27 +0200
Message-ID: <f59e60020810071541p1dfbfd8epb669cf2c0388e05@mail.gmail.com>
References: <200810052210.46360.klaasdc@gmail.com>
	<s5h4p3qgiri.wl%tiwai@suse.de> <200810061248.43643.klaasdc@gmail.com>
	<s5hskraf0ti.wl%tiwai@suse.de>
	<f59e60020810061010m39b83fb4qb05f8f008d46adf3@mail.gmail.com>
	<s5hd4idufg3.wl%tiwai@suse.de>
	<f59e60020810070246g43b50378lfc14d337d5b13d30@mail.gmail.com>
	<s5habdgn2f6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.187])
	by alsa0.perex.cz (Postfix) with ESMTP id B68E624368
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 00:41:41 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so4752121fka.0
	for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2008 15:41:28 -0700 (PDT)
In-Reply-To: <s5habdgn2f6.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 7, 2008 at 12:07 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 7 Oct 2008 11:46:58 +0200,
> Klaas De Craemer wrote:
>>
>> On Tue, Oct 7, 2008 at 7:44 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Mon, 6 Oct 2008 19:10:14 +0200,
>> > Klaas De Craemer wrote:
>> >>
>> >> On Mon, Oct 6, 2008 at 12:57 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> > [please don't drop Cc to alsa-devel ML]
>> >> >
>> >> > At Mon, 6 Oct 2008 12:48:43 +0200,
>> >> > Klaas De Craemer wrote:
>> >> >>
>> >> >> Hello,
>> >> >>
>> >> >> I'm sure that the audioquality will degrade somewhat because of the additional amplification,
>> >> >> but before, the HP-out was not usable at all. I had to use an external ampli just to use my
>> >> >> headphones, even after turning all volume sliders to 100%. Then again, when removing the HP,
>> >> >> the volume though the internal speakers was way too loud...
>> >> >>
>> >> >> I'm not sure what you mean with the output pin and headphone control, but I have uploaded the
>> >> >> output of the codegraph tool before and after my modification here:
>> >> >> http://users.vtk.be/~s0159120/codec_original.svg
>> >> >> http://users.vtk.be/~s0159120/codec_final.svg
>> >> >>
>> >> >> Below is the output of alsa-info with the patched module
>> >> >> Klaas
>> >> >
>> >> > Thanks.
>> >> >
>> >> > So, if I understand correctly, when the pin 0x0a is connected directly
>> >> > from DAC0 0x10, the output level is too low even if you set the all
>> >> > volumes maximal.
>> >>
>> >> That is correct.
>> >>
>> >>
>> >> > In the alsa-info.sh output, I see the following:
>> >> >> Node 0x10 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
>> >> >>   Amp-Out caps: N/A
>> >> >>   Amp-Out vals:  [0x5e 0x5e]
>> >> >
>> >> > which means that you decrease the output level intentionally.
>> >> > Is the HP output still too low even if you set to the higher value?
>> >>
>> >>
>> >> No, after the patch I don't need 100% anymore.
>> >
>> > Of course not :)
>> >
>> >> The HP output is fine
>> >> now, and I can tune it up and down a bit. Before using the mixer-amp,
>> >> going from 90 to 100 resulted in going from no sound to little sound.
>> >> Now the range is more useful.
>> >
>> > Could you check the raw value of the widget 0x10 without your patch?
>> > The percent doesn't tell you exactly what you changed.
>> >
>> >
>> > Takashi
>> >
>>
>> I have pasted the output of /proc/asound/card0/codec#0 below, without
>> the patch. However, I'm not sure what you're exactly looking for? I'm
>> quite new to all this stuff , but I'd be more than happy to help out
>> more, so feel free to ask anything.
>
> The mixer volume level in percentage might be different from the raw
> value of the NID 0x10 (or 0x11?) amps because of volume-knob stuff.
> I just wanted to make sure that a really high value is set to the
> amp.
>
> OTOH, if it happens only with the headphone (I suppose the loud enough
> output from the speaker after unplugging the headphone), this isn't a
> matter of the DAC amp value.


But, with this information, can something be done about it in future
releases? Maybe a model-option?

I also checked the output by connecting earplugs and by using the jack
as lineout to my hifi, but it is again quite low-volume. So that rules
out a "bad" headphone.

Klaas

ps: it also seems like most of this conversation is not listed in the
alsa-devel list?

>> Also related, in windows (yeah i know), using the IDT drivers, the
>> volume is extremely high  :) So I went searching in the driver files
>> and it seems that the widget configuration is specified there in an
>> ini file. As far as I can see, the mixer is not configured, but an
>> external amp is mentioned. Could it be that the external amp of 0x0A
>> is not used in snd-hda-intel? Or maybe it refers to the "+3dBV output
>> option on headphone capable ports" as mentioned in the datasheet...
>
> This seems to be the normal pin control bit 7 to me.  And we already
> set it.
>
> BTW, you can use hda-verb program to change the verb dynamically.
> Build the driver with CONFIG_SND_HDA_HWDEP=y, and you'll have the
> access to hwdep device, e.g. /dev/snd/hwC0D0.  The device number
> depends on the codec slot.
>    ftp://ftp.suse.com/pub/people/tiwai/misc/hda-verb-0.2.tar.bz2
>
>
> thanks,
>
> Takashi
>
>> Klaas
>>
