From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Build regressions/improvements in v3.0-rc7 (sound/isa/)
Date: Thu, 28 Jul 2011 11:58:14 -0700
Message-ID: <20110728115814.07620295.rdunlap@xenotime.net>
References: <1310585610-434-1-git-send-email-geert@linux-m68k.org>
	<20110724122624.324d10dc.rdunlap@xenotime.net>
	<s5hy5zm3j5a.wl%tiwai@suse.de>
	<20110725091003.c3453b8b.rdunlap@xenotime.net>
	<20110727121320.f50b1e6b.rdunlap@xenotime.net>
	<20110728111709.8303f78c9b5f2b3aa3f391b0@canb.auug.org.au>
	<20110728092116.cc318545.rdunlap@xenotime.net>
	<CACqU3MXUt_Kcvu_uHmnS9Wm_hV73HaCgKcggAK350LBsL-EYbg@mail.gmail.com>
	<20110728094418.3bd4e9df.rdunlap@xenotime.net>
	<CACqU3MVkOqGr0WVrCiVEU5QtfC0mcOiruCc9_rm8VL44SRFmiA@mail.gmail.com>
	<s5hzkjy5l7m.wl%tiwai@suse.de>
	<CACqU3MUfGwDwWbszG22NJoakmXj1b4So_w2kd7B-DoREz3KE8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CACqU3MUfGwDwWbszG22NJoakmXj1b4So_w2kd7B-DoREz3KE8w@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnaud Lacombe <lacombar@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Jul 2011 14:24:49 -0400 Arnaud Lacombe wrote:

> Hi,
>=20
> On Thu, Jul 28, 2011 at 2:11 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > At Thu, 28 Jul 2011 13:06:19 -0400,
> > Arnaud Lacombe wrote:
> >>
> >> Hi,
> >>
> >> On Thu, Jul 28, 2011 at 12:44 PM, Randy Dunlap <rdunlap@xenotime.n=
et> wrote:
> >> > On Thu, 28 Jul 2011 12:36:27 -0400 Arnaud Lacombe wrote:
> >> >
> >> >> Hi,
> >> >>
> >> >> On Thu, Jul 28, 2011 at 12:21 PM, Randy Dunlap <rdunlap@xenotim=
e.net> wrote:
> >> >> > On Thu, 28 Jul 2011 11:17:09 +1000 Stephen Rothwell wrote:
> >> >> >
> >> >> >> Hi Randy,
> >> >> >>
> >> >> >> On Wed, 27 Jul 2011 12:13:20 -0700 Randy Dunlap <rdunlap@xen=
otime.net> wrote:
> >> >> >> >
> >> >> >> > On Mon, 25 Jul 2011 09:10:03 -0700 Randy Dunlap wrote:
> >> >> >> >
> >> >> >> > > On Mon, 25 Jul 2011 09:37:53 +0200 Takashi Iwai wrote:
> >> >> >> > >
> >> >> >> > > > At Sun, 24 Jul 2011 12:26:24 -0700,
> >> >> >> > > > Randy Dunlap wrote:
> >> >> >> > > > >
> >> >> >> > > > > On Wed, 13 Jul 2011 21:33:30 +0200 Geert Uytterhoeve=
n wrote:
> >> >> >> > > > >
> >> >> >> > > > > > =A0 + src/sound/isa/ad1816a/ad1816a_lib.c: error: =
implicit declaration of function 'snd_dma_disable': =A0=3D> 544
> >> >> >> > > > > > =A0 + src/sound/isa/ad1816a/ad1816a_lib.c: error: =
implicit declaration of function 'snd_dma_pointer': =A0=3D> 302
> >> >> >> > > > > > =A0 + src/sound/isa/ad1816a/ad1816a_lib.c: error: =
implicit declaration of function 'snd_dma_program': =A0=3D> 244
> >> >> >> > > > > > =A0 + src/sound/isa/es1688/es1688_lib.c: error: im=
plicit declaration of function 'snd_dma_pointer': =A0=3D> 509
> >> >> >> > > > > > =A0 + src/sound/isa/es1688/es1688_lib.c: error: im=
plicit declaration of function 'snd_dma_program': =A0=3D> 417
> >> >> >> > > > > > =A0 + src/sound/isa/gus/gus_dma.c: error: implicit=
 declaration of function 'snd_dma_disable': =A0=3D> 177
> >> >> >> > > > > > =A0 + src/sound/isa/gus/gus_dma.c: error: implicit=
 declaration of function 'snd_dma_program': =A0=3D> 79
