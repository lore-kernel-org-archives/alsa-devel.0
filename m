From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/3] ASoC: Intel - Convert to use
 acpi_dev_get_first_match_name()
Date: Fri, 12 Jan 2018 21:03:22 +0000
Message-ID: <20180112210322.GG21458@sirena.org.uk>
References: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com>
 <20180105160935.48588-4-andriy.shevchenko@linux.intel.com>
 <20180112190312.GD21458@sirena.org.uk>
 <1515788467.7000.978.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8976082422276450978=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C73A266B67
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 22:03:27 +0100 (CET)
In-Reply-To: <1515788467.7000.978.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8976082422276450978==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Content-Disposition: inline


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 12, 2018 at 10:21:07PM +0200, Andy Shevchenko wrote:
> On Fri, 2018-01-12 at 19:03 +0000, Mark Brown wrote:

> > This doesn't apply against current code (even after pulling Raphael's
> > pull request) - can you please check and resend?

> It requires Pierre's series #2 [1] to be applied first.

Oh, and please note that the "and resend" part there is important, if
I've replied like that it means the patch is gone from my review queue
so I'll need to go and try to find a copy to do something with it which
can be error prone.

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpZIpkACgkQJNaLcl1U
h9C0Xwf+J46crKTMqIYBZqKkO5VH73LQBiKoHwsUJuQZC73qjPgfnCUnpPVBk6cB
PGEHsTKRzOEJU67K4hqmsrlKit+G4bgSwZfl50We6JLTUICg9XhejPb/vV0b7LgR
YnFHhJ2HMaL7E62LuV7KD5BL9i5O2avxeCd5GQmKh7pJ9lFDuZHeE96GhKYjRJ0L
qGEYEXYOkxZQswcS8yzWDLRNoj3T3sU+hmxWrDxzZ3hrXkaZH6BBUKIWoE2cT/X3
m/oVwYW7NnTCTgr8AtL3k/6HcKuCMQXlpm67bm/RFG4PnJVScMsmdv8CdMJk59LU
F0FmmetV8rBnMfoFJJQzZTjcZRO+YQ==
=ryRX
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--

--===============8976082422276450978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8976082422276450978==--
