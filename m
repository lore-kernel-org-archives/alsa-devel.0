From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002100]: pdaudiocf_old.c make error
Date: Wed, 10 May 2006 16:45:43 +0200
Message-ID: <1a3a9aaf39d0bddfa52c33080b0dd31a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2668E186
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2006 16:45:44 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2100> 
======================================================================
Reported By:                whb
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2100
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.15-1.2054_FC5
======================================================================
Date Submitted:             05-07-2006 00:28 CEST
Last Modified:              05-10-2006 16:45 CEST
======================================================================
Summary:                    pdaudiocf_old.c make error
Description: 
I'm trying to install the driver from source. I run ./configure, everything
works fine no problem. I run make, and every time this comes up:

  CC [M] 
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf.o
In file included from
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf.c:5:
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:
In function &#8216;snd_pdacf_free&#8217;:
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:105:
warning: implicit declaration of function
&#8216;pcmcia_deregister_client&#8217;
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:
In function &#8216;snd_pdacf_attach&#8217;:
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:207:
warning: implicit declaration of function
&#8216;pcmcia_register_client&#8217;
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:
At top level:
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:422:
error: unknown field &#8216;attach&#8217; specified in initializer
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:422:
warning: excess elements in struct initializer
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:422:
warning: (near initialization for &#8216;pdacf_cs_driver&#8217;)
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:424:
error: unknown field &#8216;event&#8217; specified in initializer
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:424:
warning: excess elements in struct initializer
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:424:
warning: (near initialization for &#8216;pdacf_cs_driver&#8217;)
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:427:
error: unknown field &#8216;detach&#8217; specified in initializer
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:428:
warning: missing braces around initializer
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:428:
warning: (near initialization for &#8216;pdacf_cs_driver.drv&#8217;)
/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf_old.c:428:
warning: initialization from incompatible pointer type
make[5]: ***
[/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf/pdaudiocf.o]
Error 1
make[4]: *** [/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia/pdaudiocf]
Error 2
make[3]: *** [/home/whb/packages/alsa/alsa-driver-1.0.11/pcmcia] Error 2
make[2]: *** [_module_/home/whb/packages/alsa/alsa-driver-1.0.11] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.15-1.2054_FC5-i686'
make: *** [compile] Error 2

after which make stops.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-10-06 16:45 
----------------------------------------------------------------------
Probably FC5 kernel is incompatible with the vanilla 2.6.15 kernel
regarding pcmcia stack.  Ask FC people about it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-07-06 00:28 whb            New Issue                                    
05-07-06 00:28 whb            Distribution              => Fedora Core 5   
05-07-06 00:28 whb            Kernel Version            => 2.6.15-1.2054_FC5
05-07-06 00:32 whb            Issue Monitored: whb                         
05-10-06 16:45 tiwai          Note Added: 0009728                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
