From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_FSL_SAI or SND_SOC_FSL_SSI
 depending on SoC type
Date: Fri, 29 Jan 2016 06:59:38 +0100
Message-ID: <20160129065938.6e89fc37@ipc1.ka-ro>
References: <1453293038-16032-1-git-send-email-LW@KARO-electronics.de>
	<20160128223352.GB4130@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160128223352.GB4130@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, 28 Jan 2016 23:33:52 +0100 Mark Brown wrote:
> On Wed, Jan 20, 2016 at 01:30:38PM +0100, Lothar Wa=C3=9Fmann wrote:
>=20
> > -	select SND_SOC_FSL_SSI
> > +	select SND_SOC_FSL_SAI if SOC_IMX6UL
> > +	select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IMX6SX
>=20
> Does this card not work for older i.MXs (which had the same SSI/AUDMU=
X
> combination as the majority of the i.MX6 family) as well?
>
Our baseboard contains an SGTL5000 codec which is working with
i.MX25, i.MX27, i.MX5, i.MX6Q, i.MX6DL with the fsl_ssi and imx-sgtl500=
0
+ imx-audmux driver, on i.MX28 with the mxs-saif and mxs-sgtl5000 drive=
r
and on i.MX6UL with the fsl_sai + simple-card driver.


Lothar Wa=C3=9Fmann
