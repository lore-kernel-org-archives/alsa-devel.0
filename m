From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-sgtl5000: make audmux optional for
 imx sound driver
Date: Wed, 13 Jan 2016 12:11:35 +0100
Message-ID: <20160113121135.5c18f4ee@ipc1.ka-ro>
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
	<1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
	<20160112182253.GD6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160112182253.GD6588@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi,

> On Tue, Jan 12, 2016 at 07:13:30PM +0100, Lothar Wa=C3=9Fmann wrote:
>=20
> > i.MX6UL does not have the audio multiplexer (AUDMUX) like e.g. i.MX=
6Q,
> > but apart from that can use the same audio driver. Make audmux
> > optional for the imx-sgtl5000 driver, so it can be used on i.MX6UL
> > too. Also i.MX6UL requires use of the SAI interface rather than SSI=
=2E
>=20
> If it doesn't have the audmux can you use simple-card?
>
I'll have a look at it. Thanks for the hint.


Lothar Wa=C3=9Fmann
