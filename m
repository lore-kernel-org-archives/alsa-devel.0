From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Add pinctrl PM to components of
 active DAIs
Date: Wed, 30 Oct 2013 09:19:59 -0700
Message-ID: <20131030161959.GA2493@sirena.org.uk>
References: <1383016374-30919-1-git-send-email-b42378@freescale.com>
 <CAH9JG2X3HHLYLuyPzT3TPX4N0nwJR7xU4yhnkFWyMxHeEV3mbg@mail.gmail.com>
 <20131029032512.GA8812@MrMyself> <20131029034220.GB8812@MrMyself>
 <20131029161959.GF16686@sirena.org.uk>
 <20131030014729.GD9605@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8553055288571765845=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D6D52654B7
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 18:10:45 +0100 (CET)
In-Reply-To: <20131030014729.GD9605@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, Kyungmin Park <kmpark@infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8553055288571765845==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 09:47:30AM +0800, Nicolin Chen wrote:
> On Tue, Oct 29, 2013 at 09:19:59AM -0700, Mark Brown wrote:

> > There's no reason CODECs can't implement pinctrl if they want to.

> Hmm..Sorry, I'm little confused. What should I do? Adding a pinctrl_pm
> for codec_dai->pins? Or a condition like "if (!codec_dai->active)"?

The former; I'd expect the calls to be done for the CODEC and the CPU
(you'd need the active check for the CODEC as well I guess though almost
all the time the CPU and CODEC active states should be the same).

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScTGmAAoJELSic+t+oim9M30P/19YELVbgFik91rt8GbiO28o
LnGmBiHxFm3/keJ8sTtHDzie2gi6gqKYb0IlLqWzPZToyJNGFMCnX0OMu0KhdNta
MSeH5zWewRofIp//HXPeBQSUOaOvWLLkmVnv4K0OpU5vlxLkZ0kvU5Fq/268Ze+J
9LyT0R1fDv117Ea7wryZKQm+f7JtEzKS0ekHG3GcGwBIiOUsnjbgsjJJNf86VaQr
ox34Sql+noNxVOHvd6tflOvEUQmGTFjM2Dy8q5l+zhPJ9N1jSE/NFqmISMXX/LCa
syTSsHN7gIhkbTzN1GJ+XghdQ8cgNAl6B5MnhwUgnzT5FCLLMIpA7NyYW2zhTG/j
HwNnO/G5gtgmyEiZNg78VcMfIolJPmjvHpCWHfFvO33jI3eYpA5sJW620jAmM6Pd
f4hF7yt6dj9gtd6tmeU//D1lkDQIOmH6/ezIQ3GlIqUxs4a+0mmkmyaKROY6TdgN
Z1lPB7DbwMepVGcMBEBTrM9Gb43mBWnCppbPY6db1cXHFGP2Buobz8PIp/0hmfYh
BZ/wMLmYISSVO+ga9f1fjJThqf52MHyaTC6I1r308bDqHSJm3f6lpiveUc0YWRD7
xlhCl+A9YUMd2K4D37l8M8v9TX/7RenWQdbsK6Z4bU0H2Sl6FLzykFt7Y7nNbmPl
3o+HCuFTr4dmhQ8ZjcDi
=Vq4T
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

--===============8553055288571765845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8553055288571765845==--
