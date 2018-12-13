From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Thu, 13 Dec 2018 17:42:29 +0000
Message-ID: <20181213174229.GU10669@sirena.org.uk>
References: <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
 <20181114220640.GB2089@sirena.org.uk>
 <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
 <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7342162322801668524=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0400F26789E
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 18:42:30 +0100 (CET)
In-Reply-To: <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
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


--===============7342162322801668524==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4WCFFtl4AQpQKunj"
Content-Disposition: inline


--4WCFFtl4AQpQKunj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 24, 2018 at 10:17:49PM +0200, Dimitris Papavasiliou wrote:

> discussion here.  I still feel that fixing the machine driver, so
> that it doesn't generate the pop at all would be desirable, as
> I'm not sure whether the digital_mute callback is guaranteed to
> have muted the device when the clock source takes place.

Making the machine driver more robust is definitely better, it's more
robust in case the mute is for example just a very low gain which might
still let the pop through at a lower level.

--4WCFFtl4AQpQKunj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSmgQACgkQJNaLcl1U
h9D2ngf/bW+6PznfqurXYqWivp3v7D6uFVd4OTEWrFtyq1nT0dHQnx3whdarhZeQ
jpmQfXKisekDaSnKFNv47ZzOdle4Pwswo/bfDH1NtgBULj3jVUZuV6teK0+eEKq+
5kvCQ7iIu/LOlPU3mrEgYb3boWu1KvVKJhW5sIlCj0o3hq2/MFifA1k1gmN10TNV
0DjooXqj9O6qkvblpzFCSy8CEjEGjlpLro7sXaXjCbqm9cDH+1KlYYlhQwtJDq8S
M9Z6k357TvTUtiX2lfppcDtREY7gNglceNyG/5ZVexarNWSgpxo5hX6LIKB+bB4W
p7QfByLT4xX3b9jFMJpwEj3TejXl0A==
=7ckZ
-----END PGP SIGNATURE-----

--4WCFFtl4AQpQKunj--

--===============7342162322801668524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7342162322801668524==--
