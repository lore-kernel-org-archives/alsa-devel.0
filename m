From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ts3a227e: do not report jack status
 when there is i2c read err
Date: Wed, 1 Jul 2015 19:05:24 +0100
Message-ID: <20150701180524.GX11162@sirena.org.uk>
References: <1435724282-109761-1-git-send-email-yang.a.fang@intel.com>
 <CAEUnVG6fLa_+rnmFQ1zWZod25pJomO6xqLbshj8_t8AhhtK9Sg@mail.gmail.com>
 <20150701173409.GA111758@mocha>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3074957697955801415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 09D66261560
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 20:05:35 +0200 (CEST)
In-Reply-To: <20150701173409.GA111758@mocha>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yang Fang <yang.a.fang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, Praveen K Jain <praveen.k.jain@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Denny Iriawan <denny.iriawan@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, kevin.strasser@linux.intel.com, Dylan Reid <dgreid@chromium.org>, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============3074957697955801415==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uWCTLymdFNG0vGYZ"
Content-Disposition: inline


--uWCTLymdFNG0vGYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2015 at 10:34:09AM -0700, Yang Fang wrote:
> On Wed, Jul 01, 2015 at 10:12:37AM -0700, Dylan Reid wrote:

> > Thanks, I think the error checking is good to have anyway, but should
> > the interrupt also be disabled across suspend/resume?  I'd hope this
> > device's resume callback wouldn't happen until after the parent i2c
> > bus is ready.

> I am looping Mika. I was expecting that interrupt would come after i2c
> bus is ready. but with current pinctrl-cherryview driver the interrupt
> comes in random order after resume.

I wouldn't rely on this, it's not going to be true in general - the
interrupt could flag at any time after the interrupt controller is
resumed so unless the I2C controller takes steps to ensure it is resumed
before interrupts (which has its own complications) you could get an
interrupt delivered prior to the I2C controller being ready.  Look at
how arizona handles this for one example of dealing with this problem,
though it's not ideal.

--uWCTLymdFNG0vGYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVlCvjAAoJECTWi3JdVIfQGYgH/2HUnXPXr3ZEV5qElz0VwG2N
eCfwNV7jwTIs2xVwpThMcc4MobLwJME8x/q9ouqXhbw5aTKsGHMrS3ABVyyuAyKj
+q/HisntobZGvY4OmxPZSw9DBT8hAcX27s/L1QEGcGhevj7Q1e3LkV1/jHnhMHoS
E6eBWafgp88xYqoqFcN7906Fj46L4M5Tc0jvO0VrGKQchxHCpROZWT/nBuLLqXvG
nLirkBxsnV+QAB8txvgGdqmTXpLKYuIrZEHYN0Z1s+P+rT+zaep0JCErtCU8QCt9
TV2qN4Df5+4n8WHgsfNjHVsTLxZ5zImmj9f28Q+y5oZKZ1R2ySeEsItPj9chxcM=
=/7BQ
-----END PGP SIGNATURE-----

--uWCTLymdFNG0vGYZ--

--===============3074957697955801415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3074957697955801415==--
