From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 06/11] ASoC: kirkwood: Don't set unused
 struct snd_pcm_hardware fields
Date: Thu, 9 Jan 2014 14:28:37 +0000
Message-ID: <20140109142837.GY31886@sirena.org.uk>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
 <1389014356-7014-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4378030041507426855=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A03AE261AED
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 15:28:43 +0100 (CET)
In-Reply-To: <1389014356-7014-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4378030041507426855==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1EgYJI7ea8iVjnU2"
Content-Disposition: inline


--1EgYJI7ea8iVjnU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 02:19:11PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--1EgYJI7ea8iVjnU2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzrISAAoJELSic+t+oim9XGQP/29xbcQjtEw2ruI0ffmvc4LP
wXSf/O7Im9tckhufZ2G898yIT4HkDtvDHRHvH71dy0tLVwTRHMaxUorqKMf5HXx1
BZKdyW8zIH8SL7XtOMS+/n7lUnOHhbHpFXZ0IXY3fvmhswAfK3D7ohqC4saHQ05M
dDmSAdyoiTyLB8QT5ZFN3l9JjzTXWfO3oeZtyC/O5f99uT8fZe0oAQl5bt4RhZgW
waLSTwqcopNS0/6GYPve+zeQ1ZU6C0ij1/DcYdKlgbwVP7k3p/6sCutOSXGBr0nq
9KdG+SHfh9MY5Kg6+vsDeweVle07m8a5wPYsKfVEi6fhi3G54OMusGtmgHLMIjG9
Ohon0hbRGbgPx5p64RZgBBAoV4dK35z1qWvuY7gxvD+RLWLp9raRKH1FI4xUoNNp
METHVw9lbPpU7bX04Ls6Tmo5MnopD8G3SKCByzynWbdI+IpAq0X+6zip4Zz1keff
oCTJh8VAx1T+40eQdC0Re19cUrtE0Gt4SNdr3qGXSjSyoP5jarepD7QqUlIycUjN
h0YlMfdm/HscL19tnqtYOkxi6yawPpi3vMQdoFHXr+V7oe5+o71Ht3hJBY7QXb01
fH0uTyDvF16rJLD4O0r0TJgNlj5Cr5eGVVO9NSNW/K0h0xvHRSGsAPV4TiY6YRgo
FLvT9LF5b8MxGH5kB8oT
=rpJR
-----END PGP SIGNATURE-----

--1EgYJI7ea8iVjnU2--

--===============4378030041507426855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4378030041507426855==--
