From: Arnaud Lacombe <lacombar@gmail.com>
Subject: Re: Build regressions/improvements in v3.0-rc7 (sound/isa/)
Date: Thu, 28 Jul 2011 12:36:27 -0400
Message-ID: <CACqU3MXUt_Kcvu_uHmnS9Wm_hV73HaCgKcggAK350LBsL-EYbg@mail.gmail.com>
References: <1310585610-434-1-git-send-email-geert@linux-m68k.org>
	<20110724122624.324d10dc.rdunlap@xenotime.net>
	<s5hy5zm3j5a.wl%tiwai@suse.de>
	<20110725091003.c3453b8b.rdunlap@xenotime.net>
	<20110727121320.f50b1e6b.rdunlap@xenotime.net>
	<20110728111709.8303f78c9b5f2b3aa3f391b0@canb.auug.org.au>
	<20110728092116.cc318545.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20110728092116.cc318545.rdunlap@xenotime.net>
Sender: linux-kbuild-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Takashi Iwai <tiwai@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Jul 28, 2011 at 12:21 PM, Randy Dunlap <rdunlap@xenotime.net> w=
rote:
> On Thu, 28 Jul 2011 11:17:09 +1000 Stephen Rothwell wrote:
>
>> Hi Randy,
>>
>> On Wed, 27 Jul 2011 12:13:20 -0700 Randy Dunlap <rdunlap@xenotime.ne=
t> wrote:
>> >
>> > On Mon, 25 Jul 2011 09:10:03 -0700 Randy Dunlap wrote:
>> >
>> > > On Mon, 25 Jul 2011 09:37:53 +0200 Takashi Iwai wrote:
>> > >
>> > > > At Sun, 24 Jul 2011 12:26:24 -0700,
>> > > > Randy Dunlap wrote:
>> > > > >
>> > > > > On Wed, 13 Jul 2011 21:33:30 +0200 Geert Uytterhoeven wrote:
>> > > > >
>> > > > > > =A0 + src/sound/isa/ad1816a/ad1816a_lib.c: error: implicit=
 declaration of function 'snd_dma_disable': =A0=3D> 544
>> > > > > > =A0 + src/sound/isa/ad1816a/ad1816a_lib.c: error: implicit=
 declaration of function 'snd_dma_pointer': =A0=3D> 302
>> > > > > > =A0 + src/sound/isa/ad1816a/ad1816a_lib.c: error: implicit=
 declaration of function 'snd_dma_program': =A0=3D> 244
>> > > > > > =A0 + src/sound/isa/es1688/es1688_lib.c: error: implicit d=
eclaration of function 'snd_dma_pointer': =A0=3D> 509
>> > > > > > =A0 + src/sound/isa/es1688/es1688_lib.c: error: implicit d=
eclaration of function 'snd_dma_program': =A0=3D> 417
>> > > > > > =A0 + src/sound/isa/gus/gus_dma.c: error: implicit declara=
tion of function 'snd_dma_disable': =A0=3D> 177
>> > > > > > =A0 + src/sound/isa/gus/gus_dma.c: error: implicit declara=
tion of function 'snd_dma_program': =A0=3D> 79
>> > > > > > =A0 + src/sound/isa/gus/gus_pcm.c: error: implicit declara=
tion of function 'snd_dma_pointer': =A0=3D> 619
>> > > > > > =A0 + src/sound/isa/gus/gus_pcm.c: error: implicit declara=
tion of function 'snd_dma_program': =A0=3D> 591
>> > > > > > =A0 + src/sound/isa/sb/sb16_main.c: error: implicit declar=
ation of function 'snd_dma_pointer': =A0=3D> 456
>> > > > > > =A0 + src/sound/isa/sb/sb16_main.c: error: implicit declar=
ation of function 'snd_dma_program': =A0=3D> 276
>> > > > > > =A0 + src/sound/isa/sb/sb8_main.c: error: implicit declara=
tion of function 'snd_dma_pointer': =A0=3D> 425
>> > > > > > =A0 + src/sound/isa/sb/sb8_main.c: error: implicit declara=
tion of function 'snd_dma_program': =A0=3D> 172
>> > > > > > =A0 + src/sound/isa/sscape.c: error: implicit declaration =
of function 'snd_dma_program': =A0=3D> 481
>> > > > > > =A0 + src/sound/isa/wss/wss_lib.c: error: implicit declara=
tion of function 'snd_dma_disable': =A0=3D> 1695
>> > > > > > =A0 + src/sound/isa/wss/wss_lib.c: error: implicit declara=
tion of function 'snd_dma_pointer': =A0=3D> 1160
>> > > > > > =A0 + src/sound/isa/wss/wss_lib.c: error: implicit declara=
tion of function 'snd_dma_program': =A0=3D> 1025
>> > > > >
>> > > > > All of these source files do #include <sound/core.h>,
>> > > > > but these missing/implicit functions are conditional:
>> > > > >
>> > > > > #ifdef CONFIG_ISA_DMA_API
>> > > > > #define DMA_MODE_NO_ENABLE =A0 =A00x0100
>> > > > >
>> > > > > void snd_dma_program(unsigned long dma, unsigned long addr, =
unsigned int size, unsigned short mode);
>> > > > > void snd_dma_disable(unsigned long dma);
>> > > > > unsigned int snd_dma_pointer(unsigned long dma, unsigned int=
 size);
