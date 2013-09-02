From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/14] ASoC: kirkwood-dma: remove
	IEC958_SUBFRAME formats
Date: Mon, 2 Sep 2013 12:02:02 +0100
Message-ID: <20130902110202.GO3084@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkWe-0003Iw-UI@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4176218667194974602=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AB1E6265138
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 13:02:09 +0200 (CEST)
In-Reply-To: <E1VFkWe-0003Iw-UI@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4176218667194974602==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o41d8xLWOaLD8vYh"
Content-Disposition: inline


--o41d8xLWOaLD8vYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 31, 2013 at 01:43:36PM +0100, Russell King wrote:
> The Audio block does not support IEC958 subframes as formatted by
> ALSA: they're very close, but not close enough.  The formats differ

Applied, thanks.

--o41d8xLWOaLD8vYh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJHAnAAoJELSic+t+oim9ELEQAJczr/yIjZV7J+po71/bpYFD
gpphfeuPlyvJn6JwILnoSbLQHBH6OyBFg7POOEE9tUftHItuNdwdXaVUBzY91jij
WAlwHEM2T1mvurMY3k0VOcLlDcBVAqG2emmzh7HwwQlFKLaVUSvIROu876Zd9CJK
bQWjAo5h05E2ZAN+BFEe6pNLQkEozVavqMDYqX8YdAqKyCTz8Y5z6+U9UxQhQsBj
dDuzLPTGEbD4OyNQgqjFqvE4RcTjIzek57Yz3NBPZ8lQsApv/NL8EwNXKuxDEDJO
/9EURLM44hgRv9E1Sgnhnob67HadKcvPCs6WxoJuqcxiQoo+/11m5QHMzMvmhh/P
HtYnl8RLkbRxmrJDv8XYFFPrkV3RjvHaDfFEXG9LPTWmkEmMvxnJM9ltSNNx/AuB
5K+TvnOIM7+ERTaXC5i+9Rpb5M2dheOMWy1RHWpR9Au4QTiHpYgVnu9U9tyQ72u3
FCFqmN5BkJp1s8wBUJkjh5Ix3gO0gQ+9QGQh5L21HrAFmT0+zj38uD8MnIk4PlkW
IW9XSfM+1N6J8zReAt5KtOVeT1TanhPTnDChXMTIHi9Ja5Zf0QwTP6QuQQFxZPXR
mmU5334Y6T4U6+E8euAMYzhkJlYL5DBR5st17YlQ9lC7xRuRC31ZHQkflhhUmgfF
Vny+exQLO1jCSvhWoyyV
=BAS7
-----END PGP SIGNATURE-----

--o41d8xLWOaLD8vYh--

--===============4176218667194974602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4176218667194974602==--
