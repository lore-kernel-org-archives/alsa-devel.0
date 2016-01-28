From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_FSL_SAI or SND_SOC_FSL_SSI
 depending on SoC type
Date: Thu, 28 Jan 2016 15:08:47 -0800
Message-ID: <20160128230846.GA32388@Asurada-Nvidia>
References: <1453293038-16032-1-git-send-email-LW@KARO-electronics.de>
 <20160128223352.GB4130@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160128223352.GB4130@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 28, 2016 at 11:33:52PM +0100, Mark Brown wrote:
> On Wed, Jan 20, 2016 at 01:30:38PM +0100, Lothar Wa=DFmann wrote:
>=20
> > -	select SND_SOC_FSL_SSI
> > +	select SND_SOC_FSL_SAI if SOC_IMX6UL
> > +	select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IMX6SX
>=20
> Does this card not work for older i.MXs (which had the same SSI/AUDMU=
X
> combination as the majority of the i.MX6 family) as well?

It's widely used in older i.MXs according to their DTS files. So
it should be safer to just leave SSI over here.

And I actually doubt the feasibility of running this driver with
i.MX6UL as there might not be an AUDMUX on i.MX6UL since it does
not have SSI any more while the driver always touches the address
space of AUDMUX which may not exist on i.MX6UL.
