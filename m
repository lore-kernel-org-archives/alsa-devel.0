From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: SoC sound support for imx27
Date: Thu, 8 May 2008 09:54:28 +0200
Message-ID: <200805080954.28299.jbe@pengutronix.de>
References: <200804231654.44526.jbe@pengutronix.de>
	<200805051256.38153.jbe@pengutronix.de>
	<20080505124233.GE3426@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by alsa0.perex.cz (Postfix) with ESMTP id 50DD3246CA
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 09:54:34 +0200 (CEST)
In-Reply-To: <20080505124233.GE3426@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Monday 05 May 2008 14:42, Mark Brown wrote:
> On Mon, May 05, 2008 at 12:56:37PM +0200, Juergen Beisert wrote:
> > Hmm, I did a deeper look into this code. Why - for example - does the
> > file mx31ads-wm8753.c does the job of the BSP file? Why it registers
> > devices? For my board I want to register platform_devices only in
> > arc/arm/mach-mx2/pcm038.c. Nowhere else. If there is some glue required
> > to bring components together, IMHO also arc/arm/mach-mx2/pcm038.c is the
> > correct place to do so. Why you did it in sound/ ? If you do it in soun=
d/
> > , you always need two locations to maintain. On in the arch/, one in
> > sound/ .
> That said, you don't need to do things this way, especially with ASoC v2
> where even if you do separate out the machine driver you can still
> register everything in your architecture code including a platform
> device for the machine driver.

It seems the documentation in the "asoc-v2-dev" =

(Documentation/sound/alsa/soc/) is still v1, isn't it?

I'm confused how to link the pcm-layer and the transmission layer together. =

pxa2xx-i2s.c registers a codec-dai (line 346), while the imx-ssi.c register=
s =

(line 864) a platform-dai (internally called a cpu_dai. BTW: why a differen=
t =

name?). I _believe_ the CPU DAI tries to connect the CPU-pcm to the =

transmission interface like ssi or i2s on the same chip. But both =

implementations are using the same layering (pcm-dma and ssi/i2s), but =

registering different DAIs. =


Now I have an ssi driver for my CPU (to be more precise: Two instances of i=
t, =

when I registering two ssi devices in my BSP file). But how to tell the CPU =

pcm-layer which one it should use (and for what purpose, play, capture)? An=
d =

only the ssi driver itself knows how to interact with the DMA controller. B=
ut =

this information is needed in the CPU pcm-layer as it setup the DMA.

Does a list exists, where I can store driver's private data in each layer =

(mapped iomem addresses for example)? And how to access it, when I only get =

a "struct snd_pcm_substream" as a parameter?

Regards
Juergen
-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
