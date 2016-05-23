From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4 v7] ASoC: dwc: Do not use
 devm_clk_get() if using platform data
Date: Mon, 23 May 2016 17:57:13 +0100
Message-ID: <20160523165713.GX8206@sirena.org.uk>
References: <cover.1463996627.git.joabreu@synopsys.com>
 <d288d87fc0f1c07f4d301dc08d32b1bf9915446c.1463996627.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1919943140707011726=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04E4626043A
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 18:57:30 +0200 (CEST)
In-Reply-To: <d288d87fc0f1c07f4d301dc08d32b1bf9915446c.1463996627.git.joabreu@synopsys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, linux-snps-arc@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1919943140707011726==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4PR/+zdSfVlxyWed"
Content-Disposition: inline


--4PR/+zdSfVlxyWed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 23, 2016 at 11:02:23AM +0100, Jose Abreu wrote:

> When using platform data the devm_clk_get() function is
> called causing a probe failure if the clock is not
> declared. As we can pass the clock handler by platform
> data call only devm_clk_get() when platform data is not
> used.

No, this is broken - if the device needs a clock the device needs a
clock and clock names should be static rather than passed in via
platform data (indeed NULL is a perfectly valid clock name).  The system
integation should map in a clock as needed, if it's just a fixed crystal
or something then just register a fixed clock and connect it up.

--4PR/+zdSfVlxyWed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXQzZoAAoJECTWi3JdVIfQR8kH/06w5PKPgXydQmaUoZe827Zr
TZxCfzV3r2AffBSDGIK5rXscDBzd6obkbc8+FHgC7MqZpEjtHBLRCiy+ukFdrsZ2
Ue+c5dLvVpx46OfXqmBfRMhOxBqSY5JfE9rYBkrZo5M3Q+cwe4BLJU9ErubfU34s
vG6JlFXH9vQmsUahC4F6kL+Sffhazmzt4dBsWzasgcohBbuyQ4dGCLNdwG8BTobz
qkRVx2K1YaaKz0zoKK0X3MrW6ETvtnUuuNeVz5vdhGahOG/eZHvFqv4GaLycTvVd
9mDQV8pZzvConI0GWOBvNjzF2hQgXBgM1Gj10P9xeBAH7fpY1aJOCoZGlj9diX4=
=1xV8
-----END PGP SIGNATURE-----

--4PR/+zdSfVlxyWed--

--===============1919943140707011726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1919943140707011726==--
