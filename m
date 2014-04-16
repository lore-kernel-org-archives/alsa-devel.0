From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Add explicit include of of.h
Date: Wed, 16 Apr 2014 22:33:26 +0100
Message-ID: <20140416213326.GE12304@sirena.org.uk>
References: <1397560326-28268-1-git-send-email-broonie@kernel.org>
 <20140416120607.675e3877d217fc58c18ffd58@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7700629090109444725=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 683D72650BC
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 23:33:38 +0200 (CEST)
In-Reply-To: <20140416120607.675e3877d217fc58c18ffd58@canb.auug.org.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7700629090109444725==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YFIkGcPEGW9vkGks"
Content-Disposition: inline


--YFIkGcPEGW9vkGks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 16, 2014 at 12:06:07PM +1000, Stephen Rothwell wrote:
> On Tue, 15 Apr 2014 12:12:06 +0100 Mark Brown <broonie@kernel.org> wrote:

> > From: Mark Brown <broonie@linaro.org>

> > Hopefully fixing a build failure reported by Stephen Rothwell - though
> > quite why the other OF headers don't include this as well I'm not sure.

> This did not fix the problem.  The declarations (and presumably the
> implementations) all depend on CONFIG_OF which is not set for the x86_64
> allmodconfig build ...

Oh, sorry.  For some reason I thought this was a PowerPC thing.  In any
case a stub is now being provided by OF (which is in my tree
temporarily)

--YFIkGcPEGW9vkGks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTvciAAoJELSic+t+oim9PS4QAI2iY4mwkb2sKY/qch1kKY+3
Del/FhuBeYnrNwkGfGDXEDxoenJYnWF3TXlMfSgFxByxV1a2lkvNxrJZGvxR2mfH
ZOjDViVqthAvd4q+oMZyiAsFfwmLfJAwBsZjJmqrxQr2dGF7uqt4aVfp5AsPe1jl
X7/+ZxfZbBR/on4zQc17ypEIepHi/m4nJKeBvizu67N3Zl4roOj7Sf/3Uq5awAjs
nTrdHElKm1zhuwEuPAFRmMbLk2IgjoE1xlVW1ayNp75UUX3fPCsyKg/RD/0H0Axh
cYLuTqi36NmbCTtB24BDxo0lOeOBvx9QchQ7yIitEcMu56ja7L1NJRGsa8DBxtHS
N4wMEeLxLllZ/s77ry3ixExgPNBuqyiWbmBbM6+4PlrW0Bn+ksVh73PmQ1/KzAA4
PWovGiUCqFp80A/15F+jOFfAHbWS2V2GEDDndUrPSMABxeepviAxVae3xvmUxSdH
6/aYcJGpPE/11UqWAq+KZjvzI7WgBC6Y5gGO3+A1pfYDdynbxdIVqNBJE8h3WV3Q
9bbEXAUzYNmCWF9cRhKNtClR6VdwKV9CFVU7lr72+ath77L0F/U0JtFfQGOHzh52
d3wZsQOzJ5svjJo03Q/6zUT4qRTvUAh8mMM/SLFvUChWad2Bl5MxgDtjpC9SE2bE
3ZZrUMQprMaWCPkUi5qC
=7F1d
-----END PGP SIGNATURE-----

--YFIkGcPEGW9vkGks--

--===============7700629090109444725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7700629090109444725==--
