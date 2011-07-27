From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Build regressions/improvements in v3.0-rc7
	(sound/isa/)
Date: Wed, 27 Jul 2011 12:13:20 -0700
Message-ID: <20110727121320.f50b1e6b.rdunlap@xenotime.net>
References: <1310585610-434-1-git-send-email-geert@linux-m68k.org>
	<20110724122624.324d10dc.rdunlap@xenotime.net>
	<s5hy5zm3j5a.wl%tiwai@suse.de>
	<20110725091003.c3453b8b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy6-pub.bluehost.com (oproxy6-pub.bluehost.com
	[67.222.54.6]) by alsa0.perex.cz (Postfix) with SMTP id E1E602412D
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 21:13:24 +0200 (CEST)
In-Reply-To: <20110725091003.c3453b8b.rdunlap@xenotime.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 25 Jul 2011 09:10:03 -0700 Randy Dunlap wrote:

> On Mon, 25 Jul 2011 09:37:53 +0200 Takashi Iwai wrote:
> 
> > At Sun, 24 Jul 2011 12:26:24 -0700,
> > Randy Dunlap wrote:
> > > 
> > > On Wed, 13 Jul 2011 21:33:30 +0200 Geert Uytterhoeven wrote:
> > > 
> > > >   + src/sound/isa/ad1816a/ad1816a_lib.c: error: implicit declaration of function 'snd_dma_disable':  => 544
> > > >   + src/sound/isa/ad1816a/ad1816a_lib.c: error: implicit declaration of function 'snd_dma_pointer':  => 302
> > > >   + src/sound/isa/ad1816a/ad1816a_lib.c: error: implicit declaration of function 'snd_dma_program':  => 244
> > > >   + src/sound/isa/es1688/es1688_lib.c: error: implicit declaration of function 'snd_dma_pointer':  => 509
> > > >   + src/sound/isa/es1688/es1688_lib.c: error: implicit declaration of function 'snd_dma_program':  => 417
> > > >   + src/sound/isa/gus/gus_dma.c: error: implicit declaration of function 'snd_dma_disable':  => 177
> > > >   + src/sound/isa/gus/gus_dma.c: error: implicit declaration of function 'snd_dma_program':  => 79
> > > >   + src/sound/isa/gus/gus_pcm.c: error: implicit declaration of function 'snd_dma_pointer':  => 619
> > > >   + src/sound/isa/gus/gus_pcm.c: error: implicit declaration of function 'snd_dma_program':  => 591
> > > >   + src/sound/isa/sb/sb16_main.c: error: implicit declaration of function 'snd_dma_pointer':  => 456
> > > >   + src/sound/isa/sb/sb16_main.c: error: implicit declaration of function 'snd_dma_program':  => 276
> > > >   + src/sound/isa/sb/sb8_main.c: error: implicit declaration of function 'snd_dma_pointer':  => 425
> > > >   + src/sound/isa/sb/sb8_main.c: error: implicit declaration of function 'snd_dma_program':  => 172
> > > >   + src/sound/isa/sscape.c: error: implicit declaration of function 'snd_dma_program':  => 481
> > > >   + src/sound/isa/wss/wss_lib.c: error: implicit declaration of function 'snd_dma_disable':  => 1695
> > > >   + src/sound/isa/wss/wss_lib.c: error: implicit declaration of function 'snd_dma_pointer':  => 1160
> > > >   + src/sound/isa/wss/wss_lib.c: error: implicit declaration of function 'snd_dma_program':  => 1025
> > > 
> > > All of these source files do #include <sound/core.h>,
> > > but these missing/implicit functions are conditional:
> > > 
> > > #ifdef CONFIG_ISA_DMA_API
> > > #define DMA_MODE_NO_ENABLE	0x0100
> > > 
> > > void snd_dma_program(unsigned long dma, unsigned long addr, unsigned int size, unsigned short mode);
> > > void snd_dma_disable(unsigned long dma);
> > > unsigned int snd_dma_pointer(unsigned long dma, unsigned int size);
> > > #endif
> > > 
> > > so should these drivers all depend on ISA_DMA_API ?
> > 
> > Yes, these are ISA sound cards, so they must have CONFIG_ISA and
> > CONFIG_ISA_DMA.  Although CONFIG_SND_SB8_DSP, CONFIG_SND_SB16_DSP
> > and CONFIG_SND_WSS_LIB have no direct dependency, but the drivers
> > selecting these are all in "if SND_ISA" in sound/isa/Kconfig.
> 
> Hm, yes, they are.
> 
> > > or should only pieces of each driver depend on ISA_DMA_API ?
> > 
> > I wonder which configuration makes it possible.
> > Did you see a similar problem with randconfig?
> 
> No.  This parisc allmodconfig file from linux-next builds has
> CONFIG_SND_ISA=y but it does not have CONFIG_ISA_DMA_API enabled.  Weird.
> 
> Geert, do you know how this happens?
> 
> parisc config:  http://kisskb.ellerman.id.au/kisskb/buildresult/4323458/config/
> from this failed build:  http://kisskb.ellerman.id.au/kisskb/buildresult/4323458/

Hi Stephen,
How is CONFIG_ISA_DMA_API enabled in parisc allmodconfig?
I don't see how that happens, and it's causing build errors...

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
