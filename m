From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Sat, 23 Feb 2013 23:13:42 +0100
Message-ID: <51293F16.6030209@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BD03264FDF
 for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2013 23:13:45 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so770173bkc.24
 for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2013 14:13:44 -0800 (PST)
In-Reply-To: <510FE856.9050206@ivitera.com>
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

Ok, let's keep this going... I'll post a patch of the current state that 
I got (for the M-Audio Audiophile 192). I think it's already worth a 
review/commit since spdif input is now working properly.

There is still potential for more improvements, concerning the sample 
frequency detection.


Am 04.02.2013 17:56, schrieb Pavel Hofman:
> On 2.2.2013 23:47, Jonas Petersen wrote:
>> Now, how is the windows driver detecting the rate if there is a) no
>> crystal in there and b) no Channel Status available? Might it be the
>> clock being on PLL (I'm not realy aware of what that means right now)?
> I do not know, are you sure there is really no channel status available?

Quite sure. It seems to be an ESI Juli phenomenon. I did plug my several 
devices into the AP192 spdif input while observing the channel status. 
The ESI is not sending any channel status, the others are...

But, as you suggested let's address the Juli later, maybe in a separate 
thread.


>>> Back to the light indicating "sync source" in the windows driver. I
>>> think it is reading status of GPIO06 as you reported "INT0 (pin36) --
>>> GPIO6 pin 58". It would be possible to add a new read-only control for
>>> sync source to revo.c for ap192. It might be useful. Of course a generic
>>> method for ak4114.c would be more suitable but we would have to abstract
>>> the reading method.
>> Ok, why not adding a control for that. But first explain something to
>> me. I see these 15 control definitions "snd_ak4114_iec958_controls[]" in
>> ak4114.c. How are they accessed? Where can I read for example the
>> "IEC958 External Rate" value? In the proc dir they do not show up.
>> Neither at Juli nor at AP192. Are these only API functions?
> see output of amixer contents. They are defined as PCM-type controls
> (not MIXER type and do not apper e.g. in alsamixer.

Thanks, found it. Would that help in finding out how the card is 
detecting rate without any clue?

I once read somwhere about a kind of hackish way of detecting sampling 
frequency by just capturing some samples (at a fixed rate) and 
calculating by comparing what you get to what you're supposed to get (or 
something like that, don't remember exactly). Can't find it anywhere 
right now though.

Might it be that the windows driver is doing something like that as a 
fallback (or even always) when there is no channel status?

I'd like to once send the card a - let's say - 44.1 kHz signal with a - 
let's say - 96 kHz info in the channel status and see what the windows 
driver says. :)

- Jonas
