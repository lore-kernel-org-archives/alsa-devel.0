From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Do not traverse widget hooks to snd-soc-dummy
Date: Thu, 17 Mar 2016 15:42:36 +0000
Message-ID: <20160317154236.GH2566@sirena.org.uk>
References: <1458127071-14417-1-git-send-email-harry.pan@intel.com>
 <20160317095438.GD2566@sirena.org.uk>
 <1458211115.965.13.camel@intel.com>
 <20160317112514.GE2566@sirena.org.uk>
 <56EAA4FC.5090408@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qABWltju4eaUXBmg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EAA4FC.5090408@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "Pan, Harry" <harry.pan@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gs0622@gmail.com" <gs0622@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.com" <tiwai@suse.com>, "perex@perex.cz" <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org


--qABWltju4eaUXBmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 17, 2016 at 01:37:16PM +0100, Lars-Peter Clausen wrote:

> I'd say as a quick fix for stable check that card is not NULL in
> dapm_widget_show_component(). And as a longterm fix get rid of dapm_widget
> file. Nobody should hopefully use it anymore with debugfs being available as
> the far better alternative.

Getting rid of the file is definitely not a bad idea but I'd still like
to see us make the dummy component more consistent with other components
in order to minimise the chances that we'll run into other special
cases.

--qABWltju4eaUXBmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJW6tBrAAoJECTWi3JdVIfQptYH9Ah627SJUZ8xbaGKvsWNa14o
LAx6C54MDeDTYvOLXFK879Mz5IW8bKrFO6VsQTWi4OmmKjyqRXiCOlR5v4TKsR/d
lBsBUM9dHFzmt/8wCvyPpx4TR+Vst9ethMSnKpO0zK8tbcqPLhYmpntnz1Xtx3ze
Qy37JxR+zyDOijEWvxm06klKGTjW1P/3KCpzsHgkjYm+HdS9YmzGPDEXmdxvOUY1
Vdeyeh8lSvh0O7/gEg2n6lXiFTiacAIxUTZXkWw12P5oXfpd6E9ZpKUp9YeTCyvT
2Sbyz0oiEum4RchDaeOkjIhU6EfVuPnZpV2uvXSH0f6pxUxvxSLZfYzEX6xRWw==
=L2EW
-----END PGP SIGNATURE-----

--qABWltju4eaUXBmg--
