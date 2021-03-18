Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE06C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 13:53:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDBF64F1C
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 13:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDBF64F1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0ED5C1680;
	Thu, 18 Mar 2021 14:53:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0ED5C1680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616075634;
	bh=Ve2/nk1F/T+GCGAKVkxI6siAwFKoql1OZeOANplilpk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vqi5/83vMuvRccPA9tsANAr4WRvWShn9dPujST1DP5YfQQrNT4HV4rumP1mMlYzDv
	 nzd49xt6omHKZ/k+nJ55ZnPZDS/yXF3rpbnckM4bB60FJLgRj/GuJtLWu7oB+FuVLW
	 i2acTbkbnDtGus5/K292G/W7SUiCBPp2UQ7YZmHs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DE51F80163;
	Thu, 18 Mar 2021 14:53:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B092F80165; Thu, 18 Mar 2021 14:53:02 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79E9DF800E0
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 14:52:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79E9DF800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LbGrPpjF"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81FE564F1C;
 Thu, 18 Mar 2021 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616075576;
 bh=Ve2/nk1F/T+GCGAKVkxI6siAwFKoql1OZeOANplilpk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LbGrPpjFvFY5bgXjGUkYQIlDF+JgGSMwDGGHs05lcoP6in3NJG8CApMpKgA1/PUxx
 fk+Icf+AQYzstcVrJyr1uuOvGgcY4ZGfddBSc8fkCBsiPGHClKrF3AnhLP6ZeMek54
 QROl2zHAGh2ZCZOomoCaQ10+sC6/oiE9g/Iwy2rv5I03ofndoHgwtDjKdtXRGlCb9v
 ureFi8aJUXKFqrely86AaiR90u/XdtZUlQPP8w+Dd4AjF7SPbV6Xhu4zJ208VBmIDg
 QLNMqw9C5MWnuFrexJ1U1Fow5YQJp662M69fD6qfAkZo8LgG3v64cQ54iQtNej1nFR
 Bv7vo5RuU8lnQ==
Date: Thu, 18 Mar 2021 13:52:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: Re: [PATCH v3] ASoC: Intel: Skylake: skl-topology: fix
 -frame-larger-than
Message-ID: <20210318135252.GA15895@sirena.org.uk>
References: <CAHp75Vdy083+5K=4sViwg8uNJ1_6agECYbjMSFEGXX9VTO85WQ@mail.gmail.com>
 <20210315013908.217219-1-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20210315013908.217219-1-nick.desaulniers@gmail.com>
X-Cookie: do {
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: guennadi.liakhovetski@linux.intel.com, cezary.rojewski@intel.com,
 amadeuszx.slawinski@linux.intel.com, yang.jie@linux.intel.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 liam.r.girdwood@linux.intel.com, Julia.Lawall@inria.fr,
 Andy Shevchenko <andy.shevchenko@gmail.com>, mateusz.gorski@linux.intel.com,
 tiwai@suse.com, andriy.shevchenko@linux.intel.com,
 pierre-louis.bossart@linux.intel.com
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


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 14, 2021 at 06:39:08PM -0700, Nick Desaulniers wrote:
> Fixes:
> sound/soc/intel/skylake/skl-topology.c:3613:13: warning: stack frame
> size of 1304 bytes in function 'skl_tplg_complete'
> [-Wframe-larger-than=]

Changelogs like this look like Fixes: tags and confuse tools which
attempt to parse them, please don't just put a Fixes: at the start of
the line.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTWzMACgkQJNaLcl1U
h9DNPQf/Ub0XFEPo2B9Zb6vwJ2ekYiSV9f5fi6blCU8XvdPmKPbarXfrB9bmnotr
QOIiIeGxmzDtZ9oBncTT7isXsVeXsZE84KvUK+KNR9NZCsUIreZNz0zC6wFHwJAQ
uwRp4XlbZaTySmrf0dwLtv6N0KMNXBk1i5t0P9Ra1tAb5m4MDAJ/sH45AIq6oryz
bv1JEL2HrzmMUvxVX5z0PHl15b6tGH0l/XTIzoBATjvHvQzvuZLL80qA7u3ZTPRH
Ed/gMjwCl2v7TGcWCeAtCqV+/ainIE49hg3JFti4MYMi46Yymr27w/IkQ4MU1Rkx
jwJrd6gzeSoZp7WYDaYS+GVnkTJgHA==
=8dZ2
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
