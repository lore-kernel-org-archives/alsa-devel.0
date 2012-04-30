From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work,
	"Capture Volume" inverted
Date: Mon, 30 Apr 2012 22:43:33 +0100
Message-ID: <20120430214332.GA4414@opensource.wolfsonmicro.com>
References: <1335384469.14096.203.camel@mars>
	<20120426112726.GF3207@opensource.wolfsonmicro.com>
	<1335448142.20000.40.camel@mars>
	<20120426172010.GP3207@opensource.wolfsonmicro.com>
	<1335474693.3628.26.camel@lovely>
	<20120426213745.GA18260@opensource.wolfsonmicro.com>
	<20120430192258.GA15188@local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2456381400202943817=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2587C10419C
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 23:43:36 +0200 (CEST)
In-Reply-To: <20120430192258.GA15188@local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Hans J. Koch" <hjk@hansjkoch.de>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2456381400202943817==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 30, 2012 at 09:40:55PM +0200, Hans J. Koch wrote:
> On Thu, Apr 26, 2012 at 10:37:45PM +0100, Mark Brown wrote:
> > On Thu, Apr 26, 2012 at 11:11:33PM +0200, Christoph Fritz wrote:

> > > ac97_write() doesn't get called when I try to change "Item: Differential Source".

> > Oh, right - you're not actually seeing any attempt to write.  There
> > won't be anything on the bus, then.  Still, why are you identifying the
> > shift there?  The write will be suppresed if the register contents don't
> > change which looks like what you're seeing here - though I can't see
> [...]

> I overlooked that one. What kind of horror show is that? It's definetly wrong
> to make any assumptions about hardware register contents. A low-level write
> function always has to write the given value to the given register. Everything
> else, like suppressing a write because you _think_ a register hasn't changed,
> will sooner or later lead to hard-to-find errors.

> Any performance optimizations have to take place on the highest possible level.

I'm not entirely sure you've looked at the code here...

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPnwdoAAoJEBus8iNuMP3dUf4P/0m6rc5yippg6mymHfcp39HV
kRJiCZiYLvND10E+0Ivckm5E128ykh03tXQLHWywMjhZuM+fo0ICujb/wjfVZhCD
0UEjEwHXercx3eH1QbhTiiy/fydaRbHYQVGx565YYF5zUOIeYVYkfaJM8Rp//a0W
Y9HRuXMl54967oVaLmXygoK9LzVLwW0qK3ds494Ooy24M6a2JKWSKSyumCEs6aBc
Wg58YFMqrZt//mHdnmmQgEsqQ+um6XjsklXVbBGT8Yotr3UtK0IUpxvfB0NFYQRv
mZNMrL48WpJ9x3TGGELXAJGLtouRSHd6M9zXD7uoKbVVGNRQyMsY5MHmwEWitBZ+
yjzacVhCfAjsOz1aqap0AhFmNxl7DO6rCS1oGMpT1qO7hROcVvKB/BPOKxK8NCr5
oblGr5feUj4/NY/i4PIRb08DZ04pul675phwytTJ9ibYqo7YOKnFNa7HOa6ZB3JU
O8VdkUwbP7risyRoQfVI0UtOf3F9k6h7x52Vtidym3b9IqyBIbaacPIxAPUP+b3U
enQmeCGI7x/kNnFm4TCcmEiNQ9ybRyiSn0yI3x4zJfMrfCvttf1Oo2OJxzlh1EG5
QzFGRQjLbl5Bboly/kq3NvMtHhkJujrltBx2Z8dQchL71NbTkqSqGur5zfKjBQq+
p1SDGT8hGW6xYb0+/eRA
=EJQx
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

--===============2456381400202943817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2456381400202943817==--
