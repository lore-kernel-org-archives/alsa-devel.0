From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: fsl: select SND_SOC_FSL_SAI or
 SND_SOC_FSL_SSI depending on SoC type
Date: Wed, 13 Jan 2016 11:08:46 -0200
Message-ID: <CAOMZO5BifUkzSkPCf08TSQ3B8AHiXuVhBzy+tMsnMtA8t-AvJg@mail.gmail.com>
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
	<1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
	<1452622411-16674-3-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452622411-16674-3-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 12, 2016 at 4:13 PM, Lothar Wa=C3=9Fmann <LW@karo-electroni=
cs.de> wrote:

> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 14dfdee..c128823 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -258,7 +258,8 @@ config SND_SOC_IMX_SGTL5000
>         select SND_SOC_SGTL5000
>         select SND_SOC_IMX_PCM_DMA
>         select SND_SOC_IMX_AUDMUX
> -       select SND_SOC_FSL_SSI
> +       select SND_SOC_FSL_SAI if SOC_IMX6UL
> +       select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IMX6=
SX

MX6SX has SSI and SAI interfaces.
