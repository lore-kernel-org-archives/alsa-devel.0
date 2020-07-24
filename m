Return-Path: <SRS0=4jWs=BD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D6DC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:44:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920A3206F6
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qznm0p3k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9L+IJIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920A3206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26C46167C;
	Fri, 24 Jul 2020 18:43:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26C46167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595609039;
	bh=LFdJwHelCPUb1xduFalB8+JYOGx/M3VqbZ/ygzyO5Ps=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qznm0p3k2btPdv28EO0y/GPnHoeJDV/5TV1RxGZ5YExGRhCbIIeMl2xctPsiCI1Bn
	 22mAZaMIEBKz+jiw39jNJP+/wyPtBsZpuMSS8Sk3cB1qnlI3BUPmpjudT5LDi2TWG7
	 3cbtvwZ8A0C4EB7SvK3JMk4NV13wR86lmTHK41NA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A67D0F80141;
	Fri, 24 Jul 2020 18:43:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E0A4F8014C; Fri, 24 Jul 2020 18:43:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DD4CF8011F
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2020 18:42:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DD4CF8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J9L+IJIc"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 459AB206F0;
 Fri, 24 Jul 2020 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595608975;
 bh=LFdJwHelCPUb1xduFalB8+JYOGx/M3VqbZ/ygzyO5Ps=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J9L+IJIcDu08FPqK1tgKsZ+PhwTJhZUsqtv7ysifDeFoXN094YQF5im7vynJ5hju2
 GrnbzbrYFLuLHg4599tUP/RGqAxHlNAl/yC+0i1BqyeOxyWKUfH6+jxKbHOp86P8Hs
 9LB2Xi7krCHTGzw6HZcQ+xaXpKtkbOXowWXsIHYs=
Date: Fri, 24 Jul 2020 17:42:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: dapm: don't call pm_runtime_* on card device
Message-ID: <20200724164240.GH5664@sirena.org.uk>
References: <20200724070731.451377-1-tzungbi@google.com>
 <20200724111634.GB5664@sirena.org.uk>
 <CA+Px+wU-R2qOFK8RhLzTXTqDheZhzOyKuiR-1S9qXj02QdruAA@mail.gmail.com>
 <20200724130151.GG5664@sirena.org.uk>
 <CA+Px+wVteAt5_QrGmRXcPVHJ5bEtXn9RiXH-bgcRiY_OezFj9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline
In-Reply-To: <CA+Px+wVteAt5_QrGmRXcPVHJ5bEtXn9RiXH-bgcRiY_OezFj9w@mail.gmail.com>
X-Cookie: You will wish you hadn't.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA development <alsa-devel@alsa-project.org>,
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


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2020 at 10:41:41PM +0800, Tzung-Bi Shih wrote:

> The challenge I'm facing: (&card->dapm)->bias_level is always
> SND_SOC_BIAS_OFF.  Commit 4e872a46823c stops to update it.  It has
> nowhere to add the missing puts().

> Ideally, if the bias_level goes away SND_SOC_BIAS_OFF in
> dapm_pre_sequence_async(), it calls pm_runtime_get().  If the
> bias_level goes into SND_SOC_BIAS_OFF in dapm_post_sequence_async(),
> it calls pm_runtime_put().

Right, I see the problem now.  This is probably fine.

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8bD38ACgkQJNaLcl1U
h9ACagf9FqEWTNUCGKkk5ImVEUn4UDW+uzpzhfg4Hh1leoD6HPPLZlsLYbsTE6Ra
9ohyLXIkytq+Us/Vt7h69RXPSgn0B3oPwx0PhWHo/4zRaOmPWalup/RBZOrNPpZ0
ftDumZj3U8NLL8mYF4p6KJwdM2Wptu78LBaZ9czijFu6MGsT2fXPLq87nJmbMmX3
UZmTCFQ/tM/PYQCLs8bihRZEovNDgbPpl/dXaBeUXLZUf3ZP0qJ8DpsVxJLaWZLC
fgdeq8NA+NrgUBYHf5Vuh7Gt/Mim6gNugOzf8kxc7AbxJkgJWHeN7KdCvm+02tBr
K42HOwvU9Xj/cqeyOIoedD600QH3IA==
=i2uL
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
