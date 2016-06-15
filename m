From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5] ASoC: rockchip: Add machine driver for RK3399 GRU
 Boards
Date: Wed, 15 Jun 2016 10:53:12 +0100
Message-ID: <20160615095312.GY2282@sirena.org.uk>
References: <1465807339-1100-1-git-send-email-zhengxing@rock-chips.com>
 <20160614223810.GA7925@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7292443063779152486=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160614223810.GA7925@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============7292443063779152486==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dpocmoDDGIWqY+Hu"
Content-Disposition: inline


--dpocmoDDGIWqY+Hu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2016 at 05:38:10PM -0500, Rob Herring wrote:
> On Mon, Jun 13, 2016 at 04:42:18PM +0800, Xing Zheng wrote:

> > +sound {
> > +	compatible =3D "rockchip,rk3399-gru-sound";
> > +	rockchip,cpu =3D <&i2s0>;
> > +	rockchip,codec =3D <&max98357a &rt5514 &da7219>;

> These seem fairly standard though a variety of versions in the bindings.=
=20
> Can we use audio-codec and audio-cpu (or cpu or audio-dai) here? Mark?

Well, the roles aren't actually that standard (the fact that there's
multiple CODECs and one CPU DAI here is really odd and definitely needs
a very system specific interpretation).  If they were standard we
already have the simple-card binding that things should be using.
There's no point in standard property names if the interpretation has to
be non-standard.

The vendor specific prefixes are there because all bindings are supposed
to add prefixes to property names.

--dpocmoDDGIWqY+Hu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXYSWHAAoJECTWi3JdVIfQ9xsH/0LglZjC+TOp9zRJ5zl5WQHJ
Mb6skPHTMfidDRflqj9qH/D0JdJGdMsWknkh28OjVC71fTr9yCpKSWzCbgnP3gEY
IjYmz6I7WXXmmKmOVqP+AlOReH167OA1/QJZfOZ0vuWcO+IlYJNTLECE4peeO6Mn
rOCbx1H6Hal1Rk7zIDxiZBlFgcEfepXpuKAQ3lEYZqc0yyb4tSFr4dMHc9Wzux24
jjGz59ZmIUJ+4cbmE7OjYG1VMcj229sxHIy7cxqywh6llh64KhekM1BqX1rL1nv5
XGtP7g2cjd2f5b3Wh0GVNNlypdq8r8V+PbFsz315Ediv06oVu9Z8snIwirchCEQ=
=ajK1
-----END PGP SIGNATURE-----

--dpocmoDDGIWqY+Hu--


--===============7292443063779152486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============7292443063779152486==--
