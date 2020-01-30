Return-Path: <SRS0=xcY/=3T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE10C33CB3
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:42:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D934F206D3
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xn78Kta5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D934F206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DA7C166A;
	Thu, 30 Jan 2020 13:42:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DA7C166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580388176;
	bh=O7+CmUzE4InisufZj5g6L309v+StaPua7fsv/wDLWqk=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xn78Kta5EvtzyBv+K7vPYWAqBjg9xtn29ITLRyb6lb3K7DaLtHSik8er/nr9J/y8/
	 k+w5szoNYqxYsOiNOCHO05d766w7S51lGX2Zpt/cGHbw8Zvu8gDFWQdSVbXXhpN8dF
	 8KjHUIR6Ywi4SM4EInD4y4dh41ya9fv8nXDtfgyk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97E99F80123;
	Thu, 30 Jan 2020 13:42:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D050EF8014B; Thu, 30 Jan 2020 13:42:03 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 5E089F80082
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2020 13:41:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E089F80082
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A04C4328;
 Thu, 30 Jan 2020 04:41:57 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E7B43F68E;
 Thu, 30 Jan 2020 04:41:56 -0800 (PST)
Date: Thu, 30 Jan 2020 12:41:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Message-ID: <20200130124155.GA6682@sirena.org.uk>
References: <20200130114930.28882-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
In-Reply-To: <20200130114930.28882-1-codrin.ciubotariu@microchip.com>
X-Cookie: Positively no smoking.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alexandre.belloni@bootlin.com, Arnd Bergmann <arnd@arndb.de>,
 nicolas.ferre@microchip.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, ludovic.desroches@microchip.com,
 mirq-linux@rere.qmqm.pl, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [RESEND PATCH] ASoC: atmel: fix
	atmel_ssc_set_audio link failure
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
Content-Type: multipart/mixed; boundary="===============6792195832812289029=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6792195832812289029==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2020 at 01:49:30PM +0200, Codrin Ciubotariu wrote:

> Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I can't take any patches without a signoff, please see
submitting-patches.rst.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4yzxAACgkQJNaLcl1U
h9DhMggAgULBasGe93GC8xP7foe0sWUQUTvtUeuVxUrWZlYrXAPuYZI6f0/bMeDf
chL5NIydQW2a9sMqyqBKfu5WZbl1k1ABVrFmA/CmUflMej4IdsVLM6mKdkhetmgu
XjQtVObQGU7Rx7dkpGjsrVQkzuC94G5DfcGWJYq3uABTsMlDM5+Xdp6bUbWXHza1
uCdbwrrbNivS4UH6WPvYW7I82MpdvonLc7ZhsDFa3yonrmHSnIvAQr0KLJZkCE5R
6zGBQike3MUxHiwIYAslGI3Kc7pmMlVNUHzja77PpZVFNGN7TYCeRri8FQtLXZQt
1lhBjUL3wgBwVOAYTzHtsXtUEgCOoQ==
=f+66
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

--===============6792195832812289029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6792195832812289029==--
