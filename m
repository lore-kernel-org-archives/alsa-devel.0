From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Intel: Add NULL checks for the
	stream pointer
Date: Wed, 7 Jan 2015 17:32:22 +0000
Message-ID: <20150107173222.GA2634@sirena.org.uk>
References: <1420639625-12133-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8855711006166459927=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CBF16265175
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:32:27 +0100 (CET)
In-Reply-To: <1420639625-12133-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8855711006166459927==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V3GHqwm1rrtpHsCJ"
Content-Disposition: inline


--V3GHqwm1rrtpHsCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 07, 2015 at 10:07:05PM +0800, Jie Yang wrote:
> We should not send IPC stream commands to FW when the stream is
> NULL, dereference the NULL pointer may also occur without precheck.
> Here add NULL pointer checks for these stream APIs.

Applied, thanks.

--V3GHqwm1rrtpHsCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrW2lAAoJECTWi3JdVIfQjW8H/0lUi0w9pwVFPXqlAJasvErX
EgzUOM0hYi649pgQ6ZaJ+0KEUiu6IZLUbBxbGYPese6Km6Y2Vghty4I1RY9T4IZO
pHPxmi8HxLu+ovW9+Um6Szls37Pweo1rFwhV3x9rKHQclWJyMLvqg7/62gHBQG4y
DukSCsBtyXP+aFzWLImTCJ1fPwZR3gLkyVCSwFVVXeTmR0+vN7NfW80DkBRgx5i5
4jMXisLxjOBIdhVqzPYGm8M/Ku8R3SCV81JS4PMHTmLcj4j7K7y3VcXMk7TCXnc/
pEB8Vw24mvD2h1A4CmgthDyFg21gRn27cvA8/7Jm7AHf9pNVjbZllxUuN5I3v0Q=
=biuz
-----END PGP SIGNATURE-----

--V3GHqwm1rrtpHsCJ--

--===============8855711006166459927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8855711006166459927==--
