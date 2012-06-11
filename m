From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: codecs: Add DA732x codec driver
Date: Mon, 11 Jun 2012 17:01:55 +0800
Message-ID: <20120611090152.GD11439@opensource.wolfsonmicro.com>
References: <201206110813.q5B8DvXq020445@sw-eng-lt-apt-vm1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0754592351965878418=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B8FC61041FC
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 11:02:12 +0200 (CEST)
In-Reply-To: <201206110813.q5B8DvXq020445@sw-eng-lt-apt-vm1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson@diasemi.com>
Cc: alsa-devel@alsa-project.org, Michal Hajduk <Michal.Hajduk@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============0754592351965878418==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Content-Disposition: inline


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2012 at 09:12:22AM +0100, Adam Thomson wrote:
> On Wed, Jun 11, 2012 at 05:41AM, Mark Brown wrote:

> > This doesn't apply, please always submit new code against current
> > development code for the subsystem.  You've also got something else
> > wrong with your setup, the Date: header for your mail is "Date: $(date
> > -R)" which is upsetting the tools.

> Apologies. Was using linux-next as my base code. Will re-send changes
> against your ASoC repository. Assume it should be against the 'for-next'
> head?

ASoC should be the same in both, my for-next is what turns up in -next.
The change would get applied on for-3.6.

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1bP3AAoJEBus8iNuMP3dIcUP/01c8GXwpC7EyxHqh4ucC2y3
PvEeukGr/hzJRgkJLkRJXewdyWsgWsEAuJHSIWcQeBBslsXs9PtsDrbPyzwQPYyp
Z3ARYRFRGLonCoiF+3j1OoxjpxUeFhW4KJPsenRMi1NMBw7WKwVa+qUddAB9Z6pg
KLUtbqY+PbHBOfw6SqkrhdnaeO3Yh3iXNTAUE5j3hq5Gh5E2jG3JMmOVIhbd5Uqt
dASpWFA36MHZAFUCjY6A1R59eMwrVTmA7bh7Gu8TqK4A4vG2QXlAF+udeFEH+MYu
FE1qU3kLE+u/tYNeA+G79TU6g4uzq9mQn76iEMQAP8sD7dJ0LPxEoJXsT+OgXism
HWxhsjH0Uv9HqabpCCapLYjxeeq/qGS3BazPPbkw0PGeyKqDbjlTU+MZdt1I0c0Q
4+TInpzZYymK52+bLt4ZiOvBJGlTHXGrsMobwPDdQonw9bdxsE9JWcNVYWPgmXhA
btKKBoZO6Ap8ESe06jtDKY4Tt5tUhxP8HFHT8mQMWFsxAIdjaAsQ5SssGXE0pWHu
ndKPk4v5nf/tckoATo5P3l8C+JOOo8i5HcdHl3w8PdFGzAtsUP0wqzuc7xRpm6UR
LKaF7OlGmzZ0koCglz6vYFzyNEMh3oG7kGTjAwUvXSXxW0O+i/xJDG7Qvmf+H+kG
/DfQK1s8s8m5jeLKHeGB
=K4Ag
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--

--===============0754592351965878418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0754592351965878418==--
