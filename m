From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: yesterday's morning cvs: via82xx build error?
Date: 18 Jan 2003 13:42:17 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042926137.30435.11.camel@cmn37.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA30786
	for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2003 22:43:00 +0100
Received: from cmn37.stanford.edu (cmn37.stanford.edu [171.64.197.186])
	by cm-mail.stanford.edu (8.11.6/8.11.6) with ESMTP id h0ILgHC26279
	for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2003 13:42:17 -0800
Received: from localhost (localhost [127.0.0.1])
	by cmn37.stanford.edu (8.11.6/8.11.6) with ESMTP id h0ILgHc30653
	for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2003 13:42:17 -0800
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

[I sent this to linux-audio-devel by mistake... no clue what I was
thinking]

> Date: 17 Jan 2003 18:01:14 -0800

Very strange:
I'm seeing this while trying to compile the alsa drivers:

gcc -D__KERNEL__ -DMODULE=1
-I/usr/src/redhat/BUILD/alsa-driver-0.9.0/include 
-I/lib/modules/2.4.19-1.llsmp/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -D__SMP__ -DCONFIG_SMP -DLINUX
-Wall -Wstrict-prototypes -fomit-frame-pointer -pipe -DALSA_BUILD 
-DKBUILD_BASENAME=via82xx   -c -o via82xx.o via82xx.c
In file included from via82xx.c:1:
../alsa-kernel/pci/via82xx.c: In function `snd_via82xx_create':
../alsa-kernel/pci/via82xx.c:1588: structure has no member named
`rate_lock'
make[1]: *** [via82xx.o] Error 1

The error happens when compiling in an SMP host with gcc2.96, but the
same tarfile compiles fine on a UP host with gcc2.96 (same kernel) and
on another UP host with gcc3.2...

-- Fernando




-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
