Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9EBC433E7
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:10:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9961320658
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VnYrG0Je";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6d3UlLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9961320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0304A1734;
	Wed,  2 Sep 2020 12:09:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0304A1734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599041404;
	bh=0wE9Icb6hIc1F0Ud72UzTfGsFLDOKqee1Y9bBdmkfkw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VnYrG0JeilBlmQimFeIWeL9jNtjuW5n9cqptvwGgBTC15TqVG+8BjnFhqzDBv9EU5
	 EMK9gbNseJ/Lx+S9ond+q8gnX2LdXiXT8gHH4QufURPshUPkQgbfhHXPj9Jd8HyPAb
	 DBJjseQgUuUhaw5HJ9MHUX0SFgx/ZCdNlusQEO3o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8178AF80212;
	Wed,  2 Sep 2020 12:09:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60E31F8024A; Wed,  2 Sep 2020 12:09:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A710F800F3
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 12:08:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A710F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="X6d3UlLP"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 21B5A20658;
 Wed,  2 Sep 2020 10:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599041335;
 bh=0wE9Icb6hIc1F0Ud72UzTfGsFLDOKqee1Y9bBdmkfkw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X6d3UlLP5u+w2FwFN77cUEJ8LV7NY8dtP15k9sa2SkNNPaPICCzRY/DYWl4iGVzlA
 LzUrDcQSi4x3WbLafz84XHBGo2ulY0WQ05dStxXS1RN1uWLoYGgX77QTZUGpujeJ61
 xu+VCT6PknCtouokGQjVP+wHwBUZYi/m2Ph+D+bk=
Date: Wed, 2 Sep 2020 11:08:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Allen Pais <allen.lkml@gmail.com>
Subject: Re: [PATCH v2 06/10] ASoc: fsl_esai: convert tasklets to use new
 tasklet_setup() API
Message-ID: <20200902100815.GB6162@sirena.org.uk>
References: <20200902040221.354941-1-allen.lkml@gmail.com>
 <20200902040221.354941-7-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <20200902040221.354941-7-allen.lkml@gmail.com>
X-Cookie: Prices higher in Alaska and Hawaii.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Romain Perier <romain.perier@gmail.com>,
 timur@kernel.org, Xiubo.Lee@gmail.com, clemens@ladisch.de, tiwai@suse.com,
 nicoleotsuka@gmail.com
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


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 02, 2020 at 09:32:17AM +0530, Allen Pais wrote:
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.

Acked-by: Mark Brown <broonie@kernel.org>

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Pbw4ACgkQJNaLcl1U
h9CRsgf+LUXPWsq2KUG1nixhGgZ3dm4VhGakdpsQFhADcgsyxQ27TvCvbTs+TOIW
hg7anzpSdi8Wn/eAd2zUNdPyRi8Vx52RSwHE2RpWEZu4XUJp+e3cHo/YVXeGx86K
ZfwG/9wDvf2KSo0IcbP+zZ899SMssFDgj/AosMJ/djGCxlbqB3a0CAwg9ObzhBq7
IeqVt0ejqgY4qRLtl7KI6/1c+WCyuON5eKJHxtDsaXlY75JJ7c5A+DMtgy9JZCN3
AZB5qzs137Ry5qZiOOwEMppm/uiT9eXbqswS6H+XYWWr7KJdmp9BZ9r+m+tL4PqP
o4bmSb4XjP40x0K4E63IY9jU8YDIPA==
=L7hG
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
