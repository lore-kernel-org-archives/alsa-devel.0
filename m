From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH] ASoC: pcm512x: Add ACPI support
Date: Fri, 18 May 2018 10:06:39 +0530
Message-ID: <20180518043639.GF2932@vkoul-mobl>
References: <20180517225326.30881-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id D473E266F44
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 06:36:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180517225326.30881-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 17-05-18, 17:53, Pierre-Louis Bossart wrote:
> HID is assumed to be made of TI PCI ID (0x104C) + part number, so all
> four 104C5121, 104C5122, 104C5141 104C5142 are valid.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---

...

>  static struct i2c_driver pcm512x_i2c_driver = {
>  	.probe 		= pcm512x_i2c_probe,
> @@ -67,7 +81,8 @@ static struct i2c_driver pcm512x_i2c_driver = {
>  	.id_table	= pcm512x_i2c_id,
>  	.driver		= {
>  		.name	= "pcm512x",
> -		.of_match_table = pcm512x_of_match,
> +		.of_match_table = of_match_ptr(pcm512x_of_match),

this change may not be part of this and should be mentioned in the log

Also quick grep tells me kernel has both :(

> +		.acpi_match_table = ACPI_PTR(pcm512x_acpi_match),
>  		.pm     = &pcm512x_pm_ops,
>  	},
>  };
> -- 
> 2.14.1

-- 
~Vinod
