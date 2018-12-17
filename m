From: Mark Brown <broonie@kernel.org>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 15:40:43 +0000
Message-ID: <20181217154043.GC27909@sirena.org.uk>
References: <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <20181217123703.GF13868@sirena.org.uk>
 <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
 <20181217141008.GA27909@sirena.org.uk>
 <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5165247092464707143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EA209267944
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 16:40:44 +0100 (CET)
In-Reply-To: <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
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


--===============5165247092464707143==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 17, 2018 at 05:03:04PM +0200, Dimitris Papavasiliou wrote:
> On 12/17/18 4:10 PM, Mark Brown wrote:

> > It shouldn't be called while the stream is running, if it is it'd be
> > entirely fine to just return an error.

> It's not called while the stream is running, or at least I
> haven't seen that happen.  It can be called though, while the
> device is opened and fully powered up, for instance when
> switching tracks during playback, where the next track has a
> different sample rate.  This scenario is relatively frequent
> during normal use of a DAC and can't be avoided, as far as I can
> see.

That's why I was suggesting that you should be configuring the power
down time.

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwXw3oACgkQJNaLcl1U
h9CfUwf+MU08JhsV8fZajn4vMSpMhkvwzVyP27whR4pWk+dtgc9q/dDr7Nh8tLiC
Ae3jYdWzsksu+MhNUB52Zft98dQMuOq+UIXuDdbgZCLtw7VdkXEqrSHkp1bpz/F6
WCKHyMi6iVZ3EdhfQYB2iH0X10Wi5SiAHHkqJKZ2WcIsLlQCHjL3Ymrl4h96RJdx
yHTOy1nwo80ST1zFaxKRxHB8izFbvO7ad1og3fpzhNEWDj7e0pyos9cm4SGu9Cjg
hpDBGllI1iDTpvQMSobD8nZe8ahIPibO7LAexCxHPtBbX6k8Qi3JSHhIYHm/qF6T
351D5Y+TwzzQAgXUZCwG5irZb7DUug==
=1umQ
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--

--===============5165247092464707143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5165247092464707143==--
