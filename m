From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH 3/4] sound,
 media: allow building ISA drivers it with COMPILE_TEST
Date: Fri, 20 Apr 2018 10:01:22 -0300
Message-ID: <20180420100122.5c1dfc87@vento.lan>
References: <cover.1524227382.git.mchehab@s-opensource.com>
 <3f4d8ae83a91c765581d9cbbd1e436b6871368fa.1524227382.git.mchehab@s-opensource.com>
 <s5h7ep2vysl.wl-tiwai@suse.de> <20180420095129.2b7d004d@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B0682673D8
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 15:01:37 +0200 (CEST)
In-Reply-To: <20180420095129.2b7d004d@vento.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Em Fri, 20 Apr 2018 09:51:29 -0300
Mauro Carvalho Chehab <mchehab@s-opensource.com> escreveu:

> Em Fri, 20 Apr 2018 14:37:46 +0200
> Takashi Iwai <tiwai@suse.de> escreveu:
> 
> > On Fri, 20 Apr 2018 14:32:15 +0200,
> > Mauro Carvalho Chehab wrote:  
> > > 
> > > All sound drivers that don't depend on PNP can be safelly
> > > build with COMPILE_TEST, as ISA provides function stubs to
> > > be used for such purposes.
> > > 
> > > As a side effect, with this change, the radio-miropcm20
> > > can now be built outside i386 with COMPILE_TEST.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > > ---
> > >  drivers/media/radio/Kconfig | 3 ++-
> > >  sound/isa/Kconfig           | 9 +++++----
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
> > > index d363726e9eb1..8fa403c7149e 100644
> > > --- a/drivers/media/radio/Kconfig
> > > +++ b/drivers/media/radio/Kconfig
> > > @@ -372,7 +372,8 @@ config RADIO_GEMTEK_PROBE
> > >  
> > >  config RADIO_MIROPCM20
> > >  	tristate "miroSOUND PCM20 radio"
> > > -	depends on ISA && ISA_DMA_API && VIDEO_V4L2 && SND
> > > +	depends on ISA || COMPILE_TEST
> > > +	depends on ISA_DMA_API && VIDEO_V4L2 && SND
> > >  	select SND_ISA
> > >  	select SND_MIRO
> > >  	---help---
> > > diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
> > > index cb54d9c0a77f..d2a6cdd0395c 100644
> > > --- a/sound/isa/Kconfig
> > > +++ b/sound/isa/Kconfig
> > > @@ -20,7 +20,8 @@ config SND_SB16_DSP
> > >  
> > >  menuconfig SND_ISA
> > >  	bool "ISA sound devices"
> > > -	depends on ISA && ISA_DMA_API
> > > +	depends on ISA || COMPILE_TEST
> > > +	depends on ISA_DMA_API
> > >  	default y
> > >  	help
> > >  	  Support for sound devices connected via the ISA bus.
> > > @@ -38,7 +39,7 @@ config SND_ADLIB
> > >  
> > >  config SND_AD1816A
> > >  	tristate "Analog Devices SoundPort AD1816A"
> > > -	depends on PNP
> > > +	depends on PNP && ISA
> > >  	select ISAPNP
> > >  	select SND_OPL3_LIB
> > >  	select SND_MPU401_UART    
> > 
> > Just from curiosity: what's the reason for this explicit CONFIG_ISA
> > dependency?  What error did you get?  
> 
> Kconfig complains with "select ISAPNP":
> 
> WARNING: unmet direct dependencies detected for ISAPNP
>   Depends on [n]: PNP [=y] && ISA [=n]
>   Selected by [y]:
>   - SND_AD1816A [=y] && SOUND [=y] && !UML && SND [=y] && SND_ISA [=y] && PNP [=y]
> 
> Because it is declared as:
> 
> config ISAPNP
> 	bool "ISA Plug and Play support"
>         depends on ISA
> 
> I could have tried to change ISAPNP to depends on ISA || COMPILE_TEST,
> but I suspect that would touch on yet another subsystem and has
> the potential to point to other things that need changes, as
> a lot more drivers will be selected.
> 
> Anyway, after a quick look at include/linux/isapnp.h, I suspect
> that this can work.
> 
> I'll run some tests here.

Yes, removing the ISAPNP dependency if COMPILE_TEST is trivial too.

Just sent a separate patch to be applied after this one with such
removal.

I opted to make it as a separate patch as, if the drivers there
fail to build on some weird architecture, we won't need to discard
this one.

Thanks,
Mauro
