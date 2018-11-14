From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Use less aggressive caching to
 ensure correctness
Date: Tue, 13 Nov 2018 16:26:12 -0800
Message-ID: <20181114002612.GU2089@sirena.org.uk>
References: <20181105111912.14464-1-tzungbi@google.com>
 <20181106171845.GF31950@sirena.org.uk>
 <CA+Px+wU59XObu9C2RphG8st9TEZ4v8HTtM8s5TpyGa+tSCBTKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3460207391663960821=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 53A322677E4
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 01:26:21 +0100 (CET)
In-Reply-To: <CA+Px+wU59XObu9C2RphG8st9TEZ4v8HTtM8s5TpyGa+tSCBTKg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Dylan Reid <dgreid@google.com>, lgirdwood@gmail.com, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org


--===============3460207391663960821==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XJ5wUQMT/jAb5xue"
Content-Disposition: inline


--XJ5wUQMT/jAb5xue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 07, 2018 at 12:03:06PM +0800, Tzung-Bi Shih wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> The second one is forcing to recalculate the graph at the bottom of
> snd_soc_instantiate_card() by additionally calling
> dapm_mark_endpoints_dirty().  It would waste some computing power by
> comparing with the first idea but it would be also simpler than the
> first one.

As we just discussed in person this is probably the best option - it's
what we used to have (or were supposed to have, but I'm fairly sure I
remember writing the code), I'm guessing it's gone AWOL during all the
refactorings for componentization.

--XJ5wUQMT/jAb5xue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvra6QACgkQJNaLcl1U
h9CZwgf/TT6edbiCOMu9/arM9b6nABnehKpxRtmUw8sE78HEnvskzVDorDo2uOwd
dPUUVdWRcTfUy+LrZtx7Wuw2SyaaX40FEI1cPjlM55hhQW4lJXaeqPheXM5WOLxP
DrnAKlITHLtIsdU/hl02Azk0eIBgLl4bvIgoazKfeLt5H3MSz9D9twapsJn1v0s3
B2zonmQH+L8E/MnrsVCDgXzykiZNC79mxpoWtgRepmAJUjhedtLvXXV2Goo1QT29
V66uqo4yVbH8oOP+Vjxk2CfiFF33g8CeMVfjdl07WNaD7lmfi53vi0wIHU8Fki56
y4/NQNc5QChKN/2tLDGVpvcnqjIX5A==
=IaNp
-----END PGP SIGNATURE-----

--XJ5wUQMT/jAb5xue--

--===============3460207391663960821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3460207391663960821==--
