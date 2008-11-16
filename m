From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: Alsa driver won't compile on Ubuntu kernel
	2.6.24-16-generic
Date: Sun, 16 Nov 2008 10:18:48 +0100
Message-ID: <d9690f190811160118g2bab039ap76c85f725fab7a2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.190])
	by alsa0.perex.cz (Postfix) with ESMTP id CBB1B24560
	for <Alsa-devel@alsa-project.org>; Sun, 16 Nov 2008 10:18:49 +0100 (CET)
Received: by rn-out-0910.google.com with SMTP id j67so2191514rne.21
	for <Alsa-devel@alsa-project.org>; Sun, 16 Nov 2008 01:18:48 -0800 (PST)
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
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi folks.

As you know I am maintaining an Alsa-Installation script over
at Ubuntu forums:

http://ubuntuforums.org/showthread.php?t=3D962695


Admin:
I intend to post problems over here if they're mentioned more than once, if
you don't
mind. I ask people to upload the Alsa log file.
Perhaps you can give me hint how to set this process up properly.

!These are not my problems. I just try to channel at least some of them.



Here is the first problem:

Alsa driver won't compile on Ubuntu kernel 2.6.24-16-generic

make -C /lib/modules/2.6.24-16-generic/build
SUBDIRS=3D/usr/src/Alsa-1.0.18a/alsa-driver-1.0.18a  CPP=3D"gcc -E"
CC=3D"gcc" modules
make[1]: Entering directory `/usr/src/linux-headers-2.6.24-16-generic'
  CC [M]  /usr/src/Alsa-1.0.18a/alsa-driver-1.0.18a/acore/hrtimer.o
In file included from
/usr/src/Alsa-1.0.18a/alsa-driver-1.0.18a/acore/hrtimer.c:2:
/usr/src/Alsa-1.0.18a/alsa-driver-1.0.18a/acore/../alsa-kernel/core/hrtimer=
.c:
In function =E2snd_hrtimer_callback=E2:
/usr/src/Alsa-1.0.18a/alsa-driver-1.0.18a/acore/../alsa-kernel/core/hrtimer=
.c:29:
error: implicit declaration of function =E2hrtimer_forward_now=E2
make[3]: *** [/usr/src/Alsa-1.0.18a/alsa-driver-1.0.18a/acore/hrtimer.o] Er=
ror 1
make[2]: *** [/usr/src/Alsa-1.0.18a/alsa-driver-1.0.18a/acore] Error 2
make[1]: *** [_module_/usr/src/Alsa-1.0.18a/alsa-driver-1.0.18a] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.24-16-generic'
make: *** [compile] Error



Any ideas?

Cheers
Klaus
