Return-Path: <SRS0=cdus=L5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19531C07E99
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jul 2021 19:31:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1253561369
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jul 2021 19:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1253561369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABB0616D1;
	Mon,  5 Jul 2021 21:30:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABB0616D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625513497;
	bh=DB18MTojD66qAvZOaE3kuj3EZ+WCMq11kM2ci8j+Co4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bmNrjuOG9jUz5XTT6V4Uz9Xc3DuLW9V8dH4uUS70pxLH8FXbfLnTf1GaUX9f2vELL
	 kaoUVHWwKn6NfcM6zW4K9oLO2izsaDGqSMoV236zVEYaaFhHfjoUtXGfuQbkkSBWwk
	 DrV7u8tgck5DTWBHlGhpbL60iPIcCf2/F5oGPYDU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51402F802E3;
	Mon,  5 Jul 2021 21:30:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D33FF80300; Mon,  5 Jul 2021 21:30:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 287DBF80134
 for <alsa-devel@alsa-project.org>; Mon,  5 Jul 2021 21:30:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 287DBF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="om6OQVkn"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8854061369;
 Mon,  5 Jul 2021 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625513423;
 bh=DB18MTojD66qAvZOaE3kuj3EZ+WCMq11kM2ci8j+Co4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=om6OQVknqj6I2FaQpOU2sbXe9jJSzOnntKpaZWZhpjBXS2iOAZkeNZgylpOpFqz71
 qGqINkPyFtsG7KgHMVtsMdtdGW72/5qQQOPIRWK1F1Fz8/ZIrU5p5Q4BTvAiQ/RY8O
 0oWD9HFqOLF0KTZOa5SMZaLeG0OnvXQsj0Got1XeIyfpN3I94Zt90bKjYQXO+LzmWr
 N/xbBOsUMCEhcgP9yQhgvo91IdY+G8JSKMwEWShjD/u5nEfiLWNqeag/OjRXj2Euv/
 SzNkROqfU2QO76qBOAh6tHyNctsvocqG+zvg+nW7T98SrApmD2aWsHwkAFPaBm+dU/
 y3UYJi3TjPpKg==
Date: Mon, 5 Jul 2021 20:29:52 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH] ASoC: add dai_reoder flag to reverse the stop sequence
Message-ID: <20210705192952.GI4574@sirena.org.uk>
References: <20210705155830.24693-1-vijendar.mukunda@amd.com>
 <20210705174241.GF4574@sirena.org.uk>
 <7f1ad1b3-b509-24cf-00d8-f82766aae0d6@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8/UBlNHSEJa6utmr"
Content-Disposition: inline
In-Reply-To: <7f1ad1b3-b509-24cf-00d8-f82766aae0d6@amd.com>
X-Cookie: Star Trek Lives!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, amistry@google.com,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>, Chuhong Yuan <hslester96@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, peter.ujfalusi@ti.com,
 Alexander.Deucher@amd.com, nartemiev@google.com
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


--8/UBlNHSEJa6utmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 06, 2021 at 12:30:10AM +0530, Mukunda,Vijendar wrote:

> As per our understanding by going with card wide option is easier rather
> than checking dai link name for re-ordering the stop sequence for
> specific platforms.
> We will rename the flag as "stop_dma_fist" and will post the new version.

Why would we need to check the name for the link?  Presumably all
affected AMD cards would just unconditionally set the flag, and other
systems could do what they like?

--8/UBlNHSEJa6utmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDjXa8ACgkQJNaLcl1U
h9BlPgf/ZQVPYklcHm8QzPLEpDWpJUZC9CvQKtgmhHbuo7hVxQdv90n0D69R8ZKe
y+HyvIkOKIpvbfQgZbZL6rQpSQR5vye5zwurlKf7sa0NTJiKgSgxd9vbKMD0KVNx
ydPeeuWIUp8uaSlwXnOrCBeVr3uOUDwERlCpasLP4AInu4GLGZedRPtAxFNBOLQk
ydgfWoOcNmnMA4wtFuggF/F+trNXyfQFwsEunRnAepmGL9dcsNfb1DPXmwdslsQw
y4KA4KvyGJ7lPLs3hPHRZFBVVNQlyDQrVe8E7eQQHPXdWkahyeAA7jCn/g397reB
gee7H/24vthbZVCTESTZy7kVzyrzKQ==
=9bmK
-----END PGP SIGNATURE-----

--8/UBlNHSEJa6utmr--
