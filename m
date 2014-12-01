From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before irq_dispose_mapping()
Date: Mon, 01 Dec 2014 20:56:23 +0100
Message-ID: <2547588.Qc4F2IfZke@wuerfel>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com> <547CC407.30308@metafoo.de> <20141201194147.GP7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141201194147.GP7712@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Jiada Wang <jiada_wang@mentor.com>, linux-kernel@vger.kernel.org, Timur Tabi <timur@tabi.org>, lgirdwood@gmail.com, nicoleotsuka@gmail.com, tiwai@suse.de, Li.Xiubo@freescale.com, Markus Pargmann <mpa@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Monday 01 December 2014 19:41:47 Mark Brown wrote:
> On Mon, Dec 01, 2014 at 08:39:51PM +0100, Lars-Peter Clausen wrote:
> > On 12/01/2014 07:48 PM, Timur Tabi wrote:
> 
> > >A quick grep shows the following drivers that call both functions:
> 
> > Most of these drivers will probably work fine without irq_of_parse_and_map().
> 
> I'd also note that quite a few of these drivers look pretty legacy - a
> very large proportion are for old PowerPC hardware, though by no means
> all.

Right, from the times before we were using platform_device for probing
device tree based devices and they had to map the interrupt themselves.

Some of them like arch/powerpc/sysdev/fsl_pci.c seem fine, this one
is does not expect to ever destroy a device, and it only unmaps the
interrupt if request_irq fails. drivers/ata/pata_mpc52xx.c on the
other hand seems wrong in the same was as drivers/edac/mpc85xx_edac.c
and sound/soc/fsl/fsl_ssi.c.

All other drivers that call irq_of_parse_and_map and pass that into
devm_request_irq just never unmap, and their interrupts are already
mapped by the platform code, so I think it's not even a leak.

	Arnd
