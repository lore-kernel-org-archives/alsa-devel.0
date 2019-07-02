From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: wcd934x: add support to
	wcd9340/wcd9341 codec
Date: Tue, 2 Jul 2019 15:44:11 +0100
Message-ID: <20190702144411.GP2793@sirena.org.uk>
References: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
 <20190702080920.22623-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6941996228354643436=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4280FF80058
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 16:44:12 +0200 (CEST)
In-Reply-To: <20190702080920.22623-3-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, robh+dt@kernel.org, srini@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6941996228354643436==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/NwG7NuG0/W8LcLh"
Content-Disposition: inline


--/NwG7NuG0/W8LcLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2019 at 09:09:16AM +0100, Srinivas Kandagatla wrote:

> +#define WCD_VERSION_WCD9341_1_1     5
> +#define WCD_IS_1_0(wcd) \
> +	((wcd->type == WCD934X) ? \
> +	 ((wcd->version == WCD_VERSION_1_0 || \
> +	   wcd->version == WCD_VERSION_WCD9340_1_0 || \
> +	   wcd->version == WCD_VERSION_WCD9341_1_0) ? 1 : 0) : 0)

Eew.  If you really need these make them functions and write
normal code with switch statements rather than abusing the
ternery operator like this, it's really not terribly readable.

