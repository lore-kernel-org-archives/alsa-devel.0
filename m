Return-Path: <SRS0=8UIF=YD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2EFC10F14
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:58:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F212420B7C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j1ycoIMQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DTMgmD/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F212420B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1A7B1612;
	Thu, 10 Oct 2019 17:57:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1A7B1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570723091;
	bh=CJiYHhFZc5slTDNXcsr1UJLbi7v0bVG1eHMCXJ9FBvw=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j1ycoIMQJbDg0ggPo0/kOnduNk7a0Z2lNJQA/DSsL7lcidXIs7Hd3DWwv8cAQ+Ma4
	 CSHzXQJkwVbQVk4bAKrvHHFZry7myx72Ts3t+Sq8yfLJCzuuNh/dli0/jAhVkyzqRi
	 VG74Pg5qPl4TdnVE1ADpN6PlSpf3FB+E3Tw9Gaiw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69B87F802BC;
	Thu, 10 Oct 2019 17:57:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22B52F8038F; Thu, 10 Oct 2019 17:57:20 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EABAFF802BC
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2019 17:57:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EABAFF802BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="DTMgmD/M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ViRqVDBCrSWY+fOz3i8Bb5UjyYmM7z1MB1RbjK8mhWU=; b=DTMgmD/MnCe1zUY7uA8YoFYi0
 IiLlDTb3Ekr8q06vfRgH3D43Vk9ENqSv55l5k1XLtJWU5XVddF5NTF1hMue8+LTxys8QPI0ByALMp
 TbHYxi57dtoU1ZdOfqSNsycn1uJcflcznOSifM3jX7tlNmS1BA/8xf5CHHE6w/F0ya2xE=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iIaoW-0001xV-OR; Thu, 10 Oct 2019 15:57:16 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 1E355D00041; Thu, 10 Oct 2019 16:57:16 +0100 (BST)
Date: Thu, 10 Oct 2019 16:57:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Message-ID: <20191010155716.GE4741@sirena.org.uk>
References: <20191009181356.GO2036@sirena.org.uk>
 <CAEnQRZAR1b-CHHVEv0ia92vYu38fWkwgW3mdwJFhEQsHk2j5+A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEnQRZAR1b-CHHVEv0ia92vYu38fWkwgW3mdwJFhEQsHk2j5+A@mail.gmail.com>
X-Cookie: Void where prohibited by law.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Curtis Malainey <cujomalainey@google.com>,
 Guido Roncarolo <guido.roncarolo@nxp.com>
Subject: Re: [alsa-devel] [ANNOUNCE] 2019 Linux Audio miniconference
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
Content-Type: multipart/mixed; boundary="===============7138885113596990744=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============7138885113596990744==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2019 at 09:48:14PM +0300, Daniel Baluta wrote:
> On Wed, Oct 9, 2019 at 9:15 PM Mark Brown <broonie@kernel.org> wrote:

> My topics:

I'll add these to the agenda.

> - SOF driver: ACPI / DT unification

Are there concrete plans to discuss here or is this more of a
"what are we doing" kind of thing?  ACPI standardization has been
an issue :/

> - SOF driver: Handling built-in driver use case

What's the issue here?

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2fVNsACgkQJNaLcl1U
h9C3KQf/eS5VnHNcxya+vVcaZKM2dFGpzNyFhcQ8JT+ToWPYYyUiTqMwLD9FAveU
A1xEyc1x3VBZD/ZHfnBGSF9ERUPswXk1XDm0tDnHIIKJ1KA4VyuA16oeYx3LtMFJ
sMjg9Oq36Yrh5tR8+PHhHJabffd525yX9FaxMtTRmZTDFXLp8XSMc0H58mKF9Wij
jGQbAATA7f72vULM6fpFNhMpyetzMEqDbNr6qVO1eJqz1ZfV/lHUeHQLgd+ZRiw4
EBYSuaknp9pCZ0677etmMRX6vInPkfv8J/DKdvOw+QGcv324ofSnFyfeXToZNiVw
4DnW7sCBuwMwIOEtu4inC26t1nH0Dw==
=6GjH
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--

--===============7138885113596990744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7138885113596990744==--
