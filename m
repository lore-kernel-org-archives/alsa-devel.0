From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before irq_dispose_mapping()
Date: Mon, 01 Dec 2014 21:01:43 +0100
Message-ID: <3401240.VsRpsiV8WN@wuerfel>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com> <2547588.Qc4F2IfZke@wuerfel> <547CC89F.1030205@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <547CC89F.1030205@tabi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: linuxppc-dev@lists.ozlabs.org, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Jiada Wang <jiada_wang@mentor.com>, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, tiwai@suse.de, Li.Xiubo@freescale.com, Markus Pargmann <mpa@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Monday 01 December 2014 13:59:27 Timur Tabi wrote:
> On 12/01/2014 01:56 PM, Arnd Bergmann wrote:
> > All other drivers that call irq_of_parse_and_map and pass that into
> > devm_request_irq just never unmap, and their interrupts are already
> > mapped by the platform code, so I think it's not even a leak.
> 
> Does this mean that fsl_ssi.c should not be calling 
> irq_of_parse_and_map?  How else should it get the IRQ?

platform_get_irq()

	Arnd
