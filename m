From: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Subject: Re: [Alsa-user] Master volume control
Date: Thu, 14 Mar 2013 09:38:49 -0700
Message-ID: <1D8C99720146460FA33752A5FE614436@PAULD>
References: <B3AC1EE66F1142FF99DDC145B8669DDD@PAULD>
 <512F0AF5.3050502@googlemail.com> <DB754736B2E5480F987C1DE8E330AC7C@PAULD>
 <5141E854.206@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-galgo.atl.sa.earthlink.net
 (elasmtp-galgo.atl.sa.earthlink.net [209.86.89.61])
 by alsa0.perex.cz (Postfix) with ESMTP id C3C75260840
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2013 17:39:02 +0100 (CET)
In-Reply-To: <5141E854.206@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: 'Clemens Ladisch' <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

> From: Clemens Ladisch [mailto:clemens@ladisch.de] 
> 
> I'd guess that some driver uses a busy loop for writing the codec
> registers.
> 
> Which drivers are you using for your sound hardware?

It's Intel HD Audio.

But the point is that three other processes light up when I move the slider.
I think they're all monitoring the master volume changes, and not actually
involved in doing the volume change. I would expect lots of CPU usage if I
had alsamixer open at the time, because it monitors these changes, and
updates its display. But the numbers I got from "top -H" were with no
monitoring apps running that I know of.

What I'm wondering about these processes (pulseaudio, threaded-ml,
indicator-sound) is two things:

* Is there any way to disable or uninstall them in Ubuntu?

* If I create my own minimal embedded distro (I'm trying to use the Yocto
project for that), will they simply not be there, or will I have to go to
some lengths there, too, to disable or uninstall them?

If this is just an issue with Ubuntu, then it's not worth spending much time
on it, since this synth is targeted purely for an embedded environment.

-- 

Ciao,               Paul D. DeRocco
Paul                mailto:pderocco@ix.netcom.com 
