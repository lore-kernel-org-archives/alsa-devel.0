Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951BEC43460
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 12:14:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B765613C9
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 12:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B765613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB03C1661;
	Tue,  6 Apr 2021 14:13:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB03C1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617711284;
	bh=1VSQ0HJIbUmCdIg05wmj4ZZ9I7SufRU9KX6dQuOF7nI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YP2VvevJGwz40FR+b9jugJbWrI/wTgPr4rvcZar0VgSJUyJ2olhkvb5wvoNGmis85
	 648A4ixZnlPP2pF2jYR+Cr43YzjfkvfG47K5O1LTCvDtt7NnZpN/O9b8ss3t2qnBh6
	 X1WvZNd0kGG4+lroPdvM9Jp0wzbwrwjgPCHP7rPQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53824F80249;
	Tue,  6 Apr 2021 14:13:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 385D8F80258; Tue,  6 Apr 2021 14:13:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71418F80246
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 14:13:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71418F80246
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HaMOGpFA"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92CEF6139E;
 Tue,  6 Apr 2021 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617711223;
 bh=1VSQ0HJIbUmCdIg05wmj4ZZ9I7SufRU9KX6dQuOF7nI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HaMOGpFAopXyROZ1/ivYWmGglmF+afCb6G0SdyBlZrMDMDpucDewaQYk3L2FXlaa7
 GKtccYEvFpZD4RqIoDQGeyeDNIaQJCiRhjasOv0cShuVcqMelkcxnIactfl3kmI0kK
 JvD0J6LroP56hv1wpjBldj1OUUyxVXRWLlkGZXVOubm68eTDTFbQ9Tir3umYrO9ze8
 tIgCHAgYvXbciSq6rk+wWh1zapxCcxqOsQeKDCmRayiXX4qimnjF36K0oIkIVi9pjE
 nyvwilwCm+VwX5gyv6nsWDVJpVCE8p1vN8j32pn/GtVkKzSL+qs8RpOx7uRTALc7JM
 VYAZoHGsC8NnA==
Date: Tue, 6 Apr 2021 13:13:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH 3/5] SOC Codecs: TLV320AIC3X add SPI: I2C code
Message-ID: <20210406121326.GG6443@sirena.org.uk>
References: <20210406105018.59463-1-jiri.prchal@aksignal.cz>
 <20210406105018.59463-4-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Content-Disposition: inline
In-Reply-To: <20210406105018.59463-4-jiri.prchal@aksignal.cz>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>
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


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 06, 2021 at 12:50:16PM +0200, Jiri Prchal wrote:
> +++ b/sound/soc/codecs/tlv320aic3x-i2c.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ALSA SoC TLV320AIC3x codec driver I2C interface

Please make the entire comment a C++ one so things look more
intentional.

--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBsUGUACgkQJNaLcl1U
h9B4LQf9GF26KOmX1qHaxY3EaIGFU5f6HGM0OAghFkcLgzDRRrdMgsc7PuP5pMfV
1128IE9t4vtS0WLl0AJ/lajlhMCwNA4cxIj7RD69s6TE9VLWRkSFWrkaN3qGVpn4
aP11tDzZd8cCOuBO8QWBuG32bx1t8na1Mn6yBGsjXzZMhf/GUwYfnbcWfF4GlxSl
Bl2uR411eR9fJKlG9VRv2N08SbmZUoz44BkKFJKqC/wCjjlIlu0Db2nSoZifdu4l
AWpcXVZjd/0MCh3aJCnstH4QJBO/D6UmxEsLF71IF8ZpZYPUdJA9W+AbinLyBQD5
kOeP3AsOAwkvNu/WwxlYy78rcxAmPQ==
=mLe3
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--
