Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264BDCA9EBB
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:54:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF3321A4A
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dF/4lvCR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="MOGtrGjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF3321A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3303167D;
	Tue, 22 Oct 2019 18:37:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3303167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571762272;
	bh=ZM1gwyFqRdN0IWMPGcJiLTKOUZ1T0Zks1Sz7aqyUwhU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dF/4lvCRJNOeUsr+UzvcpEBrvLa0sK1yW9cMJdzwcY5f9fOgMDZWaO8gTxLQKehyO
	 myEPFf4F6lv0grcSuV1qyD3WLZ+PyPxwGZWcbnnvtmNuf0yAvrDaAptKpprlGBtvAU
	 PdfHQgYNLCHEyopVBuEvDGIHnpp6bdI4rjicUn+A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D36EDF80539;
	Tue, 22 Oct 2019 18:37:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C319EF8058C; Tue, 22 Oct 2019 18:37:00 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A011F80390
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 18:36:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A011F80390
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="MOGtrGjt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4ZBKUToM4kIs6IK0jvb//AxftUHAUYBkcNObJNOnlPs=; b=MOGtrGjthGlR3pSbKo+weGsls
 BXeOAuHLQfVk9vCepzkg1OsBEJ7Z4ntOIC+i/GISbKG0FOHh0eKH5L73rHW0dpfQTaV/vry62tU4T
 Hm80vAIAxzNWHehm01jGPvardu0aOwk7J8o+rTauTWKeJRRMR3WKf4LvF67w/MDsqQacY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iMx9V-00072t-8z; Tue, 22 Oct 2019 16:36:57 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id B6F652743259; Tue, 22 Oct 2019 17:36:56 +0100 (BST)
Date: Tue, 22 Oct 2019 17:36:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191022163656.GN5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-16-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20191018154201.1276638-16-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH 16/46] ARM: pxa: tosa: use gpio descriptor
	for audio
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
Content-Type: multipart/mixed; boundary="===============3863435157474140660=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============3863435157474140660==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D9sZ58tf58331Q5M"
Content-Disposition: inline


--D9sZ58tf58331Q5M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:31PM +0200, Arnd Bergmann wrote:
> The audio driver should not use a hardwired gpio number
> from the header. Change it to use a lookup table.

Acked-by: Mark Brown <broonie@kernel.org>

--D9sZ58tf58331Q5M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMCcACgkQJNaLcl1U
h9AS+Af+KFHD1F8v9aWTr2l9IPxxO3sNqMg20rA6oPY9MS9aXMLdK7qrijFp3fn4
i4ST1qYowqgeTOqsC1hZdVKaVBU03Y/vRLLwn3GJSOH0YacQ7zB/FRQHmRESlLJu
MElU0aFph1IXDxzmPQPtxEgpGxilIY+gvHr1xQGlUiQUwluK2bV86cxb2Yq6kAF1
Fi5OLRPu4hWUN/WqDurqBzh5gWBrNliCsE3LBjS1ZtxjsrvY64cyNsRb8Mq3sTZi
R2sybjdMAU8xLBSsgFAA4S/N/8+hPZ7/6y9ot1YrIw+ZUnusvbOgPksE5VXuQofR
EVy8ciepYsBPN6Ub04X5V8aRAkJpog==
=SULd
-----END PGP SIGNATURE-----

--D9sZ58tf58331Q5M--

--===============3863435157474140660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3863435157474140660==--