> +static void wcd934x_update_reg_defaults(struct wcd934x_codec *wcd)
> +{
> +	struct regmap *rm = wcd->regmap;
> +
> +	regmap_update_bits(rm, WCD934X_BIAS_VBG_FINE_ADJ, 0xFF, 0x75);
> +	regmap_update_bits(rm, WCD934X_CODEC_CPR_SVS_CX_VDD, 0xFF, 0x7C);

What's all this stuff doing?  Should you be uing a regmap patch?

> +static int wcd934x_disable_master_bias(struct wcd934x_codec *data)
> +{
> +	if (data->master_bias_users <= 0)
> +		return 0;
> +
> +	data->master_bias_users--;

There's an awful lot of these refcounted things - are you sure
none of them could be supply widgets?

> +static void wcd934x_get_version(struct wcd934x_codec *wcd)
> +{
> +	int val1, val2, version, ret;
> +	struct regmap *regmap;
> +	u16 id_minor;
> +	u32 version_mask = 0;
> +
> +	regmap = wcd->regmap;
> +	version = 0;
> +
> +	ret = regmap_bulk_read(regmap, WCD934X_CHIP_TIER_CTRL_CHIP_ID_BYTE0,
> +			       (u8 *)&id_minor, sizeof(u16));
> +
> +	if (ret)
> +		return;

No error reporting at all?

> +	regmap_read(regmap, WCD934X_CHIP_TIER_CTRL_EFUSE_VAL_OUT14, &val1);
> +	regmap_read(regmap, WCD934X_CHIP_TIER_CTRL_EFUSE_VAL_OUT15, &val2);
> +
> +	dev_info(wcd->dev, "%s: chip version :0x%x 0x:%x\n",
> +		 __func__, val1, val2);

We don't report id_minor as part of the version?  Also the format
string there just seems mangled and not even internally
consistent.

> +	version_mask |= (!!((u8)val1 & 0x80)) << DSD_DISABLED_MASK;
> +	version_mask |= (!!((u8)val2 & 0x01)) << SLNQ_DISABLED_MASK;
> +
> +	switch (version_mask) {
> +	case DSD_DISABLED | SLNQ_DISABLED:
> +		if (id_minor == 0)
> +			version = WCD_VERSION_WCD9340_1_0;
> +		else if (id_minor == 0x01)
> +			version = WCD_VERSION_WCD9340_1_1;

This looks like you're trying to write a switch statement on the
minor version...

> +static void wcd934x_update_cpr_defaults(struct wcd934x_codec *data)
> +{
> +	int i;
> +
> +	__wcd934x_cdc_mclk_enable(data, true);
> +
> +	wcd934x_set_sido_input_src(data, SIDO_SOURCE_RCO_BG);
> +	regmap_write(data->regmap, WCD934X_CODEC_CPR_SVS2_MIN_CX_VDD, 0x2C);
> +	regmap_update_bits(data->regmap, WCD934X_CODEC_RPM_CLK_GATE,
> +			   0x10, 0x00);
> +
> +	for (i = 0; i < ARRAY_SIZE(cpr_defaults); i++) {
> +		regmap_bulk_write(data->regmap,
> +				  WCD934X_CODEC_CPR_WR_DATA_0,
> +				(u8 *)&cpr_defaults[i].wr_data, 4);
> +		regmap_bulk_write(data->regmap,
> +				  WCD934X_CODEC_CPR_WR_ADDR_0,
> +				(u8 *)&cpr_defaults[i].wr_addr, 4);

What is "cpr" and should you be using a regmap patch here?  Why
is this not with the other default updates?  You've got loads of
random undocumented sequences like this all through the driver,
are they patches or are they things that should be controllable
by the user?

> +		if (tx_port <= 8) {
> +			if ((tx_mux_sel == 0x2) || (tx_mux_sel == 0x3))
> +				decimator = tx_port;
> +		} else if (tx_port <= 10) {
> +			if ((tx_mux_sel == 0x1) || (tx_mux_sel == 0x2))
> +				decimator = ((tx_port == 9) ? 7 : 6);
> +		} else if (tx_port == 11) {
> +			if ((tx_mux_sel >= 1) && (tx_mux_sel < 7))
> +				decimator = tx_mux_sel - 1;
> +		} else if (tx_port == 13) {
> +			if ((tx_mux_sel == 0x1) || (tx_mux_sel == 0x2))
> +				decimator = 5;
> +		}

This looks like a switch statement, and it's not clear if there's
missing error handling.

> +static int wcd934x_get_micbias_val(struct device *dev, const char *micbias)
> +{
> +	int mv;
> +
> +	if (of_property_read_u32(dev->of_node, micbias, &mv))
> +		mv = WCD934X_DEF_MICBIAS_MV;
> +
> +	if (mv < 1000 || mv > 2850)
> +		mv = WCD934X_DEF_MICBIAS_MV;

This silently ignores errors, that's not good - people might
think they successfully configured their DT when they haven't.

> +	for_each_set_bit(j, &status, 32) {
> +		tx = (j >= 16 ? true : false);
> +		port_id = (tx ? j - 16 : j);

Please write normal conditional statements to improve legibility.

> +			/*
> +			 * Ignore interrupts for ports for which the
> +			 * interrupts are not specifically enabled.
> +			 */
> +			if (!(int_val & (1 << (port_id % 8))))
> +				continue;

Is this expected to happen?

> +	return of_platform_populate(wcd->dev->of_node, NULL, NULL, wcd->dev);

Why are we doing this?

> +{
> +	struct device *dev = wcd->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +	/*
> +	 * INTR1 consists of all possible interrupt sources Ear OCP,

Missing blank line.

> +	 * HPH OCP, MBHC, MAD, VBAT, and SVA
> +	 * INTR2 is a subset of first interrupt sources MAD, VBAT, and SVA
> +	 */
> +	wcd->irq = of_irq_get_byname(wcd->dev->of_node, "intr1");
> +	if (wcd->irq < 0) {
> +		if (wcd->irq != -EPROBE_DEFER)
> +			dev_err(wcd->dev, "Unable to configure IRQ\n");

It's helpful to print what the error code was, it can help people
debug things.

> +	wcd->reset_gpio = of_get_named_gpio(np,	"reset-gpios", 0);
> +	if (wcd->reset_gpio < 0) {
> +		dev_err(dev, "Reset gpio missing in DT\n");
> +		return wcd->reset_gpio;
> +	}

devm_gpiod_get()

> +static int wcd934x_bring_up(struct wcd934x_codec *wcd)
> +{
> +	struct regmap *wcd_regmap = wcd->regmap;
> +	u16 id_minor, id_major;
> +	int ret;

> +	dev_info(wcd->dev, "%s: wcd9xxx chip id major 0x%x, minor 0x%x\n",
> +		 __func__, id_major, id_minor);
> +

What was with the other verison parsing and printing code?

--/NwG7NuG0/W8LcLh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bbboACgkQJNaLcl1U
h9BwhAf7BFWi1FH4sIY9lOaGicdQRq41KKIjaZkNkhpFRSFFruChW+s++zX34oLC
b8eYJ+h/T+w2cyp2/ANaxF60AgOhaSgeOQpq4EyQzLCraiczvWCed9ooLXYQT9+h
O88Xa5KbrQ72VIUiksoord3LmMz61VlIDX+nv1yxe7rVszy/tRiohBtaEyRg+w0S
X2CA2xT1p8QxGctn4qsXbQSCUR+U3Y+w+U6GF70f08nDhP1OnomsEMe+pU3H6tH9
2NceHjktW8Dt6uHLiP8DiasAZkq7b0Er8KDZluiFLl+uEbj+XJVnCvIwc2PuTyT7
+0xHOuhzbd0GydVlIzf6jqFd56gUDw==
=IVnc
-----END PGP SIGNATURE-----

--/NwG7NuG0/W8LcLh--

--===============6941996228354643436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6941996228354643436==--
