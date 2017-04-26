From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8824: new driver
Date: Wed, 26 Apr 2017 15:44:28 +0100
Message-ID: <20170426144428.q5aubmdgpbuyqjhg@sirena.org.uk>
References: <1492680311-11241-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4757907459587106376=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AF0C2670DB
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 16:44:42 +0200 (CEST)
In-Reply-To: <1492680311-11241-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============4757907459587106376==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rfi3fbq62ikfjyb5"
Content-Disposition: inline


--rfi3fbq62ikfjyb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 05:25:11PM +0800, John Hsu wrote:

This is mostly good so I'll apply it but there's a couple of small
issues, please send followup patches to address them:

> +	SOC_SINGLE_TLV("Speaker Right from DACR Volume",
> +		NAU8824_REG_CLASSD_GAIN_1, 8, 0x1f, 0, spk_vol_tlv),
> +	SOC_SINGLE_TLV("Speaker Left from DACL Volume",
> +		NAU8824_REG_CLASSD_GAIN_2, 0, 0x1f, 0, spk_vol_tlv),
> +	SOC_SINGLE_TLV("Speaker Left from DACR Volume",
> +		NAU8824_REG_CLASSD_GAIN_1, 0, 0x1f, 0, spk_vol_tlv),
> +	SOC_SINGLE_TLV("Speaker Right from DACL Volume",
> +		NAU8824_REG_CLASSD_GAIN_2, 8, 0x1f, 0, spk_vol_tlv),

It would be better to name these controls so that they match up with the
names of the matching DAPM controls (so "Speaker Right DACR Volume" and
so on it seems) so that userspace can join them up with each other.

> +	/* Class D gain 9db for 1R and 2L */
> +	regmap_update_bits(regmap, NAU8824_REG_CLASSD_GAIN_1,
> +		NAU8824_CLASSD_GAIN_1R_MASK,
> +		(0xa << NAU8824_CLASSD_GAIN_1R_SFT));
> +	regmap_update_bits(regmap, NAU8824_REG_CLASSD_GAIN_2,
> +		NAU8824_CLASSD_GAIN_2L_MASK, 0xa);

Leave these at the chip default, they=20

--rfi3fbq62ikfjyb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkAsksACgkQJNaLcl1U
h9CfWAf8DsSQrPdAeldYBYMUsQREXIHjnWCiYvrq1pw3YstHWRUGrw3CSruzC/F2
ULTQ3wIxRyXVt3hFGs0Wf+ZurwKKefcinig9HOPWJzgDPL+ubsgFE97AAdGBb8A7
7WTQNSmurgn3pjO2R7M8WfxWayLA1avoKX1xh8HUAatkkdHnHi5UpGqAteY9GU7T
C7HJXHKf3YolwOWR9U75XtLHh7fV3F/GdSGk9DsU0y4UXCsAR0q/AEc6nR6NpSmc
S+tcMXkBJkIFG/B/9g+XvHpYfKrwkXmlw/V0jSwu/W7oIie8LckYM/IB1eM0mmSr
uMoqpUTBR00IJxtQfN7z8wF3rCQpUg==
=lbFi
-----END PGP SIGNATURE-----

--rfi3fbq62ikfjyb5--

--===============4757907459587106376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4757907459587106376==--
