From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/8] ASoC: simple-card: simplify code
Date: Wed, 22 Jan 2014 19:04:30 +0000
Message-ID: <20140122190430.GU17314@sirena.org.uk>
References: <20140115113551.0eb13409@armhf>
 <20140115165133.507595c9@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8438313857225468630=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FABB261A7B
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 20:04:38 +0100 (CET)
In-Reply-To: <20140115165133.507595c9@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8438313857225468630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l2vDcU+jBoWlRij1"
Content-Disposition: inline


--l2vDcU+jBoWlRij1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2014 at 04:51:33PM +0100, Jean-Francois Moine wrote:

> The check of the mandatory fields is done for DT in its specific sequence.
> Move the global check to the non-DT sequence.

Applied, thanks.

--l2vDcU+jBoWlRij1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4BY7AAoJELSic+t+oim9I20QAJA2R3yahk4plEkY/Rg/It6i
iQM8Fg8N8dsm7/T9twTt5X0n68XcGMsAndHXI463Xu0RQ9XItF01tbtIAJv5VH4L
mxwchj8UEa2EUM0YhsmKx7Je9E5UTQMixi5xrLLH3vzsqBzOR1ybZHyX9WeTuAxj
9W5UK1zHeHoYTN0iZZm5TiBOZWqvD/LabktD+Y91I71a9+Bys3u9SFLaMpMhDpXq
iniRZzHpaX7mB78IQ0G/afOFX0CqAwV5wVOZyuWJqvRtihuja+kugxZiK2BKaV6n
H+3h0L7Ev5oIz40ZLyRp7FR6nUL8a4aFFhs1xBKDVEKC79+mRYgIoLcS+RTlYanG
u+JEnk0mT3yfP8EbRh+mh1AAkvG0qRpwlBgCSQINZwVM7vjaBIuV5URVNUkZYoAb
dC/8Wcc7Mw7ZP2VYaDANT+StpEcwsBGsitI0am02xU+OzY72hNici/S4PkPoFimR
NsdyH3HWJ7waHSh8/WTAiYRjgLPh3uwuimZJ4TRGqN4Zjf5HM5tue+LgiB9diMMn
fVLp82Mqj+L/XWha9xULxmfFXdT5ATJa16nGNEo39VUPIvgZuWcj+STUqycNv/Fp
W13zWGvmOBhAj6xO1NV6Z3ffykSQ6dc0XG1NO88teOzLX96Zcr7VtSTCVf/dndc7
x/J47J7Z/nVPRNcW8KPt
=sxni
-----END PGP SIGNATURE-----

--l2vDcU+jBoWlRij1--

--===============8438313857225468630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8438313857225468630==--
