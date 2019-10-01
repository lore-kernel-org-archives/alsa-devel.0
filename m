Return-Path: <SRS0=w4sP=X2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15B4ECE587
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:58:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6734920B7C
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sFsaGoak";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="eI2nep1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6734920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2CA41674;
	Tue,  1 Oct 2019 19:57:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2CA41674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569952687;
	bh=WwXASbYCGxrpYYSKR4QhkcVfXeYhkWBJ/keU67dLnLU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sFsaGoakirmJUw/46uOgwnPWUeDsdudBUE0BWj7PM9ETBmqtGOOz227EbDxu08eW1
	 8sP2AV+XGzEnckrh2Yc8KmSONFriwCpyG1M8iq+pgDRf+wNxek6ovsqzSlS3AUuRFF
	 iyJ+duGYGMn6+DrvJceoSybrVXlx24cG53GfaZcg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D322CF80519;
	Tue,  1 Oct 2019 19:56:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B706F805FF; Tue,  1 Oct 2019 19:56:08 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 200BDF800D0
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2019 19:56:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 200BDF800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="eI2nep1R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=77rfPmQCy4NXwloZ4biLbH0UoWsY3hytG2t401n/afc=; b=eI2nep1RAhBR2abcugd1/Ea6s
 rfSgWdDz2KAaU2EOkXu1FHsMVCt4LY2BtmwcRr1KnqMiDc1Fkm2phQOq/BxW++5cUO1PJk2zTGVmG
 x/U6KJoQnO9U3OgeXlpjA4vFOPi72QbhbMeKhKt09Ie9yHnU6K8B0DO/ejuOkLsQ1VSx4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iFMNW-0005s6-1a; Tue, 01 Oct 2019 17:56:02 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 8191727429C0; Tue,  1 Oct 2019 18:56:01 +0100 (BST)
Date: Tue, 1 Oct 2019 18:56:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <20191001175601.GB14762@sirena.co.uk>
References: <CGME20191001123637eucas1p25c7551d4c967e4a2855f6c8d3b096ff5@eucas1p2.samsung.com>
 <20191001123625.19370-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20191001123625.19370-1-s.nawrocki@samsung.com>
X-Cookie: Happiness is twin floppies.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 ckeepax@opensource.cirrus.com, b.zolnierkie@samsung.com, sbkim73@samsung.com,
 patches@opensource.cirrus.com, lgirdwood@gmail.com, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [alsa-devel] [PATCH v3 RESEND 1/3] ASoC: samsung: arndale:
 Simplify DAI link initialization
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
Content-Type: multipart/mixed; boundary="===============7956576183100248391=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============7956576183100248391==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2019 at 02:36:23PM +0200, Sylwester Nawrocki wrote:

> Changes since v1:
>  - rebased due to reordering patches in the series

These still don't apply, please check and resend specifying what you're
basing them on - I don't think this is an ordering issue.

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2TkzAACgkQJNaLcl1U
h9CUywf/abOQN54gj8rAY85VcxKmxrItf1FNrBL2z0rFILYKV38ByUMbaQN/JVVu
shCwNnjyFJxrrVJJkd/S9UyQNZUSzoHLHCfhaAtwqNVsHAJpH5bUxSgkVNODw39H
w6tUOpW2N1Y6ty1twaaOxAhMUM0UmFfnDSL1oQEYiRcOnTbUBJaUmqKB3VZDm565
nBhbBhYIdIFMkgQk8FsP3wlAAvOhRmSIwd6asxxbgw+7QCVC2qQzssNNFfTs8p/F
bcQ/MqECHte1NoQaq3ripZM47/JcCTylz952igL+3ksBpdBTP/a8XmQrwA3jXprj
zHSqIDv1k9Dkd6sYolAYzv14oA8b9w==
=y3H6
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

--===============7956576183100248391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7956576183100248391==--
