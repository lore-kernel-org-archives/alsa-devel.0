From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: pcm: Trigger all commands on error
Date: Thu, 10 Oct 2013 13:35:20 +0100
Message-ID: <20131010123520.GK21581@sirena.org.uk>
References: <20131010084040.GG19005@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7911472794853080517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 176872602C6
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 14:35:27 +0200 (CEST)
In-Reply-To: <20131010084040.GG19005@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: kernel@pengutronix.de, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7911472794853080517==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6KcEWlY3qHmwPCfE"
Content-Disposition: inline


--6KcEWlY3qHmwPCfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2013 at 10:40:40AM +0200, Markus Pargmann wrote:

> For mxs-saif, we still have to store if the last START failed to handle
> the following STOP correctly which is not very different from handling
> double STOPs correctly. I don't have an idea how to fix RFCv1 without
> using some state as in RFCv2. Perhaps we should simply fix it in
> mxs-saif and other drivers then?

I think we have to - it seems like it's going to be more trouble than
it's worth to try to keep track of this in the core, there seems to be
a bit of an assumption that the triggers can just be called and for
things that aren't refcounting it's probably more robust to run the
trigger extra times rather than adding a state machine that we might get
wrong.

--6KcEWlY3qHmwPCfE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVp8FAAoJELSic+t+oim9ws4P/1IfFO2VqjK4BCyJvPPGh21d
hyqMersoyn+KQWd1yLvuyrYp59SFKOvV4F3P4+CELK+So7qxgGy74jEWbnrPVU0l
lwEqnAYozW1++A7jIi8OCZ2/Mgk8uCHLqw+zSIErSUoVnYNTWO9rqjMY2IHcpwtB
bWsPcE8cEZ6IkiPesawlCxrUjxbjqZ1XsZeBrCoAVdyHfTg/j1vhrjmLGAAC8sTW
0m4pOiwbEyYXRKuthRSRWM7B86/0eMW2VZ1aFTCQRI40kpLa5DfNpvTpMmUhVWup
k8YpyAR5qKoP3jeErAbNqTgjr+spz7y+huJ9GPBX38l0K873s6maTdCAMkaj0knk
9O5GZzqW51hEkBQNOasJPcFfJosEga/q2XEGB+yBgiNvIvQLXEgu9dfdx/MgOtwu
QJnpTipzbzxeWk9YIWpL24weDew5k5oxAUcz2jVbcib1levOVWOOAr3yUItNSjex
SIsGx+5c1s2tTBi1gb3UzVmTrh0MeFn8eLr9ObUzeBIJGt2o7QcwPIhrlPeH8tDE
Jw5HtqUC7KuTPMaU1SZnQHGhrw79kdBLawb//sTGNmeE9I4sNyAB6S24wwc45OtD
HcgSQEVafZFiY0YM/7wmHkXfqMwI311EcVEfgFn8hRj3vZr5Q8457IMnDCn/q/Ki
mluonkzU/7yH2UppwPGm
=+WSs
-----END PGP SIGNATURE-----

--6KcEWlY3qHmwPCfE--

--===============7911472794853080517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7911472794853080517==--
