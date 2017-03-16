From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE"
 to the asoc tree
Date: Thu, 16 Mar 2017 14:06:53 +0000
Message-ID: <20170316140653.jjnta4le6kws36l5@sirena.org.uk>
References: <20170210094133.11382-3-mylene.josserand@free-electrons.com>
 <E1clbY9-0000DH-LY@finisterre>
 <CAGb2v6428PpYPzpHngLgaeziwKN8u-TYiNO1bs7TFw-7VrQOAg@mail.gmail.com>
 <20170315134323.i3pvla3pzejmkxwh@sirena.org.uk>
 <CAGb2v67-b+8CM0MqhT_YQeuNxEnVoxG-COZPy8LW32Eb-QE67Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3jtbdw426c2622qy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v67-b+8CM0MqhT_YQeuNxEnVoxG-COZPy8LW32Eb-QE67Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--3jtbdw426c2622qy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 15, 2017 at 10:15:22PM +0800, Chen-Yu Tsai wrote:

> It depends on the second half of commit 4aa8146c89f3 ("ASoC: sun8i-codec:
> Remove analog "HP" widget"), which is also a cleanup. Would it be OK
> to pick these two over to fixes then? Or should we send a clean version
> instead?

That also doesn't pick over cleanly, can you send a new version against
Linus' tree, that'll be easiest and safest I think.

--3jtbdw426c2622qy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljKm/0ACgkQJNaLcl1U
h9DIlAf/UTj+suKqDu7tfUUfI0UoxqbDU0X/uYOyL0t3tCb225zmt/K/XGqzUNd6
KUSKRa9dQP0Wjp+BcW/5imxNcdWmi0SX1Un8iCoNLt6FKNHZ6947jvgaglH60dF5
yu6Kgg9dlqJ/IL0pRcnfw2k8UFsfwyCqOYF0ZK9C/dr5Cbz+GvHhxMlXubyB6ENq
Ja0sDn6mtb8QSDpjSXenjyRYw4n+HX/pwmEheC1XYskgWNnPNqHumu+If9SkVcHP
IhvlAiZSW3pEsa3zJsJ8FjsNWjAxv/iNnUlCJagefA2qV0ypuvLFs3NNdOZXWG/5
pqCZwbeIaGOnvF7w8FxJFTn29sCx0g==
=fzGz
-----END PGP SIGNATURE-----

--3jtbdw426c2622qy--
