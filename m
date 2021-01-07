Return-Path: <SRS0=NlLR=GK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A93C433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 16:37:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2EA23434
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 16:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2EA23434
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A61D168E;
	Thu,  7 Jan 2021 17:36:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A61D168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610037448;
	bh=Y6gt6mv9G74KNcvYZIz48LzKMy14E/VBc6hKapkfbyQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OH9HKO37XgSBJENn4ialCg5s9f++O9REO6mJY83c5PDr7TrwVJazhMXd9KYTiG/HP
	 F414mQXSOSoX/wrqdY8/Dayi/Trle7TrLTXxE4dh8L3ApFVe6u+pvFMulZeEILJUDp
	 eB2D/pKsjr7HaaEqwJzwgyPZw0Hn+qyz5W3HH/4c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6B53F800E9;
	Thu,  7 Jan 2021 17:36:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6301DF80258; Thu,  7 Jan 2021 17:36:35 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B495DF800E9
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2021 17:36:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B495DF800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jrOowygr"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81B492342C;
 Thu,  7 Jan 2021 16:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610037390;
 bh=Y6gt6mv9G74KNcvYZIz48LzKMy14E/VBc6hKapkfbyQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jrOowygrVO+VWTzosMBF4JeX3l4NQGnOwtsvjwieA4kcg/LuVVJ5SsbZZnQ3EyyRI
 dkCm/dMgivtqnfiWKDnk29JR2tBnq9Ihk24nGxmSAyJA2eg9HHCFy8S4Fb0xl+KHr0
 MEJkPWD9ZtXAPRcfMMXXgaj1+ExqBagCYR7Rva+nq3bsv6z/Uu0SRyb2BjzOfx6P9/
 PgKSPLgIH1MPpETyj6i4rLcnr1L5txTk69kOl4gkH7LgOTDCbzYCBWIRuLX9cg/2uK
 2JVczmvoqA8cIUjQGqd2rZ6zJkwEqRjUmrUVhOkb9hHGuL3WNAr6LCh9Uzc6DEUHgw
 MFQNeVeVK3vbg==
Date: Thu, 7 Jan 2021 16:36:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] ASoC: hdmi-codec: Fix return value in
 hdmi_codec_set_jack()
Message-ID: <20210107163600.GE4726@sirena.org.uk>
References: <20210107162640.313859-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <20210107162640.313859-1-stephan@gerhold.net>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Cheng-Yi Chiang <cychiang@chromium.org>
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


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 07, 2021 at 05:26:40PM +0100, Stephan Gerhold wrote:

> However, hdmi_codec_set_jack() returns -E*OP*NOTSUPP if jack detection
> is not supported, which is not handled in apq8016_sbc and soc_component_ret().
> Make it return -ENOTSUPP instead to fix sound and silence the errors.

You will also need to update imx-hdmi, it is explicitly checking for
-EOPNOTSUPP so this will break it.  Having two error codes with such
similar names is rather unfortunate.

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/3OG8ACgkQJNaLcl1U
h9Dv9wf/UbvY3WD7Xvjh3PzeQd/KyOkY7dk1EJqB/AjdvHl691UGnLJfwEQwjr4d
HRrAenqcoMDX335sxHuOhL33Ax/93EtCrDHxJYciNCE0C7SfaUNf8VdqUiiSpaos
/yJGssYZPMiwtSCBgBd/YCOxnLZOs0Ntqxwly/pzrpXjbivvrCyvLRsZ3kfrW1xN
qifCxlNgdR61KRDIzrZ9NNPjc7h7AkJ+c5lw/k/TGOteuvC3js6NOuxmuqKq4OcS
cGTjO2mlSRYceg8afEL5wEVy8yi4AK35xlpiB3NEGdXJmgQS+E/6EHpiGqFKgSBG
VK+nJkIm/4TNO1l9OXdjaHcAApcqXA==
=+rGI
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
