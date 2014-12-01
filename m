From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: fsl_ssi: free irq before
	irq_dispose_mapping()
Date: Mon, 01 Dec 2014 17:49:56 +0100
Message-ID: <547C9C34.9080602@metafoo.de>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
 <20141201065046.GB27289@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-248.synserver.de (smtp-out-248.synserver.de
 [212.40.185.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 24FA8260566
 for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2014 17:49:48 +0100 (CET)
In-Reply-To: <20141201065046.GB27289@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>, Jiada Wang <jiada_wang@mentor.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, timur@tabi.org, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 12/01/2014 07:50 AM, Markus Pargmann wrote:
[...]
>
> devm_request_irq() is used by other drivers too, this should not be a
> problem. Looking at the code it seems that irq_dispose_mapping may not
> be necessary with devm_request_irq(). So I think it would be better to
> remove irq_dispose_mapping() instead.

The driver creates the mapping by calling irq_of_parse_and_map(), so it also 
has to dispose the mapping. But the easy way out is to simply use 
platform_get_irq() instead of irq_of_parse_map(). In this case the mapping 
is not managed by the device but by the of core, so the device has not to 
dispose the mapping.

- Lars
