From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: plans for fireworks driver
Date: Sun, 10 Mar 2013 19:37:11 +0900
Message-ID: <513C6257.8050306@sakamocchi.jp>
References: <513A5CF4.9090803@nostar.net> <513B2B62.9040307@sakamocchi.jp>
 <513BA114.3000305@nostar.net> <513BEBE6.6030708@sakamocchi.jp>
 <513C360C.60804@nostar.net> <513C4C95.1050305@sakamocchi.jp>
 <513C52C7.7010101@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id D11C2265119
 for <alsa-devel@alsa-project.org>; Sun, 10 Mar 2013 11:37:19 +0100 (CET)
In-Reply-To: <513C52C7.7010101@nostar.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Doug McLain <doug@nostar.net>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Doug,

 >> Then I hope you to try playback.I reccomend below process:
 >> 1. use alsamixer to change sampling rate that you hope
 >> 2. use jackd in usual way, or aplay with plughw interface
 >> 3. hear 1/2ch or not
 >
 > Alsamixer successfully changes SR and clock source.  I started jack and
 > played back and edited an ardour session with no problems.  As you said
 > earlier, capture doesn't work.  the ports are there but no signal.  Once
 > that works Ill start using this driver full time.

I'm glad to hear it. I believe you can playback with any sampling rate, 
32.0 - 96.0 kHz for AudioFire2, 32.0 - 192.0 kHz for AudioFire12.

But I cannot hear all of channels which I send. My AudioFirePre8 can 
playback 16ch (differed in current sampling rate). When I playback 16ch 
with aplay or jackd, I can hear only 1/2ch physical output...

I hope you to confirm this on your devices.


Currently my driver fully utilize ALSA's snd-firewire-lib.ko to 
transmitting (and receiving) stream. But snd-firewire-lib.ko has no 
codes for receiving (=PCM capturing). I'm under working for this.

Thanks


Takashi Sakamoto
o-takashi@sakamocchi.jp

(Mar 10 2013 18:30), Doug McLain wrote:
>> I note that your system cannot communicate to your device via FFADO
>> because the device is already used by my module. You can execute
>> "modprobe -r snd-fireworks" if you want to use FFADO.
>
> That's not true.  The ffado tools (the mixer, the discovery & diagnostic
> tools, etc) work fine whether or not the alsa module is loaded, and
> whether or not jack is running on the device.  The problem with the AF12
> and your driver was whatever the problem is with ffado and AF firmware >
> 4.8.  Somehow the Clemens snd-fireworks driver was unaffected.  I dont
> know enough about the driver and hardware to understand why, but I'm
> sure you will figure it out.  I'm glad to see progress on this driver so
> do not hesitate to ask for anything.
>
>> Then I hope you to try playback.I reccomend below process:
>> 1. use alsamixer to change sampling rate that you hope
>> 2. use jackd in usual way, or aplay with plughw interface
>> 3. hear 1/2ch or not
>
> Alsamixer successfully changes SR and clock source.  I started jack and
> played back and edited an ardour session with no problems.  As you said
> earlier, capture doesn't work.  the ports are there but no signal.  Once
> that works Ill start using this driver full time.
>
> -D
