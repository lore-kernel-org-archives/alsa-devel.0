From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
Date: Tue, 16 Feb 2016 16:38:40 +0000
Message-ID: <20160216163840.GA7544@sirena.org.uk>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5hbn7g7izt.wl-tiwai@suse.de>
 <2573932.AU4HSxN0NE@wuerfel>
 <s5h4md87hnu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h4md87hnu.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Han Lu <han.lu@intel.com>, Libin Yang <libin.yang@linux.intel.com>, Thierry Reding <treding@nvidia.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 05:18:29PM +0100, Takashi Iwai wrote:
> Arnd Bergmann wrote:

> > Another option might would be to change snd_jack_new() to return
> > an error if that SND_JACK is disabled, and then require all users
> > to handle the error gracefully, i.e. not fail the probe() function
> > but just not use the jack.

> Yes, I thought of that, too.  If select is no good option, it's a good
> alternative, indeed.

It's going to be a bunch of work to implement though.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWw1COAAoJECTWi3JdVIfQt5EH/0aN4z4M/NgihvRMVIuOgyHd
ZYxCqadzBjzKQnDhmch0qtMo+/sCo4TWoIx5FwYgB18w72z3qjZeAyFiTQiM3rgo
kjhCQ1QSZT6kbLvZmj/LNjMkOsAE18NpBwsCPY+YdZEmTAPMxOsilowMsKerztVI
Dw6OFytO2FwU0LWRTOU7PPlCEtRz9I5iZhfFdaGdSKNq46Y1WAmqzuW5iYazj4Fb
RWvXjCiq+iLPRQVzHw30rTctot23kbHtmsr95rOhzTH8wsdvzOdPNeuKrTNy1dVe
wYhfBzSduEPdJCdpjB5tC94kQgo8O8yTrYIQc9Iwj2lUSTSvlZj2Bf8XjK/BTeE=
=OGKM
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
