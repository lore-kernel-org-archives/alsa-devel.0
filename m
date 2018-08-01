From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND][PATCH] ASoC: Intel: Power down links
 before turning off display audio power
Date: Wed, 1 Aug 2018 18:13:20 +0100
Message-ID: <20180801171320.GI5509@sirena.org.uk>
References: <1532350931-7324-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6362772438309078520=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 39E3C2677A3
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 19:13:29 +0200 (CEST)
In-Reply-To: <1532350931-7324-1-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ALSA ML <alsa-devel@alsa-project.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6362772438309078520==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Content-Disposition: inline


--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2018 at 06:32:11PM +0530, Sriram Periyasamy wrote:
> On certain platforms, Display HDMI HDA codec was not going to sleep state
> after the use when links are powered down after turning off the display
> power. As per the HW recommendation, links are powered down before turning
> off the display power to ensure that the codec goes to sleep state.

Pierre?

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlth6i8ACgkQJNaLcl1U
h9ByjQf9HJ44+026+s/Gsa1O0BrwFD4A+qwH9PUXsS4y5zsBktw5jbPY7yrzUVq/
zOTQZUgRpWKDXoSeevxzNHkndApIvfMWZbPC2s6C/n4cv0Y44ghe0qmC6V112YMn
7BYfUT5b7UsQkx/yW13oeNlC7a8oCI2ej/JVp/b/vaw6h+b+DTsuMrWGMt5wt/J/
lgi5SQ1pg7Vk82ow/LMfbkR1hd0C+ARcB9IzK09V0pu+b/uoZd+G9uK14SIpCFfD
ga3oE4evPzgXr53Hh25/YM7NYm3tKyHmEa/r+iO+mHfe/8EeVNwMnMEbqrd0ZxsW
QxyIkp/OnkxeV2syKBcMd/umWrEe9w==
=SXFM
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--

--===============6362772438309078520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6362772438309078520==--
