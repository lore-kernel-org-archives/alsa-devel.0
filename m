From: snookertb <snookertb@comcast.net>
Subject: Compile errors with latest alsa releases
Date: Fri, 20 Feb 2004 11:15:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403632BC.20308@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I am attempting to update the Sun JDS distro from alsa version 0.9.0 to 
a later version which supports newer Intel sound chips. I get the 
following errors in these two compiles. I ran versions 0.9.8 and 1.0.2c 
and they produced the same errors.

alsa-driver-1.0.2c compile error

Error in both cases error is triggered because of the kernel version of 
SJDS is 2.4.19-4GB. Is this alsa driver not supposed to be used with 
older kernels?

In file included from 
/home/tarpon/downloads/alsa-driver-1.0.2c/include/sound/driver.h:42,
             from usbaudio.inc:6,
             from usbaudio.c:1:
/home/tarpon/downloads/alsa-driver-1.0.2c/include/adriver.h:295: 
redefinition of `usb_make_path'
/lib/modules/2.4.19-4GB/build/include/linux/usb.h:931: `usb_make_path' 
previously defined here
make[1]: *** [usbaudio.o] Error 1
make[1]: Leaving directory `/home/tarpon/downloads/alsa-driver-1.0.2c/usb'
make: *** [compile] Error 1

alsa-driver-0.9.8 compile error

In file included from 
/home/tarpon/downloads/alsa-driver-0.9.8/include/sound/driver.h:42,
             from usbaudio.inc:2,
             from usbaudio.c:1:
/home/tarpon/downloads/alsa-driver-0.9.8/include/adriver.h:296: 
redefinition of `usb_make_path'
/lib/modules/2.4.19-4GB/build/include/linux/usb.h:931: `usb_make_path' 
previously defined here
make[1]: *** [usbaudio.o] Error 1
make[1]: Leaving directory `/home/tarpon/downloads/alsa-driver-0.9.8/usb'
make: *** [compile] Error 1

----------------------------------------------------------

alsa-utils-1.0.2c compile error

Both versions error on undeclared identifier SND_CTL_READONLY

alsactl.c: In function `get_controls':
alsactl.c:483: `SND_CTL_READONLY' undeclared (first use in this function)
alsactl.c:483: (Each undeclared identifier is reported only once
alsactl.c:483: for each function it appears in.)
make[1]: *** [alsactl.o] Error 1
make[1]: Leaving directory 
`/home/tarpon/downloads/alsa-utils-1.0.2/alsactl'
make: *** [all-recursive] Error 1

alsa-utils -0.9.8 compile error

alsactl.c: In function `get_controls':
alsactl.c:483: `SND_CTL_READONLY' undeclared (first use in this function)
alsactl.c:483: (Each undeclared identifier is reported only once
alsactl.c:483: for each function it appears in.)
make[1]: *** [alsactl.o] Error 1
make[1]: Leaving directory 
`/home/tarpon/downloads/alsa-utils-0.9.8/alsactl'
make: *** [all-recursive] Error 1


Any help or guidance would be appreciated. If this is not the right 
place to post this, please advise and point me to where to go for help.

tb



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
