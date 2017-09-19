From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: codecs: msm8916-wcd-analog: use btn0 released
 detection
Date: Tue, 19 Sep 2017 13:11:47 +0100
Message-ID: <20170919121147.wtpebx6p377cctvc@sirena.co.uk>
References: <20170913204355.26186-1-damien.riegel@savoirfairelinux.com>
 <3485d646-12fd-4435-1bae-87af9a1a857e@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hdo4m2v6a2l4xgea"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3485d646-12fd-4435-1bae-87af9a1a857e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--hdo4m2v6a2l4xgea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 18, 2017 at 10:08:04AM +0100, Srinivas Kandagatla wrote:
> On 13/09/17 21:43, Damien Riegel wrote:
> > msm8916-wcd-analog uses button0 to differentiate between headphone and
> > headset. Under some circumstances, button pressed and released
> > interrupts are not fired as the driver expects it.

> This is what we need to understand to find a right solution,
> I would like to understand on what is the difference in the hw layout.

These sorts of problems can also occur because of differences in test
process - pressure at different angles, different speeds of insertion
and a million other things.

--hdo4m2v6a2l4xgea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnBCYMACgkQJNaLcl1U
h9CplQf7BPr5ikD5I3WhxBW0uTUWE1B4A6xNjwZDtTDxg0pKVM/DH7b1+EU5RhlR
Pk4zaA4VFK67sGheSvSb+W/uBBuvx3fhUoWMhzbfaGXEBXyULY2sQS2ftZ5C6u+d
tqsg1v4WYWW+Hku76hNQfh/9Ncexa2cXYis6OETDEtayPxclK3yzlFx952g6+UAF
lkRTp9Z9wGQQQddXO2iM1ohD+xSUU218p7MQX2YalAedC/RfJDCPeOr4vAHT+MqS
0HPKConxK9nbQGm1PjfqrmLztLZPVVVwLZPatZrpYUrPAdz5p2TB5LxZfV7RJGO/
EprcRzCUYwwlmEAI8GcJbclw/c77wg==
=VXj9
-----END PGP SIGNATURE-----

--hdo4m2v6a2l4xgea--
