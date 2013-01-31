From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Thu, 31 Jan 2013 21:56:04 +0100
Message-ID: <510ADA64.9030506@gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510644E5.1040505@perex.cz> <5106747A.5070803@ivitera.com>
 <5106ECE1.7040608@gmail.com> <510799FE.3020904@ivitera.com>
 <5109C6AB.8050407@gmail.com> <510A3399.1010600@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 86130262618
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 21:56:06 +0100 (CET)
Received: by mail-bk0-f42.google.com with SMTP id jk7so1549034bkc.29
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 12:56:06 -0800 (PST)
In-Reply-To: <510A3399.1010600@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 31.01.2013 10:04, schrieb Pavel Hofman:
> On 31.1.2013 02:19, Jonas Petersen wrote:
>> Am 29.01.2013 10:44, schrieb Pavel Hofman:
>>> On 28.1.2013 22:25, Jonas Petersen wrote:
>>>>> Jonas, please could you check if ak4114 pins XTL0/1 (10, 11) are
>>>>> connected to logical high? They should be :)
>>>> Physically they're both on ground. I don't know what active state that
>>>> chip has though.
> That would mean the chip is fed 11.2896MHz clock. I do not see any
> crystal on
> http://www.nix.ru/autocatalog/m_audio_midiman_sound/34397_2245_draft.jpg
> . Is it the same card you have, with the crystal position empty? Are you
> really sure they are not on power supply?

I double-checked. There is zero ohms between these pins and ground (e.g. =

outer of the spdif connectors, or pin B3 of PCI). The adjacent pins are =

also on ground which are "VIN" (12), "P/SN" (9) and "IPS1/IIC" (8).

Yeah, pretty much excactly the same card. The crystal position is empty, =

like on the picture from nix.ru.



> I did a quick test in Windows 7. This driver is able to
>> detect the sample rate. If I set the clock source to "spdif in" at the
>> control pannel, then I can see the rate changing when I switch to
>> another rate on the spdif source.
> Did you test 192kHz and 176,4kHz?
>   The receiver can work in two modes.
> Either it knows it is fed an independent clock and detects the sample
> rate precisely, or it simply reads the sample rate from SPDIF preamble
> of the incoming stream.

You mean probably this from the datasheet:

The AK4114 has two methods for detecting the sampling frequency as follows.
1. Clock comparison between recovered clock and X=92tal oscillator
2. Sampling frequency information on channel status
Those could be selected by XTL1, 0 bits. And the detected frequency is =

reported on FS3-0 bits.

It is indeed strange. There is an example system design in the datasheet =

that also has XTL0,1 on ground, but there is a 11 MHz Crystal on XTI and =

XTO.

>   The mode is select by the XTL0,1 pins. Often the
> streams do not contain correct information, especially for consumer mode
> which does not have room for the larger samplerates code. Could you
> please test both consumer and professional modes, all common samplerates?

I tested 32, 44.1, 48, 64, 88.2, and 92 kHz with both modes. All rates =

except 64 kHz are always reliably detected (64 kHz is not in the list of =

supported frequencies of the chip). They are detected no matter what =

mode I select (prof/consumer) on both sides, even if they do not match. =

I tried all combinations.

For these tests I was using an RME Multiface. I guess one can expect =

correct streams from this device...

Now I checked the spdif signal from a dbx 376 tube channel strip. 44.1, =

48, 88.2 and 96 are detected properly.

Ok.. and now I just connected the ESI Juli(a) spdif out to the ap192 =

spdif in. I'm chaning the internal clock rate in alsamixer. Everything =

is detected, only 176.4 and 192 result in 88.2 and 96... But this might =

as well be the Juli failing, doesn't it? I wasn't able to play any sound =

at these rates neither.

By the way, the Windows 7 "M-Audio Delta Control Panel" has this "sync =

source" lamp. It is normally green an says "locked" if there is any =

detected signal. When I change the rate it will become red for a moment =

and say "rate missmatch", then it will display the detected rate and =

turn green again.

If I do nothing with a green "locked", it will periodically (about every =

6 seconds) show a red "unlocked !" for maybe half a second. Only if I =

use the signal in a program (e.g. audacity) it will stay "locked" and green.

- Jonas
