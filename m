Return-Path: <SRS0=+eNr=5T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F83C43331
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:43:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898C620787
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UZBgLzKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898C620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B67241677;
	Fri,  3 Apr 2020 11:42:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B67241677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585906990;
	bh=4XlI4hHOGCHFw+cWOYhIXjzBNiy1usBWB7gJKpT9lWQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZBgLzKXhRybkBgQKNLdzWnWzkTEfb0kGEc1Tz+u/gg3KDBz7QP2ssSXxLVDW+wqy
	 TUKL7JZNbvPZIdORVgfsgvl8bCMM5XoJQJ8U+jDIJmRKIkr83tSw8smBEcZVnuPdXF
	 68oc7U8mXwopmpU4/Jx0XpQ2yhkLU79jLZ44ucas=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44F20F800E4;
	Fri,  3 Apr 2020 11:42:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B9B5F8014C; Fri,  3 Apr 2020 11:42:19 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 33B10F800E4
 for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2020 11:42:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33B10F800E4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0617430E;
 Fri,  3 Apr 2020 02:42:14 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E40F3F71E;
 Fri,  3 Apr 2020 02:42:13 -0700 (PDT)
Date: Fri, 3 Apr 2020 10:42:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/1] reviving ack callback for 5.7(latest)
Message-ID: <20200403094211.GC4286@sirena.org.uk>
References: <CGME20200403022148epcas2p26dd2bc9071a69f08102af082d813cd36@epcas2p2.samsung.com>
 <1019298652.01585883881138.JavaMail.epsvc@epcpadp2>
 <87sghlnotv.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <87sghlnotv.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Use other side for additional listings.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com,
 hmseo@samsung.com, cpgs@samsung.com, Gyeongtaek Lee <gt82.lee@samsung.com>,
 pilsun.jang@samsung.com, tkjung@samsung.com
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


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2020 at 02:03:09PM +0900, Kuninori Morimoto wrote:

> If you want to revive ACK,
> post with user driver patch is nice idea IMO.
> Otherwise, it will/might be removed again
> because of "there is no user driver".

Yes, it'd be helpful to at least see a user during review.

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6HBPMACgkQJNaLcl1U
h9AmAwf/Wc0hZFUgjWNkJlrs3k/MGOWDPRFF3EZLFKBhpj0zF8VFmdJQDxBB7+Xh
DDB43PAwSQ44bL1pM2mruF9KYrYZoV/aCmnszFvgKkLbGqaqUySmFH5wBRcMGUWr
vlSWLtCSlz6JLqcPMIM7UQ5MccAA2D29Lq0IhwLPOV7iY8Qx4YJ0vYChmABdAaxB
+5LJlQcPdNvQmGcFCa5U98xDVMn0Ygfw0B2jgWuqsuoyUCMDuR1hLTYFQnCeNnoD
SL2cMBuiQnVTqLfFNucCn61SjCrd4G4/TO4HJmaIzJLr5iq/ZroTxBXvpXr8RzTQ
NUwRDZJ6DBLJMIa9X8yxQLDrYmfXbw==
=LCGP
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
