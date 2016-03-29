From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3 v2] ASoC: dwc: Add I2S HDMI audio support
Date: Tue, 29 Mar 2016 11:22:22 -0700
Message-ID: <20160329182222.GC2350@sirena.org.uk>
References: <cover.1459174494.git.joabreu@synopsys.com>
 <538be366488bf0d7633d702f2d0bab16707b7a47.1459174494.git.joabreu@synopsys.com>
 <20160329173158.GB2350@sirena.org.uk>
 <56FAC355.1040705@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0449166296=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <56FAC355.1040705@synopsys.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: tixy@linaro.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, Alexey.Brodkin@synopsys.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, yitian.bu@tangramtek.com, wsa+renesas@sang-engineering.com, laurent.pinchart+renesas@ideasonboard.com, tiwai@suse.com, nariman@opensource.wolfsonmicro.com, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, Maruthi.Bayyavarapu@amd.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Vineet.Gupta1@synopsys.com, buyitian@gmail.com, robh+dt@kernel.org, perex@perex.cz, lgirdwood@gmail.com, CARLOS.PALMINHA@synopsys.com, galak@codeaurora.org, alexander.deucher@amd.com
List-Id: alsa-devel@alsa-project.org


--===============0449166296==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aHyShe78FfJzbeER"
Content-Disposition: inline


--aHyShe78FfJzbeER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2016 at 07:03:01PM +0100, Jose Abreu wrote:

> The major part of this patch is the adding of an ALSA platform driver so that
> audio comes out of the box in AXS boards but we also added functionalities to
> the i2s driver and performed one bug fix related with the mask/unmask of
> interrupts. I will split the patches but they will depend on each other.

If you want to add a new platform driver you need to add a new platform
driver, not shove the code into an existing driver for a seperate IP.

--aHyShe78FfJzbeER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+sfaAAoJECTWi3JdVIfQYpEH/RzPMkqAI7jWNntBaun7Hkxz
F+FfQAT68EzXhK+14LbGZ/yFG4CYyW5oFIDL9CtZjqQoVq1AtOVV9eU7aOpgOjkn
IJVz9QB1uncmNLmQrUkql6wDjcao6MjocVHPHaLr6myqvEaaGzCGIKB/5QdbR95H
PEcufiFwW5iabn3ExjNA5u1vVQmEC6a5bjwVgFKO4QzcwajokZ4UvOWeRKHPDXcV
t7q+A0yF5w8G5e4IchX1pcdlcJ+jPC2LCB+KTUGvljjjEYbikfzuniAZBZdQIiJD
eP//Var3mV6UjXZeZ1yfo+nPd2Rf94SAj5wcd6CFZJcFm0CIdpOE6UX/MIhtS4U=
=KF9a
-----END PGP SIGNATURE-----

--aHyShe78FfJzbeER--

--===============0449166296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0449166296==--
