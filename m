From: Matthias Koenig <mk@phasorlab.de>
Subject: Re: ICC driver compiler fails - alsa-driver-1.0.11
Date: Sun, 14 May 2006 19:11:49 +0200
Message-ID: <87slncbkfe.fsf@zebra.localdomain>
References: <ac06b020605140707h7a8f870dm80da9c2ccc8ecfe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.126.187])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2F6C912B
	for <alsa-devel@alsa-project.org>; Sun, 14 May 2006 19:11:51 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Sullivan <metafunk@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

"Thomas Sullivan" <metafunk@gmail.com> writes:
> when compiling alsa driver with ICC 9.0, the configure program reports a
> mismatch between the kernel compiler version and the compiler used for this
> compilation.
> however, the kernel was compiled with the same compiler ICC 9.0
> attached are the ./configure output and the config.log file
> the commandline run was CC=icc CXX=icpc ./configure

Btw, it is safer to put the Variable assignments as parameters to configure:
./configure CC=icc CXX=icpc 

> This file contains any messages produced by compilers while
> running configure, to aid debugging if configure makes a mistake.
>
> configure:3639: icc -o conftest -g -O2 -I/lib/modules/2.6.16.16-genuineintel/build/include -I/lib/modules/2.6.16.16-genuineintel/source/include    conftest.c  >&5
> configure:3642: $? = 0
> configure:3644: ./conftest
> configure:3647: $? = 0
> configure:3752: result: Kernel compiler: gcc 3.4.6 Used compiler: icc (ICC) 9.0  20051201
> KERNEL_INC='-I/lib/modules/2.6.16.16-genuineintel/build/include -I/lib/modules/2.6.16.16-genuineintel/source/include'

Hmm, the configure test for the kernel comiler just scans the compile.h 
header of the kernel sources. Could you please post the contents of
/lib/modules/2.6.16.16-genuineintel/source/include/linux/compile.h ?
Especially the makro LINUX_COMPILER.

Regards,
Matthias


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
