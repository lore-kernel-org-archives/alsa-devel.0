From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] [PATCH 0/6] ASoC/MFD: twl6040: PLL handling changes
Date: Wed, 6 Jul 2011 08:47:25 +0300
Message-ID: <1413350.0mreIEaYWF@barack>
References: <1309773958-14608-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309773958-14608-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Samuel,

On Monday 04 July 2011 12:05:52 Ujfalusi, Peter wrote:
> Hello,
>=20
> The following series depends on the v6 of twl6040 MFD series.
>=20
> The aim is to simplify the PLL handling for twl6040:
> - Move the PLL selection control to the codec driver from machine dri=
ver
> - Sample rate constraint simplification for selected PLL
> - Avoid multiple, duplicated PLL configuration, which can slow down t=
he
> audio startup.
> - Harmonize the PLL ID usage among the drivers, so we avoid redundanc=
y.
>=20
> I have generated this series on top of l-o/devel-cleanup branch + my
> previous twl6040 MFD/Input/ASoC v6 series, since it depends on the ch=
anges
> introduced there.
> Is it OK, if Tony will be taking this as well to avoid cross tree mer=
ge
> issues? I can put the series on top of my previous series, and offer =
Tony a
> pull link.

would you be able to check patch 5 in this series?

Thank you,
P=E9ter

>=20
> Regards,
> Peter
>=20
> ---
> Peter Ujfalusi (6):
>   ASoC: twl6040: Use neutral name for power mode text/enum
>   ASoC: twl6040: Move PLL selection to codec driver
>   ASoC: twl6040: Simplify sample rate constraint handling
>   ASoC: twl6040: Configure PLL only once
>   MFD: twl6040: Remove enum for PLL tracking
>   ASoC: twl6040: No need to convert the PLL ID
>=20
>  drivers/mfd/twl6040-core.c  |   26 +++---
>  include/linux/mfd/twl6040.h |   17 ++---
>  sound/soc/codecs/twl6040.c  |  182
> ++++++++++++++++++++++--------------------- sound/soc/codecs/twl6040.=
h  | =20
>  1 +
>  sound/soc/omap/sdp4430.c    |   47 +----------
>  5 files changed, 118 insertions(+), 155 deletions(-)
