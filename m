Return-Path: <SRS0=TVyu=6S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120A6C3A5A9
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 13:21:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F1D2073E
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 13:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b+yFk1Lg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXJJaX2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F1D2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC0B21707;
	Mon,  4 May 2020 15:21:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC0B21707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588598514;
	bh=TmTThPPzqPGpxwdSnGjDCaspiEw5yMD7Er/gNQKbhp4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b+yFk1Lg6gDMoLFMHLOMTqKZzneruje3HlZ32IhVZXnpUAvihW5JHhkneX8kq7Ppz
	 zinY/bi2XmpOBJ5IiuoCmDZAURqy2s+G07zSAZ0aw6cirlmppTnposT5Nc2zgS8M7Y
	 pzp9/1z1hHBxiS1uf8/hyRJI3n+Ki8xx2Orlg0G4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DE09F80234;
	Mon,  4 May 2020 15:21:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC999F80249; Mon,  4 May 2020 15:21:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC057F800EE
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2020 15:20:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC057F800EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fXJJaX2V"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2F8F62073B;
 Mon,  4 May 2020 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588598454;
 bh=TmTThPPzqPGpxwdSnGjDCaspiEw5yMD7Er/gNQKbhp4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fXJJaX2Vl0YL18pOKUF/1VGP2I3cbrVG1ibTCHHfOpha8wJ2sSBP2awNOEPaJvX/a
 wVU5G/vDymXuIlJXDylvcakC9l59ISiMvHTaC9cPnEqAWRYbM5HZHHI+Yxe3UiV6el
 /Hc7p/Xd6+JT7sefJghKkObs2GrBARPiYcbsCFGM=
Date: Mon, 4 May 2020 14:20:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: qcom: Remove the unnecessary cast
Message-ID: <20200504132052.GA20675@sirena.org.uk>
References: <20200504073558.2340-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20200504073558.2340-1-tangbin@cmss.chinamobile.com>
X-Cookie: YOU PICKED KARL MALDEN'S NOSE!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, plai@codeaurora.org,
 linux-kernel@vger.kernel.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>
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


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2020 at 03:35:58PM +0800, Tang Bin wrote:
> It's not necessary to specify 'void const __force *' casting
> for 'drvdata->lpaif'.

This doesn't apply against current code, please check and resend.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6wFrMACgkQJNaLcl1U
h9CERwf/XWEzr0Iyb/54nGEKIkr/672FzoBds5lVOpbHkmXe6MUiIble9RCFzH1y
bwy40nhuE7TJajc4Fc0jI+a5ZP6SgeVPXVdjhU3Wk33sBDLYD4XJtTzRXjiNsB0g
YoOy6jHJ6+ruWZZ83fRj3t2peQ9KTJWDJxL4h7FxeC7jXFCECipkG8FOUTtZ8xIU
YKz1q4C0Notu2IlqnwktxTY7TnRuaUxnrGIq8AsO4hWD8VTEAySGdFkKI5Wa8Qbc
+qfwlo8jCARWb+DRm3Mnxn3yZwvmivfe72PoI7uBZiY0DihpiJGoN3KI7MSrwMHa
0rK9gsO6USmtGAS/z9FY3p85R1mC0A==
=4D65
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
