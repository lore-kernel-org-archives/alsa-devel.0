From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] MFD: DaVinci: Fix voice codec device name
Date: Thu, 27 Jan 2011 20:41:56 +0000
Message-ID: <1296160916.3376.55.camel@odin>
References: <1296134916-25742-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 26408103806
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 21:42:02 +0100 (CET)
Received: by wwe15 with SMTP id 15so2490756wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 12:42:01 -0800 (PST)
In-Reply-To: <1296134916-25742-1-git-send-email-prakash.pm@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Samuel Ortiz <sameo@linux.intel.com>, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, stable@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-27 at 18:58 +0530, Manjunathappa, Prakash wrote:
> Fix the device name in DaVinci Voice Codec MFD driver to load
> davinci-vcif and cq93vc codec client drivers.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
> This patch applies to Linus's tree at [1].
> 
> [1] http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> ---
>  drivers/mfd/davinci_voicecodec.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
> index 33c923d..fdd8a1b 100644
> --- a/drivers/mfd/davinci_voicecodec.c
> +++ b/drivers/mfd/davinci_voicecodec.c
> @@ -118,12 +118,12 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
>  
>  	/* Voice codec interface client */
>  	cell = &davinci_vc->cells[DAVINCI_VC_VCIF_CELL];
> -	cell->name = "davinci_vcif";
> +	cell->name = "davinci-vcif";
>  	cell->driver_data = davinci_vc;
>  
>  	/* Voice codec CQ93VC client */
>  	cell = &davinci_vc->cells[DAVINCI_VC_CQ93VC_CELL];
> -	cell->name = "cq93vc";
> +	cell->name = "cq93vc-codec";
>  	cell->driver_data = davinci_vc;
>  
>  	ret = mfd_add_devices(&pdev->dev, pdev->id, davinci_vc->cells,

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
