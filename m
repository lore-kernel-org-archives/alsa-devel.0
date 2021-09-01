Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DF9C432BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 17:57:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0893761075
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 17:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0893761075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 486F31777;
	Wed,  1 Sep 2021 19:56:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 486F31777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630519047;
	bh=oOjp+xyS7ptJNAzTfGgTeGc71WIK3ngXIeirUMdS6aQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MWQg6yzARFnj7v5rDuCss6Hw/6b3lX9pu6XwbGFGM5CHkC9T1tq3P3uXMFjLPwXJ+
	 SaxYTFBW+qvxHP2UmMRbw53XiSM+1pkmg5CVZetFr+GH2Ecsj6bz1hsDJKZxe/kP8S
	 zuNgV582ZPS+96uFOP6ygQPxy9F2ASVAFJGR/1Jk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7266F80227;
	Wed,  1 Sep 2021 19:56:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1F34F80254; Wed,  1 Sep 2021 19:56:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19BF1F8020D
 for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2021 19:56:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19BF1F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bu4LyAAh"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 711C660F23;
 Wed,  1 Sep 2021 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630518988;
 bh=oOjp+xyS7ptJNAzTfGgTeGc71WIK3ngXIeirUMdS6aQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bu4LyAAhs/zjZB3F3WghW4FCw8lcQ7wJ5mYiWflZ04DZRsC4klIA0TYc2dREK1amF
 zxsJ39hPFYOSTMxqiaue0Q5xucoePIOuDEm7U/Qz8B//qKDKj+AhqXFDtEgO9yr6cP
 smXwL6Ad3R33OQG2g5B+RSZi6JHBr+RpDgzR2N776fFLLDJ1csySYR3UNMKX5RixJW
 QRwRXHqzQO93YVp2sg4YvidpQK1ZE1qea3ovD4hck3M43imKtTHCciIvgou51O1WTf
 fe80eGpp61RLBS1hvE/9THoAkVDvEmEyuiTKqoGPAubOf2ObJkHWHrsjiDte5G2AP/
 /FWDHA9pgS2mA==
Date: Wed, 1 Sep 2021 18:55:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Albert Wang <albertwang@realtek.com>
Subject: Re: [PATCH v2 1/2] ASoC: rt5682s: Add driver for ALC5682I-VS codec
Message-ID: <20210901175554.GJ5976@sirena.org.uk>
References: <20210831130258.19286-1-derek.fang@realtek.com>
 <ee3ba91ee5c24dda9db9d05622d1dfaf@realtek.com>
 <CAOCJVXxPFM4CZ88LPTRp10ExiB1YTvkGYU37aYPBUXcxD2=uyw@mail.gmail.com>
 <CAEy1m_CatKECNf=3-7qZD9OCECfAjaynZ4aoWrfzV518szTL=g@mail.gmail.com>
 <18b688bf0eda4a24ae9897a9b7420530@realtek.com>
 <20210901163755.GI5976@sirena.org.uk>
 <E33A207A-7141-4D72-82D3-A59EA5C8CE5C@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
In-Reply-To: <E33A207A-7141-4D72-82D3-A59EA5C8CE5C@realtek.com>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Yu-hsuan Hsu <yuhsuan@google.com>,
 Albert Chen <albertchen@realtek.com>,
 Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 Mingjane Hsieh <mingjanehsieh@google.com>,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 01, 2021 at 05:29:20PM +0000, Albert Wang wrote:

> We would like to complete the upload in Linux maintainer, then finish the upstream process in google side. May I learn from you when the verification could be done?

Well, the merge window just opened so it'll be two weeks today before I
start applying new patches again.  Until the patches are applied someone
can always come along and report an issue.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEvvqoACgkQJNaLcl1U
h9CzsAf/c6kwE1pf6RQlupCJCVhPtK9jCdKp1+4jz34DINqGDlVs7b3SHM6yAQrk
pI6bNnPJ3rkTU9glq+gJfCbST/0PCJO8MG9zhhHYqL0Wz7l0FhIh0uSrU1hoHf7i
2ZDXch05DBCP+XCHJusub6loe7uTtrVzZE9SYgaBkkLrlHoRUSm5VyieSmECzHBT
g2Rj9AoVMkswoX/MrutZj1n4OoCEPlZcGdWuexmxpp5tjJvNZTvb96f5oDM7cxn3
GdXup4lqXAQsw4g/UBaicszph+B7UZVrsJzV24/AYXeiJJnKE5KxjhH3CIACMCiY
nOSVBRgdXHFJACAX64UxDqXDehiboA==
=lMBO
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
