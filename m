Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA2C433E7
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:11:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B78206C0
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h2qLft8W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zJdRVyGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B78206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC53C1739;
	Wed,  2 Sep 2020 12:11:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC53C1739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599041514;
	bh=LRn25mkz5jY53YTarh2TIsQrLHDNa1lpJcQeyDOPdis=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h2qLft8WN3y1sBQJZ9lF7ZodaqWD1P901YbvH+M89Y9XeOO4r/O6MG+I61Elrg685
	 7W/EfEaKFTHcxYXKTrPULe7wV2j3xPiGNASrBMGEFoy+5obZh50rV0CIG0fW1lAYNB
	 cFIeFm7gtnPm3AuEAbRU0EVO/rGvzZ5Il+s7eSY4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E97FF800F3;
	Wed,  2 Sep 2020 12:11:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 923B2F80257; Wed,  2 Sep 2020 12:10:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E1CDF800BA
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 12:10:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E1CDF800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="zJdRVyGT"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 30975206C0;
 Wed,  2 Sep 2020 10:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599041451;
 bh=LRn25mkz5jY53YTarh2TIsQrLHDNa1lpJcQeyDOPdis=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zJdRVyGTOlxVB5DEC3wJQp0wHoyxSKyuWcGNZ7nsR8SXuJV5mB2w38IB1gGYoxnIA
 rfqmlubFfb1jcvHdpQvyo909ZfbJ1rRF5WdfUnOvMavMhLW/UihPb2k7ykVrLsmz0A
 BBWcXpwPrAU8DgmRt70BZLiWWjb0mqzrzG4wiN4s=
Date: Wed, 2 Sep 2020 11:10:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Allen Pais <allen.lkml@gmail.com>
Subject: Re: [PATCH v2 07/10] ASoC: siu: convert tasklets to use new
 tasklet_setup() API
Message-ID: <20200902101011.GC6162@sirena.org.uk>
References: <20200902040221.354941-1-allen.lkml@gmail.com>
 <20200902040221.354941-8-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline
In-Reply-To: <20200902040221.354941-8-allen.lkml@gmail.com>
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


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 02, 2020 at 09:32:18AM +0530, Allen Pais wrote:
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.

Acked-by: Mark Brown <broonie@kernel.org>

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Pb4IACgkQJNaLcl1U
h9D3xQf7BJmcNAFxLbeiBBfMGhA6hFTkCfQS0K49jMZGZiiHhblYRS1iJG4OXPlh
3q6t260/m6hsIlskug7yPBUw7TG88hxtJOgEpOXDQ/PKnSGOY7vzXyFvrNhbCg9C
CsAD2qrRNLNR7e4h6Q3W8/a0IyIOITvGMlXzlN1qpzqupMplsX9bvEPt7gCqXl57
7Md9yOOb+MP05+2mGaa87Xh1XK+VTwc7gZq2IAWRcjWNTA8OdLDqm0qdkBGhqgcr
fkrLCZ0mlwJ+eCgWN0HrY7wXQ4M8WZUnIKdMJNpta2CaWxP9hyEeEuYsSGakfHdn
bFd7gywFl1YXQn5YDUZ7OLHjQ6HHuw==
=9ob/
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
