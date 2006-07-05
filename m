From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001962]:
	/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.c:69: error
Date: Thu, 6 Jul 2006 00:32:50 +0200
Message-ID: <7e9a0e763f9830007a0d632405029c11@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B0286254
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 00:32:50 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1962> 
======================================================================
Reported By:                lnthai2002
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1962
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     closed
Distribution:               centos
Kernel Version:             2.6.9-34
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-24-2006 22:52 CET
Last Modified:              07-06-2006 00:32 CEST
======================================================================
Summary:                   
/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.c:69: error
Description: 
compiling alsa-driver on centos 4.2(RH EL) for Sound Blaster Live! 24bit
with the command:
./configure --with-cards=ca0106 --with-sequencer=yes;make
give error:

make[1]: Entering directory
`/usr/src/kernels/2.6.9-34.106.unsupported-i686'
  CC [M]  /usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.o
/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.c:69: error: syntax
error before "snd_pcm_link_rwlock"
/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.c:69: warning: type
defaults to `int' in declaration of `snd_pcm_link_rwlock'
/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.c:69: error:
conflicting types for 'snd_pcm_link_rwlock'
/usr/src/alsa/alsa-driver-1.0.9rc4a/include/sound/pcm.h:484: error:
previous declaration of 'snd_pcm_link_rwlock' was here
/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.c:69: error:
conflicting types for 'snd_pcm_link_rwlock'
/usr/src/alsa/alsa-driver-1.0.9rc4a/include/sound/pcm.h:484: error:
previous declaration of 'snd_pcm_link_rwlock' was here
/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.c:69: error:
incompatible types in initialization
/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.c:69: error:
initializer element is not constant
/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.c:69: warning: data
definition has no type or storage class
make[4]: *** [/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.o]
Error 1
make[3]: *** [/usr/src/alsa/alsa-driver-1.0.9rc4a/acore] Error 2
make[2]: *** [_module_/usr/src/alsa/alsa-driver-1.0.9rc4a] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory
`/usr/src/kernels/2.6.9-34.106.unsupported-i686'
make: *** [compile] Error 2

How can i fix this problem?

======================================================================

----------------------------------------------------------------------
 rlrevell - 03-27-06 04:19 
----------------------------------------------------------------------
Try a newer ALSA, 1.0.9rc4a is way too old to debug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-06 22:52 lnthai2002     New Issue                                    
03-24-06 22:52 lnthai2002     Distribution              => centos          
03-24-06 22:52 lnthai2002     Kernel Version            => 2.6.9-34        
03-27-06 04:19 rlrevell       Note Added: 0008984                          
07-06-06 00:32 Adrian Bunk    Status                   assigned => closed  
07-06-06 00:32 Adrian Bunk    Resolution               open => not an issue
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
