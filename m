From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Add ACPI support
Date: Tue, 16 Aug 2016 18:20:06 +0100
Message-ID: <20160816172006.GW9347@sirena.org.uk>
References: <20160814111823.1782-1-john@metanate.com>
 <20160814111823.1782-2-john@metanate.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7082325023874399217=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AE66C266807
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 19:20:26 +0200 (CEST)
In-Reply-To: <20160814111823.1782-2-john@metanate.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Keeping <john@metanate.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============7082325023874399217==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NUQP2JP/Zo+En7Or"
Content-Disposition: inline


--NUQP2JP/Zo+En7Or
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 14, 2016 at 12:18:22PM +0100, John Keeping wrote:

> The Chromebook Pixel 2015 uses this codec with the ACPI ID RT5677CE, so
> add an ACPI match table and support for reading properties from ACPI.

This would be a lot easier to review with a concrete description of what
"support for reading properties from ACPI" means and probably also split
out a bit so that different things were being added separately.

> +/* GPIO indexes defined by ACPI */
> +enum {
> +	RT5677_GPIO_PLUG_DET,
> +	RT5677_GPIO_MIC_PRESENT_L,
> +	RT5677_GPIO_HOTWORD_DET_L,
> +	RT5677_GPIO_DSP_INT,
> +	RT5677_GPIO_HP_AMP_SHDN_L,
> +};

If these are an ABI you should explicitly assign the values so that they
can't get remapped by future edits.  If they're not an ABI I don't
understand the comment.

> +	if (ACPI_HANDLE(dev)) {
> +		u32 val;
> +
> +		if (!device_property_read_u32(dev, "DCLK", &val))
> +			rt5677->pdata.dmic2_clk_pin = val;
> +
> +		rt5677->pdata.in1_diff = device_property_read_bool(dev, "IN1");
> +		rt5677->pdata.in2_diff = device_property_read_bool(dev, "IN2");

What happens if someone makes a machine which uses the DT<->ACPI
mappings (especially given that this is currently undocumented)?  That
would not work which defeats the whole purpose of using the device
property APIs.  Shouldn't we be accepting either property?

--NUQP2JP/Zo+En7Or
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXs0tFAAoJECTWi3JdVIfQvXwH/1dddlrOZLW8tbq48xya5Hil
3bXIVCLTlG+Yp6HZPZXHjuvqBjrk3AKLT4ikn1VkePKT7Uf80Zu3X9mXxDVXKbCS
5uXXsLey6TfWOWqUeMdIP/1MLUS2X+Lf1vPEiS18HMhoDfoIA3Sd3T+d5BpFxiP7
uioC7bBDtYZTKT1Iho/QENI1JwjXQOERmSSymNKs74CGGBppVsgkqIQDTss/jTwr
M9/KaeBNE4lC3Qi4yJiL4VxoLdKkEE8up0tUAQWttyoZbGnaTVUm7+TiQgqbrZDE
vGUTqd+3AjxgQG3Jz/l2QTJ2XT1O4FR645ew7W0iSts5seEt8dSDqCniYeDNhPY=
=FsiY
-----END PGP SIGNATURE-----

--NUQP2JP/Zo+En7Or--

--===============7082325023874399217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7082325023874399217==--
