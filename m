Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65515C2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 13:07:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C14321D91
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 13:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FqRk+0uD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugz0qDz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C14321D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A700717BD;
	Thu, 12 Nov 2020 14:07:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A700717BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605186472;
	bh=JmWe86iRfjnrlFQ0+Hs5aSog82HM/Zfqa8dTyELUIT4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FqRk+0uDNp2q6ERfxT1XgDbNXVqLKydGy8mAVd3WA/Ud76fvub/BX0fiMuWAOBhQ4
	 ORG5Z0VtZcFpgjlpg/1Q8D+9VErXz9DPUrIS1R9IybIp8e88dc6E56XpjlA1nTl3ID
	 tbuspriZfoHl5sPdDg2qOEIOPuzAaBYNMyKaAKsc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BE27F80161;
	Thu, 12 Nov 2020 14:07:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE23FF801D5; Thu, 12 Nov 2020 14:07:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88BCDF800D1
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 14:06:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88BCDF800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ugz0qDz+"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E99B521D91;
 Thu, 12 Nov 2020 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605186415;
 bh=JmWe86iRfjnrlFQ0+Hs5aSog82HM/Zfqa8dTyELUIT4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ugz0qDz+LIQhM2gKFT7JVNwpzS6OQFDZnmRDrjr7SszI5JVe68lIYspcS78TgpOPq
 U78MznsYA0M26v+SKu77sfl2NIue2TEeY0xMUjyAmTx4QAODO7GJgDt5/2UgkytfGX
 h5AEQm1iZLCEGKhodrC1j+1yopJKHBnP4yNlqWg0=
Date: Thu, 12 Nov 2020 13:06:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Zhang Qilong <zhangqilong3@huawei.com>
Subject: Re: [PATCH v2 0/2] ASoC: Fix error handling in arizona
Message-ID: <20201112130639.GA4742@sirena.org.uk>
References: <20201112124140.1730493-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20201112124140.1730493-1-zhangqilong3@huawei.com>
X-Cookie: Danger: do not shake.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, tiwai@suse.com,
 lgirdwood@gmail.com, rf@opensource.cirrus.com
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


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 08:41:38PM +0800, Zhang Qilong wrote:
> The first patch fixed a wrong free in wm8997_probe. The
> other fixed PM disable depth imbalance on error handling.
>=20
> Change Log v2:
> - add collected review and ack.

Please don't resend for this, it just adds to the noise and makes things
more work to manage.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+tM14ACgkQJNaLcl1U
h9DU6Af+JDgNTxXzjOYcPDwjzwwwnrV1ogHeoMCwR40NaMdpKNwgTz4OA0m3ldMS
CSX9yNmw9sOUx1tho/JvUk19e9Vk+N/hip++Ii/e5HpuOTiQb3L4wgbYtwy0Kvk3
kY6L/eDwc5AJOg4gkvhW7Ro6uwMmUQj5Z/i9GGtsvaP/ycaW29Ri+Yqp4cVSS+QR
Q3iofKzcrwLBYX+kF9WA7YEK/C2A//BYUXZ9wnSEwolQ2xNGkWfTeGHMyFbHjKtb
jcG5Mi8uW1+wLtsgS9Yzr78bHYG7Kuoo/r0XOqxcr5p/rAL7KdRSptlZcm0agJLT
4LRC0j8H6Q53B5RrcZXsS+OBsClg7g==
=azxu
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
