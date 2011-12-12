From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [alsa-devel] [PATCH 2/5] ASoC: mxs: add .owner to struct
 snd_soc_card
Date: Mon, 12 Dec 2011 10:10:36 +0100
Message-ID: <20197.50444.333155.552035@ipc1.ka-ro>
References: <cover.1323436034.git.LW@KARO-electronics.de>
	<555be1750dd09586d5eede6457f72310890274b0.1323436034.git.LW@KARO-electronics.de>
	<20111209141203.GH3327@pengutronix.de>
	<20194.7382.414612.182139@ipc1.ka-ro>
	<20111211025358.GB2800@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111211025358.GB2800@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, alsa-devel@alsa-project.org, Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Mark Brown writes:
> On Fri, Dec 09, 2011 at 03:36:06PM +0100, Lothar Wa=C3=9Fmann wrote:
> > Wolfram Sang writes:
>=20
> > > I can't find any other instance setting owner in snd_soc_card?
>=20
> > Then that other uses are most probably faulty too.
>=20
> This needs to be fixed up generally, not just for a specific driver.
>
There are 84 drivers affected by this. I did not check though whether
all of them are compilable as module.
I could provide a patch for all of these, but I can at most do a
compile testing for some of them.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
