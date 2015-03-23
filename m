From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC:pcm512x: Make PLL lock output selectable via device
 tree.
Date: Mon, 23 Mar 2015 09:56:21 -0700
Message-ID: <20150323165621.GH14954@sirena.org.uk>
References: <1426886563-10936-1-git-send-email-hm@hmbedded.co.uk>
 <20150322162409.GG6643@sirena.org.uk>
 <550FE05F.6070204@hmbedded.co.uk>
 <105aef6a0e21488d8661d2a2823515d8@EMAIL.axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <105aef6a0e21488d8661d2a2823515d8@EMAIL.axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Howard Mitchell <hm@hmbedded.co.uk>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 11:00:53AM +0000, Peter Rosin wrote:

> Strongly agreed that we should fix this before it is published (I assumed
> that is was included in 3.19, it felt so long ago that Mark merged it...). My
> preference would be to remove the pll-lock things entirely though. Assuming
> you don't need it for your board of course, but I doubt it from your description.
> I used it to make sure I had understood the chip correctly, that's all.

It didn't make v3.19 so if we're very quick we can get this in as a fix.
Can someone resend a version which splits this into two patches, one
deleting the existing code to configure GPIO 4 and the other adding the
configurability?  I can then send the removal as a bug fix to v4.0 so we
don't have any compatibility issues and add the new feature for v4.1.

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEEW0AAoJECTWi3JdVIfQvzYH/2xMMbtkw/+CYYyy6RP2NlUS
YgABW2ZvwFwtgfD3DMjch3qW8iJy0rq5zDMLtpOtSrwCq0J1CC6Te4yzeuH3Gm04
W7VYzgpX7wPVkBCt59EVXYJ7NyW0XIw4XdDrltiDN0mLBiksvTLytjnbQYNFHedX
lDoAXfS1djTLYeNvpcj6J8fDAmiPI1681Hb22wGU96xre1NBrEbSzlevqIuYn3ct
06mq4ni/r9F4EwFh20YOrKU9gv1HuV372DvB2AZr4QYiNlmQQMmnGOAZc1n24S9R
2x2vUcoamftRe6FOa8MITZBN0MMbGMRH081ByP2TyG/MMSzDJhr6sGr2iuCff8w=
=uWR1
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--
