From: Raffaele Recalcati <lamiaposta71@gmail.com>
Subject: HDA irq understanding
Date: Mon, 6 Feb 2012 08:06:16 +0100
Message-ID: <CAFU7RzPKtt1-jJTgCWV1XgB+Fk-CA8FGeTCorW7cypBGFNoj7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f44.google.com (mail-qw0-f44.google.com
	[209.85.216.44]) by alsa0.perex.cz (Postfix) with ESMTP id BF3582441F
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 08:06:17 +0100 (CET)
Received: by qafi29 with SMTP id i29so1983939qaf.17
	for <alsa-devel@alsa-project.org>; Sun, 05 Feb 2012 23:06:16 -0800 (PST)
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

Hi,
I know my question is quite easy for this ml, but I hope to get a little help.
I'm an embedded developer and I'm not so good with x86.
I'm trying to load the system and hear mp3 decoding getting worst, but
no way on my "Intel(R) Core(TM)2 Duo CPU P8400  @ 2.26GHz"
very basic system.
I'm trying to understand why I can't.
Using trace (the complete one is here
www.opensurf.it/trace12-02-04-19-14-48.txt_orig.lzma ) I get:

grep HDA trace12-02-04-19-14-48.txt
..
      cpu-100.sh-26486 [000]  9490.976257: irq_handler_entry: irq=21
handler=HDA Intel
      cpu-100.sh-26474 [000]  9490.984236: irq_handler_entry: irq=21
handler=HDA Intel
      cpu-100.sh-26467 [000]  9490.992220: irq_handler_entry: irq=21
handler=HDA Intel
      cpu-100.sh-26502 [000]  9491.088042: irq_handler_entry: irq=21
handler=HDA Intel
..
almost every 10msec
pulseaudio reads from /dev/snd/pcmC0D0p,
mplayer reads from pulseaudio.

How can I create context switch problem in this situation and trace is well ?
Thanks,
Raffaele

---------------------
Loading the system
---------------------
where I have lauched cpu-100.sh 20 times
$ cat cpu-100.sh
#!/bin/bash
while : ; do
true
done

I have also launched
root $ ping -l 100000 -q -s 10 -f localhost &
once

---
www.opensurf.it
