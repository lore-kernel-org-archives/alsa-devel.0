From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 14:10:08 +0000
Message-ID: <20181217141008.GA27909@sirena.org.uk>
References: <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <20181217123703.GF13868@sirena.org.uk>
 <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6187478607375722386=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6707B267AC9
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 15:10:10 +0100 (CET)
In-Reply-To: <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6187478607375722386==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 17, 2018 at 02:58:03PM +0200, Dimitris Papavasiliou wrote:

> In general the clocks need to be switched during the hw_params
> callback (when the new callback specifies a new sample rate,
> which needs the other clock) and, as far as I can see, this can
> happen at more or less any time, i.e. in all power states and
> regardless of whether the device is opened or closed.

It shouldn't be called while the stream is running, if it is it'd be
entirely fine to just return an error.

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwXrkAACgkQJNaLcl1U
h9ApjAf8DrWvb7tFvEEK/5ilBwfZQRhs2QW/VGe2xVhmL83HhtBRSCONtbQwI1Ub
Djiw4VE1uskOg7CBGD+JsGr8AVnd1pgefCSbyOPeDNr4w/m2HfkLQynKkdZDXqqo
RARunlRhH8V9wZyX2NrxtoNGesm69ms0nTKWjknKFLbN9Fpecka+nzp4LepDW5JJ
iJ/W8BmiVT4qlwHeDiV+9I6BJ4G6gWpO3smdUr5LcQ2i6S6GrKl5HXPB4lqfxfxr
urkGiK6AM45YDbUk5SjVPLRr7JlhbjdVf0w2arTj0Jqdtwxkmf8Z1FKKZYpGDjkm
CPL/CW9rKXZ2/IoX5v+pzfNZGv7V9A==
=egjz
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

--===============6187478607375722386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6187478607375722386==--
