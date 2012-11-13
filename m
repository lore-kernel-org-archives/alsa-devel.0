From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 2/3] ASoC: atmel-ssc-dai: register dai and pcm directly
Date: Tue, 13 Nov 2012 18:20:40 +0900
Message-ID: <20121113092038.GU18224@opensource.wolfsonmicro.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
 <1352706028-750-3-git-send-email-voice.shen@atmel.com>
 <20121113083031.GP18224@opensource.wolfsonmicro.com>
 <50A20E82.9020704@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lzfPtAjrR1KYNfg0"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50A20E82.9020704@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--lzfPtAjrR1KYNfg0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2012 at 05:10:26PM +0800, Bo Shen wrote:
> On 11/13/2012 16:30, Mark Brown wrote:

> >Why are you changing this?  Single devices are supposed to specify -1 as
> >their id.

> This is for non-dt support, using the id to tell which ssc will be
> used to remap into audio subsystem. Maybe this is a mixed up usage,
> however I can not find good solution, any suggestions?

The machine driver should know which SSC it is using all by itself, it's
specific to a particular machine.  This is how it's been doing it since
it was written...

> This is a similar implement as 7840487cd6298f9f931103b558290d8d98d41c49

Don't quote raw commit IDs, they're not legible by humans.

> Yes, this patch is a little more than registration, however when
> change the registration method, the related code will be affected,
> so also clean up them in this patch, do I need to split this patch?

Yes, one change per patch.  Having many unrelated changes in one patch
makes it very difficult to review anything.

--lzfPtAjrR1KYNfg0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQohDgAAoJELSic+t+oim913EP/RAWCm+D70KLNYD8wzzUE4FI
Lr09wQchC28JdQ9CSGaxayZP2H4GowRsGjtFDatuhVUWgQRej3YRbYNHq++1pLct
zq8uuSbK3wdTHcFZ8sBmGmNb07U+9prLL9Bxs7Enez1D0BnJFpJr6TNDE/o8zYqT
HPHedBlelQdaLSQjI5HF6cg1WVdRR12+3tJ7hvHYcC135LacNNg9VfP0EPkHYxrn
ySQKmsfxVlv0cpICuSzNaP5w7BKNdMT9saklRCNjiyOexWRazJIDRsjvEQI2DXzi
koTVTJmkWurOpZfWHBFsOluveAPpCMHy4zpxr4Jkq8xJMVMDjnQhdSuxSiYDaUpT
x11nVbtHRJJb6NQGs2EvMiyumOFUwlgyQB+q0/eIKY4XQ/D1BH0wmHA9+7QSTxz3
h3C6RwL/0A7aTjEWmSUGsi6sM3bCSfyoz/xYxreSI6pCQ9Q4JNiU0fCX5M/zLYWg
X96oRjmhcxDVb8bmYQUSG2eTByUSl5AzFeUlTlk12qT2uul6gd3p5165OUbLAVx1
TREYLutadcD69mJ1MR0Jliid+0kpDXTVUHD6rhCUFXo9mlsVBVPrSa5nW/Dlhwfb
rgCX8wUqylQLhn06XgXtansqWImGPgl+/+DcQBarUlXdVlRy864eioZyCJ1Q5RIo
nQdIjZHRBe+CARqCM43E
=nxsn
-----END PGP SIGNATURE-----

--lzfPtAjrR1KYNfg0--
