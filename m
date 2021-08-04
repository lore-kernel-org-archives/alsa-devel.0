Return-Path: <SRS0=vE6Q=M3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD86AC4338F
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 18:11:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4387B60EB2
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 18:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4387B60EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85C7D168D;
	Wed,  4 Aug 2021 20:10:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85C7D168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628100661;
	bh=6ytqM1pqOmChi2kXhLk2K+nQSEdHW+8BvIOQWWWX020=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PXRm8ACgkq6yL5NEKGH+cvpCc/ifCQfctpSSK02qO9FDo8tNGPc7DiQLhB3CLVrl7
	 DfK0CG9XBYc2SZaH7L5Fh5hFY3rg72MxQ6KbvM5H8MPwnceSvgF2+8EVbGsLcQ7R2R
	 18+i7Nc2y+4CDtbIxCZzCGDIkpOF5NLi3BZtp2G0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4504F801F7;
	Wed,  4 Aug 2021 20:10:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D04D3F8025F; Wed,  4 Aug 2021 20:10:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7406BF8010A
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 20:10:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7406BF8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="P38SyYn5"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0439C60C41;
 Wed,  4 Aug 2021 18:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628100602;
 bh=6ytqM1pqOmChi2kXhLk2K+nQSEdHW+8BvIOQWWWX020=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P38SyYn532zv26lpVO7xXFeJQVE0gDXG8tt41cet8eI+MBRZAohGA8IVwuR16UDsI
 PRyHWK6xV5HMoHJI3Ks6UjJfINZYuVaIMPJ4HmfrxW2qKagsR4rHtQWszPlC+XpNJ2
 xZgEKe8jmrXAPdz1tGHV7SUNncMfMWMqfx6KAyg7IZvxpRKwl1Hb0VdNNclterhK9G
 gd1miSp9KcLmUurqbces5ERVuri3+oZlR6o7UStYB9Ubs5NFJ4uxTp1225YBnet9in
 H3NKY9mgBLkvjXDTxqIiUxtSP5QkFdvCN+ZVHPBw5FDQVo+TlQY5c/QJDIOss9ZrbE
 MYA4k0snVJXYg==
Date: Wed, 4 Aug 2021 19:09:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 13/20] ASoC: qdsp6: audioreach: add basic pkt alloc
 support
Message-ID: <20210804180947.GI26252@sirena.org.uk>
References: <20210803125411.28066-1-srinivas.kandagatla@linaro.org>
 <20210803125411.28066-14-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZY5CS28jBCfb727c"
Content-Disposition: inline
In-Reply-To: <20210803125411.28066-14-srinivas.kandagatla@linaro.org>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 devicetree@vger.kernel.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com, bjorn.andersson@linaro.org
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


--ZY5CS28jBCfb727c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 03, 2021 at 01:54:04PM +0100, Srinivas Kandagatla wrote:

> +config SND_SOC_QDSP6_AUDIOREACH
> +	tristate "SoC ALSA audio drives for Qualcomm QDSP AUDIOREACH Framework"
> +	depends on QCOM_GPR
> +	help
> +	 To add support for Qualcomm QDSP6 AudioReach Audio Framework.
> +	 This will enable sound soc platform specific audio drivers.
> +	 This includes q6apm, q6prm and associated dai and clock drivers
> +	 for DSP.
> +

We're adding the Kconfig before we've added all the code so the thing
works?

>  obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
> +obj-${CONFIG_SND_SOC_QDSP6_AUDIOREACH} += qdsp6/

This adds two different references to the qdsp6 subdirectory which feels
like there's something wrong...

--ZY5CS28jBCfb727c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEK1+oACgkQJNaLcl1U
h9B+zgf+M5vf0KFIqUbLqxP6KTr6dkSNSLCJY3Zmy284yALq6wESbc4ALQD9gHTH
KAVTXxX9PFoIxojDqmhDEuHpCFIpd0vSpNQ6cczvnnmPeAIT/D1vHulir7b7NT1d
DhEGc5dAbuysQFuJJmWvlQfVzIqk7bHrUf7ku1Shja2k8HC3qA1QbWoBa2gktWte
+yYaU8ksNTL1KdGAwQlHBKye9FLB+3boBxdMR7FbIFDEZfgE5L8DhaTE6TYlW+jP
sjhPWp/HnnPIYKR6FkMz2e25ub+PBu6yBaVWmuMY4d4cj0zTjkPkW8qOX3nDCxVm
kijhrySflUcL1tb7j3vAjMF5d52okw==
=NQ+I
-----END PGP SIGNATURE-----

--ZY5CS28jBCfb727c--
