From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before irq_dispose_mapping()
Date: Mon, 01 Dec 2014 10:51:57 -0600
Message-ID: <547C9CAD.1000008@tabi.org>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com> <20141201065046.GB27289@pengutronix.de> <547C9C34.9080602@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <547C9C34.9080602@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Markus Pargmann <mpa@pengutronix.de>, Jiada Wang <jiada_wang@mentor.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, Li.Xiubo@freescale.com, nicoleotsuka@gmail.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/01/2014 10:49 AM, Lars-Peter Clausen wrote:

> The driver creates the mapping by calling irq_of_parse_and_map(), so it
> also has to dispose the mapping. But the easy way out is to simply use
> platform_get_irq() instead of irq_of_parse_map(). In this case the
> mapping is not managed by the device but by the of core, so the device
> has not to dispose the mapping.

Is this a problem unique to the SSI driver?  Maybe devm_free_irq() 
should also dispose of the mapping?
