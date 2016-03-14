From: moosotc@gmail.com
Subject: Re: No audio output via built-in speaker on a
	MacMini	while headphone jack is plugged in
Date: Mon, 14 Mar 2016 20:16:11 +0300
Message-ID: <87r3fd3rqc.fsf@gmail.com>
References: <87pouxtr6p.fsf@gmail.com> <s5hwpp5gfx3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B50B260440
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 18:16:14 +0100 (CET)
Received: by mail-lb0-f170.google.com with SMTP id k12so15426665lbb.1
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 10:16:14 -0700 (PDT)
In-Reply-To: <s5hwpp5gfx3.wl-tiwai@suse.de> (Takashi Iwai's message of "Mon,
 14 Mar 2016 17:52:56 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> On Mon, 14 Mar 2016 09:11:10 +0100,
> moosotc@gmail.com wrote:
>> 
>> [1 Output of alsa-info.sh <application/octet-stream (base64)>]
>> 
>> 
>> `amixer set Speaker unmute' makes no difference
>> physically unplugging the headphone jack from the socket does, i.e.
>> `amixer set Speaker (un)mute' does the right thing.
>
> Could you give more details?  The description is too concise and
> vague.
>

I have a script to toggles sound emission by the built-in speaker:

#!/bin/sh
amixer get Speaker | grep -q "\[on\]" && onoff="mute" || onoff="unmute"
amixer set Speaker $onoff
echo "$onoff"

As we speak:

`--> atoggle
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [0.00dB] [on]
  Front Right: Playback 127 [100%] [0.00dB] [on]
unmute

This setting is ignored when (i.e. speaker is always silent) if the
headphone jack is plugged in.

This used to work in prior kernels, I believe I've shared my bisection
results with you in one of the earlier (personal) e-mails, if there's a
better way to achieve the desired result (i.e. control sound emission by
the speaker regardless of the headphone jack plug-status) I'll happily
use that instead.

> The auto-mute feature is standard behavior.  When "Auto-Mute Mode"
> control is set to "Enabled", the speaker is muted no matter what you
> set the speaker mute switch.  If this isn't the case, please elaborate
> what you expected and what doesn't work.
>
>
> thanks,
>
> Takashi

-- 
mailto:moosotc@gmail.com
