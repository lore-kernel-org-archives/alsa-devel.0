From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dpcm: prevent error for paths
 including static links
Date: Wed, 30 Mar 2016 09:36:50 -0700
Message-ID: <20160330163650.GG2350@sirena.org.uk>
References: <1458056089-885-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
 <20160329212224.GM2350@sirena.org.uk>
 <20160330085812.GE31814@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9049789722976611800=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED8C5265A84
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 18:36:55 +0200 (CEST)
In-Reply-To: <20160330085812.GE31814@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============9049789722976611800==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MKyq+TZLpK62LzFe"
Content-Disposition: inline


--MKyq+TZLpK62LzFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2016 at 09:58:12AM +0100, Charles Keepax wrote:
> On Tue, Mar 29, 2016 at 02:22:24PM -0700, Mark Brown wrote:

> > Is this not just a normal CODEC connected to a back end on a DPCM
> > system?  What are a "dynamic DAI" and "static DAI"?  Your changelog is
> > very unclear, I really can't tell from your changelog what this is
> > aiming to do or how it proposes to do it.

> The issue is basically if you have a path with a DPCM DAI at the
> front, but then a regular CODEC to CODEC DAI link later in the
> path. Say for example a CODEC attached to a CPU that uses DPCM
> but then the path goes through a CODEC to CODEC link to a speaker
> AMP after the CODEC.

Doesn't this mean that the appropriate fix is to terminate the DPCM
routing at the first back end DAI so we're not trying to DPCM outside
the SoC?

--MKyq+TZLpK62LzFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/ACgAAoJECTWi3JdVIfQyGAH/iuZDp/TVyKBynrbz3GypG1o
fipIPbC4AblkVBaSUd4orW3VoiDVr7ttAciaxHioDRjDaR9eA701NO3o5QQOV8+B
l/Ij/foXnSOgE8OOQCOrDcxqhIAqVcU1gUhSx3tWlgNaclEINjZ9ruXaU5nInKf6
gsjRRLlsTGNUT6qYh34ZASpjJTUx2DCWFXilTo1n0xeX9oNEriZu7MzqEimRK6Yv
DZyA+PelK9gliiaNi6asg30Jxsv5Ndg282B38hWSKZ83ESp82taEyUHe/Hx0WE/+
tdNUMSeSpsYHHjMkfvVqihAG7V0wO+9NtoK5eYYhAtz0mzavyx9opRv+nKxP+B4=
=Hc3P
-----END PGP SIGNATURE-----

--MKyq+TZLpK62LzFe--

--===============9049789722976611800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9049789722976611800==--
