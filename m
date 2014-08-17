From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: rcar: Use && instead of & for
 boolean expressions
Date: Sun, 17 Aug 2014 09:33:44 -0500
Message-ID: <20140817143344.GL14537@sirena.org.uk>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
 <1408285102-24538-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8829102240434594510=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97DBF2650DA
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:34:02 +0200 (CEST)
In-Reply-To: <1408285102-24538-4-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============8829102240434594510==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hTKW8p8tUZ/8vLMe"
Content-Disposition: inline


--hTKW8p8tUZ/8vLMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 17, 2014 at 04:18:19PM +0200, Lars-Peter Clausen wrote:
> Sparse spits out the following warning:
> 	sound/soc/sh/rcar/gen.c:250:21: warning: dubious: x & !y

Applied, thanks.

--hTKW8p8tUZ/8vLMe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8L1FAAoJELSic+t+oim99gIQAJulLnBoeUCvw3XCs3NY6hIF
mTgRGjw/yc3WC5aMX1FsuWxrYHItXZ6vein1PnuCsw0jmqugCb2uJDPgekTEEUP9
yJQiz2SWNSle5x9Img3T7r6H1kAIvT8RiNBDwhcsvGGYZC+nQlFp4mNEclbP4kW+
VFwAHkfI9kYdGwevlpbYWw/+3e5BsZQp+2iGx+wZ98MbBNzf3EKtCoqKHPK/tYMi
EAvcYKL3rBBIO/IxP8+3NGXQspiI0qMHkCqM39LtXl0sRas7HrSIye1CjI9uDP8Z
7SQqpg9/EMrHbRk+D1qehnP57diWW6wmuRXekZZ5YT6OiiTNjDz7tii9f9gzMUYH
tARR/687wn2IWuPanOakQxsn6FFXNE7llf8hC+RRSOditcBfLtV3jUvEcnaJN/2q
j4byhCMnW3dwn8GVgVVe8lxkhWv1uCZHGtgiJv8jWBFJ1ANO6waRcQl8InZTpV6J
tEGyvwrevqVL3rqnZiS8DzxVOOhrdMeRVClWmuY2kfUVYutSAiEJ9y53AkdnTCea
eHKbB8pSSUz5onuIEl21CO0jPvBbvvnePLvarx3QPwv0++hXZeLUj2jrEq9EkFWc
muRoe8xZk+H+Wer+YqipAVny1Q5Yk0+UYpjN8vOayK3f2ZLjaU6Y6IHIvOoDFQN9
+F3EXJ3E+AwfNX0QLo8f
=xY0o
-----END PGP SIGNATURE-----

--hTKW8p8tUZ/8vLMe--

--===============8829102240434594510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8829102240434594510==--
