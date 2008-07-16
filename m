From: georg <georg.brand@web.de>
Subject: Re: CS5530 on Geode GX1 won't work
Date: Wed, 16 Jul 2008 16:29:42 +0200
Message-ID: <200807161629.43001.georg.brand@web.de>
References: <200807152315.23490.georg.brand@web.de>
	<487DB4AE.4070901@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 0407124456
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 16:30:10 +0200 (CEST)
In-Reply-To: <487DB4AE.4070901@ladisch.de>
Content-Disposition: inline
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
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hello

> > root@tux:~# aplay foo.wav
> > aplay: main:546: audio open error: Device or resource busy
> > ...
> > root@tux:~# lsof | grep -i pcmC0D0p
>
> It's possible that the device has been opened with OSS (i.e., /dev/dsp*)
> or that somebody has opened the capture device (SB doesn't do full
> duplex).  Is there anything in /dev/ that is being used?

OSS is completely disabled in kernel .config.

Here is a complete grep on /dev:

root@tux:~# lsof | grep "/dev"
init         1       root   10u     FIFO       0,13            
111 /dev/initctl
udevd      915       root    0u      CHR        1,3          31003 /dev/null
udevd      915       root    1u      CHR        1,3          31003 /dev/null
udevd      915       root    2u      CHR        1,3          31003 /dev/null
dropbear  3223       root    0u      CHR        1,3             86 /dev/null
dropbear  3223       root    1u      CHR        1,3             86 /dev/null
dropbear  3223       root    2u      CHR        1,3             86 /dev/null
dbus-daem 3232 messagebus    0u      CHR        1,3             86 /dev/null
dbus-daem 3232 messagebus    1u      CHR        1,3             86 /dev/null
dbus-daem 3232 messagebus    2u      CHR        1,3             86 /dev/null
dbus-daem 3232 messagebus    4u      CHR        1,3             86 /dev/null
hcid      3245       root    0u      CHR        1,3             86 /dev/null
hcid      3245       root    1u      CHR        1,3             86 /dev/null
hcid      3245       root    2u      CHR        1,3             86 /dev/null
getty     3264       root  cwd       DIR       0,13   13580     48 /dev
getty     3264       root    0u      CHR        4,1            864 /dev/tty1
getty     3264       root    1u      CHR        4,1            864 /dev/tty1
getty     3264       root    2u      CHR        4,1            864 /dev/tty1
dropbear  3272       root    0u      CHR        1,3             86 /dev/null
dropbear  3272       root    1u      CHR        1,3             86 /dev/null
dropbear  3272       root    2u      CHR        1,3             86 /dev/null
dropbear  3272       root    6u      CHR        5,2            179 /dev/ptmx
sh        3273       root    0u      CHR      136,0              2 /dev/pts/0
sh        3273       root    1u      CHR      136,0              2 /dev/pts/0
sh        3273       root    2u      CHR      136,0              2 /dev/pts/0
sh        3273       root   10u      CHR        5,0            858 /dev/tty
lsof      3278       root    0u      CHR      136,0              2 /dev/pts/0
lsof      3278       root    2u      CHR      136,0              2 /dev/pts/0
grep      3279       root    1u      CHR      136,0              2 /dev/pts/0
grep      3279       root    2u      CHR      136,0              2 /dev/pts/0

Thank you for your help!
Any further suggestions?

Bye
Georg
