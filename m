From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: Intel: sst: load firmware using
	async callback
Date: Fri, 31 Oct 2014 12:51:01 +0000
Message-ID: <20141031125101.GW18557@sirena.org.uk>
References: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
 <1414666259-4450-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2870786083221342948=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 280E7265884
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 13:51:23 +0100 (CET)
In-Reply-To: <1414666259-4450-2-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2870786083221342948==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ge9m2ApKBiUdxzN4"
Content-Disposition: inline


--ge9m2ApKBiUdxzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 04:20:56PM +0530, Vinod Koul wrote:
> We would like the DSP firmware to be available in driver as soon as possible. So
> use the async callback in driver to probe to load the firmware as soon as
> usermode is up

Applied, thanks.

--ge9m2ApKBiUdxzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU4W0AAoJECTWi3JdVIfQcr4H/AgQdpABSUBaEVGJGR81mywe
c65ralM/mRqiCuEVXEre3TGQ+fxsgFzgF3y920sckuXfUVwv8Zha/I2/xtd7xqk0
i+FzWDw225hbQTUo5/P0IxyojfG78NVU+V3x0++KvbOiL0lMMdwCEEmb0VikrxQc
expxuCgxFGxLd9Tvunmr6jE/Iz8F+b+azVqXF/m4fkMgd8Y6aTeHm1b5FJDoVjgX
PuEZl0r0HFHhI4Cg8ioRaDv5TyfSy0b7ky1JStsbigEmb+KlS/BRjNomvotyBqG+
p6bFtvIwJ6qiGIt1D4vOHfWiauxCzMd5xV50VFW+PhE1ggRTJe8mQXw0os7Mdmo=
=Pi41
-----END PGP SIGNATURE-----

--ge9m2ApKBiUdxzN4--

--===============2870786083221342948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2870786083221342948==--
