Return-Path: <SRS0=HRrq=LM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35233C48BDF
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 11:34:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB3461260
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 11:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB3461260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB8D21720;
	Fri, 18 Jun 2021 13:33:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB8D21720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624016083;
	bh=9s2RQDW9wanQqORyAIBE9pVzVvO91REtRxxPhTclx3k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BMJQQ3rGKEeer2BIwWL9jys4TFJN+qaNW5s7Sa4Ayr5VMDMY6SvbhrKrZTGY52tMQ
	 Wvd6tGb0B93n96IrmvDvw+e9eK0y8Tuh3BMw4H8nAvNQarcix7o1lwhkizpJxhkLpU
	 1GVagaZkq9k/VFsiy2TFI4Ys756Co4L1LFOnuQUY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FE0BF80148;
	Fri, 18 Jun 2021 13:33:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95F89F8032D; Fri, 18 Jun 2021 13:33:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A378F80148
 for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2021 13:33:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A378F80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SqlXqi54"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E68B610CA;
 Fri, 18 Jun 2021 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624016024;
 bh=9s2RQDW9wanQqORyAIBE9pVzVvO91REtRxxPhTclx3k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SqlXqi54Wb+yJCY85fbszND337jMrH1YM9XsF+vWgllGBpqb9VlxWeoQIneYKtmoL
 DDWw6wt7vpYW0ktptOHD07s18Z7MKMyqxG+QttWQ+0Vs2sUxhpzUOOPOfsT/wModgb
 KXCsOEO7f9llPwPii+Ae6A6fRw2dlavWsuGTs3GxHsarnYKzEzSFsGSjK7tZq9E9nB
 aijS9ai4jkTUI2U2HTPCWoqjIGzZ2KpEeJPAT0iO0F5xtCjm/IyRptmvk+3pMiwIFR
 zzUZ93Gzt1DsGgsmiJO5sWtcXSjvGbPlxA3dkXDbdCcC6ctVmJhpGelXftHm9jGPSx
 NZ7ixSeKGTPsg==
Date: Fri, 18 Jun 2021 12:33:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: disable all interrupts when suspend
 happens
Message-ID: <20210618113322.GA4920@sirena.org.uk>
References: <1624009876-3076-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5DYLZmz6f0yjrOpaL4B_wicq0ofrYpW6QqzNPEc0j407Q@mail.gmail.com>
 <CAA+D8AOiL2otCBRyP3q7EWd2C7RnUhWZjRtxcJWQyXXXydf_ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <CAA+D8AOiL2otCBRyP3q7EWd2C7RnUhWZjRtxcJWQyXXXydf_ZQ@mail.gmail.com>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <festevam@gmail.com>
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


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 18, 2021 at 07:30:25PM +0800, Shengjiu Wang wrote:
> On Fri, Jun 18, 2021 at 7:21 PM Fabio Estevam <festevam@gmail.com> wrote:

> > The operations in _suspend() are usually balanced with the ones in _resume().

> > Shouldn't you enable the interrupts in resume() then?

> No,  as you said below, the interrupts are enabled in fsl_xcvr_prepare().
> so this change should not block anything.

Might be worth a comment explaining why there's the asymmetry.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDMhIIACgkQJNaLcl1U
h9APMQf/d/lJMjdPrNhdzJeuS3tVHQ268JZCwmabDferZbnDRbjuwaiq+4wAdnBC
EFksPtmaTNBBrrLUc1bTxLs0Hl0wBGNv+zf5r8FCfEm60zrQF3QKDTZ1t46ZelbX
9uQRMcFanYwBChVofttzEwDHWStsDCHoi7pfP4ZwGTR+SR6rERyzgAv43862ne/G
klbzzYKa+CyLGvojCzNTZBvkyNPQCkhuazh7wk6UolcFTf2oz+wjUPYyJ/Xbwqb5
t+Y4zwAqMls5GZtzFWIohvRgCULmADRq8FqCzFQIYm3teLhDgQGtbM8Xn2Tz3Vp0
MQveAgdluQ8hDsBYMq31CB4CgMOZag==
=a0cm
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
