Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9236C33CA2
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:26:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7492080D
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tVpal3eC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7492080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B5E01704;
	Fri, 10 Jan 2020 14:25:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B5E01704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578662760;
	bh=gJqXtDL2+Lja2AS7m+xJ3NxsjCiyo2enH48WoBrbq5c=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tVpal3eCLOOdlqe52L6y0LqLK/MRo5SHVx7V0Z5/sYMowL+pUyIKoX5qcf/HBhk2i
	 t/IaLGmKsEYyzofBql7uExOTT3K2TmlH5WQzgyp+Aq7X5gifmmcewJ9SR+Bt3LNNX8
	 BMbpZ48qYBt7p4xWUoMk/6okFKXp9brltRkEEd0s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90B10F80116;
	Fri, 10 Jan 2020 14:25:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C64E5F8011C; Fri, 10 Jan 2020 14:25:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id F2336F800B9
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 14:25:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2336F800B9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECBB71FB;
 Fri, 10 Jan 2020 05:25:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73B233F534;
 Fri, 10 Jan 2020 05:25:02 -0800 (PST)
Date: Fri, 10 Jan 2020 13:25:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20200110132501.GA5889@sirena.org.uk>
References: <CGME20200109212932eucas1p17a0066e1b426db3d4fdbd89632ea5130@eucas1p1.samsung.com>
 <applied-20200108115007.31095-1-m.szyprowski@samsung.com>
 <77e524c5-f0a4-1996-2bf5-cbb7395f7c25@samsung.com>
MIME-Version: 1.0
In-Reply-To: <77e524c5-f0a4-1996-2bf5-cbb7395f7c25@samsung.com>
X-Cookie: A little pain never hurt anyone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Tzung-Bi Shih <tzungbi@google.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Dylan Reid <dgreid@google.com>
Subject: Re: [alsa-devel] Applied "ASoC: max98090: fix incorrect helper in
 max98090_dapm_put_enum_double()" to the asoc tree
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
Content-Type: multipart/mixed; boundary="===============4030485920484921414=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4030485920484921414==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2020 at 10:02:05AM +0100, Marek Szyprowski wrote:

> This patch has been applied twice. First time for the=20
> max98090_dapm_put_enum_double() function (as it has been designed),=20
> second time for max98090_put_enum_double(), what is completely wrong=20
> thing (it does exactly the opposite thing).

> Mark, please revert/drop 4e93c1294f4b051d574d6bc59755d2863286990e commit.

OK.  For things like this it's generally easiest to just send a revert
that can be directly applied.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4YeywACgkQJNaLcl1U
h9Ah3wf+MDyukWg0tVh436KwxdTsrwn1OucKLb64Ll1MS9U38t0GcpHyTfqsPAjT
4Y0mSanevxLyrIvGotqI9ISf1bHiFuhGq5EhfZ3TdROPUfet4153XmLguVDA0hyg
y96Re9MuyvkMvhq9jGtTQoqTXGt90ajnsMEk6LxmdScADs3bzXyyEN2PxLUSCnAo
1tOKL4qjjKzFNvhgo7aoMXFjmitGhRMgi+bFEz3WAzVvEXSYPKAMeXAlyNgNtJKV
cF5lTQ36gBQuHoPAfdbnCzGyTRqkFGf9//9rYMFUf6rqZKzpwhPfFlL4O9cbNNQb
UYm2/wAGzp78Zc1i4ejmMUZC84K1+w==
=EG91
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

--===============4030485920484921414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4030485920484921414==--
