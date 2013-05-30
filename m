From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 4/6] MIPS: jz4740: Register jz4740 DMA device
Date: Thu, 30 May 2013 21:24:21 +0400
Message-ID: <51A78B45.1060604@cogentembedded.com>
References: <1369931105-28065-1-git-send-email-lars@metafoo.de> <1369931105-28065-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369931105-28065-5-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maarten ter Huurne <maarten@treewalker.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

On 05/30/2013 08:25 PM, Lars-Peter Clausen wrote:

> Register a device for the newly added jz4740 dmaengine driver.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
[...]
>   3 files changed, 23 insertions(+)
> diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
> index e9348fd..35a9d8c 100644
> --- a/arch/mips/jz4740/platform.c
> +++ b/arch/mips/jz4740/platform.c
> @@ -329,3 +329,24 @@ struct platform_device jz4740_pwm_device = {
[...]
> +struct platform_device jz4740_dma_device = {
> +	.name	= "jz4740-dma",
> +	.id	= -1,

    Why not align all = in this structure?

> +	.num_resources = ARRAY_SIZE(jz4740_dma_resources),
> +	.resource      = jz4740_dma_resources,
> +};
