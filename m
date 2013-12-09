From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: tlv320aic3x: no mono controls
	3007 model
Date: Mon, 9 Dec 2013 18:00:54 +0000
Message-ID: <20131209180054.GO29268@sirena.org.uk>
References: <1386233642-24412-1-git-send-email-j.weitzel@phytec.de>
 <1386233642-24412-2-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1392007064782650399=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B29BA261A0D
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 19:00:59 +0100 (CET)
In-Reply-To: <1386233642-24412-2-git-send-email-j.weitzel@phytec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1392007064782650399==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="No+p7QntJvZK+Tqp"
Content-Disposition: inline


--No+p7QntJvZK+Tqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2013 at 09:54:02AM +0100, Jan Weitzel wrote:
> if codec driver is used for AIC3X_MODEL_3007 the mono iout controls overwrite
> registers for class-d amplifier.
> classd amplifier controls are only used for AIC3X_MODEL_3007.

Applied, thanks.

--No+p7QntJvZK+Tqp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpgVTAAoJELSic+t+oim9uhYP/RuJY1xYBvUumuSC1ZzTOon5
8mM69hUA1ol+J2QlR5p1hAXDs+lHXMFeCiJzNVqc7vSA+TFM2A1nrjsyotoShpkA
97fLJKXJUUpTbCr4mJ5pxawaYIgd/yaZV32wiwgdGGZn8InjE+Ml9TvcPWQOW0Bq
87LDQhY+uTmaVc5nB14/GPJRo9dg/LMHGA2cCFLHizx/mIrXRZQrqAVjdBfzMi7Z
umK51v1tngfe1EC53yZGFG7QEJ/Es/tKPUi2zzVup6nHL+EhNpSlgTRg5bQ9CUTZ
WBQy4SHIiQhBVItzy7zYao/qGGKQVueXSC4tPrE96C/vLNbbj9ZuQ3ukCu4JY6k2
oTrDkhwV/drOXSf/92VDMoplMv41HvLApQlre6jS9iU7Ewyf1oAXbR/uYOobDPtk
4JNUvk3DVoYHO1ujKoFMPOson7Nl15GiTVd+W97whL5dPNt6GX8pPYEJ2ueQjKzG
qPQpzM+Rd7JdZRRuJAqmienIiRvSuf5vXyZvWxrckjyZ2ZZepiUGcZPw3Ani0T6+
jDSbkfksWoxWI4lmRGZ/dYtZ4xo86CsSAlJHcfYpw8ItPNVqLPve9b8BxSMJ4pbW
KWdVpOjqc6GQ80IUVhJrnkU6+gr4F72+jcGoRhhMDlO6gFssS7mXDFJ43wW1YT9V
c3yq+C6OTQAHnae4TdOL
=Z3ae
-----END PGP SIGNATURE-----

--No+p7QntJvZK+Tqp--

--===============1392007064782650399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1392007064782650399==--
