Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18646C433E2
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:28:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980CB205CB
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VYa8QWxv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtX+/tcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980CB205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A4B215F2;
	Wed, 15 Jul 2020 16:27:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A4B215F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594823281;
	bh=2qpN2cOs0v8OgbKiTCEOLREVstlLLC76OJcC/cCHwQw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VYa8QWxvt8kczIs91USS4gEoxiEDD8ZXG4VCoo/bNhFgPiyETGKMtHbcVHFupEHss
	 ArJQ98+0peEzNgpcZj7Bw2MXHsiDX0unJzukzLdyophqLYeJLfQqbU+cv6aeQIE+WM
	 5tR266sIHE0+ubRrNSbtvaH9bIZ1IRhcqKKTJ3qw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A48CDF8014E;
	Wed, 15 Jul 2020 16:27:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B53E5F8021D; Wed, 15 Jul 2020 16:27:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6CBFF80113
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 16:27:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6CBFF80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DtX+/tcc"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5078B205CB;
 Wed, 15 Jul 2020 14:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594823220;
 bh=2qpN2cOs0v8OgbKiTCEOLREVstlLLC76OJcC/cCHwQw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DtX+/tccMlVeMNKiozjp+uC/QzIQ1f5ReA3ZExvuVyNGw7we44RduABqcmoZCDDTW
 Yzotqw74bb233t4PKstgZM/1zygsYv/Qh2xv2TfbzbNK1RRDl96p13D4q6Shjmt1T7
 POLd33Hw9krqvH6eIAcns0jJpXABgnfIgVr5iNJ0=
Date: Wed, 15 Jul 2020 15:26:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix misspelling
 of 'exists'
Message-ID: <20200715142651.GA44014@sirena.org.uk>
References: <20200715094447.3170843-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20200715094447.3170843-1-lee.jones@linaro.org>
X-Cookie: Minimum charge for booths.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
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


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2020 at 10:44:47AM +0100, Lee Jones wrote:

>  /*
> - * This dapm route map exits for DPCM link only.
> + * This dapm route map exists for DPCM link only.
>   * The other routes shall go through Device Tree.

This doesn't apply against current code, please check and resend.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8PEioACgkQJNaLcl1U
h9DvQAf/f/u76ASoswKuqEP0xg72QuhZGUj08nlVQnAV1civDdfyjXZEc45CEfoX
SBrMdVIMfvk8oxGZIsgRkhW+QimcJLr5rsyO7RylN6YZsXysfG0GqDbuH9WvgGSJ
yTggaet7yI6gAlbjos476ee+yrzNSssnBzOpxuk5pXCYxDkEf0lgclfQY21oOG/t
8F1tzjQjJ8kXcfYfnBofJFJPqi5EA2DbogxL0bH+7/ndzpuo4BNVb4463SuG7CXy
upIOZq7CFRlVOY4Izb27YyFAeq3SnigakVEBJrkFeKsOECP6gTBHSbZGrydD2NrO
2K6J+fPzeGcdXutqMeP+n2ke/vXxLw==
=viwB
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
