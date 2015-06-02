From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/6] ASoC: zx: add zx296702 hdmi codec
Date: Tue, 2 Jun 2015 19:13:26 +0100
Message-ID: <20150602181326.GB14071@sirena.org.uk>
References: <CABymUCNvM=k4tWJutpzoK-VFvKhBC4EGjh_OzWYMMRppUqvSOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6489624969728516948=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B78A32652CE
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 20:13:36 +0200 (CEST)
In-Reply-To: <CABymUCNvM=k4tWJutpzoK-VFvKhBC4EGjh_OzWYMMRppUqvSOA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============6489624969728516948==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2vfFyZRy2guiefOI"
Content-Disposition: inline


--2vfFyZRy2guiefOI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2015 at 09:42:34AM +0800, Jun Nie wrote:

> So I need implement dai link in machine audio card driver, while not
> use simple card and device tree initialization. In this way, I surely
> can embed HDMI audio codec in HDMI driver. Is that right?

I'm sorry, I don't entirely follow what you're saying here.

> I had try to initialize audio all from dts, so need a HDMI codec dt
> node to connect with DAI. However, I cannot find a way to create an
> independent HDMI CODEC dt node because it is brought up from HDMI
> driver. If my above understanding is correct, a machine level DAI link
> shall resolve this issue with dropping simple card and DAI link in
> dts. Thanks for your comments!

If the HDMI encoder is simple I'd expect it to be possible to use it
with simple-card.  If it isn't then we can look at why.

> BTW: HDMI driver is far from mature, so you did not see HDMI function
> implementation in this patch serial.

Sure, no problem.

--2vfFyZRy2guiefOI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbfJGAAoJECTWi3JdVIfQaRcH/0FOck7LcqQpBRJ8SpEsqyUd
NQORMyaujcBH2OXDpE90tVPMZxDIdl885QQw/p1mhTCFgEk3lC18QwgnNnkkx/a2
dFdwLA/jnZIwWq8C8iIkmW/5Ln+3raG4w7tOpQg+rTfYjvGj37KPrVLybqoUmW38
xAdw0HO1/t92ToPXMn8nYBS4rZv++fa/gv4ksnpDMAu/a7Us4UVQUIydqmZhYkZk
iLO4bfbS+mEbN2wVk1j/Vu4gSe+cNDBp1ld3SSrBqGQ/eDEanKYwUeZlYxu0qYjP
/qRrBql9EonLOLxVxP/IqUdYe/E4OAdQChRYGWXD5mW5uJD4VjdX1EjDtlwRu/E=
=Kudx
-----END PGP SIGNATURE-----

--2vfFyZRy2guiefOI--

--===============6489624969728516948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6489624969728516948==--
