From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/16] ASoC: core: Add multi reg control
	struct & macros
Date: Thu, 22 Mar 2012 15:56:43 +0000
Message-ID: <20120322155643.GJ3091@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<20120313213859.GG3177@opensource.wolfsonmicro.com>
	<4F69C493.7070109@stericsson.com>
	<20120321124029.GD3226@opensource.wolfsonmicro.com>
	<4F6B4970.3080003@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6258240285999601472=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1EA0E103F03
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 16:56:46 +0100 (CET)
In-Reply-To: <4F6B4970.3080003@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============6258240285999601472==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXxEqdD4tcVTjWte"
Content-Disposition: inline


--AXxEqdD4tcVTjWte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 22, 2012 at 04:46:56PM +0100, Kristoffer KARLSSON wrote:
> On 2012-03-21 13:40, Mark Brown wrote:

> > This makes no sense - how do the vales "span four 8-bit registers" while
> > using only two register addresses?

> Every write to register 0x5A copies the written data to the correct active
> internal chunk of bits of the composite (which after chip boot up is the upper
> bit parts of the complete 32-bit parameter) then it automatically (as part of
> the write operation) toggles an internal shift pointer inside the chip that

This *really* isn't what the control you provided describes and is going
to break when people try to do things like readback.  The hardware
design here is sufficiently "creative" that I think the best thing is to
just code it in the driver, ideally doing something more direct which
makes it clear that you've got this shifting going on.

--AXxEqdD4tcVTjWte
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPa0uwAAoJEBus8iNuMP3dkNsP/i8dUN3N7PEhKKrxze/JljhN
nLVdsWZQ0HMh9Fkrno08CgD+6ANRtBrxwq8/UKInQhEHeyzH5yuFxVZf0Dqaf2M1
rMa+3uJXXruhkpZrkiiszcnpmJK7RSRsPY+hGVe1rpJ4ZOLN4bT4xom7Rrr1rIft
0C2lHwIr8KZXjRLy17Km6jUHclm06h13x9V6iO9Qv9VQYZFN/ge3nh4F052HpKV/
S9OJk08pzSkp172DVygcsAJZ2fqfQdNcldHT6KllcB5ZteDR0RVthUebiIY1ovxG
N1LCNUJQ6agZOM9GnqQBfOv0lHYGAMwkJMDLIgARdXzvj5Yf3CL2wNEp+cqnOatx
FWPnvFUXYUefLpiz+wnIye0N24EcLtizvuD1F3ZA0+qmqdlR9Mgvvu6+AmPewnSM
UFYcz6GowMTpvw48HClC5qUsmMmAlJq5JdVWk2PszKfBWaQftg22m7+d+XnI42/x
4MgucMKgdygzFFc7Iv8rclj+CH/VIpmypPnQndu5DnkC6rI7ZAAuIhXKumXNmDtC
YSZc96RFvx8ivxz2BHY1t3zSzWFW6r/6CwldJRb0yYtKjosQgvVwGC+9Q0s67wmG
mcR3lKPBGm/1UcwEHL8y6w4iqyKCgsLYgvTpIhgZu/K+orxTMBGi3aSUA6C5W9HA
UgnHC5e5bneJCKMp0imv
=tg9m
-----END PGP SIGNATURE-----

--AXxEqdD4tcVTjWte--

--===============6258240285999601472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6258240285999601472==--
