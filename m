From: Weijia Yang <gte733z@prism.gatech.edu>
Subject: Re: cs46xx experimental DSP drivers
Date: Tue, 24 Sep 2002 20:10:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D90FEF4.2040309@prism.gatech.edu>
References: <3D8F7F59.6030105@prism.gatech.edu> <3D90A8D8.7070103@cucumelo.org> <3D90B54F.20402@prism.gatech.edu> <3D90D641.7050200@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Benny Sjostrand wrote:>> Benny--
> 
> 
> Finally, so far I know the Santa Cruz is yet another card where we dont 
> have  technical specifications. It's possible that there is any GPIO or 
> whatever kind of logic that controls "something" that makes the sound 
> better.
> Not having a Santa Cruz card dont make things easier ... I had one I 
> would start testing all the EGPIO's by the hard way seing what happens, 
> (maybe
> someone that have time and such a card can do this ?) In the current 
> cs46xx driver there is some debug code to control the EGPIO's from the
> ALSA mixer that can be activated by defining 
> CONFIG_SND_CS46XX_DEBUG_GPIO in cs46xx_lib.c, that I've been using to 
> test EGPIO functionality on
> the Game Theater XP card.
> 
> It's possible that the current ALSA driver needs to be optimized. When a 
> new PCM channel is opened first time the driver needs to do a lot a 
> things. Sure that the you got a small and short  peak when audio 
> playback starts. Can you can meusure if it's System time, User time ?
> 
> The "external_amp" parameter is specified when module is loaded, eg. on 
> a line in /etc/module.conf:
> option snd-cs46xx external_amp=1
> 



/Benny

I have tested the modules option (the parameter is actually 
snd_external_amp) but no difference. I am attempting to use the debug 
code, but after defining I get the following errors during compile:

gcc -D__KERNEL__ -DMODULE=1 
-I/home/weijia/Downloads/alsa-cvs/alsa-driver/include 
-I/lib/modules/2.4.19/build/include -O2 -mpreferred-stack-boundary=2 
-march=i686 -malign-functions=4 -DLINUX -Wall -Wstrict-prototypes 
-fomit-frame-pointer -pipe -DALSA_BUILD -DCONFIG_SND_CS46XX_NEW_DSP=1 
-DKBUILD_BASENAME=cs46xx_lib   -c -o cs46xx_lib.o cs46xx_lib.c
In file included from cs46xx_lib.c:2:
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c: In function 
`snd_cs46xx_iec958_put':
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1615: warning: `res' might be 
used uninitialized in this function
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c: In function 
`snd_cs46xx_egpio_select_get':
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1767: structure has no member 
named `current_gpio'
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c: In function 
`snd_cs46xx_egpio_select_put':
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1776: structure has no member 
named `current_gpio'
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1777: structure has no member 
named `current_gpio'
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c: In function 
`snd_cs46xx_egpio_get':
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1791: structure has no member 
named `current_gpio'
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c: In function 
`snd_cs46xx_egpio_put':
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1806: structure has no member 
named `current_gpio'
./../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1808: structure has no member 
named `current_gpio'
make[3]: *** [cs46xx_lib.o] Error 1
make[3]: Leaving directory 
`/home/weijia/Downloads/alsa-cvs/alsa-driver/pci/cs46xx'
make[2]: *** [_modsubdir_cs46xx] Error 2
make[2]: Leaving directory `/home/weijia/Downloads/alsa-cvs/alsa-driver/pci'
make[1]: *** [compile] Error 1
make[1]: Leaving directory `/home/weijia/Downloads/alsa-cvs/alsa-driver'
make: *** [build] Error 2


any ideas? Thanks

-- 
Weijia Yang
School of Electrical and Computer Engineering
Georgia Institute of Technology
Atlanta, GA



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
