Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951B2C5ACD7
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:38:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A9920724
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JDi3fdyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A9920724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69A77170E;
	Wed, 18 Mar 2020 16:38:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69A77170E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584545931;
	bh=4akeEMEswCjvtvX1Rrk5mzvpnOFnzCu9RW8kKt/LfWA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JDi3fdyw96TfSeMz2KrEa2RaqxaMjYTrgJdyXM0fj/3/fh3SaLC0LmgsdFVuaA2nF
	 O8wIGngznFp3TodhHdH+5uUot3qDLp+cL66In5aHSm9TpPxYHsFooSINeNhIvtuECq
	 vcSoTHuGcHC5TtX+veVnLXFNvCBdfQoDXJaoYIKA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D07B2F80132;
	Wed, 18 Mar 2020 16:38:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2436F80139; Wed, 18 Mar 2020 16:37:58 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 641E1F80058
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 16:37:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 641E1F80058
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 477687FA;
 Wed, 18 Mar 2020 08:37:53 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCE123F52E;
 Wed, 18 Mar 2020 08:37:52 -0700 (PDT)
Date: Wed, 18 Mar 2020 15:37:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH 2/2] ASoC: rt5682: remove noisy debug messages
Message-ID: <20200318153751.GE4553@sirena.org.uk>
References: <20200317073321.12660-1-shumingf@realtek.com>
 <CA+Px+wUeaARQdGXc=x3jNZJvOsF3bSWnaXMPh-Kmji0QCK=oPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <CA+Px+wUeaARQdGXc=x3jNZJvOsF3bSWnaXMPh-Kmji0QCK=oPg@mail.gmail.com>
X-Cookie: Oh no, not again.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com,
 ALSA development <alsa-devel@alsa-project.org>, lars@metafoo.de, "M R,
 Sathya Prakash" <sathya.prakash.m.r@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>,
 derek.fang@realtek.com,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2020 at 11:22:47PM +0800, Tzung-Bi Shih wrote:
> On Tue, Mar 17, 2020 at 3:35 PM <shumingf@realtek.com> wrote:

> > +                       dev_dbg(rt5682->component->dev, "can't find div for sysclk %d\n",
> >                                 rt5682->sysclk);

> Looking at around of the file, use pr_debug( ) here could be more consistent.

It'd be better convert those pr_debug() to dev_dbg()s TBH.

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5yQE4ACgkQJNaLcl1U
h9AbVAf5Ad//f5s6FDCiNYgXTlWGiL5a5j4tdNBkN8Lu+opSUdMJQOpGcP9+IC3l
m/aG5hy8nwvHeeVGapvr98iRxHsyzWo21PDYWTZZx/wQW8QjuZQtHlmEc8YMj1g7
ZOPA31XdUBS3DtwlA2gXa6GGI0l7QzHGQJWbNy1SpWZbcZhGf3bzYz2Crj3fb6jG
GyQ2k1HO7uKA1m+b/3BeWOEaBqcXdrrzhuovq852VIH06b4xJpdiGJOQtX2GP85a
UFt700TxQ6u2V2GDUW/pSJxpG3bSSqX8ezS+8eH4y5B7q7Fr1szRlEQ9mvFtRwh1
Xx1AuDoqT98Fz2jgpm7vH6y3A3oaTA==
=gRP/
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