> >> >> >> > > > > > =A0 + src/sound/isa/gus/gus_pcm.c: error: implicit=
 declaration of function 'snd_dma_pointer': =A0=3D> 619
> >> >> >> > > > > > =A0 + src/sound/isa/gus/gus_pcm.c: error: implicit=
 declaration of function 'snd_dma_program': =A0=3D> 591
> >> >> >> > > > > > =A0 + src/sound/isa/sb/sb16_main.c: error: implici=
t declaration of function 'snd_dma_pointer': =A0=3D> 456
> >> >> >> > > > > > =A0 + src/sound/isa/sb/sb16_main.c: error: implici=
t declaration of function 'snd_dma_program': =A0=3D> 276
> >> >> >> > > > > > =A0 + src/sound/isa/sb/sb8_main.c: error: implicit=
 declaration of function 'snd_dma_pointer': =A0=3D> 425
> >> >> >> > > > > > =A0 + src/sound/isa/sb/sb8_main.c: error: implicit=
 declaration of function 'snd_dma_program': =A0=3D> 172
> >> >> >> > > > > > =A0 + src/sound/isa/sscape.c: error: implicit decl=
aration of function 'snd_dma_program': =A0=3D> 481
> >> >> >> > > > > > =A0 + src/sound/isa/wss/wss_lib.c: error: implicit=
 declaration of function 'snd_dma_disable': =A0=3D> 1695
> >> >> >> > > > > > =A0 + src/sound/isa/wss/wss_lib.c: error: implicit=
 declaration of function 'snd_dma_pointer': =A0=3D> 1160
> >> >> >> > > > > > =A0 + src/sound/isa/wss/wss_lib.c: error: implicit=
 declaration of function 'snd_dma_program': =A0=3D> 1025
> >> >> >> > > > >
> >> >> >> > > > > All of these source files do #include <sound/core.h>=
,
> >> >> >> > > > > but these missing/implicit functions are conditional=
:
> >> >> >> > > > >
> >> >> >> > > > > #ifdef CONFIG_ISA_DMA_API
> >> >> >> > > > > #define DMA_MODE_NO_ENABLE =A0 =A00x0100
> >> >> >> > > > >
> >> >> >> > > > > void snd_dma_program(unsigned long dma, unsigned lon=
g addr, unsigned int size, unsigned short mode);
> >> >> >> > > > > void snd_dma_disable(unsigned long dma);
> >> >> >> > > > > unsigned int snd_dma_pointer(unsigned long dma, unsi=
gned int size);
> >> >> >> > > > > #endif
> >> >> >> > > > >
> >> >> >> > > > > so should these drivers all depend on ISA_DMA_API ?
> >> >> >> > > >
> >> >> >> > > > Yes, these are ISA sound cards, so they must have CONF=
IG_ISA and
> >> >> >> > > > CONFIG_ISA_DMA. =A0Although CONFIG_SND_SB8_DSP, CONFIG=
_SND_SB16_DSP
> >> >> >> > > > and CONFIG_SND_WSS_LIB have no direct dependency, but =
the drivers
> >> >> >> > > > selecting these are all in "if SND_ISA" in sound/isa/K=
config.
> >> >> >> > >
> >> >> >> > > Hm, yes, they are.
> >> >> >> > >
> >> >> >> > > > > or should only pieces of each driver depend on ISA_D=
MA_API ?
> >> >> >> > > >
> >> >> >> > > > I wonder which configuration makes it possible.
> >> >> >> > > > Did you see a similar problem with randconfig?
> >> >> >> > >
> >> >> >> > > No. =A0This parisc allmodconfig file from linux-next bui=
lds has
> >> >> >> > > CONFIG_SND_ISA=3Dy but it does not have CONFIG_ISA_DMA_A=
PI enabled. =A0Weird.
> >> >> >> > >
> >> >> >> > > Geert, do you know how this happens?
> >> >> >> > >
> >> >> >> > > parisc config: =A0http://kisskb.ellerman.id.au/kisskb/bu=
ildresult/4323458/config/
> >> >> >> > > from this failed build: =A0http://kisskb.ellerman.id.au/=
kisskb/buildresult/4323458/
> >> >> >> >
> >> >> >> > How is CONFIG_ISA_DMA_API enabled in parisc allmodconfig?
> >> >> >> > I don't see how that happens, and it's causing build error=
s...
> >> >> >>
> >> >> >> Sorry, but I don't understand the question. =A0The problam i=
s that
> >> >> >> CONFIG_ISA_DMA_API is not enabled, right? =A0On parisc, it i=
s just (from
> >> >> >> arch/parisc/Kconfig)
> >> >> >>
> >> >> >> config ISA_DMA_API
> >> >> >> =A0 =A0 =A0 bool
> >> >> >>
> >> >> >> and nothing selects it. =A0However, I would have expected an=
 allmodconfig
