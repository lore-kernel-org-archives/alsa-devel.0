From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Tue, 29 Jan 2013 14:10:22 +0100
Message-ID: <5107CA3E.9000104@gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com
 [209.85.217.176])
 by alsa0.perex.cz (Postfix) with ESMTP id F041B26160D
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 14:10:24 +0100 (CET)
Received: by mail-lb0-f176.google.com with SMTP id s4so699596lbc.35
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 05:10:24 -0800 (PST)
In-Reply-To: <510798CC.3080006@ivitera.com>
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

Am 29.01.2013 10:39, schrieb Pavel Hofman:
> @Pavel, btw. I also have an ESI Juli@. Spdif capture with this one
> does not
> work at all (as compared to "kind of working" with the Audiophile 192).
>>> Interesting. I am pretty sure I tested the SPDIF input of Juli quite
>>> extensively. It even reported the incoming samplerate correctly. How did
>>> you test it? Please list amixer contents and ak4114 regs here. Thanks.
>> I just tried again. The Juli just seem to freeze the whole alsa when I
>> try to access the spdif input.
> OK, let's do some troubleshooting. Do you have SPDIF signal present at
> Juli's input when you try to capture?

Yes, normally I have a 1 kHz Sine/-12dB(25%)/44100 coming in when testing.

> Does it lock the moment you open the capture stream (i.e. start the
> capturing), or when you switch the rate selector to IEC958-In?

I have the Juli card in another machine right now. I'm using the analog 
out there, which is working fine. It's running a Ubuntu 12.10. 'uname 
-a' says

Linux rakete 3.5.0-22-generic #34-Ubuntu SMP Tue Jan 8 21:41:11 UTC 2013 
i686 i686 i686 GNU/Linux

/proc/asound/version says:

Advanced Linux Sound Architecture Driver Version 1.0.25.

I behaves like this:

If I switch 'Multi Track Internal Clock' to 'IEC958 In', the whole 
system goes crazy. Not instantly, but when I start alsamixer it locks up 
(only alsamixer, it can not be killed -9 then). When doing 'ps -aux' it 
locks up somewhere in the middle of the list.
This is all with a signal going in the spdif input.
When I reboot (still with signal), the login screen locks up. I can move 
the mouse, but I can not input the password. Also the background image 
does not load (which normally does). I can switch to another terminal 
(e.g. ctrl-alt-f1) and log in. But it will hang sooner or later.
No way switch back the 'Multi Track Internal Clock' to a fixed rate.
Only if I disconnect the signal from the spdif input and reboot, then I 
can switch it back and bring the system back to reason. Pew...

- Jonas
