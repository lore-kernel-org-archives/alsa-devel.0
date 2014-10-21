From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 1/2] ARM: pxa: spitz: register spitz-audio
	device
Date: Tue, 21 Oct 2014 19:12:02 +0200
Message-ID: <87d29l1h5p.fsf@free.fr>
References: <1413881664-24870-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr
 [80.12.242.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 16AB92605F3
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 19:12:07 +0200 (CEST)
In-Reply-To: <1413881664-24870-1-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Tue, 21 Oct 2014 12:54:23 +0400")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

Hi Dmitry,

> Register spitz-audio device to be used by ASoC driver.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/arm/mach-pxa/spitz.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index 840c3a4..a9f971f 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -924,6 +924,23 @@ static inline void spitz_i2c_init(void) {}
>  #endif
>  
>  /******************************************************************************
> + * Audio devices
> + ******************************************************************************/
> +#if defined(CONFIG_SND_PXA2XX_SOC_SPITZ) || defined(SND_PXA2XX_SOC_SPITZ_MODULE)
> +static struct platform_device spitz_audio_device = {
> +	.name	= "spitz-audio",
> +	.id	= -1,
> +};
> +
> +static inline void spitz_audio_init(void)
> +{
> +	platform_device_register(&spitz_audio_device);
> +}
> +#else
> +static inline void spitz_audio_init(void) {}
> +#endif

Couldn't you eliminate the "#if defined" line , and "#else ... #endif" ?

I mean that spitz_audio_init() would always register the spitz_audio_device,
regardless of the config. The config would build or not build the sound soc
platform driver. Would that be alright for all your usecases ?

Cheers.

-- 
Robert
