Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A467FC4742F
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:19:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61F720809
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="A1cWFB3v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCbvTnIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61F720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1482018C4;
	Fri, 25 Sep 2020 18:19:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1482018C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601050793;
	bh=pARXzuQweWzMGyLglB+Cl1uA4InYoHIq2Zz9Hovb3XA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A1cWFB3vRoafP0lkRaemhg5CR2Qbiz6OL7724sCIVo/rQpo8j2ew64UOB8NvwiyWv
	 tPmgw3VbknbrwNB57CmcsGp2sb5WmQ9ufGodl5sJl8tXlXFSCBST1cdg6eGiuGI0V4
	 3MAf3jmPixSY5ldezBnlN1cIZAO61+ank2qgM8LA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E682F8021C;
	Fri, 25 Sep 2020 18:18:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99DEDF80254; Fri, 25 Sep 2020 18:18:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F984F801EB
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 18:18:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F984F801EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TCbvTnIJ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E47B32076B;
 Fri, 25 Sep 2020 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601050711;
 bh=pARXzuQweWzMGyLglB+Cl1uA4InYoHIq2Zz9Hovb3XA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TCbvTnIJ434Xjb01nThujbP9Fzc2PhllL/uHmfxCbcAl+ceWtDjlIbIYQvy9NN6K0
 ZBBcRYoe3eszWUxlsqe4AJOq4aEEcbkiSw9+7tXZR2KrDh94O+ifThsCoStdxRPx0U
 BpYR4fjCFjKTeWEHiAexquW9xlOhGtF+G2rEgn2c=
Date: Fri, 25 Sep 2020 17:17:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: qdsp6: Drop of_match_ptr to fix
 -Wunused-const-variable
Message-ID: <20200925161736.GE4841@sirena.org.uk>
References: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
 <20200925084925.26926-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Content-Disposition: inline
In-Reply-To: <20200925084925.26926-2-srinivas.kandagatla@linaro.org>
X-Cookie: Onward through the fog.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 kernel test robot <lkp@intel.com>, tiwai@suse.com
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


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2020 at 09:49:24AM +0100, Srinivas Kandagatla wrote:
> The of_device_id is included unconditionally by of.h header and used
> in the driver as well.  Remove of_match_ptr to fix W=1 compile test
> warning with !CONFIG_OF:

It's better to fix this by adding #ifdefs around the table so that we
don't have unneeded bloat from the match table in !OF cases.

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9uGB8ACgkQJNaLcl1U
h9D5mQf7BN4ggDuq0D7tgkLzPkFtKb1QByqki2VZPAvHhk9BfXQvZze88i1f4v9m
PJUnVApRXyrSeBEnbVE84U6c0YlBjqLtfcuPB1k4OJNHfC/HYmRhDcxYs3UzOfkE
42e2sLaxZCEtywxU1KI8C0ZA6v88A9UTKarqQ6UoMuR3fK6zvypAtcYQgFMYLd9Z
CESA+BxYeR52+mZNzjGe4YWvs7L94N2KsoZgXe/Ti1K0IPgmjHdx18wDf8LsFbCt
Q4/mbKDCubywsQzha9IGILFbPByAnjceD2qtptSYWl8mrcrMz+be0KGhyGzUDnyD
N94QdvaIZYVuH+t+AiD+ziRSFsbkWw==
=+N7A
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--
