From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Enabled button jack for BSW
 platform with rt5650 codec
Date: Tue, 5 May 2015 23:30:28 +0100
Message-ID: <20150505223028.GK15510@sirena.org.uk>
References: <1430785160-72477-1-git-send-email-yang.a.fang@intel.com>
 <20150505214902.GG15510@sirena.org.uk>
 <CAEUnVG7MW4z4kHipcCWEFAvkqFEu42k4ax4+S2YDvexwJjHdPw@mail.gmail.com>
 <20150505221415.GA109322@mocha>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4876765031728197596=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AD4B2604A7
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 00:30:34 +0200 (CEST)
In-Reply-To: <20150505221415.GA109322@mocha>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yang Fang <yang.a.fang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, srinivas.sripathi@intel.com, Vinod Koul <vinod.koul@intel.com>, Praveen K Jain <praveen.k.jain@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Denny Iriawan <denny.iriawan@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, kevin.strasser@linux.intel.com, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============4876765031728197596==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WAAb/gZE1HXiAv4U"
Content-Disposition: inline


--WAAb/gZE1HXiAv4U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 03:14:15PM -0700, Yang Fang wrote:

> now rt5645_set_jack_detect in rt5645.c aleady split jack into 3 like
> below. maybe we need Bard to combine them ?

It's fine to do that in the CODEC driver and actually good for the
headphone and microphone - the board can always pass in the same jack
for all of them but if it does have split headphone and mic jacks then
it can do that.

--WAAb/gZE1HXiAv4U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVSUSAAAoJELSic+t+oim9HLEP/RnN0y0bB5kUSGImKfp2kazs
fNhXrrwWBbTFqMcBARt0hINy04GISY2okJlzgzO0bb8jtLKcvSiN01BFsmu2Tx48
IA3wytRlzZmxx5Y85tR4pPCudfrZM6I0HtuTwLakRroupSKO8Y1DLyKu5m2Mkho+
YW1ScAuN+H2fkJ0GfMZ+80x0md4yHtvaDyGs5HVgGx2fFYboUCtAKy2sgUsZ5sPA
k1m8fvgnQICYCy8e0ALV3a/dMaRGkY4iMEsGk6Z8VQ3QL6XXgYBRrwIu7hCZQVpc
9myv7Rd03nTYQ1/d2m8/VFI2w+0zQcEVfML9puhHBhmWPyPxm5VGP5IJ/LyREHcK
NWevV546L90Ih6sMOEZDxNA21DLP+4dQO5BHnpHNKex02zvpJ/q1/L+QsQXQ9ivf
xTSAeeQQv2Ddq+JT7X315R/mS+mqxZLyOtqrWDAevUgS+VhzIwxH++oQMgKmRJzm
xAw/XMof/k+/n6r470jCGh9cPQqpm/8aLsVnud0Pu54DGWAMFu0nAuj47b2TzC+q
wP3BZji3V20ejupX2PbLj8kxYJieKckeefRszq2oniJnRiKhn/ionIrYfRZXr5ii
/MQ+tsJWREdb1nSDrp+d07bfvLFZIp8DDrUtSGDVRlOk5DTP4peG47H16EdSHmXF
PvUZYnRMusvjUTSapm1y
=tz7C
-----END PGP SIGNATURE-----

--WAAb/gZE1HXiAv4U--

--===============4876765031728197596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4876765031728197596==--
