From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Trying again with cross compile
Date: Fri, 07 Apr 2006 15:15:31 +0100
Message-ID: <1144419331.9653.22.camel@localhost.localdomain>
References: <1144413234.9653.16.camel@localhost.localdomain>
	 <s5hslopy2vx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hslopy2vx.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-04-07 at 14:41 +0200, Takashi Iwai wrote:
> At Fri, 07 Apr 2006 13:33:54 +0100,
> Adrian McMenamin wrote:
> > 
> > I've downloaded the cvs alsa-driver.
> > I've added an sh directory -
> > 
> > adrian@bossclass:~/alsa-driver/sh$ ls -l
> > total 32
> > -rw-r--r--  1 adrian adrian  2156 2006-04-07 12:34 aica.h
> > -rw-r--r--  1 adrian adrian   356 2006-04-07 12:34 Kconfig
> > -rw-r--r--  1 adrian adrian    65 2006-04-07 12:34 Makefile
> > -rw-r--r--  1 adrian adrian 18262 2006-04-07 12:34 snd_aica.c
> > 
> > and then I run cvscompile (as configured below) and get this... what do
> > I do next?
> 
> Edit configure.in to add sh arch support.  Add the corresponding
> directory alsa-driver/Makefile (there are multiple places you need to
> add there).
> 
well, I think I've added this and it still breaks - will this build
against a 2.6.15 kernel?



make ARCH=sh

...
make -C /home/adrian/linux-2.6.15.2 SUBDIRS=/home/adrian/alsa-driver
O=/home/adrian/linux-2.6.15.2 modules
make[1]: Entering directory `/home/adrian/linux-2.6.15.2'
  CC [M]  /home/adrian/alsa-driver/acore/hwdep.o
  CC [M]  /home/adrian/alsa-driver/acore/memalloc.o
  CC [M]  /home/adrian/alsa-driver/acore/sgbuf.o
  CC [M]  /home/adrian/alsa-driver/acore/memory_wrapper.o
  CC [M]  /home/adrian/alsa-driver/acore/pcm.o
  CC [M]  /home/adrian/alsa-driver/acore/pcm_native.o
/home/adrian/alsa-driver/acore/pcm_native.c: In function `snd_pcm_xrun':
/home/adrian/alsa-driver/acore/pcm_native.c:1205: error: too few
arguments to function `snd_power_wait'
/home/adrian/alsa-driver/acore/pcm_native.c: In function
`snd_pcm_prepare':
/home/adrian/alsa-driver/acore/pcm_native.c:1326: error: too few
arguments to function `snd_power_wait'
/home/adrian/alsa-driver/acore/pcm_native.c: In function
`snd_pcm_drain':
/home/adrian/alsa-driver/acore/pcm_native.c:1417: error: too few
arguments to function `snd_power_wait'
/home/adrian/alsa-driver/acore/pcm_native.c: In function `snd_pcm_drop':
/home/adrian/alsa-driver/acore/pcm_native.c:1540: error: too few
arguments to function `snd_power_wait'
make[4]: *** [/home/adrian/alsa-driver/acore/pcm_native.o] Error 1
make[3]: *** [/home/adrian/alsa-driver/acore] Error 2
make[2]: *** [_module_/home/adrian/alsa-driver] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/home/adrian/linux-2.6.15.2'
make: *** [compile] Error 2





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
