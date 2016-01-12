From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/2] ASoC: fsl: select SND_SOC_FSL_SAI or SND_SOC_FSL_SSI
 depending on SoC type
Date: Tue, 12 Jan 2016 12:28:59 -0600
Message-ID: <569545EB.4080307@tabi.org>
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-3-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452622411-16674-3-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>, Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Lothar Wa=C3=9Fmann wrote:
> -	select SND_SOC_FSL_SSI
> +	select SND_SOC_FSL_SAI if SOC_IMX6UL
> +	select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IMX6SX

I don't think this is compatible with a multiarch kernel.
