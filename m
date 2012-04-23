From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/8] ASoC: Ux500: Add MSP I2S-driver
Date: Mon, 23 Apr 2012 19:29:11 +0100
Message-ID: <20120423182911.GU8318@opensource.wolfsonmicro.com>
References: <1334914386-27482-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5510973762952119992=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FE1C103EFC
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 20:29:14 +0200 (CEST)
In-Reply-To: <1334914386-27482-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============5510973762952119992==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YnIutncTLXsDZs5t"
Content-Disposition: inline


--YnIutncTLXsDZs5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2012 at 11:33:06AM +0200, Ola Lilja wrote:

> Add driver for running I2S with the MSP-block.

This depends on the change for the debug print function.  Otherwise
there's a bunch of relatively minor stuff but overall this looks
generally good.

> +static int ux500_msp_dai_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	int ret = 0;
> +	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
> +
> +	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter.\n", __func__, dai->id,
> +		snd_soc_stream_str(substream));
> +
> +	/* Don't enable regulator if it's MSP1/3 */

Why not?

> +static void ux500_msp_dai_shutdown(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{

> +	if (drvdata->reg_enabled) {
> +		ret = regulator_disable(drvdata->reg_vape);
> +		if (ret < 0)
> +			dev_err(dai->dev,
> +				"%s: ERROR: Failed to disable regulator (%d)!\n",
> +				__func__, ret);
> +		drvdata->reg_enabled = 0;
> +	}

This looks like the driver is going to get confused with bidirectional
audio - if one direction stops then it'll turn the regulator off.

> +	/* Don't enable regulator if it's MSP1/3 */
> +	if (!drvdata->reg_enabled && (drvdata->msp->id != MSP_1_I2S_CONTROLLER)
> +		&& (drvdata->msp->id != MSP_3_I2S_CONTROLLER)) {

This seems confused, you're enabling in multiple places...

> +static int ux500_msp_dai_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	unsigned int mask, slots_active;
> +	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
> +
> +	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter.\n",
> +			__func__, dai->id, snd_soc_stream_str(substream));
> +
> +	switch (drvdata->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		if (params_channels(params) != 2) {
> +			dev_err(dai->dev,
> +				"%s: Error: I2S requires ch = 2 (ch = %d)!\n",
> +				__func__, params_channels(params));
> +			return -EINVAL;
> +		}

Should really set up constraints for this, though in principle format
can change at runtime (though it rarely does).  Perhaps we should do
something special if the configuration happens on init...

> +		if (params_channels(params) != slots_active) {
> +			dev_err(dai->dev,
> +				"%s: Error: Channels to slots mismatch (ch = %d, slots = %d)!\n",
> +				__func__, params_channels(params),
> +				slots_active);
> +			return -EINVAL;
> +		}

Similarly here.

> +	drvdata->reg_vape = regulator_get(NULL, "v-ape");
> +	if (IS_ERR(drvdata->reg_vape)) {

No, this should be using the struct device.  Regulators should always
be requested in the context of their consumer.  You could use
devm_regulator_get() too (there's a clock one too, but only in -next).

> +	ret = ux500_msp_i2s_init_msp(pdev, &drvdata->msp, platform_data);
> +	if (!drvdata->msp) {

Should be no need to cast away from void.

> +
> +	ux500_msp_i2s_cleanup_msp(pdev, drvdata->msp);
> +	devm_kfree(&pdev->dev, drvdata);

You're missing the point of devm_ here! :)

--YnIutncTLXsDZs5t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlZ9xAAoJEBus8iNuMP3dITMP/2UExl8puO1E4LYAqoBmw6Z2
8NicdQ8u5WMYgntmFuUWS/OzX9D0X7BX3vvNt+qaoRpacvXjtsen9vU0DuLkVVwx
UoZP1edcmNpRjKKMvUQ/gF2SyicKGDvz5zAZu53jEtQNY2IUven8B83XmpKFTTBO
jU8hQqbVlicLbcFlNIu68BhaEcH7L60yxZVhJbIluuoIBPh5UZukuaW1TvfJgBfU
IiZasbBU4oSDBf9dQJSt5JnOMrAIHBY5UIJKi8hm7gGarNdhjv5fNTQ8VkRKy9eC
CybBNxXCEnmyUh6B6+ge9UppNuX9+8VIjuspyNNJncUU5PA/u1HsVLkI1H8etL7S
B4Llqc48y0lTnDUf0FxLMI6CTed29Rl0rwG9pBBb4XYRKQNYHkLVge8BJmeF7S4W
N/4FpRutmWj+BnTw4a10hyDKdnBtm8emOp0wwEWsAahwEWCpKUTtqrcobg+kxkhb
iEXzyCLtAJ9MZoOWZ/zolEcK+2iLER2ZTxUMn8ST4gBC4YVVwgpIr7xuHx9+80zT
AuE6xqVTMIABb45IPzauhhgYPyxpdnMhg8c9EmVOcbjp8lEZOFtVobLnNJ6W2/JA
NFi/NtA5nnozDBQUzcW2cmROPjRKkUoPdksBMmdn8GuNialzawJ5iF6Bv3Onl/oG
xXRlsTQyLBTgGQaJxF/R
=PNgs
-----END PGP SIGNATURE-----

--YnIutncTLXsDZs5t--

--===============5510973762952119992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5510973762952119992==--
