Return-Path: <SRS0=1DJj=5R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133A3C43331
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:38:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C4F2073B
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ag8xuCnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C4F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E353D1660;
	Wed,  1 Apr 2020 10:37:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E353D1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585730288;
	bh=oNkcy6MCIxLMMKXHzyyc2MBvLh1ZBTsMYqXgnMQF8B4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ag8xuCnMT0L3FT7FspU+GMxob1gWrrSQxT+xjMn/tk1Oc5sotyoDxPA/8xxY/Sd6i
	 YbabxEUhLyon9Ehg/Phpt9NjGyhS2fbqepZVoETAfCuTmaSRH/hGTLTzRSd/i2iq5L
	 2iHTDsSemkNnl8dqUAcQwzI2D5IY43/Bh7oajRbo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 734AAF8014A;
	Wed,  1 Apr 2020 10:37:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DA15F8014B; Wed,  1 Apr 2020 10:37:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 32FC2F80110
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2020 10:37:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32FC2F80110
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6756C31B;
 Wed,  1 Apr 2020 01:37:10 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF7CA3F52E;
 Wed,  1 Apr 2020 01:37:09 -0700 (PDT)
Date: Wed, 1 Apr 2020 09:37:08 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?77+9zLDvv73vv73vv70=?= <gt82.lee@samsung.com>
Subject: Re: [PATCH 2/3] ASoC: topology: use name_prefix for new kcontrol
Message-ID: <20200401083708.GA4943@sirena.org.uk>
References: <CGME20200401004223epcas2p2a2b0f54f83ea8fa0c1a1b96660cf4b69@epcas2p2.samsung.com>
 <004c01d607be$68cd8b50$3a68a1f0$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <004c01d607be$68cd8b50$3a68a1f0$@samsung.com>
X-Cookie: The Ranger isn't gonna like it, Yogi.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 hmseo@samsung.com, tkjung@samsung.com, pilsun.jang@samsung.com
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 09:42:23AM +0900, =EF=BF=BD=CC=B0=EF=BF=BD=EF=BF=BD=
=EF=BF=BD wrote:
> Current topology doesn't add prefix of component to new kcontrol.

Please only number patches if you are sending them as part of a patch
series, the purpose of numbering is to make sure that things get handled
in the right order.  Without a series it looks like there are some
missing patches.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6EUrAACgkQJNaLcl1U
h9A44gf/YID6zxs73bxg9qqZA+lDbazM6OoPj+aQIQAQDpJb61z4CCa8gmzHhzkp
iEUUvkGYTBq9+DjRrAK2CGyWuv3oyeoRe1l3wlwP9KpkbpkTXORXfyI0ZZQK7/K8
UgOw58rHO+/UeAlCtkXO6rVAUgGFJB45Uhy5w3wsPR5sOnn8s/ubiwbmgBCOwJVD
Q+kk4Ga8vKp3HRvBM0Hwmg1hadAnhzwxmYaXU8mkW2F3Mmb9TfDFP052W8NgKKb+
rhGqT/DbzN7+VBdzwpVJFrDTP+fIELWBkKiKjVwhUbpG2ma5mqKsrXF4tAPE4zVz
soK0VmDTQ6/x7HDj2UnaAKQJjfjnDQ==
=xwrp
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
