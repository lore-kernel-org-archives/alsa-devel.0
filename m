Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A156C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:00:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA66206DA
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qtaWva7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA66206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5622E1660;
	Fri, 20 Dec 2019 13:59:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5622E1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576846806;
	bh=6vrETVMnZipWTECs0l3Y1WlkpImN3lE0A39gYoy8Vd4=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qtaWva7xAth00EOKjmx2EuiSn4eCXm7YgR1koh/6iR02qwDAkLV4FmRENKYu0nLa4
	 yYpnWK2QWpI4yNY+wYQNtZzcBIbWTORfQ95hIarvDiEjdEdqLJXjBrR4vZ6pIrJSq4
	 b0GCwG3kumliV42wgaZTnI90XLC5GI8VCeLwzyS0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1297F8014C;
	Fri, 20 Dec 2019 13:59:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99118F8014F; Fri, 20 Dec 2019 13:59:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2D136F80059
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 13:59:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D136F80059
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B29330E;
 Fri, 20 Dec 2019 04:59:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC6383F719;
 Fri, 20 Dec 2019 04:59:08 -0800 (PST)
Date: Fri, 20 Dec 2019 12:59:07 +0000
From: Mark Brown <broonie@kernel.org>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Message-ID: <20191220125907.GD4790@sirena.org.uk>
References: <20191219210944.18256-1-angus@akkea.ca>
 <20191219210944.18256-2-angus@akkea.ca>
MIME-Version: 1.0
In-Reply-To: <20191219210944.18256-2-angus@akkea.ca>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, kernel@puri.sm,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 1/2] ASoC: gtm601: add Broadmobi bm818
	sound profile
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
Content-Type: multipart/mixed; boundary="===============7466168436731151251=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============7466168436731151251==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2019 at 01:09:43PM -0800, Angus Ainslie (Purism) wrote:

> @@ -37,7 +37,7 @@ static struct snd_soc_dai_driver gtm601_dai = {
>  		.channels_max = 1,
>  		.rates = SNDRV_PCM_RATE_8000,
>  		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> -		},
> +	},
>  	.capture = {

This is an unrelated indentation change.

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl38xZoACgkQJNaLcl1U
h9C4ZAf8CQJRsBBKW1r/HN9qrSPlWJ/8y2yShT5u/Q46IsjSr2ENsv3ljkkC9BIv
ioX2h5Y/ikx7RJy5rVYwrp2anG97WNnfXu8I9OfIlvjBfDKoxg99HwmJQWL7niqh
VS/rxHQyEPIyvaDaDT6wKF+gYZpvlCQaYLi6DRhYQxZzhLo72tWrDvvr8604bOn4
aJqd0Enqf716cNuRGkYQLNkQd4565oA50kxybbJoRaiYedLR+lnvcAPQvGfpV9CL
g/owmDglgQj3oDOSgw4F4iSRNVohxf0CncQMoCGmWPLpuzw5Z0n1OU+Idfwqv08j
E/Na+edk3JFuBsoEQ+zqRmhqyaDACw==
=ximh
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--

--===============7466168436731151251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7466168436731151251==--
