From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] Asoc: sam9x5_wm8731: depend on ARCH_AT91
	instead of SOC_AT91SAM9X5
Date: Tue, 13 Jan 2015 13:56:13 +0100
Message-ID: <54B515ED.9080406@atmel.com>
References: <1421152046-20069-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 8154A26041A
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 13:56:15 +0100 (CET)
In-Reply-To: <1421152046-20069-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Brown <broonie@kernel.org>, Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Le 13/01/2015 13:27, Alexandre Belloni a =E9crit :
> The SOC_AT91SAM9X5 option is going to be removed, only depend on ARCH_AT9=
1 like
> for the other drivers.
> =

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  sound/soc/atmel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index fb3878312bf8..1579e994acf8 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -45,7 +45,7 @@ config SND_ATMEL_SOC_WM8904
>  =

>  config SND_AT91_SOC_SAM9X5_WM8731
>  	tristate "SoC Audio support for WM8731-based at91sam9x5 board"
> -	depends on ATMEL_SSC && SND_ATMEL_SOC && SOC_AT91SAM9X5
> +	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC
>  	select SND_ATMEL_SOC_SSC
>  	select SND_ATMEL_SOC_DMA
>  	select SND_SOC_WM8731
> =



-- =

Nicolas Ferre