>> > > > > #endif
>> > > > >
>> > > > > so should these drivers all depend on ISA_DMA_API ?
>> > > >
>> > > > Yes, these are ISA sound cards, so they must have CONFIG_ISA a=
nd
>> > > > CONFIG_ISA_DMA. =A0Although CONFIG_SND_SB8_DSP, CONFIG_SND_SB1=
6_DSP
>> > > > and CONFIG_SND_WSS_LIB have no direct dependency, but the driv=
ers
>> > > > selecting these are all in "if SND_ISA" in sound/isa/Kconfig.
>> > >
>> > > Hm, yes, they are.
>> > >
>> > > > > or should only pieces of each driver depend on ISA_DMA_API ?
>> > > >
>> > > > I wonder which configuration makes it possible.
>> > > > Did you see a similar problem with randconfig?
>> > >
>> > > No. =A0This parisc allmodconfig file from linux-next builds has
>> > > CONFIG_SND_ISA=3Dy but it does not have CONFIG_ISA_DMA_API enabl=
ed. =A0Weird.
>> > >
>> > > Geert, do you know how this happens?
>> > >
>> > > parisc config: =A0http://kisskb.ellerman.id.au/kisskb/buildresul=
t/4323458/config/
>> > > from this failed build: =A0http://kisskb.ellerman.id.au/kisskb/b=
uildresult/4323458/
>> >
>> > How is CONFIG_ISA_DMA_API enabled in parisc allmodconfig?
>> > I don't see how that happens, and it's causing build errors...
>>
>> Sorry, but I don't understand the question. =A0The problam is that
>> CONFIG_ISA_DMA_API is not enabled, right? =A0On parisc, it is just (=
from
>> arch/parisc/Kconfig)
>>
>> config ISA_DMA_API
>> =A0 =A0 =A0 bool
>>
>> and nothing selects it. =A0However, I would have expected an allmodc=
onfig
>> to set it to y. =A0Clearly I don't understan how allmodconfig works =
any
>> more :-(
>>
>> Michal, is my understanding correct? =A0Is this a bug in allmodconfi=
g?
>
> When I do:
> $ make ARCH=3Dparisc O=3DPAR allmodconfig
>
> I don't get CONFIG_ISA_DMA_API enabled, so the question is simply
> how is the linux-next build system ending up with CONFIG_ISA_DMA_API =
enabled?
>
Where do you see that "linux-next build system ending up with
CONFIG_ISA_DMA_API enabled" ?

=46rom what I understood of the problem, the issue is that
CONFIG_ISA_DMA_API does _not_ ends up enabled.

 - Arnaud

> What commands are used to cause this?
>
>
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your c=
ode ***
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuil=
d" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
