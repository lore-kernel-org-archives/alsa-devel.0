From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Thu, 31 Mar 2005 17:23:08 +0800
Message-ID: <424BC17C.6000700@netvigator.com>
References: <423CCDAC.80401@netvigator.com> <1111674841.3353.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1111674841.3353.11.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Clemens Ladisch wrote:
> Raymond wrote:
>
>>What will be needed for a proper "MIDI" wavetable implementation ?
>
>
> Have a look at the OPL4 driver, it's the simplest wavetable driver.
> However, it doesn't support downloading instruments.
>
>

http://www.midi.org/about-midi/tutorial/tutor.shtml


Do anyone know how to fix the error
"*** No rule to make target `snd-au8830-synth.o', needed by `modules'.
Stop." ?


# ls /cvs/alsa-driver/pci/au88x0
au8810.c  au8830.c  au8830_seq.c    CVS       Makefile  snd-au8830.o
au8820.c  au8830.o  au8830_synth.c  Makefile  pci-ids.h  test

---------------------------------------------------------------------------

# more /cvs/alsa-driver/pci/au88x0/Makefile
ifndef SND_TOPDIR
SND_TOPDIR=../..
endif

include $(SND_TOPDIR)/toplevel.config
include $(SND_TOPDIR)/Makefile.conf

include $(SND_TOPDIR)/alsa-kernel/pci/au88x0/Makefile


snd-a8830-synth-objs := au8830_synth.o au8830_seq.o

sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if
$(CONFIG_SND_SEQUENCER),$(1)))

obj-$(call sequencer,$(CONFIG_SND_AU8830)) += snd-au8830-synth.o


include $(SND_TOPDIR)/Rules.make

--------------------------------------------------------------------------

# cd /cvs/alsa-driver
#./cvscompile --with-cards=au8830 --with-sequencer=yes

...

make  -C au88x0 fastdep
make[2]: Entering directory `/cvs/alsa-driver/pci/au88x0'
/cvs/alsa-driver/include/sndversions.h was not updated
gcc32 -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/cvs/alsa-driver/include
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc
-iwithprefix include  au8830.c > .depend
make[2]: Leaving directory `/cvs/alsa-driver/pci/au88x0'


...

make  -C au88x0 modules
make[2]: Entering directory `/cvs/alsa-driver/pci/au88x0'
gcc32 -D__KERNEL__ -DMODULE=1 -I/cvs/alsa-driver/include
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc
-iwithprefix include  -DKBUILD_BASENAME=au8830   -c -o au8830.o au8830.c
ln -sf ../pci/au88x0/snd-au8830.o /cvs/alsa-driver/modules/snd-au8830.o
rm -f snd-au8830.o
ld  -r -o snd-au8830.o au8830.o
make[2]: *** No rule to make target `snd-au8830-synth.o', needed by
`modules'. Stop.
make[2]: Leaving directory `/cvs/alsa-driver/pci/au88x0'
make[1]: *** [_modsubdir_au88x0] Error 2
make[1]: Leaving directory `/cvs/alsa-driver/pci'
make: *** [compile] Error 1













-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
