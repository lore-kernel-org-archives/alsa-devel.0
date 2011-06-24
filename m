From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] SOUND: Fix non-ISA_DMA_API build failure
Date: Fri, 24 Jun 2011 14:36:23 +0100
Message-ID: <20110624133623.GA32018@linux-mips.org>
References: <20110623144750.GA10180@linux-mips.org>
	<201106241519.44425.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	by alsa0.perex.cz (Postfix) with ESMTP id DBC1A2450B
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 15:36:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201106241519.44425.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 24, 2011 at 03:19:44PM +0200, Arnd Bergmann wrote:

> > The sole ISA sound driver that does not use the ISA DMA API is the Adlib
> > driver so replaced the dependency of SND_ISA on ISA_DMA_API and add it =
to
> > each of the drivers individually.
> =

> Do we really care all that much about the Adlib driver on platforms witho=
ut
> ISA_DMA_API? Right now all of sound/isa/ is hidden behind ISA_DMA_API and
> I think that's acceptable

When looking into this build error I started untangling the mess from the
isa from the sounds end and found the media bits as the root cause after I
finished the sound bits.  I honestly don't care about the Adlib - until I
plug an Adlib into one of my SGI Indigo=B2 and that's unlikely to happen :)

> > diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
> > index e4c97fd..0aeed28 100644
> > --- a/drivers/media/radio/Kconfig
> > +++ b/drivers/media/radio/Kconfig
> > @@ -168,7 +168,7 @@ config RADIO_MAXIRADIO
> >  =

> >  config RADIO_MIROPCM20
> >         tristate "miroSOUND PCM20 radio"
> > -       depends on ISA && VIDEO_V4L2 && SND
> > +       depends on ISA && ISA_DMA_API && VIDEO_V4L2 && SND
> >         select SND_ISA
> >         select SND_MIRO
> >         ---help---
> =

> Then this hunk by itself would be enough to solve the compile
> errors, AFAICT.

It is, I've tested that.

  Ralf
