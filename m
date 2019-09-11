Return-Path: <SRS0=DUcU=XG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D45C49ED6
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:04:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968D72075C
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JZziLVfL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SyVqUXDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968D72075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1891169B;
	Wed, 11 Sep 2019 12:03:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1891169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568196289;
	bh=uIPF4H9vK1fTivZ0j1X+WemG14QJgOV6CBpeRD9QU2w=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JZziLVfLC0DIY9I5+mvFbD/z4HXJDSil3kKb/KJzNTpYKFk4lk2WUKbwB2InXSiuC
	 KrZjbGYoElUDY3oCpCGemTwzbeMf62LoIZp3vBczjdUcXqYoEAzztynV+/9wOHBnpH
	 1Jis6cipunMrFNHca1MXFIiSRasWarLjn2WSytQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46A5BF802DF;
	Wed, 11 Sep 2019 12:03:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A838F80323; Wed, 11 Sep 2019 12:03:58 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE19CF800A9
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2019 12:03:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE19CF800A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="SyVqUXDT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jfmz88C6lrhs31cRlnO49TRqP1LMaWlkChTQG4q+Yew=; b=SyVqUXDTdYWAInG1jgsHwaWdH
 tFuY19DeE6XUnOA8U1ciXF7ZiKrzizIVnnPTY6a92MPIuOvWPmsjgqyQtrNbBWMkLEq0JsiR9WWN1
 cQeZAgZYhaSoiYcVYR/4luC1DZDJWUAVMCNaegctmk9+yh50ZCeqva6nVQmNIi4/WDrOQ=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1i7zTd-0007XI-4R; Wed, 11 Sep 2019 10:03:53 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 87284D02D76; Wed, 11 Sep 2019 11:03:52 +0100 (BST)
Date: Wed, 11 Sep 2019 11:03:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Message-ID: <20190911100352.GS2036@sirena.org.uk>
References: <cff8bff1e8d3334fa308ddfcec266a5284e3c858.1568169346.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
In-Reply-To: <cff8bff1e8d3334fa308ddfcec266a5284e3c858.1568169346.git.shengjiu.wang@nxp.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 nicoleotsuka@gmail.com, robh+dt@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: fsl_mqs: add DT binding
	documentation
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
Content-Type: multipart/mixed; boundary="===============8424652578073064385=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8424652578073064385==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="//h4sZKAxcnndsN6"
Content-Disposition: inline


--//h4sZKAxcnndsN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2019 at 10:42:38AM -0400, Shengjiu Wang wrote:

> +  - gpr : The gpr node.

What is a gpr node?

--//h4sZKAxcnndsN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl14xocACgkQJNaLcl1U
h9DCkQf/boGjyVueB4AhrIMUugvRHAK7g8btFd64V3bz8anjolHMklTWGGeE9FGv
Z0dIvqYu+GNy8SdEDagnH4ZqeiGhgDyeNLCPCSg++HgsJLsw2PadGfxpIagEPm1X
5MXKVBiRW31EKo8d58xRsNVbWdWpkNsMW/4JiTRQR6IZ4op8DxAqGmpWpvjuAcPZ
KBNo78YpmO3x+stm5dC9zAXWro0NzcMu2G98bLWAHieY5yT8v7aQDFZtPvNRjxNr
2IyRhZDcE1NU+Kbi8QGKYtmTYICdgJtt4wsx2k4GZ9/+SXx+d+HL6UHu67imQm6N
/0diiJmTf9MkEXh05p1whRrAXYKiyA==
=XX1U
-----END PGP SIGNATURE-----

--//h4sZKAxcnndsN6--

--===============8424652578073064385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8424652578073064385==--
