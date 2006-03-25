From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Adding controls
Date: Sat, 25 Mar 2006 17:25:00 +0000
Message-ID: <1143307500.9313.6.camel@localhost.localdomain>
References: <1142984360.9284.33.camel@localhost.localdomain>
	 <1142985518.4532.193.camel@mindpipe>
	 <1143059773.9254.3.camel@localhost.localdomain>
	 <1143060946.9254.5.camel@localhost.localdomain>
	 <s5hek0tjy2y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 6749A192
	for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2006 18:25:12 +0100 (MET)
In-Reply-To: <s5hek0tjy2y.wl%tiwai@suse.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-03-23 at 10:43 +0100, Takashi Iwai wrote:
> At Wed, 22 Mar 2006 20:55:46 +0000,
> Adrian McMenamin wrote:
> > 
> > On Wed, 2006-03-22 at 20:36 +0000, Adrian McMenamin wrote:
> > 
> > > > 
> > > I did. Made no difference afaics
> > > 
> > 
> > By which I mean I included the asound header file
> > 
> > :(
> 
> How are you compileing your stuff?  In the alsa-driver tree?
> If so, check the compiler options, especially -Ixxx is passed
> with a proper path.  In 2.6 environment, run like
> 
> 	% make V=1
> 
> then you'll see verbose output.
> 

I am compiling this out of the tree and it worked fine until I added the
mixer code...

This is the makefile

# This needs to point at your sh sources
KERNEL_SRC = /home/adrian/linux-2.6.15.2

# Output directory that you used when building Linux kernel, if any.
# Note: this driver will be compiled to the current directory
regardless.
O = $(KERNEL_SRC)

PWD := $(shell pwd)

obj-m := snd_card_aica.o

all::
	$(MAKE) -C $(KERNEL_SRC) M=$(PWD) modules



This is the verbose output

adrian@bossclass:~/aica/aica$ make V=1 ARCH=sh
CROSS_COMPILE=/home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux- -j2
make -C /home/adrian/linux-2.6.15.2 M=/home/adrian/aica/aica modules
make[1]: Entering directory `/home/adrian/linux-2.6.15.2'
mkdir -p /home/adrian/aica/aica/.tmp_versions
make -f scripts/Makefile.build obj=/home/adrian/aica/aica
  /home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc
-Wp,-MD,/home/adrian/aica/aica/.snd_card_aica.o.d  -nostdinc
-isystem /home/adrian/buildroot/build_sh4/staging_dir/lib/gcc/sh4-linux-uclibc/3.4.2/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2     -fomit-frame-pointer -pipe -ml -Wa,-isa=sh4 -m4 -m4-nofpu -Wdeclaration-after-statement   -DMODULE -DKBUILD_BASENAME=snd_card_aica -DKBUILD_MODNAME=snd_card_aica -c -o /home/adrian/aica/aica/snd_card_aica.o /home/adrian/aica/aica/snd_card_aica.c/home/adrian/aica/aica/snd_card_aica.c:58: warning: function declaration isn't a prototype
/home/adrian/aica/aica/snd_card_aica.c:111: warning: function
declaration isn't a prototype
/home/adrian/aica/aica/snd_card_aica.c:132: warning: function
declaration isn't a prototype
/home/adrian/aica/aica/snd_card_aica.c:148: warning: function
declaration isn't a prototype
/home/adrian/aica/aica/snd_card_aica.c:163: warning: function
declaration isn't a prototype
/home/adrian/aica/aica/snd_card_aica.c:171: warning: function
declaration isn't a prototype
/home/adrian/aica/aica/snd_card_aica.c: In function
`stereo_buffer_transfer':
/home/adrian/aica/aica/snd_card_aica.c:221: warning: passing arg 2 of
`dma_xfer' makes integer from pointer without a cast
/home/adrian/aica/aica/snd_card_aica.c:232: warning: passing arg 2 of
`dma_xfer' makes integer from pointer without a cast
/home/adrian/aica/aica/snd_card_aica.c: In function
`aica_period_elapsed':
/home/adrian/aica/aica/snd_card_aica.c:277: warning: passing arg 2 of
`dma_xfer' makes integer from pointer without a cast
/home/adrian/aica/aica/snd_card_aica.c: In function
`snd_aicapcm_pcm_open':
/home/adrian/aica/aica/snd_card_aica.c:308: warning: ISO C90 forbids
mixed declarations and code
/home/adrian/aica/aica/snd_card_aica.c: At top level:
/home/adrian/aica/aica/snd_card_aica.c:356: warning: function
declaration isn't a prototype
/home/adrian/aica/aica/snd_card_aica.c: In function `spu_begin_dma':
/home/adrian/aica/aica/snd_card_aica.c:373: warning: passing arg 2 of
`dma_xfer' makes integer from pointer without a cast
/home/adrian/aica/aica/snd_card_aica.c: At top level:
/home/adrian/aica/aica/snd_card_aica.c:489: warning: "struct
snd_ctl_elem_info" declared inside parameter list
/home/adrian/aica/aica/snd_card_aica.c:489: warning: its scope is only
this definition or declaration, which is probably not what you want
/home/adrian/aica/aica/snd_card_aica.c:489: warning: "struct
snd_kcontrol" declared inside parameter list
/home/adrian/aica/aica/snd_card_aica.c:494: warning: "struct
snd_ctl_elem_value" declared inside parameter list
/home/adrian/aica/aica/snd_card_aica.c:494: warning: "struct
snd_kcontrol" declared inside parameter list
/home/adrian/aica/aica/snd_card_aica.c:499: warning: "struct
snd_ctl_elem_value" declared inside parameter list
/home/adrian/aica/aica/snd_card_aica.c:499: warning: "struct
snd_kcontrol" declared inside parameter list
/home/adrian/aica/aica/snd_card_aica.c:504: error: variable
`snd_aica_controls' has initializer but incomplete type
/home/adrian/aica/aica/snd_card_aica.c:505: error: unknown field `iface'
specified in initializer
/home/adrian/aica/aica/snd_card_aica.c:505: warning: excess elements in
struct initializer
/home/adrian/aica/aica/snd_card_aica.c:505: warning: (near
initialization for `snd_aica_controls')
/home/adrian/aica/aica/snd_card_aica.c:506: error: unknown field `name'
specified in initializer
/home/adrian/aica/aica/snd_card_aica.c:506: warning: excess elements in
struct initializer
/home/adrian/aica/aica/snd_card_aica.c:506: warning: (near
initialization for `snd_aica_controls')
/home/adrian/aica/aica/snd_card_aica.c:507: error: unknown field `index'
specified in initializer
/home/adrian/aica/aica/snd_card_aica.c:507: warning: excess elements in
struct initializer
/home/adrian/aica/aica/snd_card_aica.c:507: warning: (near
initialization for `snd_aica_controls')
/home/adrian/aica/aica/snd_card_aica.c:508: error: unknown field
`access' specified in initializer
/home/adrian/aica/aica/snd_card_aica.c:508: error:
`SND_CTL_ELEM_ACCESS_READWRITE' undeclared here (not in a function)
/home/adrian/aica/aica/snd_card_aica.c:508: warning: excess elements in
struct initializer
/home/adrian/aica/aica/snd_card_aica.c:508: warning: (near
initialization for `snd_aica_controls')
/home/adrian/aica/aica/snd_card_aica.c:509: error: unknown field
`private_values' specified in initializer
/home/adrian/aica/aica/snd_card_aica.c:509: warning: excess elements in
struct initializer
/home/adrian/aica/aica/snd_card_aica.c:509: warning: (near
initialization for `snd_aica_controls')
/home/adrian/aica/aica/snd_card_aica.c:510: error: unknown field `info'
specified in initializer
/home/adrian/aica/aica/snd_card_aica.c:510: warning: excess elements in
struct initializer
/home/adrian/aica/aica/snd_card_aica.c:510: warning: (near
initialization for `snd_aica_controls')
/home/adrian/aica/aica/snd_card_aica.c:511: error: unknown field `get'
specified in initializer
/home/adrian/aica/aica/snd_card_aica.c:511: warning: excess elements in
struct initializer
/home/adrian/aica/aica/snd_card_aica.c:511: warning: (near
initialization for `snd_aica_controls')
/home/adrian/aica/aica/snd_card_aica.c:512: error: unknown field `put'
specified in initializer
/home/adrian/aica/aica/snd_card_aica.c:513: warning: excess elements in
struct initializer
/home/adrian/aica/aica/snd_card_aica.c:513: warning: (near
initialization for `snd_aica_controls')
/home/adrian/aica/aica/snd_card_aica.c:533: warning: function
declaration isn't a prototype
/home/adrian/aica/aica/snd_card_aica.c: In function
`load_aica_firmware':
/home/adrian/aica/aica/snd_card_aica.c:537: warning: ISO C90 forbids
mixed declarations and code
/home/adrian/aica/aica/snd_card_aica.c: In function `aica_init':
/home/adrian/aica/aica/snd_card_aica.c:609: error: `snd_aica_control'
undeclared (first use in this function)
/home/adrian/aica/aica/snd_card_aica.c:609: error: (Each undeclared
identifier is reported only once
/home/adrian/aica/aica/snd_card_aica.c:609: error: for each function it
appears in.)
/home/adrian/aica/aica/snd_card_aica.c:609: warning: passing arg 1 of
`snd_ctl_add' from incompatible pointer type
/home/adrian/aica/aica/snd_card_aica.c: At top level:
/home/adrian/aica/aica/snd_card_aica.c:504: error: storage size of
`snd_aica_controls' isn't known
/home/adrian/aica/aica/snd_card_aica.c:504: warning: 'snd_aica_controls'
defined but not used
make[2]: *** [/home/adrian/aica/aica/snd_card_aica.o] Error 1
make[1]: *** [_module_/home/adrian/aica/aica] Error 2
make[1]: Leaving directory `/home/adrian/linux-2.6.15.2'
make: *** [all] Error 2
adrian@bossclass:~/aica/aica$





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
