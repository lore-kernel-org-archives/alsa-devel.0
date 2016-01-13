From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: fsl: select SND_SOC_FSL_SAI or
 SND_SOC_FSL_SSI depending on SoC type
Date: Wed, 13 Jan 2016 15:02:08 +0100
Message-ID: <20160113150208.408864ea@ipc1.ka-ro>
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
	<1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
	<1452622411-16674-3-git-send-email-LW@KARO-electronics.de>
	<CAOMZO5BifUkzSkPCf08TSQ3B8AHiXuVhBzy+tMsnMtA8t-AvJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5BifUkzSkPCf08TSQ3B8AHiXuVhBzy+tMsnMtA8t-AvJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi,

> On Tue, Jan 12, 2016 at 4:13 PM, Lothar Wa=C3=9Fmann <LW@karo-electro=
nics.de> wrote:
>=20
> > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> > index 14dfdee..c128823 100644
> > --- a/sound/soc/fsl/Kconfig
> > +++ b/sound/soc/fsl/Kconfig
> > @@ -258,7 +258,8 @@ config SND_SOC_IMX_SGTL5000
> >         select SND_SOC_SGTL5000
> >         select SND_SOC_IMX_PCM_DMA
> >         select SND_SOC_IMX_AUDMUX
> > -       select SND_SOC_FSL_SSI
> > +       select SND_SOC_FSL_SAI if SOC_IMX6UL
> > +       select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IM=
X6SX
>=20
> MX6SX has SSI and SAI interfaces.
>
I chose the settings, so that the default behaviour before this patch i=
s
not changed. The other interface can still be enabled by the user.
[Yes, I know this is a case of the frowned-upon use of 'select' with
user-visible symbols, but this is as things currently are]


Lothar Wa=C3=9Fmann
