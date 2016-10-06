From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rl6347a: Use dev_err_once for I2C
 communication error prints
Date: Thu, 6 Oct 2016 18:26:24 +0200
Message-ID: <20161006162624.bvnn2s7u7s2uex6j@sirena.org.uk>
References: <20161005140536.12166-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9069609231401909588=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9767E266820
 for <alsa-devel@alsa-project.org>; Thu,  6 Oct 2016 18:26:40 +0200 (CEST)
In-Reply-To: <20161005140536.12166-1-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9069609231401909588==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yspduknmwsjm3uyv"
Content-Disposition: inline


--yspduknmwsjm3uyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 05, 2016 at 05:05:36PM +0300, Jarkko Nikula wrote:

> It's difficult to guess from bunch of "ret=-121" errors what driver and
> device actually caused them. Since struct i2c_client has the dev pointer
> use that for dev_err_once() in order to see the device and not spam the
> log needlessly.

dev_err() is obviously an improvement (as would a better message be) but
dev_err_once() seems like a big jump that we don't normally do for our
I/O errors - transient errors do happen from time to time (especially
when people get their power up sequences wrong) and it can be useful to
know if something is just dead, failed gradually over time or just had a
single transient error.  It's also helpful since a lot of the errors
that do occur result in long timeouts so it's not always clear that
we're grinding through lots of I/Os if we don't say anything.  Am I
missing something about this case?

--yspduknmwsjm3uyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9nsvAAoJECTWi3JdVIfQ+H4H/jqg4FN8Fph/PjSsQsV5w60n
DuADHAwhzvcZeRWkBnd4sMXbKSueSvMwmfZyZwu1uRUs9CHROwykaxMk8vQlbfDu
yswCiIlW4grR83wh7fZioXptCMi8GXQtjcZJoE9/0fRlsa6bVjSvRHg1lEkfBkTy
R69mRPMMlIWAQUiHSqL6KmN6pMGMpbMcWqCQCwPWkg7KHJHsQECe/vWS8dRsFjS+
feZ5XsdGxSINGwZ5J0v96kciM6yAIjTQAGc9UC/HDT4njp8HIT7wfRvVQYF2dUay
tlvRw243UAOm+OXSmduLsrCdHRzMyvIBXvbtQOj6g9t0qwP4CEdGsaaCj6eWRug=
=7Av1
-----END PGP SIGNATURE-----

--yspduknmwsjm3uyv--

--===============9069609231401909588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9069609231401909588==--
