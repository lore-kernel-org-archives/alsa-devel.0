From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Thu, 15 Mar 2012 16:24:13 +0000
Message-ID: <20120315162413.GO3138@opensource.wolfsonmicro.com>
References: <4F5FD706.8040209@freescale.com>
	<20120313234638.GY3177@opensource.wolfsonmicro.com>
	<4F6008FA.3040805@freescale.com>
	<20120314122723.GC3133@opensource.wolfsonmicro.com>
	<4F612319.50302@freescale.com>
	<20120315130253.GA6065@S2101-09.ap.freescale.net>
	<4F61F080.4090800@freescale.com>
	<20120315142115.GB6065@S2101-09.ap.freescale.net>
	<CA+7tXig6=gz8utcnV8qUs6=JnwEz8+tqc-57v-xNcYcK_AAHXw@mail.gmail.com>
	<CA+7tXiiJyLAm1ytyqQYgbJ_roUtXwxqhFWKEBk+4jY_HV5V8Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5948226693756794378=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8796710465A
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 17:24:18 +0100 (CET)
In-Reply-To: <CA+7tXiiJyLAm1ytyqQYgbJ_roUtXwxqhFWKEBk+4jY_HV5V8Zg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============5948226693756794378==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qi3SIpffvxS/TM8d"
Content-Disposition: inline


--qi3SIpffvxS/TM8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 15, 2012 at 11:57:52AM -0400, Trent Piepho wrote:

> which caused text window in gmail to become deselected, which caused a
> subsequent enter to send the email rather than creating a new line.

> For esai, would you add something like:
>     esai-controller = <&esai1>;
>     esai-audio-codec = <&sgtl5000_3>;

> That seems rather ugly to me.

None of these examples seem particularly to reflect realistic audio
hardware; they're more describing a board with multiple distinct audio
subsystems on it than a single card.  Remember that nothing at all is
fixed about how the card binding works internally, the card driver is
free to pick any binding that makes sense for the systems it supports.
Shoehorning every possible card into the same binding is definitely a
really bad idea.

> It seems to me in most device bindings where one piece of hardware is
> attached to another, than the one upstream has in its binding a
> phandle to the one downstream.  But here we have a third binding with
> two lists of devices and an implied link between devices in
> corresponding positions in the lists.  Does any other device binding
> work like that?

There's no upstream and downstream here, really.  But like I say none of
this looks like realistic hardware anyway.

*Please* go and read the previous discussions of audio bindings for
SoCs, while it's more understandable with people who haven't been
involved before its still tiresome to have to go back to square one.

--qi3SIpffvxS/TM8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYhenAAoJEBus8iNuMP3dDMMP/3+Ipi2ABHZWoqGyL8A1RPfv
BxWfZC5R/8+eUsBzHKNpnkko516wmlIVKW7B7RM3Kpw2M92Mj7idy7+L55RyPWCS
VlX7OF40cIqrBw3IsfD++HKJZEBQNRiRHMR0zOi8PT5OH7FhOotoivA1uBCZv8pm
63Dw+iS2LRClFhB5+uir4/YuBJtKiUFYBmlFmtFRwXu1fOPVlAoFUb+jnuoKAH+O
k/BzVYPD62GXZmbQovVnyDO3eqivPoEBmws/LUypg7tZo4AZLQ7/wJVYjMSmiIdC
wtn5/ZcJ5yi7P30c9r4eDEemmnJofoxz/Z1pw7t2XJb4br5ayyZ6euwnL5syjMxc
4ARBrGjuaNfNlw9A4YBPx6/hgnzB0jjnw9v6qONtiEdMaOxu7D/r4H7/mPy/g8yJ
T8SjcYx14iebHnDzUJsLG24QR/lWaaBQFT4xCXH24NKfsl7jz5i4buG6ua6+iyxT
rmg5eUWRQhtc4eaG9+3ejfXLLXkbFEddmtPm/mQUaW7NmnO8QDefEOKTwuplu/fN
dTgS+K0CoQwnFvnCQUTIOalX0vh3TgwDV/TO5Wlvqov8S42FAD6E8ZsTubJB2l7e
cms1H1z/ALWdGfZs5upLp16BWlfliJnVHMVsXzweUVoDpKM3lTvlZR1gpgt4sfQa
Ktr/a0k2wH4+UrMcioti
=5zHp
-----END PGP SIGNATURE-----

--qi3SIpffvxS/TM8d--

--===============5948226693756794378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5948226693756794378==--
