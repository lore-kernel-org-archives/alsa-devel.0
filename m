From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/5] ASoC: dwc: Iterate over all channels
Date: Mon, 22 Dec 2014 13:53:01 +0000
Message-ID: <20141222135301.GQ17800@sirena.org.uk>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <67cea1f0a74c333ec2048c7796cda37302d45e95.1418826016.git.Andrew.Jackson@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UJEqbsikIZBgizPR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <67cea1f0a74c333ec2048c7796cda37302d45e95.1418826016.git.Andrew.Jackson@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jackson <andrew.jackson@arm.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--UJEqbsikIZBgizPR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 19, 2014 at 04:18:06PM +0000, Andrew Jackson wrote:

> The Designware core can be configured with up to four stereo channels.
> Each stereo channel is individually configured so, when the driver's
> hw_params call is made, each requested stereo channel has to be
> programmed.

This is quite unclear to someone who doesn't know the hardware, is this
a bug fix or a new feature?  It looks like it's a fix...

--UJEqbsikIZBgizPR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmCI8AAoJECTWi3JdVIfQ4UwH/inEk5U0iocLQ+aTXSE3Atnp
VM/qo3kMfH+Dd+B02dxwB36/jJZ7EC/Xs77iI7lWZlaOadKgK4ZctfLXkaTsDQ4V
ZbELnBVSGR12/6mjWCRz60YzavpVgX0/ooLrFf+pCGGE39Wnw0w/y3JCowXfB14Y
jIfsHV4pMb+kj6RbAZ4LgoIrHPLEPCNhMuAUPR1E1HMOo+HAnP/ECY51mQs/Wjyf
ttdekwDJQv1YpsWr8miNCK46o1m4VF4VYdyXJBvZurMdD0OY1w+IFuUH7t/IvVqw
KRFJymTXpTY5cd7y1CXKBPeoBdFb9WEMjOW2cxftmnLCZgqE8l3DnC9Te1ntiTU=
=DUQ4
-----END PGP SIGNATURE-----

--UJEqbsikIZBgizPR--
