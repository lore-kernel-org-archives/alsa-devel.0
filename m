From: Michael Weiner <mweiner@gmail.com>
Subject: Error trying to compile driver
Date: Fri, 7 Feb 2014 18:46:52 -0500
Message-ID: <CAJF-=aU+iXQf-gLmCSox7cc8o0sWMD3E+MG_=JnfjJ6uecQL=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 62D562654D0
 for <alsa-devel@alsa-project.org>; Sat,  8 Feb 2014 00:46:53 +0100 (CET)
Received: by mail-we0-f179.google.com with SMTP id q58so2743232wes.38
 for <alsa-devel@alsa-project.org>; Fri, 07 Feb 2014 15:46:53 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I am trying to fix the sound on a laptop i am working on. Has CentOS 5.10
64bit installed and i am trying to use the alsa-compile.sh script but it
fails with the following error:

make -C /lib/modules/2.6.18-371.4.1.el5/build
SUBDIRS=/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d  CPP="gcc
-E" CC="gcc" modules
make[1]: Entering directory `/usr/src/kernels/2.6.18-371.4.1.el5-x86_64'
  CC [M]
/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/acore/hwdep.o
In file included from
/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/include/adriver.h:1695,
                 from
/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/acore/hwdep.c:1:
include/pcmcia/cistpl.h:557: error: expected specifier-qualifier-list
before 'cisdata_t'
include/pcmcia/cistpl.h:586: error: expected specifier-qualifier-list
before 'cisdata_t'
include/pcmcia/cistpl.h:590: warning: 'struct pcmcia_socket' declared
inside parameter list
include/pcmcia/cistpl.h:590: warning: its scope is only this definition or
declaration, which is probably not what you want
include/pcmcia/cistpl.h:593: warning: 'struct pcmcia_socket' declared
inside parameter list
include/pcmcia/cistpl.h:594: warning: 'struct pcmcia_socket' declared
inside parameter list
include/pcmcia/cistpl.h:595: warning: 'struct pcmcia_socket' declared
inside parameter list
include/pcmcia/cistpl.h:598: warning: 'struct pcmcia_socket' declared
inside parameter list
In file included from include/pcmcia/ds.h:23,
                 from
/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/include/adriver.h:1696,
                 from
/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/acore/hwdep.c:1:
include/pcmcia/bulkmem.h:27: error: expected specifier-qualifier-list
before 'memory_handle_t'
include/pcmcia/bulkmem.h:38: warning: 'struct pcmcia_device' declared
inside parameter list
include/pcmcia/bulkmem.h:39: warning: 'struct pcmcia_device' declared
inside parameter list
In file included from
/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/include/adriver.h:1696,
                 from
/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/acore/hwdep.c:1:
include/pcmcia/ds.h:35: error: expected specifier-qualifier-list before
'win_req_t'
include/pcmcia/ds.h:55: error: expected specifier-qualifier-list before
'adjust_t'
make[3]: ***
[/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/acore/hwdep.o]
Error 1
make[2]: ***
[/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d/acore] Error 2
make[1]: ***
[_module_/tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.18-371.4.1.el5-x86_64'
make: *** [compile] Error 2
Working directory /tmp/alsa-compile-script/alsa-driver-1.0.25.3584.gb044d.
Compilation of alsa-driver failed.
Report this problem to the <alsa-devel@alsa-project.org> mailing list.

Can anyone help me figure out why this is failing? Kernel is 2.6.18-371.4.1

Thank you in advance
Michael Weiner
--
