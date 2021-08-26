Return-Path: <SRS0=0cRQ=NR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1E1C432BE
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 16:48:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEAA160FC0
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 16:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEAA160FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 616D316BF;
	Thu, 26 Aug 2021 18:47:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 616D316BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629996479;
	bh=5BkR5bF0zGZlx7J9T0gycIg/KuDBuU99UT630BXNBAI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V2/d38dFcFLJ0khkz4zuTg/QzJboDDfOLJRXPhwDENqMGCmXZUbGsmvEcz2Ln9Z7i
	 F61urgqvH+HMhhJFJizVVSsTxTMNU3XPaZPHBlDB34JGpdtIAccWq+FuRLju6URWH/
	 dBilgrbb6ZlAbrJUVWYF1jV2GaxRkNrSP8HrCjpA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F14F9F801D5;
	Thu, 26 Aug 2021 18:47:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE484F801D8; Thu, 26 Aug 2021 18:47:07 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 756B1F8013F
 for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2021 18:47:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 756B1F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="IWO/WE20"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4iePUfVCoqQTU+Jkn94t4cw64850bMiYuuSedSykd+o=; b=IWO/WE20Q/eE06wvl1XfiRgbYO
 GI6iHwGJE+BJFdsRSgVjxM5O0oA6OHTn5DflXEPoDcNcEWiETt6hMGxE3eslL/jX0/qiZ0ggQhcPJ
 QsPkVfttesRFH+jWF3GztZg/wS4Ypua1j9Qv2asYvPE+L0yDNp4uOLDuGcXjM1Ym9f64=;
Received: from 94.196.104.219.threembb.co.uk ([94.196.104.219]
 helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <broonie@sirena.org.uk>)
 id 1mJIWs-00FVed-Vn; Thu, 26 Aug 2021 16:47:03 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 203C3D123A5; Thu, 26 Aug 2021 17:46:45 +0100 (BST)
Date: Thu, 26 Aug 2021 17:46:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: mediatek: mt8192: re-add audio afe
 document
Message-ID: <YSfFdQLzZkZ4Inxf@sirena.org.uk>
References: <20210826163329.3903340-1-tzungbi@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LUR/zvNV20WmbNxR"
Content-Disposition: inline
In-Reply-To: <20210826163329.3903340-1-tzungbi@google.com>
X-Cookie: I can relate to that.
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org,
 jiaxin.yu@mediatek.com
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


--LUR/zvNV20WmbNxR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 27, 2021 at 12:33:29AM +0800, Tzung-Bi Shih wrote:

> dt-bindings/clock/mt8192-clk.h now can be found in linux-next per [4],
> re-adds the document back.

OK, so that means we need to wait until after -rc1 to apply this
- it needs to be in mainline or otherwise cross merged with the
ASoC tree to avoid bisection issues.  I'll queue it up for -rc1.

--LUR/zvNV20WmbNxR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEnxXQACgkQJNaLcl1U
h9C5qQf+IUkLO9vzpKVDHaBOp7ERntEwOmwTLhF7FfUq26hlDK+Z3++0N1gaMGK5
x+cQtwLw64YMbGNL70rGMJAdQaDAiNvssB3De2uNTrugXkD0Jtfsk+C7GvVYDiNh
nDBn03GrDIdvOOLKbqCt4+TmHdXe2+gOIbBcanp0V9auvjiuGDys1blzcEefxQ+T
oLxnVtjyF5fJmgr9RfS3/Wsf3rLk0PGdISy0e9fgvmzGoPIJsmi/VUbik4ohUr4t
CAZGrJ5nYa42qCwEfwop7OyRs5OOSVydXCMhjKBSBBblAD6ddKoLrbhqOUX9NlQm
9J3Oau3mVbIDPNXm/YJeGtnXvp+09A==
=U92Y
-----END PGP SIGNATURE-----

--LUR/zvNV20WmbNxR--
