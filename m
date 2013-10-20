From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: kirkwood: fix loss of external clock at
 probe time
Date: Sun, 20 Oct 2013 17:33:26 +0100
Message-ID: <20131020163326.GN2443@sirena.org.uk>
References: <20131018203555.4d974251@armhf>
 <20131018191259.GF10079@pengutronix.de>
 <20131019102809.180dc4ff@armhf>
 <20131020080333.GG10079@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6411236333935572787=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131020080333.GG10079@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6411236333935572787==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IW2h5r2J1WQ8moYU"
Content-Disposition: inline


--IW2h5r2J1WQ8moYU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2013 at 10:03:33AM +0200, Uwe Kleine-K=F6nig wrote:

> Yes, that's understood. My suggestion behaves as your's for the return
> values -EPROBE_DEFER and -ENOENT, so the deferred probe should work,
> too. The question is only what you want to do for other errors (don't
> know if they can happen at this stage). I'd say, on a dt parsing error
> bail out, too.

It seems like the best thing to do is defer if the error might resolve
itself but otherwise carry on with the reduced functionality from the
internal clocks.  I'd expect most errors to be permanently fatal though,
certainly a failure to parse the DT is unlikely to get fixed at runtime.

--IW2h5r2J1WQ8moYU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZAXTAAoJELSic+t+oim9yzoQAI1ZS4eQ2b2aV7NeJ7aiuhGB
H9kftQzOzIuZCCWGHBIgaasVw/DWSNZeYuG1i1Pa2sZsn8bRFdbu86RSnsLOWMSo
FnWz/WHMlL8kp1KXT8lkAFU5sIBIsp/98lM6FYRMmfBHlTkOZpAsSI45ES8hs7sD
0ralGH+guGzmbOFHokxEOp1oejAq08oV0Q/JYzESwtpi0C3DkQ6sI5tgK2/K4Cyy
AfASou5nPdeUvfJQDUJaH8Q+KuWWIyQQxreC4mOE1M7//8MGFe0mePrawVLQjuge
QQzZZxGn8ZH8tspIKr05cO25kre0AmlMMMRtd+i2+FF69IxEF+0GzeRFqXbc9N9Q
rR8DKXwtDo+QbHiQLmwPyXnxo7I/MSXojfHhzjwwXMa68wwxd8VcZ73ZfPeO15Ow
WvZOJMrldd44zEFSaRwP6Qj1X6SZQNgX9l4oOrPZgnO0WRv0ZXFGzW3WF4AtZbn6
Nbd5mrEDsJo8IxbX9UspES8Mzo+KI4ng3ujMiv2LgNo7ktqzRYSPWTZqmoHGl18X
AOZBpgur2Y49sGVWVRoDD+/vdu4kFsuT81BqkbAt2bVz5X8TAfkvbQB6behlRxoQ
pH/YSJ+CrZmh/Vni0fJtTSv5QdlJ1ZrRR9CFysoECjbRLII32KnI9nNFY2PbmjGF
I0l+V2jR3oqPsNCy7oyv
=FUnl
-----END PGP SIGNATURE-----

--IW2h5r2J1WQ8moYU--


--===============6411236333935572787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6411236333935572787==--
