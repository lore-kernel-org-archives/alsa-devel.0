From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3 v2] ASoC: dwc: Add I2S HDMI audio support
Date: Tue, 29 Mar 2016 10:31:58 -0700
Message-ID: <20160329173158.GB2350@sirena.org.uk>
References: <cover.1459174494.git.joabreu@synopsys.com>
 <538be366488bf0d7633d702f2d0bab16707b7a47.1459174494.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0133732050=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <538be366488bf0d7633d702f2d0bab16707b7a47.1459174494.git.joabreu@synopsys.com>
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
Cc: tixy@linaro.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Alexey.Brodkin@synopsys.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, yitian.bu@tangramtek.com, wsa+renesas@sang-engineering.com, laurent.pinchart+renesas@ideasonboard.com, nariman@opensource.wolfsonmicro.com, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, Maruthi.Bayyavarapu@amd.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Vineet.Gupta1@synopsys.com, buyitian@gmail.com, robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com, CARLOS.PALMINHA@synopsys.com, galak@codeaurora.org, alexander.deucher@amd.com
List-Id: alsa-devel@alsa-project.org


--===============0133732050==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q1SX3yAxAkj1z+aD"
Content-Disposition: inline


--q1SX3yAxAkj1z+aD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 28, 2016 at 03:36:10PM +0100, Jose Abreu wrote:
> HDMI audio support was added to the AXS board using an
> I2S cpu driver and a custom platform driver.
>=20
> The platform driver supports two channels @ 16 bits with
> rates 32k, 44.1k and 48k. ALSA Simple audio card is used to
> glue the cpu, platform and codec driver (adv7511).

>  sound/soc/dwc/Kconfig          |   1 +
>  sound/soc/dwc/designware_i2s.c | 385 +++++++++++++++++++++++++++++++++++=
++++--

Your changelog appears to describe the writing of a machine driver but
this is a large patch adding code to an I2S controller driver.  This
means I can't review your patch since I can't tell what it is supposed
to do.  If you've added functionality to this driver you need to send
one or more patches each of which adds a single feature to the driver
together with a changelog which describes what that feature is.

Glancing at the patch I'm not 100% sure that the features you're adding
are part of the Synopsis device but I'm not entirely sure.

>  2 files changed, 373 insertions(+), 13 deletions(-)
>=20
> diff --git a/sound/soc/dwc/Kconfig b/sound/soc/dwc/Kconfig
> index d50e085..bc3fae7 100644
> --- a/sound/soc/dwc/Kconfig
> +++ b/sound/soc/dwc/Kconfig
> @@ -2,6 +2,7 @@ config SND_DESIGNWARE_I2S
>  	tristate "Synopsys I2S Device Driver"
>  	depends on CLKDEV_LOOKUP
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
> +	select SND_SIMPLE_CARD

No, this doesn't make sense - the fact that someone has used a Synopsis
I2S controller doesn't mean that they have a system which uses
simple-card.  If the user wants to use simple-card they need to enable
it separately, this is the same pattern we follow for all CPU controller
drivers.

--q1SX3yAxAkj1z+aD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+rwMAAoJECTWi3JdVIfQ/NwH/iLn+lucQZx+h6XQbK3+LBRY
sqy6LGFdkcfp9k4TGDX6yM3+RTqNNzFr5NLWgOTANVFT8cEigO+Vx/g7pmcW1Zcv
zykqni+Gr8q2ij/i+E1AaCWtxIYt8IOWqoGAT6kmEOoGq97ghQjjdtcaCExWLPeX
4lLTRrYodZ/LQZDoX33jVI5N5FcTI8RHjzYCjfQry35VlL1QzXbHaDy+vB6CyEYq
MFqCNhcgl+wMuCgdvPWxPGqgcBD4UxmrNtlKqLY8K0tletQMxREirtDODcqs5rm5
QyLPItmwc/LSRoINUXh44/bOclcUr5Z67a/CxlaZ46xRs1ZaASmKSaFlcTzAB0c=
=y76O
-----END PGP SIGNATURE-----

--q1SX3yAxAkj1z+aD--

--===============0133732050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0133732050==--
