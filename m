From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Allow complete
 shutdown of McASP when not in use
Date: Wed, 4 Mar 2015 11:30:04 +0000
Message-ID: <20150304113004.GJ21293@sirena.org.uk>
References: <1425392792-12659-1-git-send-email-peter.ujfalusi@ti.com>
 <20150303150742.GZ21293@sirena.org.uk> <54F6DA94.2000702@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2056028159864628890=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B732265051
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 12:30:10 +0100 (CET)
In-Reply-To: <54F6DA94.2000702@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2056028159864628890==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4SAUf7275hKTfsu8"
Content-Disposition: inline


--4SAUf7275hKTfsu8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2015 at 12:12:36PM +0200, Peter Ujfalusi wrote:
> On 03/03/2015 05:07 PM, Mark Brown wrote:

> > I see there's actually a balanced put in the resume path...  I see
> > what's going on here but I'm thinking that perhaps something more
> > explicit that calls the ops directly and checks pm_runtime_is_enabled()
> > might be clearer?

> The issue with the pm_runtime_is_enabled() is going to be in the resume path,
> as I did get_sync() it will return true at the end all the time.

You can just store the state before you do the enable...

--4SAUf7275hKTfsu8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9uy7AAoJECTWi3JdVIfQHwoH/RR1pwh9Bd5upvoqdn7V8BIT
LfPlHcZPsSPviX7d7TA//SjgDm5aJtQkrCEQBcWXPTNIiRWa+D7DHzMfDJ5AU1o6
RksJ3EY4QA0a5+AM34YQbigg1iZvnHcbo7yhyYExQMi+pVmBtueajeXdvt7l3eOB
zaozsQENjunnImXzEEvzxfdSunLp5+s5trYZ/QJplsisM9hK5f7y3yKT0cSlHjP1
0yQYVQi5/uInIXi7SGNuM8rXIl/Kc7cYC1RfsMNDR5wneRsRJJpj6DZp/WiEE9iS
thbtkEhgBr6rgzSpzg6GrnTNCS6KZ4/0aKiWjlTN2hEmJjxSLyY22wRrHnXsjcg=
=hDc+
-----END PGP SIGNATURE-----

--4SAUf7275hKTfsu8--

--===============2056028159864628890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2056028159864628890==--
