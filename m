Return-Path: <SRS0=BIX5=5Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCC9C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:08:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13363212CC
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O2LwCaMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13363212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6277486F;
	Tue, 31 Mar 2020 20:07:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6277486F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585678105;
	bh=jl26SHyxAe0iJyZr0GDE1hbdlNocrKRvr1fmq6hyG5Y=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O2LwCaMY9EUqotYhdxtrGEfNP5PwLJA0agp8HSGmRed2ax9lcROSVMI/M2YImL3mF
	 KXDohdWSBRx2vFtw3aTSn9F1CmmLEP6mAe0NcnDwM07l+vWUa0ZZX7/Fu9vd+5h+wg
	 7kq2o5ExsaUaBKTrBjHOKZ4pOImVWrk8bkZJTVmA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C5F2F80140;
	Tue, 31 Mar 2020 20:07:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 387BAF800AA; Tue, 31 Mar 2020 20:07:31 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id EA278F800AA
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2020 20:07:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA278F800AA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BCAA30E;
 Tue, 31 Mar 2020 11:07:25 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BFF13F68F;
 Tue, 31 Mar 2020 11:07:24 -0700 (PDT)
Date: Tue, 31 Mar 2020 19:07:23 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?77+9zLDvv73vv73vv70=?= <gt82.lee@samsung.com>
Subject: Re: [PATCH 2/3] ASoC: topology: use name_prefix for new kcontrol
Message-ID: <20200331180723.GG4802@sirena.org.uk>
References: <CGME20200330073555epcas2p47495e0e0435e6cf34e6a5d7e248a3e80@epcas2p4.samsung.com>
 <000f01d60665$d8e86220$8ab92660$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Content-Disposition: inline
In-Reply-To: <000f01d60665$d8e86220$8ab92660$@samsung.com>
X-Cookie: It's later than you think.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com
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


--/i8j2F0k9BYX4qLc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 04:35:55PM +0900, =EF=BF=BD=CC=B0=EF=BF=BD=EF=BF=BD=
=EF=BF=BD wrote:

>  	return soc_tplg_add_dcontrol(comp->card->snd_card,
> -				comp->dev, k, NULL, comp, kcontrol);
> +				comp->dev, k, comp->name_prefix, comp,
> kcontrol);

This has word wrapping damage too.

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6DhtoACgkQJNaLcl1U
h9BxoQf/dtErOCZxcQuegBqZXoqe10hOS7KtZfQCG1lbC3FHQPmccA4pFEzqk+LZ
z+XRE0+B4ZSxgFxm3Tru8+yacymO+q+j532+I6jEeStrqnISV1bSj1nVCa3EslFj
4WkVrBKrbV8pIFSqU78asMhBsyiXPOfPbMfMSV+aZ9z9D9cO1Lem/UHCopgB206Q
uqUeGwIkcC1qEutqWejqJcGdlpk+F/uSsjOa7Y5Fy3tab0POXPpfF6wvAmhwFFzY
EX7mAMIZI2qidGwL49y5f3uMloRzHi2HYsMML9bXBWdi6pAaawSennsI1s+2q04f
O+MIag8spXQxp3ImOm2uA6i/WAKgcw==
=zPUC
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--
