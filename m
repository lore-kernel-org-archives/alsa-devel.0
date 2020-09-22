Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8A7C4363D
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:44:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B99E2399A
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UVP25/Lh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmuJKVX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B99E2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BC0A1733;
	Tue, 22 Sep 2020 16:43:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BC0A1733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600785868;
	bh=m1hM4c6dFFDnao7F9PZYKBupx4rTzbl45tccKtkOQjU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UVP25/Lh1es6G0zpISnGpvzLz2uuosWimJtS9dA8/XDSlqUz3yoB3zUDa/U8I761F
	 gDH7sjUHN6y5NbITYcWkhOm0FJpZqMui7YdLoPcOJmwqseYZtQQmeptvWpkglQ/SHt
	 tk3tm+xb8a1MFUDOlTIthXyKNBTL2Qdiyq+JYD3g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79884F802C4;
	Tue, 22 Sep 2020 16:43:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E465FF802D2; Tue, 22 Sep 2020 16:43:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95799F802A2
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 16:43:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95799F802A2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VmuJKVX8"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 884782395C;
 Tue, 22 Sep 2020 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600785794;
 bh=m1hM4c6dFFDnao7F9PZYKBupx4rTzbl45tccKtkOQjU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VmuJKVX8oP36C9cT3aUT+BZ+z1eEDAm3kR764yQxu4qROx0SIWjH1yFmjoYMzg57W
 ViFCLl3xNJk57KtrYDbEGraAFYAOppbTA+wz4KCHULRmFtfyPP/uaUfCy2J33YXGOX
 FNiDelp7905draUXgZSWkW2KtL/9De70llt0R5fI=
Date: Tue, 22 Sep 2020 15:42:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.8 03/20] ASoC: wm8994: Skip setting of the
 WM8994_MICBIAS register for WM1811
Message-ID: <20200922144221.GW4792@sirena.org.uk>
References: <20200921144027.2135390-1-sashal@kernel.org>
 <20200921144027.2135390-3-sashal@kernel.org>
 <20200921150701.GA12231@sirena.org.uk>
 <20200922142515.GN2431@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gvPGo+RAdjC9O5ul"
Content-Disposition: inline
In-Reply-To: <20200922142515.GN2431@sasha-vm>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
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


--gvPGo+RAdjC9O5ul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 10:25:15AM -0400, Sasha Levin wrote:
> On Mon, Sep 21, 2020 at 04:07:01PM +0100, Mark Brown wrote:

> > This is pretty much a cosmetic change - previously we were silently not
> > reading the register, this just removes the attempt to read it since we
> > added an error message in the core.

> Right, the only reason I took it is that error message - I find that
> bogus error messages have almost the same (bad) impact as real kernel
> bugs.

The point is that the error message isn't present in stable kernels so
there is no impact on any user visible behaviour.

--gvPGo+RAdjC9O5ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9qDUwACgkQJNaLcl1U
h9CjdAf+PXoDfp7834wZQ9f1rb79rWZspO34iLgtd2QfsiJLwuTe2hFDIKkdoXXU
ajhzk5ZjNKGpRq9aid6yJWpRor0e3qn1fUDdJgavmPHoNnTQ6q1EKzHv6nDRMSWD
doWsRBkTkSmignj73JlG9keOyvMgihQVIZSZSEafqIsKWYHXMwLE96Qghgt0hFDv
DrDEz6xHrA4AhTGBEMvhQMy2rvU5O8AwfzyD+u2vD6j+ejy/Q3DdldGMhrPbNvB2
W4l2rheJ1a0km9anTOOUUYHDiDp7ttqpvzuDOB42lttBXk+jgLroxkcU4EKZrsuL
nmlsEikx87yrqnX68TKTrlZGqoaxAg==
=7xiC
-----END PGP SIGNATURE-----

--gvPGo+RAdjC9O5ul--
