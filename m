From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: da7219: Update DAI clock binding info to cover
 WCLK/BCLK
Date: Thu, 21 Mar 2019 12:21:52 +0000
Message-ID: <20190321122152.GA5684@sirena.org.uk>
References: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
 <a2e2ae888b3c2fbcaab3e4791ce98f877e3d38ff.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a2e2ae888b3c2fbcaab3e4791ce98f877e3d38ff.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Akshu Agrawal <Akshu.Agrawal@amd.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2019 at 05:49:30PM +0000, Adam Thomson wrote:

> -- #clock-cells :  Should be set to '<0>', only one clock source provided;
> -- clock-output-names : Name given for DAI clocks output;
> +- #clock-cells :  Should be set to '<1>', two clock sources provided;
> +- clock-output-names : Names given for DAI clock outputs (WCLK & BCLK);

This might need some handling later on as it's a binding change, however
I can't see any current users so hopefully nobody will notice.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyTgeAACgkQJNaLcl1U
h9B0qAf+PFsG2TAKEIRT9VDw6jBv1x9NUTOiIOByLkIgFdaUQ9F+Ve0TdGxHQncO
5h7ubsO0hb7whjsTNTK7LjCQS5Ibz9b8Upilqtr3Mg9uHi/gJCpKwve7T0mzMeVZ
wHWk26x5BdInzZOKHn8V2lu8kBKAiapJ0/CUp2r7qOTPhsfQM/bNU+JaVf0JjTQv
D57JjwlCblHOvi5PN35jzz/f7d78C4cj573MDtV5YNVTjSmRZ0hneNpU4AsTQHhA
K/DNAGbPN7juXURKxQWTFFo7UTlRwBrpiV4e5KgpkKo/8i/i0Ue2IcOESDQodGVG
UlcKlS76bSdREljWeVz4MBqK9/BylA==
=UT0f
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
