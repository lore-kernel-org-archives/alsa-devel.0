From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 17 Apr 2013 15:01:47 +0100
Message-ID: <20130417140147.GM13687@opensource.wolfsonmicro.com>
References: <1364340938-17175-1-git-send-email-swarren@wwwdotorg.org>
 <20130327011511.GP18316@opensource.wolfsonmicro.com>
 <515377AD.9080704@wwwdotorg.org>
 <20130327230730.GA18316@opensource.wolfsonmicro.com>
 <1121E117AD4ECE49880A389A396215BB8718BB370D@rtitmbs7.realtek.com.tw>
 <516DD0D4.5070409@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8201402381011156536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E8B3726164D
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 16:01:48 +0200 (CEST)
In-Reply-To: <516DD0D4.5070409@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============8201402381011156536==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3FyYKcuUbgqNYeqV"
Content-Disposition: inline


--3FyYKcuUbgqNYeqV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2013 at 04:29:40PM -0600, Stephen Warren wrote:

> a) There are many different VDD inputs to the chip. I imagine that some
> of these only need to be enabled/active under certain conditions. For
> example, perhaps the SPKVDD or MICVDD inputs are only required if
> actively using the speakers or microphones, and could be disabled at
> other times? If so, all of these "optional" or "part-time" VDD inputs
> should be represented as regulators, and retrieved/manipulated using
> Linux APIs such as regulator_get(), regulator_enable(), etc.

There's framework support for regulator supplies in ASoC so you just
need to specify the name and the core will do the rest.

> b) Some VDD inputs are optional; for example, either I believe that a
> board should either provide DCVDD, or provide LDO1_IN and assert the
> LDO1_EN input signal. Similarly, I think that either MICVDD should be
> provided, or SPKVDDL be provided, coupled with LDO2_EN register bit
> being set. This may require the RT5640 driver to provide two regulator
> objects (LDO1, LDO2), which the board file or device tree can connect
> back to the DCVDD and MICVDD inputs if appropriate for the board's HW
> configuration. In the case where LDO1 is used, a separate fixed
> regulator with GPIO should be used to control the LDO1_EN GPIO input.

That said if boards generally don't use external supplies and use the
built in regulators then it's probably best to at least have the driver
assume that by default.

> > Bard: You are right. The mic type should be defined according to circuit.
> >           And it should be change in run time.
> >          So, should we just remove this control in codec driver?

> Mark's point is that the driver should either/both accept some platform
> data structure, or parse device tree, to configure the input pins. I
> don't think completely removing all mechanisms to configure this would
> be a good idea, since then how would the board/device-tree author
> configure the CODEC?

Indeed, there definitely should be configuration - however what I was
commenting on there was a user-visible ALSA control which should
definitely go.

--3FyYKcuUbgqNYeqV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbqs8AAoJELSic+t+oim901UP+wdaWznWsJRZmAU2+XuqwU5u
fBaXruqyJDuXzEMOqlME0jgrNcB2PsePjM8eQ3+lGmDIkHV83WYnlp7A1OjNGb/i
tnzdyB5Uc78U3Ka0qOF7W9OykIZSTfIKCbFar7GK+3meFF1TtZqtPHbCrcpND9Py
j4msKKPMeqY2VjGCfhJYXRGwGSe6QibeEkzLetHtm66z1Govw/eAOgvEWNWSSqt+
rGARtFpDfTe4ZqxV4tuqhmDWyFUk2zTYqUvLyKXE0bsG3ZJQhvce/362xS11KNOl
ON5QD8HtdqnfIKGSkdKfwvtqkuqD9v+pGg1mttK/doS8cQpXA8ZRFaXnXLsK4V93
0tLzDhKLK3YTi4UGEuOkPAGh6N8jXI+GKgrXS+8Sd2FG6acURdps9BwP7nPS5TzD
YXdqc50aKW6pAcpAhUywrXSodFfXmgmoUTcB8ZWrGiJ0ftGBb2Vt5ta/vS4Sx+YA
MfzCz/Vh81Zdq/6424lU0on3cMh1k/hUo5lll8giVyIre/J3EhZdu6E4uTs8NuIa
aABRObfWLLNDfXiLuZlygYeGmlBl2XMjdF/kNa/bgMg86QW3BRl/VrSf02R5PqIA
MpSi2cVPo75TkUUubxACYsN1ttVPat6n/TBW/IJ53hF8fUah1JIBqOo2CmgpPfuY
UegN7QHsrjvsnVwKrwtA
=ccrL
-----END PGP SIGNATURE-----

--3FyYKcuUbgqNYeqV--

--===============8201402381011156536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8201402381011156536==--
