From: Timur Tabi <timur@freescale.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Tue, 17 Jun 2008 09:55:05 -0500
Message-ID: <4857D049.8010109@freescale.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>	
	<1213612755.6599.51.camel@odin>	
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>	
	<4856776B.7040300@freescale.com>	
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>	
	<20080616150337.GB22229@sirena.org.uk>	
	<9e4733910806160853o2970f281m239712d8a2619e91@mail.gmail.com>	
	<48568E60.10206@freescale.com>	
	<9e4733910806160923u1e7b3688tba4af776db2ddeef@mail.gmail.com>	
	<485693BA.9010801@freescale.com>
	<9e4733910806161758l55429b08o645c0a040dd2fdad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A948244D0
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 16:55:10 +0200 (CEST)
In-Reply-To: <9e4733910806161758l55429b08o645c0a040dd2fdad@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:

> The architecture still doesn't appear right to me. fsl-dma.c is
> another driver that is self-creating its own device. 

Well, giving it its own device makes it easier to create sysfs entries.

> We can certainly
> add code to arch/powerpc/platforms/86xx/mpc8610_hpcd.c to create a
> "fsl-elo" device, but it's another fake device. 

I don't understand your penchant for putting code in the wrong drivers.  First
it's fabric code in the SSI driver.  And now you want DMA code in the platform
driver.

> Plus there's already a
> driver for the real "fsl,eloplus-dma" hardware in the system.

The DMA nodes that the DMA driver is supposed to use are marked with a different
compatible property (I haven't figured out exactly what).  This prevents the
standard DMA driver from touching them.

> Needing
> to create fake devices is a sign that the design is not correct. 

That sounds like an overgeneralization to me.

> dma
> support should probably be a library that is linked into the ssi
> driver and not be a standalone device driver.

Each SSI needs two specific DMA channels.  I suppose we could augment ASoC to
figure out which channels map to which SSI, but that's a lot of extra work.  I
don't know if it's possible to support all architectures with a model like that.

> If you do it in
> the fabric driver, then the fabric driver can never be optional.

I don't have any problem with that at all.

-- 
Timur Tabi
Linux kernel developer at Freescale
