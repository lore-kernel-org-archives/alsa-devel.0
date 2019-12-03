Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A82C432C0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:33:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFAC20659
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FHxHuHSE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="egqYvhOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFAC20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C60884A;
	Tue,  3 Dec 2019 15:32:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C60884A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575383581;
	bh=yfT40LYG54GnVGa200m0qBfpmKihY9mns33W6bzJ7zc=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FHxHuHSE7mHM4KJg1rSRXwURsdL5bQ3gNpAukKUGMjkWJ8z0J76cbbx0VPEUbsQwo
	 FTfjaG+T1YSa/+Z24jcosvugf98dkwNZo9HRuCxRMIcQwblLv5kYDvEEPcfUn5J0gx
	 VXjj0mCTsbhgSVT/CJRskW0ll9/cdjoBRb+8i3SY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96206F8015A;
	Tue,  3 Dec 2019 15:32:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEFFAF80227; Tue,  3 Dec 2019 15:32:08 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58082F800ED
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 15:32:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58082F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="egqYvhOE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lHp+myS6pf4Jfc7A7zQQjP81X0wvMHMx0CwGmN1oWK0=; b=egqYvhOEsxCp5bOxO2pnJLKuL
 ftuVLFeE1d5MsyaRITrv3FZ+fkI3ZWV0QwMMVogTy6OGYULANmJ0rt3JYeBXul2zFPwlwwTAPxwKv
 FGu0H5HTmkIPyfOqt4xRQqFIB8MStA3U3DlyKGEhp1SKJUP+8NODfTKF7N+xlRQ7kuN90=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ic9Df-0002kh-GP; Tue, 03 Dec 2019 14:32:03 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 36491D002FA; Tue,  3 Dec 2019 14:32:03 +0000 (GMT)
Date: Tue, 3 Dec 2019 14:32:03 +0000
From: Mark Brown <broonie@kernel.org>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Message-ID: <20191203143203.GK1998@sirena.org.uk>
Mail-Followup-To: "Angus Ainslie (Purism)" <angus@akkea.ca>, kernel@puri.sm,
 Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Allison Randal <allison@lohutok.net>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Enrico Weigelt <info@metux.net>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191202174831.13638-1-angus@akkea.ca>
 <20191202174831.13638-2-angus@akkea.ca>
MIME-Version: 1.0
In-Reply-To: <20191202174831.13638-2-angus@akkea.ca>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, alsa-devel@alsa-project.org,
 kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Enrico Weigelt <info@metux.net>,
 Allison Randal <allison@lohutok.net>
Subject: Re: [alsa-devel] [PATCH 1/2] sound: codecs: gtm601: add Broadmobi
 bm818 sound profile
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
Content-Type: multipart/mixed; boundary="===============2213508423534772457=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2213508423534772457==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YZQs1kEQY307C4ut"
Content-Disposition: inline


--YZQs1kEQY307C4ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2019 at 10:48:30AM -0700, Angus Ainslie (Purism) wrote:

> +	if (np && of_device_is_compatible(np, "broadmobi,bm818"))
> +		dai_driver = &bm818_dai;

Rather than having a tree of these it'd be better if...

>  #if defined(CONFIG_OF)
>  static const struct of_device_id gtm601_codec_of_match[] = {
>  	{ .compatible = "option,gtm601", },
> +	{ .compatible = "broadmobi,bm818", },
>  	{},
>  };

...this used the data you can provide along with the of_match as
the dai_driver so the probe function doesn't have to know about
the individual variants.

--YZQs1kEQY307C4ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3mceIACgkQJNaLcl1U
h9D6eQf/T/YMXLxjUSaHDNc3AzKq7rmVZaiaaG+DgfkilPDOorbOBrcpI9of4xTG
59U9JeM9TLU3DNyTPO1aTK37vDTDq8y3wmkw5H2IRqldu46zxbSPqwzkeHdwBdNZ
XPWhtvtg1pcAfPR3hqSvKQOk5+rKWDQxXthiVH5sukuB+p4kavijAnJWamv+D7QU
LrSnZB9IQP17L2CfxVSKXouPphsnvD7sd8f/H+iElMtzDvYBB4iTFcnIBhpa9v6K
rbR2dFgEc+egWZCVY+OVeFh/NGRDTu9CgcLz+D7rkivTNXjcbmoUCQ9ijEEF/sRk
fdjT/0UJKPykUJvMEDbsmafVaq4J5g==
=XMui
-----END PGP SIGNATURE-----

--YZQs1kEQY307C4ut--

--===============2213508423534772457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2213508423534772457==--
