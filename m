From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001983]: compilation error on the file usbmixer.c
Date: Fri, 31 Mar 2006 15:41:41 +0200
Message-ID: <d7e4ecd30358a1f8b662ea9cf21c5da0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 143D515D
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 15:41:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1983> 
======================================================================
Reported By:                croiset
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1983
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Redhat 7.2
Kernel Version:             2.4.7-10
======================================================================
Date Submitted:             03-31-2006 15:41 CEST
Last Modified:              03-31-2006 15:41 CEST
======================================================================
Summary:                    compilation error on the file usbmixer.c
Description: 
In linux 2.4.7-10, it's impossible to compile because in the file
usbmixer.c.

I obtain this error :
make[1]: Entre dans le répertoire
`/home/redhat/BUILD/alsa-driver-1.0.11rc4/usb
'
i386-redhat-linux-gcc -D__KERNEL__ -DMODULE=1
-I/home/redhat/BUILD/alsa-driver-
1.0.11rc4/include  -I/lib/modules/2.4.7-10/build/include -O2
-mpreferred-stack-
boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -
Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc
 -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.7-10/build/includ
e/linux/modversions.h
-I/home/redhat/BUILD/alsa-driver-1.0.11rc4/alsa-kernel/us
b -DKBUILD_BASENAME=usbaudio   -c -o usbaudio.o usbaudio.c
i386-redhat-linux-gcc -D__KERNEL__ -DMODULE=1
-I/home/redhat/BUILD/alsa-driver-
1.0.11rc4/include  -I/lib/modules/2.4.7-10/build/include -O2
-mpreferred-stack-
boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -
Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc
 -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.7-10/build/includ
e/linux/modversions.h
-I/home/redhat/BUILD/alsa-driver-1.0.11rc4/alsa-kernel/us
b -DKBUILD_BASENAME=usbmixer   -c -o usbmixer.o usbmixer.c
usbmixer.c: In function `snd_usb_soundblaster_remote_init':
usbmixer.c:1824: dereferencing pointer to incomplete type
usbmixer.c:1830: dereferencing pointer to incomplete type
usbmixer.c:1832: dereferencing pointer to incomplete type
usbmixer.c:1833: dereferencing pointer to incomplete type
usbmixer.c:1834: dereferencing pointer to incomplete type
usbmixer.c:1835: dereferencing pointer to incomplete type
make[1]: *** [usbmixer.o] Erreur 1
make[1]: Quitte le répertoire
`/home/redhat/BUILD/alsa-driver-1.0.11rc4/usb'
make: *** [compile] Erreur 1
error: Bad exit status from /var/tmp/rpm-tmp.10604 (%build)

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 15:41 croiset        New Issue                                    
03-31-06 15:41 croiset        Distribution              => Redhat 7.2      
03-31-06 15:41 croiset        Kernel Version            => 2.4.7-10        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
