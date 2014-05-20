From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ad1980: Replace goto loop with
	do-while loop
Date: Tue, 20 May 2014 22:53:50 +0100
Message-ID: <20140520215350.GV12304@sirena.org.uk>
References: <1400588590-26820-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2512436542948857722=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 220752650AE
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 23:54:05 +0200 (CEST)
In-Reply-To: <1400588590-26820-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2512436542948857722==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q7K/b4KrHb9cgTGH"
Content-Disposition: inline


--Q7K/b4KrHb9cgTGH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 20, 2014 at 02:23:10PM +0200, Lars-Peter Clausen wrote:
> Using a proper do-while loop here instead of a open-coded goto loop is both
> cleaner and shorter.

Applied, thanks.

--Q7K/b4KrHb9cgTGH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe87rAAoJELSic+t+oim9y/AP/38bpXEP6WpPAZMQMNUe6K+7
TqXdQnYyo3b73uWfmJS/AHttlnuQfKGlQsrAJHQLUWo/t0xL+e6yW9bVKFls9asR
4k1vBTPJzkUME3dWuRLSUL2jr5x3QafHWEUPaVDJlmas6VXcbTTSFoN4+WmDQFFp
7Xu5oooxCJz9NvhV5ukcXEcAVwb8YutHa60B/lW1UUdyjSh50O2no+xbB3shdBzq
s3RrVtvJqlupJu6CRRFucybKWghkuWpdjwdAEEdXkoGC/+RqmhOWE6bysN0A2RxS
svSUfap930jfm3ld2mNKWecI1uf7ZF9oDWYEI1iyhVxu+F1GcyPfQO3EIrF4nj8x
pqx8XTloIlm670c7LGHAAJF4/Ak5chUr6Lg7GAJsGRQcFayFWVrMEWm8wblZitqH
HW4GfVBmrCR+z7zqgvsYp3ZrkNmCFHOlYBnCkvj78O8x59FmrATigZW1f8Ry2Buv
8G4hgkSpsd5mBqFpN3raTRjarJYRkSGbevnRl9s7/mAyH4icLRIVB6itw3o5Xl9u
5JuuJ5jsmsfJmzzlothnAaV+99mVAyHrYj3HQ5wGVH1KIjS/ACi3qBo4/5y/9fvn
5yBa/53MFLhJmVJ9KR6gLQzxSvqOY+mGTUOsiGbe9tJk0l9GOzJCblBI5lC29Zpf
ELu84UJYulfWLITzWHvt
=OOTt
-----END PGP SIGNATURE-----

--Q7K/b4KrHb9cgTGH--

--===============2512436542948857722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2512436542948857722==--
