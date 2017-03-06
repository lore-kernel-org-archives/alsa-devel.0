From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: ASoC: TLV320AIC23: Unquote NULL from
	control name
Date: Mon, 6 Mar 2017 11:41:18 +0100
Message-ID: <20170306104118.6v763cejdc3ow6ef@sirena.org.uk>
References: <20170301122628.10392-1-liviu@dudau.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7622204102617195780=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 552FA261740
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:42:07 +0100 (CET)
In-Reply-To: <20170301122628.10392-1-liviu@dudau.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liviu Dudau <liviu@dudau.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7622204102617195780==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="neci4vy5fgejob6e"
Content-Disposition: inline


--neci4vy5fgejob6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 01, 2017 at 12:26:28PM +0000, Liviu Dudau wrote:
> Without this I am getting the following messages at boot on my Trimslice:
>    tlv320aic23-codec 2-001a: Control not supported for path LLINEIN -> [NULL] -> Line Input

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--neci4vy5fgejob6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli9PM0ACgkQJNaLcl1U
h9Axqwf/atuVnE4PW8mL13F7nhNCo1N7jEZ51JEEKpds/sOdmzWombFTZyyMzK56
48SPlBkNvDhrjFHj2+hSkmGCfgO9OogS/9y9aFUCKw7ace5WPV2k5Y9Gm6RM+cov
8jujdvWsMfy8B7gkkyByZzSP6HN2sEhz2MRLf1rHeTdROtV1sxE9pJXR30E4qq0C
/NUwRu+n5aiULF8MCgdWKqOhs8XuE6A5HYXf3WCHWzu3sRC70LNcfW8RCGx2/pQA
y5YZPa5XzYJdCV0LUxTrGlfCm+u3xR1TcYoK2OHYpK7i/BXVE1jqXIrobIvLcwkt
3QNbZLaT98vV7oWKyathqj0+44gqBg==
=QdEp
-----END PGP SIGNATURE-----

--neci4vy5fgejob6e--

--===============7622204102617195780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7622204102617195780==--
