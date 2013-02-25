From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Mon, 25 Feb 2013 12:47:54 +0100
Message-ID: <512B4F6A.1070505@ivitera.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com> <51081FA7.70907@gmail.com>
 <5108F541.3010300@ivitera.com> <5109BADB.30403@gmail.com>
 <510A485F.9060100@ivitera.com> <510AEF46.1080608@gmail.com>
 <510C6A3C.1000501@gmail.com> <510CEE14.2050800@ivitera.com>
 <510D9799.6070307@gmail.com> <510FE856.9050206@ivitera.com>
 <51293F16.6030209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id ECEA226514F
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 12:47:53 +0100 (CET)
In-Reply-To: <51293F16.6030209@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 23.2.2013 23:13, Jonas Petersen wrote:
> 
>>> Ok, why not adding a control for that. But first explain something to
>>> me. I see these 15 control definitions "snd_ak4114_iec958_controls[]" in
>>> ak4114.c. How are they accessed? Where can I read for example the
>>> "IEC958 External Rate" value? In the proc dir they do not show up.
>>> Neither at Juli nor at AP192. Are these only API functions?
>> see output of amixer contents. They are defined as PCM-type controls
>> (not MIXER type and do not apper e.g. in alsamixer.
> 
> Thanks, found it. Would that help in finding out how the card is
> detecting rate without any clue?

Hopefully. It shows you values of all ak4114 registers. The same
information as available to the windows driver.

Now can you please look at the regs if you can spot any hint of the
incoming sample rate from Juli (specifically the spdif channel status
regs and the incoming fs regs)? Thanks.

> 
> I once read somwhere about a kind of hackish way of detecting sampling
> frequency by just capturing some samples (at a fixed rate) and
> calculating by comparing what you get to what you're supposed to get (or
> something like that, don't remember exactly). Can't find it anywhere
> right now though.
>
> Might it be that the windows driver is doing something like that as a
> fallback (or even always) when there is no channel status?

Well, it is certainly feasible but I very much doubt the driver does it.


> 
> I'd like to once send the card a - let's say - 44.1 kHz signal with a -
> let's say - 96 kHz info in the channel status and see what the windows
> driver says. :)

Take a look at the iecset utility. It sets the IEC958 channel status
bits of the spdif transmitter (e.g. of your Juli or AP192). I would
start a 44.1kHz stream and try to rewrite the values using iecset. You
can check in regs list of your ice1724 card in
/proc/asound/yourcard/ice1724 if the change took place (register MT3C).
The playback may lock the IEC958 channel status controls. If it is the
case, try to comment out the IEC958 Playback Default "lock true" in
/usr/share/alsa/cards/ICE1724.conf.

Instead of iecset you can use amixer to manipulate IEC958 Playback
Default directly, but you will have to figure out correct bit values.

Good luck and thanks for the patch you sent :)

Pavel.
