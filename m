From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: io: Remove hw_read() operation
Date: Tue, 4 Mar 2014 17:27:23 +0800
Message-ID: <20140304092723.GH13126@sirena.org.uk>
References: <1393924251-6754-1-git-send-email-broonie@kernel.org>
 <53159AD0.5000800@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4954611203752950549=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D8A6265745
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 10:27:35 +0100 (CET)
In-Reply-To: <53159AD0.5000800@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4954611203752950549==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2014 at 10:20:16AM +0100, Lars-Peter Clausen wrote:

> >  	codec->write = hw_write;
> >-	codec->read = hw_read;

> But this part will break snd_soc_read() and with it basically every
> driver that has any controls or DAPM widgets.

Bah, so it does.

> I do have a set of patches that moves IO to the component level that
> will clean this all up quite a bit. I'm just waiting for Xiubo Li
> snd_soc_codec_set_cache_io() cleanup to be merged first, since it
> will make things a bit simpler.

That seems to be going really slowly...  in any case the real fix here
is to get all the users converted over to regmap.  We could also just
do something similar to what we've done with update_bits() (where we did
it for locking) which is going to be much quicker.

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFZx4AAoJELSic+t+oim9GMIP/1QgHAvsrflrE3FiURO6KhFg
IPw3NS0Jn0tMfAIAF+CpIHeKTHiX6mdschPXsN6ayNpGsaJbksSRngSkTmLntHro
TkAKnEwVZaZxpg/Xjp1cUBP5XR0hAbYxUyXDtFegi+ooHvkz57Axp9h0szF82EP8
dfTWzMWQH0pkTdihAREGzL3kVCuJMndoEmfHDvq2oqsB2XZY0GTmBDImkzpc/2N7
+DKUCoXAW1ZDMkFg4FAE7bwwozKI4J6ePf9B+P8OMU2Hs6CLSMr7SomIl/rd5e4D
Ah7hOGw3sAtrN6SWQsOdqA/FOsnZOkwHx80d22r7MkIg19mLGpfqmqFI7zQhOh6f
vQJtljpvlxQ5iOChdJnGrM6PpQV08Cdu/KImgMTP99d+N7F/E1Z4C/qCzX0hh69J
RTub+uV0pSSUHLvXldJL3pXoeXgoNy6QBa099QpQumc7Lz1M8C9W5TrqIKs4MY2I
ifUcv9zDToqtLB70zX/xXlWTvu/qHR5IMgYJ7H5K2Uy9MCXluxKHuTsmriyT/yJN
oQ4gPSkxNEh4GgFZWZduNfw+0kb7C5K/wLNhqWVO0YjID+2FM2NJ6jmEi4Kkg+Ib
UoWXd7kCllXu28MK9T9VFnmvJqnRJKymtz5IDj9Y7MnetY7o1BHNVn2FhKrlBJIx
T4HWVcUzvxSVWKBrpmb+
=3AJ5
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--

--===============4954611203752950549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4954611203752950549==--
