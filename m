From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC][PATCH 00/13] bebob: a new driver for
 BridgeCo BeBoB based device
Date: Thu, 05 Dec 2013 22:08:47 +0100
Message-ID: <52A0EB5F.9090003@monom.org>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
 <529A2691.4000401@monom.org> <529ABE4F.6070406@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hotel311.server4you.de (hotel311.server4you.de [85.25.146.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 46485261A9F
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 22:08:49 +0100 (CET)
In-Reply-To: <529ABE4F.6070406@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 12/01/2013 05:42 AM, Takashi Sakamoto wrote:
> Hi Daniel,
>
> Thanks for your testing.

No problem.

> At first, I describe our system to test. I use Ubuntu 13.10. You use
> Fedora 19.

Be aware I have a lot of own build libraries flying around (e.g.
libiec61883, libraw1394, ...)

> (Dec 01 2013 02:55), Daniel Wagner wrote:
>> I have tried this series (incl. the bug fix you recommend) on a FA-66.
>> While I see some output in alsa-info, pulseaudio didn't pick it up. I
>> also noted that some logs in the dmesg. I am not sure what is supposed
>> to work already or not.
>>
>> Here are my logs
>>
>> http://www.monom.org/misc/alsa-firewire/2013-11-30
>
> 1.pulseaudio
> PulseAudio can automatically load 'module-alsa-card' with
> 'module-udev-detect' (utilizing sysfs/dbus). But for snd-bebob, this
> mecanism doesn't work because PulseAudio cannot decide profiles for the
> card even if success to detect.
>
> For this problem, I have a need to commit some codes for PulseAudio but
> this may be my future work.
>
> Well, when I test with PulseAudio, I always directly load
> 'module-alsa-sink' or 'module-alsa-source' by these lines:
> $ pactl load-module module-alsa-sink device=hw:X,X
> $ pactl load-module module-alsa-source device=hw:X,X

I got the FA-66 now working (playback) with explicit loading of the
modules.

> 2.dmesg
> Hm. I want to know which asynchronous transaction is failed.
> [  446.796563] snd-bebob fw1.0: transaction failed: no ack
> [  446.838567] snd-bebob fw1.0: transaction failed: no ack

I was not able to reproduce this so far. Note that I a have crapy
firewire card. So that might just be the main reason why we
see these.

> Would you investigate which transactions cannot get 'no ack'?

I have uploaded some two logs. The first one is for the fa-66
(fw-fa66.txt) and the second one is for the Audio5 (fw-a5.txt).

There seems to be an issue with the Audio5, though I haven't
looked into it yet (quite busy, sorry) For that device I
even got a serial console to it) Maybe you see the problem
already from the log.

http://www.monom.org/misc/alsa-firewire/2013-12-05/

cheers,
daniel
