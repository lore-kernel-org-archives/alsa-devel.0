From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 0/4] ASoC: Regression fix for OMAP in DT
	boot (3.11)
Date: Thu, 11 Jul 2013 16:02:10 +0200
Message-ID: <51DEBAE2.6060709@metafoo.de>
References: <1373546146-30271-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-055.synserver.de (smtp-out-055.synserver.de
 [212.40.185.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C89126587B
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 16:01:31 +0200 (CEST)
In-Reply-To: <1373546146-30271-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 07/11/2013 02:35 PM, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Drop the change in dmaengine_pcm.h
> - Use .filter_data to store the DMA channel name
>  - omap-pcm: checks if the DAI is probed via DT and uses decides which method to
>    use to request the DMA channel
> - Dropped the cleanup patch for omap-dmic from the series
>   I will send another series with cleanups later
> 
> I just noticed in mainline kernel (pre 3.11-rc1) that OMAP4 audio is not probing
> anymore. This is because OMAP4 also moved to DT only mode (3.10 DT boot was
> fine).
> The issue underneath is that we can not use platform_get_resource_byname() for
> DMA resources when booted with devicetree.
> 
> In case of DT boot we can use the DMA name to request the channel.
> 
> Due to technical issues OMAP can not be moved to generic dmaengine pcm as other
> SoCs did.
> 
> Mark: can you queue this series for 3.11? Thank you.
> 
> Regards,
> Peter

Looks good, all 4 patches:
Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

But I'm wondering who do you register the PCM device in the DT case? Do you
have a separate DT node for the PCM device?

- Lars

> ---
> Peter Ujfalusi (4):
>   ASoC: omap-pcm: Request the DMA channel differently when DT is
>     involved
>   ASoC: omap-mcpdm: Do not use platform_get_resource_byname() for DMA
>   ASoC: omap-dmic: Do not use platform_get_resource_byname() for DMA
>   ASoC: omap-mcbsp: Use different method for DMA request when booted
>     with DT
> 
>  sound/soc/omap/mcbsp.c      | 39 ++++++++++++++++++++++-----------------
>  sound/soc/omap/omap-dmic.c  | 11 +----------
>  sound/soc/omap/omap-mcpdm.c | 16 ++--------------
>  sound/soc/omap/omap-pcm.c   | 17 ++++++++++++++---
>  4 files changed, 39 insertions(+), 44 deletions(-)
> 
