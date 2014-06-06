From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Show Baytrail SST DSP
 firmware details during init
Date: Fri, 6 Jun 2014 14:13:27 +0100
Message-ID: <20140606131327.GQ2520@sirena.org.uk>
References: <1402042211-13842-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0161281701263821718=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D13FC265172
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 15:13:48 +0200 (CEST)
In-Reply-To: <1402042211-13842-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0161281701263821718==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZFN9GYGE3tAy85aa"
Content-Disposition: inline


--ZFN9GYGE3tAy85aa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 06, 2014 at 11:10:11AM +0300, Jarkko Nikula wrote:
> DSP initialization complete message IPC_IA_FW_INIT_CMPLT is a large message
> carrying firmware details in mailbox. Read and show those details during
> init in order to be able to get that information to QA reports.

Applied, thanks.  Is it worth putting these into sysfs file so we can
get the data read out with alsa-info.sh?

--ZFN9GYGE3tAy85aa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkb5zAAoJELSic+t+oim92+wP/jhqAbU6LqDvB96wYLsBBkad
jZ+0a7lEa/e6SUT8bjiBIUhdS6hmcaz9UEL4rx8iFgF4KZB5S82DOQvn1Eyobxnq
10J7VzZgNYGj45YUdoR8pqbQ+ZpBhgyz69aQyQHMV33+yKsC5CM4eISrS0JEDFFc
tb2E5VuIWUfe7GUJZEtql30bRB94FTe3IUWxSjPwfZdriRe2/ytOS6U9IgbpxjYX
yxdcB5HHzVOgUMjfZpgs6hGzXMlZkEpPeMx+sPjcLMu38uskaoNsvWlEfGhkU7kU
QIdDvM69+SM/UPUFJCrM9XxaLNP5S+FjU8ytPOndI3SDm/+4oTUVvaPV7v3gDlTz
mLpLOrHG4gOeTN9yKXA9W5WAsvyY8iPWlXnsw42hHEdqtrk//gE2xCnTtagIIFYC
Yle3+AZ2JIF2xkvBJxTrjelxnd5WhhBxOxHLD5b7BuOxUjLn8I2cD22z81fu136e
1YEJVMfA9Kgpo4jCFqnXbcMYDHyn88lo/7qfRcUwAGIQHp+OB82SlYEMARPEhmCj
hGzh0s24FJhsH59TlDBwtf2niwLrVxEPIXSjfCG2ox24E6Kx0SyJuxokC5KSdjIe
UGQs9NK89YTkKnTBxcRsqXAK4yIlQMk4IxvrPvhOX4yWz12lOR3p9xTpgsY38thc
I6wxsaEXLHUF82L+Ds0M
=g6Lu
-----END PGP SIGNATURE-----

--ZFN9GYGE3tAy85aa--

--===============0161281701263821718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0161281701263821718==--
