From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 06/11] ASoC: davinci: Add support for
 AM33xx SoC Audio
Date: Wed, 18 Sep 2013 19:09:46 +0100
Message-ID: <20130918180946.GF21013@sirena.org.uk>
References: <cover.1379409268.git.jsarha@ti.com>
 <c59efc1524b19f50dc37606bfa246dde9c20d312.1379409268.git.jsarha@ti.com>
 <20130918144723.GU21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2902586541495767404=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C318F2610A4
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 20:09:56 +0200 (CEST)
In-Reply-To: <20130918144723.GU21013@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jsarha@ti.com
Cc: nm@ti.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, joelf@ti.com, gururaja.hebbar@ti.com, detheridge@ti.com
List-Id: alsa-devel@alsa-project.org


--===============2902586541495767404==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz/qo3iW6Lu5yGf1"
Content-Disposition: inline


--rz/qo3iW6Lu5yGf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2013 at 03:47:23PM +0100, Mark Brown wrote:
> On Tue, Sep 17, 2013 at 12:26:05PM +0300, jsarha@ti.com wrote:
> > From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
> >=20
> > AM33xx uses same McASP IP as the Davinci Platform. This patch updates
> > Kconfig and makefile to enable build for McASP, PCM & Codec drivers.
>=20
> Applied, thanks.

Dropped since this breaks x86 builds due to dma_alloc_writecombine() not
being defined (our DMA APIs really aren't wonderful...).

--rz/qo3iW6Lu5yGf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOexnAAoJELSic+t+oim9ADEP/05AQsoBIhWO9krViYbO0ibx
SlpiFrzFa9DAW5h7xbrXbL+MO1YURo+Fzf18x04tipg8PplnPYn/guqlH1SGSxCM
Y6XXKtTfTwut4yPjq1dNfBrtbq3Hh/C+939lUR7BIVDYMdP3iD3Hiib/8PDQM6Ue
CXtXxXJkPcZxN4kCRBqxo3dE8R+f7sgcY8tqQRXq1ssYZl1mSu/oBo4bMKZ4CEPi
CNLqh1qgtMlr2bA2eekN73dracKAjwimdznB4JRCsJwCza5uM2zO67JLvXWI4+8m
oEQylVTbTCJza07Z9DhVP9Rj0Qjax/HbGCSzjsQInV0xs8Wvw6z52epBbIOvgKmT
YwnX2ggj2FRQMw+I23+jIbv7smTIjy/K1ScZmFY5uylJe7i3bR7ZsmH/NkCAsfPu
M/wzxrj0oCIy8tzaIMBZoGQWs/YeJ1f/89z5pmGbh/RJv/l03ADr3MexsHxNlyy3
ZAagw6VUcL4BmWW+eMAzggGztjQMuYLrviir22++FJqqef4gf7IFZo+Tl8eyV9kb
TM1q/Ad/rcuB7vSJ8I+KbmLbin/4SwcKUAxwqnhiTl285bTo7J0n60HiLBSqfiic
kyYgt2sxsDtrETVOZ/3gWQzKL7fAHkPi8lLiouhVRGThbpUBWDdEiYwXPL7jqXkv
xbddTS3XLePyJHG444dE
=bdJE
-----END PGP SIGNATURE-----

--rz/qo3iW6Lu5yGf1--

--===============2902586541495767404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2902586541495767404==--