> >> >> >> to set it to y. =A0Clearly I don't understan how allmodconfi=
g works any
> >> >> >> more :-(
> >> >> >>
> >> >> >> Michal, is my understanding correct? =A0Is this a bug in all=
modconfig?
> >> >> >
> >> >> > When I do:
> >> >> > $ make ARCH=3Dparisc O=3DPAR allmodconfig
> >> >> >
> >> >> > I don't get CONFIG_ISA_DMA_API enabled, so the question is si=
mply
> >> >> > how is the linux-next build system ending up with CONFIG_ISA_=
DMA_API enabled?
> >> >> >
> >> >> Where do you see that "linux-next build system ending up with
> >> >> CONFIG_ISA_DMA_API enabled" ?
> >> >>
> >> >> From what I understood of the problem, the issue is that
> >> >> CONFIG_ISA_DMA_API does _not_ ends up enabled.
> >> >
> >> > Thanks for catching me.
> >> >
> >> > The problem (second try) is that ISA SND drivers are being built=
 (on parisc)
> >> > even though ISA_DMA_API is not enabled -- and should not be enab=
led,
> >> > so the ISA SND drivers should not be built. =A0I think I have it=
 right this time.
> >> >
> >> > From the parisc .config file listed above:
> >> >
> >> > CONFIG_SND_ISA=3Dy
> >> > CONFIG_SND_ADLIB=3Dm
> >> > CONFIG_SND_AD1816A=3Dm
> >> > CONFIG_SND_AD1848=3Dm
> >> > CONFIG_SND_ALS100=3Dm
> >> > CONFIG_SND_AZT1605=3Dm
> >> > CONFIG_SND_AZT2316=3Dm
> >> > CONFIG_SND_AZT2320=3Dm
> >> > CONFIG_SND_CMI8330=3Dm
> >> >
> >> >
> >> > etc. =A0But none of these should be enabled. =A0AFAIK.
> >> > So how does this happen?
> >> >
> >> warning: (RADIO_MIROPCM20) selects SND_ISA which has unmet direct
> >> dependencies (SOUND && !M68K && SND && ISA && ISA_DMA_API)
> >
> > Hm, I thought this was fixed by
> > commit 4756fc64ecd628efa6f8296711d7dbcefabf25dd
> > Author: Ralf Baechle <ralf@linux-mips.org>
> > Date: =A0 Fri Jun 24 10:30:09 2011 -0300
> >
> > =A0 =A0[media] MEDIA: Fix non-ISA_DMA_API link failure of sound cod=
e
> >
> > OK, it landed after 3.0-rc7, so this problem must be fixed now?
> % git checkout v3.0-rc7
> % make ARCH=3Dparisc allmodconfig
> [...]
> warning: (RADIO_WL128X) selects TI_ST which has unmet direct
> dependencies (MISC_DEVICES && NET && GPIOLIB)
> warning: (RADIO_MIROPCM20) selects SND_ISA which has unmet direct
> dependencies (SOUND && !M68K && SND && ISA && ISA_DMA_API)
> warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP
> && FUNCTION_TRACER && KMEMCHECK) selects FRAME_POINTER which has unme=
t
> direct dependencies (DEBUG_KERNEL && (CRIS || M68K || FRV || UML ||
> AVR32 || SUPERH || BLACKFIN || MN10300) || ARCH_WANT_FRAME_POINTERS)
> #
> # configuration written to .config
> #
> % grep -c SND_ISA .config
> 1
>=20
> % git checkout v3.0
> Previous HEAD position was 620917d... Linux 3.0-rc7
> HEAD is now at 02f8c6a... Linux 3.0
> % make ARCH=3Dparisc allmodconfig
> [...]
> warning: (RADIO_WL128X) selects TI_ST which has unmet direct
> dependencies (MISC_DEVICES && NET && GPIOLIB)
> warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP
> && FUNCTION_TRACER && KMEMCHECK) selects FRAME_POINTER which has unme=
t
> direct dependencies (DEBUG_KERNEL && (CRIS || M68K || FRV || UML ||
> AVR32 || SUPERH || BLACKFIN || MN10300) || ARCH_WANT_FRAME_POINTERS)
> #
> # configuration written to .config
> #
> % grep -c SND_ISA .config
> 0
>=20
> Look good to me.

Great, thanks everyone.  Yes, I was working on old data.
Sorry about that.  Anyway, lots of build errors now fixed by Ralf.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your cod=
e ***
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
