From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_FSL_SAI or SND_SOC_FSL_SSI
 depending on SoC type
Date: Thu, 28 Jan 2016 22:25:30 -0800
Message-ID: <20160129062529.GA3370@Asurada-CZ80>
References: <1453293038-16032-1-git-send-email-LW@KARO-electronics.de>
 <20160128223352.GB4130@sirena.org.uk>
 <20160128230846.GA32388@Asurada-Nvidia>
 <20160129065133.7338cf2c@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160129065133.7338cf2c@ipc1.ka-ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 29, 2016 at 06:51:33AM +0100, Lothar Wa=DFmann wrote:
> Hi,
>=20
> On Thu, 28 Jan 2016 15:08:47 -0800 Nicolin Chen wrote:
> > On Thu, Jan 28, 2016 at 11:33:52PM +0100, Mark Brown wrote:
> > > On Wed, Jan 20, 2016 at 01:30:38PM +0100, Lothar Wa=DFmann wrote:
> > >=20
> > > > -	select SND_SOC_FSL_SSI
> > > > +	select SND_SOC_FSL_SAI if SOC_IMX6UL
> > > > +	select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IMX6=
SX
> > >=20
> > > Does this card not work for older i.MXs (which had the same SSI/A=
UDMUX
> > > combination as the majority of the i.MX6 family) as well?
> >=20
> > It's widely used in older i.MXs according to their DTS files. So
> > it should be safer to just leave SSI over here.
> >=20
> Nothing prevents you to enable the SSI driver on any i.MX6 module.

What about i.MX2, 3 and 5 series? Will they still be able to enable
SSI without changing .config file as usual?

> The only change I made is to select the SAI driver instead of the SSI
> driver on i.MX6UL because the i.MX6UL does not have an SSI unit!
>=20
> > And I actually doubt the feasibility of running this driver with
> > i.MX6UL as there might not be an AUDMUX on i.MX6UL since it does
> > not have SSI any more while the driver always touches the address
> > space of AUDMUX which may not exist on i.MX6UL.
> >
> #define this driver

Your change is applied to "SND_SOC_IMX_SGTL5000" whose corresponding
driver is the imx-sgtl5000.c file.

> The FSL_SAI driver does not touch the audmux address space in any way=
=2E

This imx-sgtl5000 driver does access AUDMUX registers. And I thought
you tried to use this one which made me very confused.

> The simple-card audio driver works perfectly well with the FSL_SAI
> driver on i.MX6UL.

It seems like you are using simple-card while letting the other driver
(imx-sgtl5000) select SAI for you. It doesn't sound so right to me.
