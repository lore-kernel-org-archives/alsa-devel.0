From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: 1.0.16rc2
Date: Wed, 30 Jan 2008 10:09:15 +0000
Message-ID: <200801301009.15630.gineera@aspect135.co.uk>
References: <Pine.LNX.4.61.0801291553220.11819@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 26EC8246D1
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 10:49:41 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0801291553220.11819@tm8103.perex-int.cz>
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I get the following compile error:

make[1]: Entering directory `/usr/share/alsa1.0.16rc2/alsa-driver-1.0.16rc2/acore'
gcc -D__KERNEL__ -DMODULE=1 -I/usr/share/alsa1.0.16rc2/alsa-driver-1.0.16rc2/include  -I/lib/modules/2.4.21-99-athlon/build/include -O2 -mpreferred-stack-boundary=2 -march=athlon -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include /lib/modules/2.4.21-99-athlon/build/include/linux/modversions.h   -DEXPORT_SYMTAB -c hwdep.c
In file included from hwdep.c:1:
/usr/share/alsa1.0.16rc2/alsa-driver-1.0.16rc2/include/adriver.h:1461: error: redefinition of `__ffs'
/lib/modules/2.4.21-99-athlon/build/include/asm/bitops.h:410: error: `__ffs' previously defined here
make[1]: *** [hwdep.o] Error 1
make[1]: Leaving directory `/usr/share/alsa1.0.16rc2/alsa-driver-1.0.16rc2/acore'
make: *** [compile] Error 1

I have pasted several lines so you can see the context.  This wasn't a problem in 1.0.14; I haven't compiled since then.

Alan
