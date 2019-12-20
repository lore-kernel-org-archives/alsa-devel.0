Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBABC43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:02:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B7F206DA
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N+U2i3X2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B7F206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC2CE166A;
	Fri, 20 Dec 2019 14:01:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC2CE166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576846961;
	bh=9Su86UYtqq8EdLOejCTJ8m9FnqGFnsRNwqWePPHcYAM=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N+U2i3X2V3B+TWN/Id8AOmmY6tIxjb9vqWgQbiPhxSmHay4XLxpHRnMPmKWdRu9Ht
	 SK/lcKNqsrTNkYL8RD+pD9D0mxiP7QusXVMC74DI4FwNlQozyXVax9d1AJfZ3o8+XU
	 yd+A2KE/fWtJ0EVJeVKWPqlngveabUoW4ciWpeu0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59EF2F800B5;
	Fri, 20 Dec 2019 14:01:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B474F80257; Fri, 20 Dec 2019 14:01:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 543EEF800B5
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 14:01:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 543EEF800B5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8912130E;
 Fri, 20 Dec 2019 05:01:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068FD3F719;
 Fri, 20 Dec 2019 05:01:44 -0800 (PST)
Date: Fri, 20 Dec 2019 13:01:43 +0000
From: Mark Brown <broonie@kernel.org>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Message-ID: <20191220130143.GF4790@sirena.org.uk>
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
Content-Type: multipart/mixed; boundary="===============8161133912987475810=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8161133912987475810==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 01:09:43PM -0800, Angus Ainslie (Purism) wrote:

>  static int gtm601_platform_probe(struct platform_device *pdev)
>  {
> +	struct snd_soc_dai_driver *dai_driver;
> +
> +	dai_driver =3D of_device_get_match_data(&pdev->dev);
> +

I was going to apply this but it causes build warnings:

sound/soc/codecs/gtm601.c: In function =E2=80=98gtm601_platform_probe=E2=80=
=99:
sound/soc/codecs/gtm601.c:83:13: warning: assignment discards =E2=80=98cons=
t=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
  dai_driver =3D of_device_get_match_data(&pdev->dev);
             ^

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl38xjYACgkQJNaLcl1U
h9Df9gf/RXeLC/iEcTjvaaWh2UqB0phzyy+OHv9wXcopbWJ0trlsSZ9OfjI4keLj
/SQlaeT4FyfDcNOaRH2npIrvNnjrnN5WAIQps3EZHDIaFzaPXeQt3bgOmrLQIVIt
sQCsJEiC7U6ZKf4R6KBux/PX7rfO2q0Wd5RSuCEoFHBOECd0L3imZhCTaLhw34I0
b3woQI/+BCbnNXMQiwmiXqYWT6Ak4LpCfIRevMPbvVli2lp98fc9M+ldCGjnrQ5K
AU2h1gS326XiacrjDGiqO5II8eD3cQWm7RPF+c4Nqm+dj8PgwHhcMnYluwKPNIcn
FOGmQ5BDpr2lt82gvh2NFTcNAUBlxQ==
=gbI3
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--

--===============8161133912987475810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8161133912987475810==--
