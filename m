From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: clarify ac97 dependency
Date: Tue, 24 Nov 2015 14:50:21 -0800
Message-ID: <20151124225021.GA4600@Asurada-CZ80>
References: <2830784.Nrm81IgjTt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F8C926052F
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 23:50:29 +0100 (CET)
Received: by padhx2 with SMTP id hx2so35764408pad.1
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 14:50:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2830784.Nrm81IgjTt@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2015 at 11:21:10PM +0100, Arnd Bergmann wrote:
> A new randconfig build failure shows that the fsl-asoc-card module
> must not be built-in when the AC97 driver is a loadable module:
> 
> sound/built-in.o: In function `fsl_asoc_card_late_probe':
> :(.text+0x571d8): undefined reference to `snd_ac97_update_bits'
> 
> I couldn't come up with a nice solution, so this adds another dependency
> on "X || !X", which is the Kconfig way of saying that we have an
> optional dependency on something that might be a loadable module.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you

> Fixes: 50760cad9de9 ("ASoC: fsl-asoc-card: add AC'97 support")
> ---
> The commit that introduced this was merged for 4.4-rc1, so we might
> want the fix to go into 4.4 as well.
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 19c302b0d763..14dfdee05fd5 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -283,6 +283,8 @@ config SND_SOC_IMX_MC13783
>  config SND_SOC_FSL_ASOC_CARD
>  	tristate "Generic ASoC Sound Card with ASRC support"
>  	depends on OF && I2C
> +	# enforce SND_SOC_FSL_ASOC_CARD=m if SND_AC97_CODEC=m:
> +	depends on SND_AC97_CODEC || SND_AC97_CODEC=n
>  	select SND_SOC_IMX_AUDMUX
>  	select SND_SOC_IMX_PCM_DMA
>  	select SND_SOC_FSL_ESAI
> 
