From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/19] ASoC: Intel: mfld-pcm: add FE and BE
	ops
Date: Mon, 23 Jun 2014 12:26:26 +0100
Message-ID: <20140623112626.GB24291@sirena.org.uk>
References: <1402662848-24534-10-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4683129880026252035=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AC7162617B5
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 13:26:30 +0200 (CEST)
In-Reply-To: <1402662848-24534-10-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4683129880026252035==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4rQ9lIe3OahbhU4J"
Content-Disposition: inline


--4rQ9lIe3OahbhU4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 06:03:58PM +0530, Vinod Koul wrote:
> Now that we have added code for managing DPS piplelines we need to add the code
> for DSPs FrontEnd and Backend dai.

Does this bisect OK?  I'm not seeing anything that hooks the DPCM stuff
up here but I might be missing something.

--4rQ9lIe3OahbhU4J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqA7fAAoJELSic+t+oim9L1EP+gK9Z0J32QbMmCyP4oJtht7G
t1yAuNUnAvbsjHftfgs/IWQ9sNUWYnym/YbKuRuO9yWbM7lHc8ukF2cmZ0t6Cvvv
yBlmQn2QRoI8ehTkwfgmtu+vv/zr/ogphLf8OcUHz3LnsA0jhhVAWmHr0IdjhPV3
I+HGTVnRtcBVoD4TvvnAvJtslBKOvG4QnFy4VlEvfwVJJB12BTsIIs1iZLpPiuP1
b2iU3rzTMsvcVNL6w3B0RiDrIAYsDT1VXDpXFQ0L+Tj2nMkgl/iCcV74y5KJJv7E
m3HgTFaxkfoBLQgfeDOr7rctXjZl0LfSUbjMh1ROzLDjo9lYzV5cBbarDZ1eL53n
ObHsq8TG02RBd0o+mrZyIePdYxkhsOS4inTsG4QzudGTnxSFGeykkbIphpanKni4
NNWZxAK0Zjq5Fkub1ujQHQ+ZNMzpyTf6yoKUa966xwE4qkGA170S1ahY3VLl+qCg
fepiF0zHkVWmOhkmXk3n1GvQHBRoyhAXeODnNripU3FR2eZndrbfp37YJMRlADRU
+ZpA3XPFRIE7Bhb+9tkiNMcRunW0ml1UexgTaMK1hsMnuogcZFuagSe2qNJ8PqV2
X/gwyaioSHFa5TMvw1ss4coWfOKcyAG89H8Tk+Bt7dG2q5Wbv1PQyBhO/gTqeSnk
9KtWOXujPSV+05NlEPTM
=4jyY
-----END PGP SIGNATURE-----

--4rQ9lIe3OahbhU4J--

--===============4683129880026252035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4683129880026252035==--
