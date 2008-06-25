From: "Caloro Maurizio" <mauric@gmx.ch>
Subject: Building trouble - redefinition of struct timeval
Date: Wed, 25 Jun 2008 15:54:09 +0200
Message-ID: <20080625135409.236240@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id A63AD24356
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 15:54:09 +0200 (CEST)
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


Please i need help for following error message "redefinition of struct time=
val - /include/global.h"

the configure script run without any Error, if i compile "alsa-lib-1.0.17rc=
2" on I386 Netbsd 4.0
i receive folowing error break.

"./configure --prefix=3D/usr --sysconfdir=3D/etc --build=3Di386-unknown-net=
bsdelf4.0 --host=3Di386-unknown-netbsdelf4.0 --target=3Di386-unknown-netbsd=
elf4.0 --with-pythonlibs=3Dlpython2.5 --with-pythonincludes=3D-I/usr/includ=
e/python2.5 --enable-shared=3Dno --enable-static=3Dyes" & gmake

gmake ... >

Making all in controll
gmake[1]: Entering directory `/usr/source/alsa-lib-1.0.17rc2/src/control'
if /bin/ksh ../../libtool --tag=3DCC --mode=3Dcompile gcc -DHAVE_CONFIG_H -=
I. -I. -I../../include -I../../include    -g -O2 -MT cards.lo -MD -MP -MF "=
.deps/cards.Tpo" -c -o cards.lo cards.c; \
        then mv -f ".deps/cards.Tpo" ".deps/cards.Plo"; else rm -f ".deps/c=
ards.Tpo"; exit 1; fi
 gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2 -MT car=
ds.lo -MD -MP -MF .deps/cards.Tpo -c cards.c -o cards.o
In file included from ../../include/local.h:109,
                 from control_local.h:22,
                 from cards.c:35:
../../include/global.h:138: error: redefinition of 'struct timeval'
../../include/global.h:143: error: redefinition of 'struct timespec'
gmake[1]: *** [cards.lo] Error 1
gmake[1]: Leaving directory `/usr/source/alsa-lib-1.0.17rc2/src/control'
gmake: *** [all-recursive] Error 1


i have see that this its a possible  handle with Posix_C_Source but i dont =
found =

the correct answer for me trouble.... Please for any Help i'am happy.

thanks
MC


-- =

Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
