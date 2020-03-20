Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7497AC4332B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:16:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC3B2051A
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FYWJUTEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC3B2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FAF517B2;
	Fri, 20 Mar 2020 13:15:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FAF517B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584706600;
	bh=7DU4BFEH027DS1xtBiza35jxnRowW4xC2oTqrwQMZWU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FYWJUTEXT+Fjbf9y3iQbUhMGpWWdVR7ndqKiO0v9kIZ/RoIiDGSyOA2nRm94meu5E
	 fn9GiehchG3FqTNloGhzoVmIeyKKztp2xMnHJXzO6A97K9EyxJQSzLp3+XgxJ6EH1U
	 2Eo9hjefCBKMQyLz2c8uVOICoGjudGBPn9LWctWA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A057F80126;
	Fri, 20 Mar 2020 13:15:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40204F8015B; Fri, 20 Mar 2020 13:15:47 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 22B8BF80126
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 13:15:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22B8BF80126
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A50AC31B;
 Fri, 20 Mar 2020 05:15:41 -0700 (PDT)
Received: from localhost (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0E13F85E;
 Fri, 20 Mar 2020 05:15:41 -0700 (PDT)
Date: Fri, 20 Mar 2020 12:15:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [alsa-devel] [EXT] Re: [PATCH] ASoC: sgtl5000: Revert "ASoC:
 sgtl5000: Fix of unmute outputs on probe"
Message-ID: <20200320121539.GB3961@sirena.org.uk>
References: <20191212071847.45561-1-alison.wang@nxp.com>
 <CAGgjyvHHzPWjRTqxYmGCmk3qa6=kOezHywVDFomgD6UNj-zwpQ@mail.gmail.com>
 <VI1PR04MB40627CDD5F0C17D8DCDCFFE2F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <VI1PR04MB4062C67906888DA8142C17E1F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <CAGgjyvGAjx1SV=K66AM24DxMTA_sAF2uhhDw5gXCFTGNZi8E7Q@mail.gmail.com>
 <VI1PR04MB40620DD55D5ED0FDC3E94C2BF4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <20191212122318.GB4310@sirena.org.uk>
 <CAJ+vNU0xZOb0R2VNkq6k3efdkgQUtO_-cEdNgZ643nt_G=vevQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0xZOb0R2VNkq6k3efdkgQUtO_-cEdNgZ643nt_G=vevQ@mail.gmail.com>
X-Cookie: Laugh when you can
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Igor Opaniuk <igor.opaniuk@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alison Wang <alison.wang@nxp.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
 "festevam@gmail.com" <festevam@gmail.com>
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


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2020 at 01:49:37PM -0700, Tim Harvey wrote:

> The response above indicates maybe there was an additional ALSA
> control perhaps added as a resolution but I don't see any differences
> there.

The response is talking about existing controls that are already in the
driver.

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl50s+sACgkQJNaLcl1U
h9BQ8wf/bNkc+gfjOgAy8vg35nBok4c9UrW/sr+phlxjxTDNXqHsikV9NU5wVryf
PPMFtP7SNRjy3sKVlkVzph8IhxbMv5BA1DDp2ejW6L0Gh+atXdN4Wr9Cupiw4+PB
mf9bOzJ7Ol0cL9nHaaLBZKyBRg8kjw2h9g5T94UDlelR4csnAI7NYlO6crY2xOlR
CIDGMt06OapXefylEtQFRXc2usw180zscmOlEmafMku73M2qsyAWiXbvJD2O38Dz
QZ9M/NoQpp62WHkPawJXe19ju6n1KrEuPhIr8hW2EcHRbWligh3stcdBrZupXQfd
0TV+XAdvYJRrLzbCEu8v4+poN+b6hw==
=PTUB
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
