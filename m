From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH] ASoC: mxs-saif: export
 mxs_saif_put_mclk,mxs_saif_get_mclk
Date: Mon, 26 Nov 2012 09:49:50 +0100
Message-ID: <20659.11566.624414.569253@ipc1.ka-ro>
References: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
	<1353587470-11994-4-git-send-email-LW@KARO-electronics.de>
	<20121123020635.GK4385@opensource.wolfsonmicro.com>
	<20655.9202.288388.343758@ipc1.ka-ro>
	<20121123144541.GT4529@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121123144541.GT4529@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

Mark Brown writes:
> On Fri, Nov 23, 2012 at 08:21:22AM +0100, Lothar Wa=C3=9Fmann wrote:
> > > On Thu, Nov 22, 2012 at 01:31:09PM +0100, Lothar Wa=C3=9Fmann wro=
te:
>=20
> > > Why?
>=20
> > I thought that was obvious... To be able to compile the mxs sound
> > driver as module.
>=20
> Do you want to add new users of these functions, or are there existin=
g
> users which currently fail to link when built as modules?
>
The existing MXS sound driver fails to build as module
(CONFIG_SND_SOC_MXS_SGTL5000=3Dm) without this patch.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
