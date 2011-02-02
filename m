From: Rods Bobavich <rodnisms@gmail.com>
Subject: snd-usb-audio dying on jackd xruns
Date: Wed, 2 Feb 2011 09:54:24 -0700
Message-ID: <AANLkTinc02yXS=axf5wCQMq3e+nhiJj_ZaHmjk-bcorS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id C384F24341
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 17:54:44 +0100 (CET)
Received: by ewy19 with SMTP id 19so139270ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Feb 2011 08:54:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

So I start jackd and it runs fine for a while. Then ALSA crashes and
triggers an xrun. Jackd continues to do its merry thing - minus the part
about spitting info out to my soundcard...

At first I thought this was a Jackd issue but when I looked deeper it seems
to be ALSA. Once this happens I cannot restart jackd and resume an audio
session. In fact, I cannot even rmmod snd-usb-audio. Sometimes I cannot
lsusb. So it looks like something is getting seriously hosed!

It seems to be specific to my machine.

I've tried multiple usb intefaces. All work fine with other computers. I've
tried multiple version of Ubuntu with various versions of ALSA on this
machine. All exhibit the same behavior. I have 3 other machines that run
these interfaces just fine... So it seems to be a
hardware compatibility issue not a software glitch in one version.

I've tried many boot flags but to no avail. I'm at a loss on how to
troubleshoot.

The machine is M4N75TD motherboard with a Phenom II 1055T and the latest
bios flash.

Please advise,

...Rods ;-)
