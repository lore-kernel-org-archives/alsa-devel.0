From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix clang warning without CONFIG_PM
Date: Thu, 7 Mar 2019 15:27:57 +0200
Message-ID: <5674adc4-b4ee-36b0-3beb-812b75485f66@ti.com>
References: <20190307101145.636705-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307101145.636705-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Tony Lindgren <tony@atomide.com>, Kees Cook <keescook@chromium.org>, Vishal Thanki <vishalthanki@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 07/03/2019 12.11, Arnd Bergmann wrote:
> Building with clang shows a variable that is only used by the
> suspend/resume functions but defined outside of their #ifdef block:
> 
> sound/soc/ti/davinci-mcasp.c:48:12: error: variable 'context_regs' is not needed and will not be emitted
> 
> We commonly fix these by marking the PM functions as __maybe_unused,
> but here that would grow the davinci_mcasp structure, so instead
> add another #ifdef here.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Fixes: 1cc0c054f380 ("ASoC: davinci-mcasp: Convert the context save/restore to use array")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/ti/davinci-mcasp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index a3a67a8f0f54..9fbc759fdefe 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -45,6 +45,7 @@
>  
>  #define MCASP_MAX_AFIFO_DEPTH	64
>  
> +#ifdef CONFIG_PM
>  static u32 context_regs[] = {
>  	DAVINCI_MCASP_TXFMCTL_REG,
>  	DAVINCI_MCASP_RXFMCTL_REG,
> @@ -68,6 +69,7 @@ struct davinci_mcasp_context {
>  	u32	*xrsr_regs; /* for serializer configuration */
>  	bool	pm_state;
>  };
> +#endif
>  
>  struct davinci_mcasp_ruledata {
>  	struct davinci_mcasp *mcasp;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
