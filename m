From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: fsl_ssi: free irq before
	irq_dispose_mapping()
Date: Mon, 01 Dec 2014 17:59:06 +0100
Message-ID: <547C9E5A.8040307@metafoo.de>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
 <20141201065046.GB27289@pengutronix.de> <547C9C34.9080602@metafoo.de>
 <547C9CAD.1000008@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-248.synserver.de (smtp-out-248.synserver.de
 [212.40.185.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 22DC2260566
 for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2014 18:00:17 +0100 (CET)
In-Reply-To: <547C9CAD.1000008@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Markus Pargmann <mpa@pengutronix.de>, Jiada Wang <jiada_wang@mentor.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 12/01/2014 05:51 PM, Timur Tabi wrote:
> On 12/01/2014 10:49 AM, Lars-Peter Clausen wrote:
>
>> The driver creates the mapping by calling irq_of_parse_and_map(), so it
>> also has to dispose the mapping. But the easy way out is to simply use
>> platform_get_irq() instead of irq_of_parse_map(). In this case the
>> mapping is not managed by the device but by the of core, so the device
>> has not to dispose the mapping.
>
> Is this a problem unique to the SSI driver?  Maybe devm_free_irq() should
> also dispose of the mapping?
>

If the mapping was not created by the device, the device shouldn't dispose 
it. Mapping and requesting the interrupt are two independent operations.
