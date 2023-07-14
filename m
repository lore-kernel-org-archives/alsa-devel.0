Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8763CEB64DA
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Jul 2023 13:20:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9409DA4A;
	Fri, 14 Jul 2023 15:20:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9409DA4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689340855;
	bh=tirD/wF/jKjckc+La/ZsfkUe4wRBh7yzU/pcdStcVtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Jer9o8WM8cphyTpsxEZrjUHtGWSAVgo2UG+xuA1lpT+jqzknXogwkqsR46RebjJme
	 794TDnkvJp94G80C4xdEaQ+NxBZ5V8gz9YcaPaXh0s7BSDw4MSgkyTZd0Udswmk3MA
	 RJpNZIwIbxi1CIkR6ijgI92f+VPKir3g8fMGBnPw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF40DF80535; Fri, 14 Jul 2023 15:20:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A3DBF80236;
	Fri, 14 Jul 2023 15:20:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5716AF80236; Fri, 14 Jul 2023 15:20:00 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EEBE5F800E4
	for <alsa-devel@alsa-project.org>; Fri, 14 Jul 2023 15:19:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEBE5F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oRWRINC1
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0E10461CCF;
	Fri, 14 Jul 2023 13:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D553DC433C7;
	Fri, 14 Jul 2023 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689340795;
	bh=tirD/wF/jKjckc+La/ZsfkUe4wRBh7yzU/pcdStcVtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRWRINC1LKA7Ocnup4uD3DbURWlO0ZtA4FDy7A9WFaxCqp6DOkZiJbnQnaAetpscU
	 B5lGRISt1OB50nu5xVM4tiIuQVV8yKqGTa1Zmdu0yGYKBtxxgIgzN4pr+fyeGBvRtM
	 GGQMUemTTU68Otog3LJjR58P9jM7o1ygLBF3byrg1lZZxL9Dhxhg4wQBIe9gGOvy8K
	 jPIv5mo2kmQKWEHBxNWrArJyE2Fn99sn5ecn+QtM3rDFcjBzzBpNtUqkVH63GcwNv2
	 SJIhhqJwLmeW4qaMHWEWouO2N89p9ysjjkNnl1IdtquFwKvKPz0bXQi2KpgwKwzetp
	 BAxbmfQXVi/tQ==
Date: Fri, 14 Jul 2023 14:19:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Zhu Ning <zhuning0077@gmail.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
	tiwai@suse.com, amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com, zhuning@everest-semi.com
Subject: Re: [PATCH v1 2/5] ASoC: codecs: ES8326: Change Hp_detect and
 volatile reg function
Message-ID: <ce3d5d97-85cd-420d-8bec-75a73d36b683@sirena.org.uk>
References: <20230714032453.3334-1-zhuning0077@gmail.com>
 <20230714032453.3334-2-zhuning0077@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bPGwa1jDvPTceUEv"
Content-Disposition: inline
In-Reply-To: <20230714032453.3334-2-zhuning0077@gmail.com>
X-Cookie: Preserve the old, but know the new.
Message-ID-Hash: WKPCD2WNVECXIUEI3SI23LKYVVH2RSUK
X-Message-ID-Hash: WKPCD2WNVECXIUEI3SI23LKYVVH2RSUK
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WKPCD2WNVECXIUEI3SI23LKYVVH2RSUK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--bPGwa1jDvPTceUEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2023 at 11:24:50AM +0800, Zhu Ning wrote:

> -static const struct regmap_range es8326_volatile_ranges[] = {
> -	regmap_reg_range(ES8326_HP_DETECT, ES8326_HP_DETECT),
> -};
> -
> -static const struct regmap_access_table es8326_volatile_table = {
> -	.yes_ranges = es8326_volatile_ranges,
> -	.n_yes_ranges = ARRAY_SIZE(es8326_volatile_ranges),
> -};
> +static bool es8326_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ES8326_HPL_OFFSET_INI:
> +	case ES8326_HPR_OFFSET_INI:
> +	case ES8326_HPDET_STA:
> +	case ES8326_CTIA_OMTP_STA:
> +	case ES8326_CSM_MUTE_STA:
> +		return true;

That's clearly not just a name chnage, it's extending the set of
volatile registers which should really be a separate patch - if you need
to resend for some other reason please split it out, but if there's no
other issues in the series don't worry here and just consider it next
time.

--bPGwa1jDvPTceUEv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSxS3UACgkQJNaLcl1U
h9CJ0Af/cQDKk3UoNYm+TdLjkfr5oAcxWMMCDzfASHf9G8owlsqFh4uTKyDAOgD1
31r7aB1t6Q4i/SOvyqcKn6YOYC/4EmgCC6sScHKF/KtFpx59W82VQCEbM0dO8Mwn
mRKySy1d7reschpKLfVcgePonKyzn/7zRpMQxTlKVBZxi+GX1E+MC0/xHzlh2ieS
saOGRpCb+MQPManmGauuK2QF5cTNC3N09728sr4h9QWENFAF9b0wMtOyD+nbYlRY
F2p2uMDC6939PmkgBMaNCor+HqXjSHOhw1su7KI2URg5OLo4IgmAkKzrgmzl6sXz
UjY843a+zxiyaYtV2HCv/W6XxK/G+g==
=4qJ4
-----END PGP SIGNATURE-----

--bPGwa1jDvPTceUEv--
