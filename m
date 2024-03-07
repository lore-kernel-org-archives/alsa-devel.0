Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF2FC54798
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:53:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1541884D;
	Thu,  7 Mar 2024 13:52:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1541884D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709815982;
	bh=MblaJ/xBbyAlKSi+e0NY+oob1/RL+llTsv1GcmbHug4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RVYqHXw1faCxWHQl56T2g6qsBnll/NDBQDgUDEP+Ry063ixwryygg/2QhLWLxRxM4
	 d0Vk94ujH1635YpmyOcz4cWUFSnMx3E+/l/GOEfNp8d+puwyLb4pvyG2xPGG0NiX21
	 nMYjPHeML3990Bl042RYYurkb/KNa1ieihH2/z7M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 419F3F8059F; Thu,  7 Mar 2024 13:52:30 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 87EE0F805A9;
	Thu,  7 Mar 2024 13:52:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D546F8024E; Thu,  7 Mar 2024 13:52:25 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CEF32F80087
	for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2024 13:52:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEF32F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=d8l6/5Ae
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 934EA614F3;
	Thu,  7 Mar 2024 12:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB771C433F1;
	Thu,  7 Mar 2024 12:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709815936;
	bh=MblaJ/xBbyAlKSi+e0NY+oob1/RL+llTsv1GcmbHug4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8l6/5Ae9Jc8Q5gtpYdqmVO7Bn5xYa/nI0y/WNBC7lZ9A+7MTGoERrSyeZLKuj2JQ
	 MQ4hySceKJxRI2PnSYBmJI+xBMeN6Z7LeijVfT6/2KKfAE6LPJoN8Jvqott/Ropt1l
	 N/lu9QrVbR2yUVmeivDKG1K2LzanzlGxPC1tvzK2MzGwKTwbjpQNOYpd2vuv3FWP6+
	 a6reH1zjT7H1D7+CqpY85CGl07Vbq4nAyVopneT7QIakgnNou0w58+YUuV3IXFAKMz
	 QP4g9QfkUKAqgpI4zlGj8VYJLTA4Unq8fPewhuYw8pcZMoCHDsisUguS31qfQ9a/7+
	 XkMn4AbGjMIcw==
Date: Thu, 7 Mar 2024 12:52:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ASoC: starfive: Add PDM controller support
Message-ID: <fddca901-273c-4b06-ad59-d156941920d6@sirena.org.uk>
References: <20240307033708.139535-1-xingyu.wu@starfivetech.com>
 <20240307033708.139535-3-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OMuJ0wTIjHrUHwqT"
Content-Disposition: inline
In-Reply-To: <20240307033708.139535-3-xingyu.wu@starfivetech.com>
X-Cookie: Been Transferred Lately?
Message-ID-Hash: 2SWOTSOHFFVD7WZSZTIB3Y5ADNHNNG7D
X-Message-ID-Hash: 2SWOTSOHFFVD7WZSZTIB3Y5ADNHNNG7D
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2SWOTSOHFFVD7WZSZTIB3Y5ADNHNNG7D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--OMuJ0wTIjHrUHwqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2024 at 11:37:08AM +0800, Xingyu Wu wrote:

> +static const struct snd_kcontrol_new jh8100_pdm_snd_controls[] = {
> +	SOC_SINGLE("DC compensation Control", JH8100_PDM_DMIC_CTRL0, 30, 1, 0),
> +	SOC_SINGLE("High Pass Filter Control", JH8100_PDM_DMIC_CTRL0, 28, 1, 0),
> +	SOC_SINGLE("Left Channel Volume Control", JH8100_PDM_DMIC_CTRL0, 23, 1, 0),
> +	SOC_SINGLE("Right Channel Volume Control", JH8100_PDM_DMIC_CTRL0, 22, 1, 0),
> +	SOC_SINGLE_TLV("Volume", JH8100_PDM_DMIC_CTRL0, 16, 0x3F, 1, volume_tlv),
> +	SOC_SINGLE("Data MSB Shift", JH8100_PDM_DMIC_CTRL0, 1, 7, 0),
> +	SOC_SINGLE("SCALE", JH8100_PDM_DC_SCALE0, 0, 0x3F, 0),
> +	SOC_SINGLE("DC offset", JH8100_PDM_DC_SCALE0, 8, 0xFFFFF, 0),
> +};

Simple on/off switches should have names ending in Switch, volumes
should end in Volume as per control-names.rst.  Please for the next
version you post show the output of running mixer-test on a system with
this device, it will identify these and other issues.

> +static int jh8100_pdm_component_probe(struct snd_soc_component *component)
> +{
> +	struct jh8100_pdm_priv *priv = snd_soc_component_get_drvdata(component);
> +
> +	snd_soc_component_init_regmap(component, priv->regmap);
> +	snd_soc_add_component_controls(component, jh8100_pdm_snd_controls,
> +				       ARRAY_SIZE(jh8100_pdm_snd_controls));

You can just specify the controls in the snd_soc_compoenent_driver.

> +#ifdef CONFIG_PM
> +static int jh8100_pdm_runtime_suspend(struct device *dev)
> +{
> +	struct jh8100_pdm_priv *priv = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(priv->icg_clk);
> +	return 0;
> +}
> +
> +static int jh8100_pdm_runtime_resume(struct device *dev)
> +{
> +	struct jh8100_pdm_priv *priv = dev_get_drvdata(dev);
> +
> +	return jh8100_pdm_crg_enable(priv);
> +}
> +#endif

It's weird that the runtime suspend and resume are not symmetric - why
do we need to bring the device out of reset but not put it into reset?

> +	if (!device_property_read_u8(&pdev->dev, "starfive,pdm-modulex", &using_modulex))
> +		if (using_modulex == 1)
> +			base += JH8100_PDM_MODULEX_SHIFT; /* Use module 1 */

This really looks like you've got one hardware block with two devices in
it, either the address ranges registered for the devices in DT should be
separate and you shouldn't need this property or you should have one
component registering both PDM interfaces.

--OMuJ0wTIjHrUHwqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXpuHoACgkQJNaLcl1U
h9Bj5Af/R9ushCNRKrPb78ikXIhM0zTjHfChPI6K6mCQsquHeplDYjw97T1NMXpF
t3mQJVASZqIIv4ve6aaaObvoNYMNfQHF1qxI7fw8TL2RR1nqo2MI6b7+hZEMcFLo
iW9+/SHL1mFHQ+gSdRIgDBj/ym9Plcryy1ajxFom8gqitvA/o0kZJHez6EpW2t0I
avPYFO3iHOTB77FSG6YcwY+RKqrluLRgVAuNXIay1P9+VKW0Zx4gFo7ZRcd2s1xz
5bGuh2cqhWCOwJXiKYjNUZPs8usGcGDEc6TtluNXKACrtzRPCymY1YYpVWEPkK6C
5X21iVfOR/nJ0+kRIKeGzk57bmvIBA==
=W35A
-----END PGP SIGNATURE-----

--OMuJ0wTIjHrUHwqT--
