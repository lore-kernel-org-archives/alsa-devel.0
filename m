From: Daniel Mack <zonque@gmail.com>
Subject: Re: [alsa-devel] [patch] ASoC: adau1701: type bug with ADAU1707_CLKDIV_UNSET
Date: Fri, 26 Jul 2013 17:54:02 +0200
Message-ID: <51F29B9A.5080103@gmail.com>
References: <20130725164016.GA4027@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20130725164016.GA4027@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, device-drivers-devel@blackfin.uclinux.org, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 25.07.2013 18:40, Dan Carpenter wrote:
> ADAU1707_CLKDIV_UNSET is always compared against an unsigned int and
> not an unsigned long.  The current tests are always false.

Well, in my case, sizeof(unsigned int) equals sizeof(unsigned long), so
it didn't hit me. But it should be fixed of course, thanks for catching.

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Daniel Mack <zonque@gmail.com>


> 
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
> index 44d8a95..2c10252 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -91,7 +91,7 @@
>  #define ADAU1701_OSCIPOW_OPD		0x04
>  #define ADAU1701_DACSET_DACINIT		1
>  
> -#define ADAU1707_CLKDIV_UNSET		(-1UL)
> +#define ADAU1707_CLKDIV_UNSET		(-1U)
>  
>  #define ADAU1701_FIRMWARE "adau1701.bin"
>  
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

