From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: rc4
Date: Wed, 23 Oct 2002 20:17:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0210232011440.321-100000@mailserver.intern.bfad.de>
References: <s5hvg3t1jhe.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailserver.intern.bfad.de (mail.bfad.de [212.62.208.67])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA16506
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2002 20:16:03 +0200
In-Reply-To: <s5hvg3t1jhe.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Oct 2002, Takashi Iwai wrote:

> > I have just updated to CVS.
> > 
> > Debian 2.2
> > 
> > I needed to run autoconf; ./configure; make; ./configure; make
> 
> do you mean that the original configure script in rc4 tarball doesn't
> work?  if yes, it's a bug of rc4 tarball - we have to release rc5...

No, I have got CVS version, but did not run cvscompile - my fault.

But now with the real rc4  tarball and 2.4.9 kernel + Debian 2.2rev7
./configure
make
[...]
make[3]: Leaving directory `/tmp/alsa-driver-0.9.0rc4/isa/wavefront'
/tmp/alsa-driver-0.9.0rc4/include/sndversions.h was not updated
gcc -M -D__KERNEL__ -DMODULE=1 -I/tmp/alsa-driver-0.9.0rc4/include
-I/lib/modules/2.4.9/build/include -O2 -mpreferred-stack-boundary=2 -march=i686
-DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe -DALSA_BUILD
als100.c azt2320.c cmi8330.c dt019x.c es18xx.c opl3sa2.c sgalaxy.c sscape.c >
.depend
sscape.c:500: macro `min' used with only 2 args
make[2]: *** [fastdep] Error 1
make[2]: Leaving directory `/tmp/alsa-driver-0.9.0rc4/isa'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/tmp/alsa-driver-0.9.0rc4'
make: *** [include/sndversions.h] Error 2


I would say, low priority - 2.4.9 kernel is probably quite exotic at the
moment.

alsa-driver-0.9.0rc4 compiles OK on Debian-3.0 with 2.4.20pre8 kernel.

Best regards,
--
Tomek



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
