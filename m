From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001962]: /usr/src/alsa/alsa-driver-1.0.9rc4a/acore/pcm_native.c:69: error
Date: Fri, 24 Mar 2006 22:52:40 +0100
Message-ID: <442040a2e711f6c7a4f823ede2ec5ebf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9AA1E1E0
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2006 22:52:43 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Status:                     assigned
Distribution:               centos
Kernel Version:             2.6.9-34
======================================================================
Date Submitted:             03-24-2006 22:52 CET
Last Modified:              03-24-2006 22:52 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-06 22:52 lnthai2002     New Issue                                    
03-24-06 22:52 lnthai2002     Distribution              => centos          
03-24-06 22:52 lnthai2002     Kernel Version            => 2.6.9-34        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
