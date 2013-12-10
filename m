From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: ep93xx: get rid of
 ep93xx-pcm-audio struct device
Date: Tue, 10 Dec 2013 11:57:16 +0000
Message-ID: <20131210115716.GH29268@sirena.org.uk>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
 <1386620656-18391-2-git-send-email-swarren@wwwdotorg.org>
 <52A62BC3.1050807@metafoo.de> <52A6573E.1000504@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4067796839047185824=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 836FA2651CE
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 12:57:23 +0100 (CET)
In-Reply-To: <52A6573E.1000504@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4067796839047185824==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nzRyboNcQJj8oYvt"
Content-Disposition: inline


--nzRyboNcQJj8oYvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 09, 2013 at 04:50:22PM -0700, Stephen Warren wrote:
> On 12/09/2013 01:44 PM, Lars-Peter Clausen wrote:

> > This will have a conflict with the "ASoC: ep93xx: Use
> > devm_snd_dmaengine_pcm_register()" patch from the topic/ep93xx branch.

> That's true. The conflict isn't conceptually that hard to resolve, but
> probably a lot more than you want to do in a merge. I guess the way to
> resolve it is to merge topic/ep93xx and topic/spear into topic/dma, then
> to apply these patches on top. If that sounds good, I can rebase them
> and resend.

Please always submit against -next or at least check that that's going
to work and comment on the result, it makes life easier.  Remember that
all the topic branches are constantly merged together, it's important
that that works smoothly.

--nzRyboNcQJj8oYvt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpwGYAAoJELSic+t+oim9cZEP/RsEMg2Sx/riNeNEZakRmcm/
PX1apuP4VbjELT5uXibe12hz9s5QcV6sDBDUJivKW1pcsyRgkKyF+NklCD4uLfik
FGAH3+Hdrln31jR7dLFeeMe6mJ5TwUASo8h6qCbEkC4swBmcd+HN99BX+9lbr8GN
Oo4UK8MvDFHVqqp7SS5DayNdE1U3WwK8/Z68lG3RMBH2NRuxcA8g6+bBqPNCUnWE
BqokPKP/C0Q1YKNyIis7g6AZX7LOgvgz9FTjP/3fszaBDJr0pLu3Yrm3mJ8J7wSg
iiZpnlMKAJsZkBPd0d5nxRBsBrHzGBRHj+b4LXatRZrIGxnDxFsfxW16gWhRkxb8
padPWMIN2f5pjFuMgJk72Xbpch4z4zPsBWXQiA5ZMQrhM/EJmaufrRfh+XxZ1G/r
k1Nj5HdJ5rgxta0r20wqzg7DNV+VnTi1Ox3V1TrvpNS+I9BSlnjAXXv4cmKsoEcB
jPvNTjCJ6iD7ibZfIInxBNttOebISVqQ/703/mBkkSKjptPr+MySej3jE6d5IZwp
qbnlZ2mUFVDvLsvIIGvqGAi1ryE6LIjWtD26T1pSxMwzhqOzeYNYBpqCi9qchSHY
NY6nm4DdRlTPsfvO3Dwwl56R2wE4IAg1d8ClB/41OJN2Z7e2IytGtdJs2XZxlQY5
/IovsbyrYMlGUjobcqIl
=OXzT
-----END PGP SIGNATURE-----

--nzRyboNcQJj8oYvt--

--===============4067796839047185824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4067796839047185824==--
