From: Mark Knecht <markknecht@gmail.com>
Subject: USB audio - 10x too fast on 2.6.14
Date: Wed, 2 Nov 2005 18:04:55 -0800
Message-ID: <5bdc1c8b0511021804m250a54dbx5b88e21acd4b74a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I recently updated my wife's kernel. Everything went fine and the
machine appeared to be working very well. However, when we tried our
USB->TosLink device a 3:30 minute song plays in about 25 seconds. The
device has been working fine for quite awhile - like 8-10 months.
Recently (2.6.13) I started using SMP and the Hyperthreading stuff
since her processor supports it. No problems until this update

dragonfly ~ # uname -a
Linux dragonfly 2.6.14-gentoo #2 SMP PREEMPT Sun Oct 30 06:34:03 PST
2005 i686 Intel(R) Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux
dragonfly ~ #

dragonfly ~ # cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).
dragonfly ~ #

dragonfly ~ # emerge -pv alsa-lib alsa-tools alsa-utils alsa-jack alsa-oss

These are the packages that I would merge, in order:

Calculating dependencies ...done!
[ebuild   R   ] media-libs/alsa-lib-1.0.9  -doc +jack 0 kB
[ebuild   R   ] media-sound/alsa-tools-1.0.8-r1  +X 0 kB
[ebuild   R   ] media-sound/alsa-utils-1.0.9a  +nls 0 kB
[ebuild   R   ] media-plugins/alsa-jack-1.0.9  0 kB
[ebuild   R   ] media-libs/alsa-oss-1.0.8-r1  0 kB

Total size of downloads: 0 kB
dragonfly ~ #

dragonfly ~ # cat /proc/asound/cards
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with ALC655 at 0xfa081000, irq 22
1 [default        ]: USB-Audio - USB Audio CODEC
                     Burr-Brown from TI               USB Audio CODEC=20
at usb-0000:00:1d.1-1, full s
dragonfly ~ #

dragonfly ~ # lsusb
Bus 005 Device 001: ID 0000:0000
Bus 004 Device 002: ID 058f:9360 Alcor Micro Corp.
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 003: ID 046d:c505 Logitech, Inc. Cordless Mouse+Keyboard Rec=
eiver
Bus 003 Device 002: ID 08bb:2902 Texas Instruments Japan
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 002: ID 051d:0002 American Power Conversion Back-UPS
Pro 500/1000/1500
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000
dragonfly ~ #

Any ideas about what caused this?

Thanks,
Mark


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
