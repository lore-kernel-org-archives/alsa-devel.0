From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: TI codecs and their crazy variable length
	registers
Date: Thu, 31 Jul 2014 00:17:56 +0100
Message-ID: <20140730231756.GE17528@sirena.org.uk>
References: <CAKON4OyCqvjLq09+WymcSKRwfLJrSBoLMRWksNO2hKrtR3u3vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7139327320808537327=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 727302615F3
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 01:18:12 +0200 (CEST)
In-Reply-To: <CAKON4OyCqvjLq09+WymcSKRwfLJrSBoLMRWksNO2hKrtR3u3vw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7139327320808537327==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OIgYXu83Vzyiobw6"
Content-Disposition: inline


--OIgYXu83Vzyiobw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2014 at 05:56:36PM -0400, jonsmirl@gmail.com wrote:

> I'm working on a TI codec attached via I2C.  Just to make things
> interesting the registers have varying byte lengths of - 1,4,8,12,20
> bytes. What's the best strategy for using regmap with it?

I'd use the reg_read() and reg_write() callbacks to hide the registers
that will fit in an integer, the rest of the stack can pretend they've
got 32 bit values which should improve code reuse.  The larger registers
are going to need custom controls I expect but that's probably a given
anyway, and if they're coefficeints they'll be fairly simple binary
controls. =20

It should be possible to write a standard ASoC control type for binary
blocks that can be written with a single I2C transfer...

> Also, does regmap restore MMIO registers after a suspend? Allwinner
> has code in their drivers for drivers for saving/restoring the DAI
> registers over a suspend.

It can be used to do that, same as anything else you need to a cache
sync.  The Tegra audio drivers do this - that's why regmap-mmio was
originally written.

--OIgYXu83Vzyiobw6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2X0hAAoJELSic+t+oim9lQMP/2uYOjFY5G4YjlPkiyueeqOu
6EP14/efCTO30JqUOEH4NTW0lF1svms1ibgDt0n37gmg6AmikRYtOH5VfqOf0Ink
4AFLqf1IYx7kBapciXU/wUUBJFmNCGZBBdFtEt+FovZ56Y2I3RKYN3WsZIML1snO
tLvUpri2X8ZEQ8wJgVS1oKn0GrG7SeFDKQdPX3y/imyGVgh2OIpHDEw0R2EZlJI2
G99jYX4KSLesVMppvxgBh51LyACn8CrRlhE+6N+R/K2dkRdKDACKfGeQRFN8a+me
eMW8mTxNItjyzVkrTAGjSh72ahe232qnwf79Y23YpNjgV9onOc8ReFdHAvRZQmOD
PCyYi21CW+COuth3WAUH1L2y2vLZiNY5JUcOoD2oA0LKtfg48eAkNNdyg0F3ztj0
ODYfcoSp8IFyO4ZYW+gv3oIX6iMJJUm2KB8Pmq7ir3yEJAwHcg9F3A8Q7nfd+iy0
QaoP8GhFie0bcLzdCfAKJY5hVfxS2OBtjC2477lp9s6cmbf9uLjzv+e2xfK83weN
LyUrncsb1AcrLWTs1rFuPejMUxyvOm+xttrC7d5u3VDKLldD5V8OoGl7IgDdwvqy
PnRMppZW3hCyhyfEZOLjlbTyLUrRfycN+l4316nFZs3XXrBLfueiWpD/4qiC0lvp
3UJBJCtxH/ZtQIIE4IKJ
=5HDp
-----END PGP SIGNATURE-----

--OIgYXu83Vzyiobw6--

--===============7139327320808537327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7139327320808537327==--
