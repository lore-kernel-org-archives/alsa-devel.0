From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_FSL_SAI or SND_SOC_FSL_SSI
 depending on SoC type
Date: Fri, 29 Jan 2016 06:51:33 +0100
Message-ID: <20160129065133.7338cf2c@ipc1.ka-ro>
References: <1453293038-16032-1-git-send-email-LW@KARO-electronics.de>
	<20160128223352.GB4130@sirena.org.uk>
	<20160128230846.GA32388@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160128230846.GA32388@Asurada-Nvidia>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, 28 Jan 2016 15:08:47 -0800 Nicolin Chen wrote:
> On Thu, Jan 28, 2016 at 11:33:52PM +0100, Mark Brown wrote:
> > On Wed, Jan 20, 2016 at 01:30:38PM +0100, Lothar Wa=C3=9Fmann wrote=
:
> >=20
> > > -	select SND_SOC_FSL_SSI
> > > +	select SND_SOC_FSL_SAI if SOC_IMX6UL
> > > +	select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IMX6SX
> >=20
> > Does this card not work for older i.MXs (which had the same SSI/AUD=
MUX
> > combination as the majority of the i.MX6 family) as well?
>=20
> It's widely used in older i.MXs according to their DTS files. So
> it should be safer to just leave SSI over here.
>=20
Nothing prevents you to enable the SSI driver on any i.MX6 module.
The only change I made is to select the SAI driver instead of the SSI
driver on i.MX6UL because the i.MX6UL does not have an SSI unit!

> And I actually doubt the feasibility of running this driver with
> i.MX6UL as there might not be an AUDMUX on i.MX6UL since it does
> not have SSI any more while the driver always touches the address
> space of AUDMUX which may not exist on i.MX6UL.
>
#define this driver
The FSL_SAI driver does not touch the audmux address space in any way.
The simple-card audio driver works perfectly well with the FSL_SAI
driver on i.MX6UL.


Lothar Wa=C3=9Fmann
