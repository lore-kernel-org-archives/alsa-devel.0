From: Doug McLain <doug@nostar.net>
Subject: Re: plans for fireworks driver
Date: Sun, 10 Mar 2013 05:30:47 -0400
Message-ID: <513C52C7.7010101@nostar.net>
References: <513A5CF4.9090803@nostar.net> <513B2B62.9040307@sakamocchi.jp>
 <513BA114.3000305@nostar.net> <513BEBE6.6030708@sakamocchi.jp>
 <513C360C.60804@nostar.net> <513C4C95.1050305@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
 [209.85.216.182])
 by alsa0.perex.cz (Postfix) with ESMTP id F23EF2650D4
 for <alsa-devel@alsa-project.org>; Sun, 10 Mar 2013 10:30:52 +0100 (CET)
Received: by mail-qc0-f182.google.com with SMTP id k19so1117502qcs.13
 for <alsa-devel@alsa-project.org>; Sun, 10 Mar 2013 01:30:51 -0800 (PST)
In-Reply-To: <513C4C95.1050305@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

> I note that your system cannot communicate to your device via FFADO
> because the device is already used by my module. You can execute
> "modprobe -r snd-fireworks" if you want to use FFADO.

That's not true.  The ffado tools (the mixer, the discovery & diagnostic 
tools, etc) work fine whether or not the alsa module is loaded, and 
whether or not jack is running on the device.  The problem with the AF12 
and your driver was whatever the problem is with ffado and AF firmware > 
4.8.  Somehow the Clemens snd-fireworks driver was unaffected.  I dont 
know enough about the driver and hardware to understand why, but I'm 
sure you will figure it out.  I'm glad to see progress on this driver so 
do not hesitate to ask for anything.

> Then I hope you to try playback.I reccomend below process:
> 1. use alsamixer to change sampling rate that you hope
> 2. use jackd in usual way, or aplay with plughw interface
> 3. hear 1/2ch or not

Alsamixer successfully changes SR and clock source.  I started jack and 
played back and edited an ardour session with no problems.  As you said 
earlier, capture doesn't work.  the ports are there but no signal.  Once 
that works Ill start using this driver full time.

-D
