From: tpeltone@cc.hut.fi
Subject: Re: Experimental USB audio support
Date: Thu, 30 May 2002 11:17:45 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m34rgq6od2.fsf@kolumbus.fi>
References: <s5hy9e2hk02.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy9e2hk02.wl@alsa2.suse.de> (Takashi Iwai's message of "Wed,
 29 May 2002 20:44:13 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> Hi,

> right now you can find a driver for USB audio on cvs.

Hello, what happen? Tried to run cvscompile in alsa-driver...

make[1]: Entering directory `/usr/local/src/alsa-cvs/alsa-driver/usb'
/usr/local/src/alsa-cvs/alsa-driver/include/sndversions.h was updated
gcc -E -M -DALSA_BUILD -D__KERNEL__ -DMODULE=1 -I/usr/local/src/alsa-cvs/alsa-driver/include -I/lib/modules/2.4.18-ac3/build/include -O2 -mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe  usbaudio.c usbaudio.h usbmixer.c > .depend
usbaudio.h:125:35: missing binary operator before '<'
make[1]: *** [fastdep] Error 1
make[1]: Leaving directory `/usr/local/src/alsa-cvs/alsa-driver/usb'
make: *** [dep] Error 1
bash-2.05$ date
Thu May 30 11:14:40 EEST 2002
bash-2.05$ uname -a
Linux teppo 2.4.18-ac3 #2 Sat Mar 9 18:20:38 EET 2002 i686 unknown
bash-2.05$ 

>Takashi

Teppo
-- 
Teppo Peltonen - tpeltone@cc.hut.fi - 0407380441



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
