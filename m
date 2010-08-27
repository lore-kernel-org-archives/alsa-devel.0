From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem with underrun on new CS42448 x2 driver
Date: Fri, 27 Aug 2010 23:04:24 +0100
Message-ID: <20100827220400.GA7806@opensource.wolfsonmicro.com>
References: <AANLkTi=3kc74QqDopiAw+u8ie2Qn47p9XQpw54b6iB4Z@mail.gmail.com>
	<20100826124757.GC5721@sirena.org.uk>
	<AANLkTinY5mcCPKEJcm+Yru-+7U+nEWe+VaWL558UhhrB@mail.gmail.com>
	<20100826185226.GC24381@opensource.wolfsonmicro.com>
	<AANLkTimZdZnXRc9hL6zPhhauf7U=ihCGaNOKK+ve3vXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F02F31037F9
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 00:04:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimZdZnXRc9hL6zPhhauf7U=ihCGaNOKK+ve3vXw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: Mike Frysinger <vapier@gentoo.org>, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 27, 2010 at 04:11:48PM -0400, Adam Rosenberg wrote:

> >> I have not entered any constraints into the driver because there really
> >> should be no need. =A0The driver just copies whatever PCM data that is
> >> provided directly to the DMA buffer. =A0It seems that the problem occu=
rs
> >> because the location to copy to is based on the pos suggested by the
> >> callback function. =A0I am still finding it difficult to tell how ALSA=
 decides
> >> there is an underrun or overrun. =A0I am definitely trying to read or =
write
> >> the pcm data fast enough but it seems as though I get these errors any=
way.

> > I've no idea what "the callback function" is?

> The callback function is the PCM copy function that I define in struct
> snd_pcm_ops

So, this will be decided based on how much data ALSA thinks is being
consumed and how much it thinks can be =


> >> Questions:
> >> 1. =A0How do I implement an ASoC-style driver that supports multiple c=
hips
> >> when they are connected to the same SPORT but use different SPI chip
> >> selects?

> > Look at current ASoC in -next, I've never tried this multi drop DAI
> > setup directly myself but it does support multiple CODECs in the system.

> I could not find anything in the linux-2.6.x/sound/soc/ directory
> called "next" and cannot find any documentation in
> linux-2.6.x/Documentation/sound/alsa/soc about "multi drop"

-next is Stephen Rothewell's linux-next tree which contains the latest
development versions of all the trees that are likely to go into Linux
at the next merge window.

The documenation is bitrotted here but you're looking for the recent
multi-component changes.

> >> 2. =A0How do I define the proper buffer/period size constraints or sho=
uld I
> >> ignore the suggested position during copy operations and just keep tra=
ck of
> >> the position within the DMA buffer myself?

> > Your constraints will flow from the requirements of the hardware plus
> > any additional requirements that the driver you've written imposes. =A0=
For
> > example, if you always need a period of data ready to start DMA on which
> > the application can't touch for coherency reasons then you need to make
> > sure that there's at least three periods (running, about to run and
> > updatable), or if your hardware DMAs in blocks you need a minimum period
> > size for that.

> This information was a little cryptic at first.  It turns out it was
> the diamond in the rough though.  I set periods_min in struct
> snd_pcm_hardware to 3 and it solved quite a few underrun problems.

Right, so this means that previously you were not getting as much data
as you needed buffered by your application so when the driver ran out of
data to feed to the hardware the application hadn't provided any.

> Question: Is there a way I can force ALSA to always use a period size
> that is a multiple of 16?

You're looking for =


        snd_pcm_hw_constraint_step(runtime, 0,
                                   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 16);

I suspect but ICBW - it'll be one of the snd_pcm_hw_constraint_()
functions.  Take a look at what other drivers are doing with this sort
of stuff.
