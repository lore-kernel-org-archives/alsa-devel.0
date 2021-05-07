Return-Path: <SRS0=FKDJ=KC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C30CC433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 15:39:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F1B61474
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 15:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F1B61474
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2D4F1677;
	Fri,  7 May 2021 17:38:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2D4F1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620401987;
	bh=qrB6z45lJne2TH1vK2BagutxMHoB7qI70gJjcuVXP6o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M6fVjGqbtQk4seKdD9IS0w89vDeC9xub86XtoM43ODYAOCiulUp6dGRnx672x4Ug4
	 7MJ/7hDfGd2HfRrpNlWrkzH03nr82ky9LVDHcbu96TuEViMjk1Wtcjcvf8yvlPPdbB
	 jrLJgJymlrD4pQqUVBtnZGMfV0qi0gp53upqe9Zo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 485CBF80257;
	Fri,  7 May 2021 17:38:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 024B8F8025F; Fri,  7 May 2021 17:38:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E527F8010B
 for <alsa-devel@alsa-project.org>; Fri,  7 May 2021 17:38:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E527F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="u/wUMMPF"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D133A61474;
 Fri,  7 May 2021 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620401930;
 bh=qrB6z45lJne2TH1vK2BagutxMHoB7qI70gJjcuVXP6o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u/wUMMPFAzmGPQS9fu/dK0tPuntOfc3jqxO0tA6DadA/qwJ6gCAeMV1abHMPR8R91
 3gMAnf2WXl3JSjfORVpUCmk4y7WV13qbTSY85ZPibtJeqO7maVqxNIaLuOcqeBb6Co
 MXZc7TfaqQbEwy5Is3dzdTJpAlFZVhs/6gtpNnTt4O1HqnNT8mNRxEQtdHxc+KVHfP
 BdBMxaqsZCcd+NSbfA/W4ukWcBYoxhKNrSHgkgGXyG6kHoZUTBXVg+m0FLrd7WwKZ+
 QOV2aj6UKkraoYYZU2t6x8PCZjCrokS0KWQ+XrBG9hWzeIb45fhnBhWGnvPvwVZrHi
 5l+KZvPPbEXbw==
Date: Fri, 7 May 2021 16:38:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: make HSBIAS_SENSE_EN optional
Message-ID: <20210507153812.GD6383@sirena.org.uk>
References: <20210507141748.742037-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <20210507141748.742037-1-tanureal@opensource.cirrus.com>
X-Cookie: Postage will be paid by addressee.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Vitaly Rodionov <vitalyr@opensource.cirrus.com>, patches@opensource.cirrus.com,
 Takashi Iwai <tiwai@suse.com>, James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>, linux-kernel@vger.kernel.org
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


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 07, 2021 at 03:17:48PM +0100, Lucas Tanure wrote:

> +  - cirrus,hs-bias-sense-en: Configures HSBIAS output current sense through
> +  the external 2.21-k resistor. HSBIAS_SENSE is hardware feature to reduce
> +  the potential pop noise during the headset plug out slowly. But on some
> +  platforms ESD voltage will affect it causing test to fail, especially
> +  with CTIA headset type. For different hardware setups, a designer might
> +  want to tweak default behavior.
> +
> +  0 - disabled
> +  1 - enabled
> +  Default = 1

A boolean property would generally be present/absent rather than having
a value...

> +	ret = device_property_read_u32(dev, "cirrus,hs-bias-sense-en", &val);

...and read using device_property_read_bool().

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCVXuQACgkQJNaLcl1U
h9DnoQf/fhx607K3Ic6jTRvxIvSmJltZh9VYh8D2LQ4ilAtNFfRsshkN74XGW7UU
szJk6CUGeWykTDQHf0ZXNeX+XrcTXpiL8UwFSRA8krK2zCn3NhmKsiM8D6ApkFka
OelzY67sdXGqISRscr5HBjqEt1hmsqDpmY5a3LkldrpHoxI2nxoXD77y589nfZrM
4TEecX5JTJvDIM9HvYVjekUbXlP/pQ3Di47RAFV4skfS66BQw9EB1OllHURjJqcM
xYaZajfrDOeIcQ30Sui7oAWEcPFnJSKqUWHb8Kjm5ARMzm0miJKKpMWqhAcPA/RN
EIsFq6UpT04oTfuEnCKUQOYveYjxUg==
=HTbi
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
