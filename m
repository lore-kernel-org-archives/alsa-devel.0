From: Will <walsac2@liam2.demon.co.uk>
Subject: Re: [PATCH] add aplaymidi & arecordmidi utils
Date: Wed, 25 Feb 2004 13:22:31 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402251322.NAA11847@liam2.demon.co.uk>
References: <Pine.HPX.4.33n.0402250921050.3124-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402250921050.3124-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <clemens@ladisch.de> wrote:
>
>Did you change asequencer.h in both the kernel and alsa-lib?

No, I didn't see my script had actually failed to patch
include/sound/asequencer.h

BTW I know there are several correct ways of updating the ALSA in Linux 2.6.x
according to the docs at Wiki alsa.opensrc.org and alsa-project/alsa-doc/
Is the following a correct way of updating the ALSA in Linux 2.6.3?

1. Get the latest main CVS ALSA:

cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-driver
cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-kernel
cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-firmware
cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-lib
cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-oss
cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-utils
cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-tools

2. configure and make install everything including
   firstly alsa-driver and secondly alsa-kernel 

3. update Linux kernel headers and source files

  mv alsa-kernel/include/*.h linux-kernel-source/include/sound
  for i in arm core drivers i2c isa oss p* sparc synth usb; do
     pseudo shell script:
     mv alsa-kernel/$i/[./]*/*.[ch] linux-kernel-source/sound/subdirectories
  done


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
