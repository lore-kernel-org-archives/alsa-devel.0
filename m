From: Florian Schanda <ma1flfs@bath.ac.uk>
Subject: Problems with gcc-3.4 / alsa-lib
Date: Sun, 1 Feb 2004 13:34:34 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402011334.34572.ma1flfs@bath.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I have tried to compile alsa-lib CVS with gcc-3.4 CVS and got the following 
error:

 gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -O2 
-march=pentium4 -MT pcm_dmix.lo -MD -MP -MF .deps/pcm_dmix.Tpo -c pcm_dmix.c  
-fPIC -DPIC -o .libs/pcm_dmix.o
pcm_dmix_i386.h: In function `mix_areas1':
pcm_dmix_i386.h:45: error: PIC register `ebx' clobbered in `asm'
pcm_dmix_i386.h: In function `mix_areas1_mmx':
pcm_dmix_i386.h:163: error: PIC register `ebx' clobbered in `asm'
pcm_dmix_i386.h: In function `mix_areas2':
pcm_dmix_i386.h:245: error: PIC register `ebx' clobbered in `asm'
pcm_dmix_i386.h: In function `mix_areas1_smp':
pcm_dmix_i386.h:45: error: PIC register `ebx' clobbered in `asm'
pcm_dmix_i386.h: In function `mix_areas1_smp_mmx':
pcm_dmix_i386.h:163: error: PIC register `ebx' clobbered in `asm'
pcm_dmix_i386.h: In function `mix_areas2_smp':
pcm_dmix_i386.h:245: error: PIC register `ebx' clobbered in `asm'
make[2]: *** [pcm_dmix.lo] Error 1
make[2]: Leaving directory `/sources/alsa-lib/src/pcm'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/sources/alsa-lib/src'
make: *** [all-recursive] Error 1

I don't know enough gcc asm to fix this; any ideas?

	Florian Schanda


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
