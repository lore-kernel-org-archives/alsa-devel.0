Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89461C4727E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:27:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8C720759
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vHbb5rhZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6bqjH/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8C720759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDF6F1931;
	Thu,  1 Oct 2020 18:26:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDF6F1931
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601569666;
	bh=rFIiHKx9xR8FwXNa1B0rNzQj97c7/7Pi9wS3NAt0XtM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vHbb5rhZU5KAtwbHpkxcslFj6LxNEBKIkJhtgIa0ViyLA/sJKSoNVkcjQMrlKMD/s
	 aPHSMuxSfbh+TIJvGb2oOqk4dhpBIllGhREIpRfsFPLtGNVlqLK2CBkC92MB55Adv1
	 oFh6w3PdlsFNqVNDera+7A3yOsJnVTj1KjocH1XQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6446EF8022B;
	Thu,  1 Oct 2020 18:26:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFF01F8022D; Thu,  1 Oct 2020 18:26:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0396F8020C
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 18:26:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0396F8020C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="j6bqjH/V"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EFA3F20759;
 Thu,  1 Oct 2020 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601569565;
 bh=rFIiHKx9xR8FwXNa1B0rNzQj97c7/7Pi9wS3NAt0XtM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j6bqjH/VvT9RK9wsqpZkG9D+2rwnuyjxivA1g+QFgys08fPIsu9GzwB527uaGPCw0
 mHU0FEPLsoBuUrCFhqdtoZZpcBEZBJf2/3eLIy0EkYr1BOkI+HVGF0jpbBo/xP5JtL
 simADQ65xVApAzx1CMTG0D2XkeNtIsgCTDxWz530=
Date: Thu, 1 Oct 2020 17:25:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 2/2] ASoC: tas2764: Add the driver for the TAS2764
Message-ID: <20201001162505.GO6715@sirena.org.uk>
References: <20200930163809.6978-1-dmurphy@ti.com>
 <20200930163809.6978-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ll0BBk1HBk/f94B0"
Content-Disposition: inline
In-Reply-To: <20200930163809.6978-2-dmurphy@ti.com>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--Ll0BBk1HBk/f94B0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 11:38:09AM -0500, Dan Murphy wrote:

This all looks good - a few very minor things below but nothing
substantial:

> +	default:
> +		dev_err(tas2764->dev, "Not supported evevt\n");
> +		return -EINVAL;

evevt -> event

> +static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	int ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
> +						TAS2764_PWR_CTRL_MASK,
> +						mute ? TAS2764_PWR_CTRL_MUTE : 0);
> +
> +	if (ret < 0)
> +		return ret;

This looks weird with the ternery operator and extreme indentation -
could you please at least split the declaration of ret from the call to
make the line length a bit extreme?

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +	case SND_SOC_DAIFMT_DSP_A:
> +		tdm_rx_start_slot = 1;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_B:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		tdm_rx_start_slot = 0;
> +		break;

I'm not seeing any other handling that distinguishes between the I2S and
DSP modes anywhere - I'm guessing this is because the device is really
only implementing the DSP modes but because it's mono this is compatible
with the I2S modes?  It'd be worth having a comment saying this since
while that would be OK not distinguishing between modes properly is a
common error in drivers so it'd help avoid cut'n'paste issues if someone
uses this code as a reference.

> +static int tas2764_register_codec(struct tas2764_priv *tas2764)
> +{
> +	return devm_snd_soc_register_component(tas2764->dev,
> +					       &soc_component_driver_tas2764,
> +					       tas2764_dai_driver,
> +					       ARRAY_SIZE(tas2764_dai_driver));
> +}

This is a bit odd - can we not just inline the component registration
rather than having this function?

--Ll0BBk1HBk/f94B0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl92AuEACgkQJNaLcl1U
h9BbYAf+OXUXc8a9ucmuF714vCimWP7Xs6JYHxHZlADbWBOC+swlHom2WEPxe8Mc
jXNwUj9mVkeyLKcrMfU5f094l38hnJZfrtnPKlfKbnz/zfwNrC2oXGkzoT4Queyg
1jv4Zwuan1D0ZFIf1kEYh9L+g91RQdLixLwTimYhukN7YcC3cuWj4ybhsfEvqdzu
hEg2WFRpXc4Svtu3jnLGm1hQCjYNj+fr0PGYlIx/+4itiqOYy0WyWlHCyUMjBynM
vW58F577Ipvx3QvdrED5sUhe/7GACoArDCQJgJcpwZY8rulpzQQ8hRkCL819VkeZ
vZJpiu8dPD8Zuhip5E541lNBxknhNA==
=LkeT
-----END PGP SIGNATURE-----

--Ll0BBk1HBk/f94B0--
