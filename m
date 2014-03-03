From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] ASoC: pxa: mioa701_wm9713: Convert to
 table based DAPM setup
Date: Mon, 3 Mar 2014 11:01:17 +0900
Message-ID: <20140303020116.GP2411@sirena.org.uk>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
 <1393685300-5307-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3472661011973067832=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EDB0265532
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 04:35:42 +0100 (CET)
In-Reply-To: <1393685300-5307-6-git-send-email-lars@metafoo.de>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3472661011973067832==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HrsILUyxNtiOryfc"
Content-Disposition: inline


--HrsILUyxNtiOryfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 03:48:18PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the DAPM widgets and routes. This on one hand
> makes the code a bit cleaner and on the other hand the board level DAPM elements
> get registered in the card's DAPM context rather than in the CODEC's DAPM
> context.

This doesn't apply, please check and resend.

--HrsILUyxNtiOryfc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE+JpAAoJELSic+t+oim9CEwP/161/X8I59TK+p4BjRC09Bnb
YxJSmo0cLq0gZgWKFDjOAkjHBoCyTVUDka/hRG+BaeGhwCM7McSfLz//FJbUl3J0
RLn6Qex8gE5vU0LbYEg4CuzGKCazDC4eSilgMWeGf9ssdi2YvwZskZpaoNMJsVkV
uPQCsv9yJpoXSuDWCc34B91L5a4MMYW7KetLc9YfE/9cbraM5geQ3J7qzVWKJoyG
7IrCn+pw9bUjxyrlhRUtUH+V1OGJ/vNe+UgAbhTtxapfAIvF3LXrQ+/+G7iPICYf
LysZiix+CtAvZmDIqS/zUmFVApytIc01nwSXUtZGPAIh37DTZYNmGnmh/2aUm+U+
uoAE58AkZPDpmoAEzxNs7F9kgiacG6hl40l6TkfjWEmFJSs5N/3yAa7lplrms3zE
irCXgeqN+LYOi82VnSU+dKrgD+xSDxK63ImkrMZn3eBOOxJlPfCoOONLZqYs/UJt
kTydwyFJ9qvWc6wJN0gebPlxYT+EJZbvkAlYkx/b7/AtNnsjJkHbgqspwbehuQ0H
ggW57uoqxlTzAqUvyEK9XSyhLilvQruym5ZcqcTXOHgIv58ch0WD/NknAa2WXjX6
ljpKUnEfozZoWjD+dy80XdMdfHcPqz/HWC0eyt+CZ9cZLudPuABg0zEntXG6rjAd
zmBtwbv1hHf9N+mIT0HM
=7OIv
-----END PGP SIGNATURE-----

--HrsILUyxNtiOryfc--

--===============3472661011973067832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3472661011973067832==--
