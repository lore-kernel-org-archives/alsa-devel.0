Return-Path: <SRS0=4jWs=BD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AF8C433E4
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:52:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B164F2073E
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oaj+VDfg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F13CfL8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B164F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45AB01680;
	Fri, 24 Jul 2020 12:51:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45AB01680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595587941;
	bh=PWG32YcOeMhH2GemOphH4Q5kn3Lnq8/kK3Cn2vynBns=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oaj+VDfgrPXT2e07FwN/adjv7CK/x7oBrAnI22Tv4EpF8tBx2kmgpRbEhoifJOxTP
	 fdw53wbPhveZZMSl2sy/lk/X/yPHDm64Z/vwiMMpkPEohs8mOZnpKhabgwi073XfVn
	 YkyUfvcTwSljKVnZAIxRHowG1Gx4Q9WQaXyzLZik=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BBCC7F80141;
	Fri, 24 Jul 2020 12:51:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18DA1F8014C; Fri, 24 Jul 2020 12:51:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83A33F800DF
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2020 12:51:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83A33F800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="F13CfL8g"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AE4D92073E;
 Fri, 24 Jul 2020 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595587874;
 bh=PWG32YcOeMhH2GemOphH4Q5kn3Lnq8/kK3Cn2vynBns=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F13CfL8g3nuEJDlJLOJWXoQxuiGsmhcbLkqR3TjHfE+4YtoZbpNAOvoKtkd2cESJO
 Dflwy+cwmJdExBiwXmtYEDNj1QWcDUekKwgWndHKUXiotd3FTxwjukBYHZA/7fY9E0
 HKqx+IFR1ua1y60dDC0WoFg5wGByT2ZHtSDCuMX8=
Date: Fri, 24 Jul 2020 11:50:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Steve Lee <steves.lee@maximintegrated.com>
Subject: Re: [PATCH 3/3] ASoC: max98390: update dsm param bin max size
Message-ID: <20200724105059.GA5664@sirena.org.uk>
References: <20200724085644.9837-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20200724085644.9837-1-steves.lee@maximintegrated.com>
X-Cookie: You will wish you hadn't.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com,
 ckeepax@opensource.cirrus.com, ryans.lee@maximintegrated.com,
 steves.lee.maxim@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 krzk@kernel.org, lgirdwood@gmail.com, nuno.sa@analog.com, geert@linux-m68k.org,
 dmurphy@ti.com, shumingf@realtek.com, srinivas.kandagatla@linaro.org,
 rf@opensource.wolfsonmicro.com
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


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2020 at 05:56:44PM +0900, Steve Lee wrote:
>  MAX98390_DSM_PARAM_MAX_SIZE is changed to support extended
>  register update.

I'm missing patches 1-2 and have no cover letter - what's the story
with dependencies?

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8avQ8ACgkQJNaLcl1U
h9Aj3gf/YVzWgBS3oyh3vmgjlIEpdZ48zKwfNrdP3AjsgdDI/wZsm/firZQBHg7G
6AituA5MsDLLEH8KG4S6HZ30QY3mC4BB0v8ILr9OeOGc/+M1OugxQQPMgK5RqZ8e
o8PGXWFmZdTnE2Uitl70g7Kb0aHiWY3aiB3M8EKVY5+z3OShdaVfcrOJBmssd9Uj
kWF0WxHZzYpkC1xny5352uirIwuv4tVkupZeP4A9Tg6A/LgRlKpqVG/GVZJMjjdY
9d5lewHYM/UTje7Fk+21hvKnGScwlPt9iMejfI0A85Fm0So9WPVGqimIKLn8mu61
ChWNE4Zr+67zERK/T8B8aktKc+gVxw==
=TNpF
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
