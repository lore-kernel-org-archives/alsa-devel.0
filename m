Return-Path: <SRS0=k5Qg=4P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CE2C11D3D
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:17:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D0624688
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jfo2aNwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D0624688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67842169B;
	Thu, 27 Feb 2020 16:16:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67842169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582816663;
	bh=5O4hf1BrKm48izkdW6Iogp2FlShcWcKB/R1PR+9baw8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jfo2aNwkLFbZhY9jJNW7yDGpg7BbaTO8KIEe/vJ8ROVJt+516X+F6YSXEFzRNbgav
	 r5SYICvXmrTLF4RP4gxB4XuvhOB0AVdR++ebM3G6Ur433cPirsASSAEyFYB6xWkNQP
	 tkFprAR+pEF91DARk2N/3qtG80lrRNJLBgrhuBjU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7208F8013E;
	Thu, 27 Feb 2020 16:16:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A889AF80142; Thu, 27 Feb 2020 16:15:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 09CF2F80089
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2020 16:15:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09CF2F80089
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 746D830E;
 Thu, 27 Feb 2020 07:15:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEDA43F7B4;
 Thu, 27 Feb 2020 07:15:18 -0800 (PST)
Date: Thu, 27 Feb 2020 15:15:17 +0000
From: Mark Brown <broonie@kernel.org>
To: tangbin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] zte:zx-spdif:remove redundant dev_err message
Message-ID: <20200227151517.GC4062@sirena.org.uk>
References: <20200227150701.15652-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <20200227150701.15652-1-tangbin@cmss.chinamobile.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, jun.nie@linaro.org, shawnguo@kernel.org,
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


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 11:07:01PM +0800, tangbin wrote:
> devm_ioremap_resource has already contains error message, so remove
> the redundant dev_err message

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5X3QQACgkQJNaLcl1U
h9ClgQgAhVigaSedyPLajRpUX2vIOrqhnhTyoVj19iSU3QJ1uooXc/UR/CSyoPqA
cAz7Zl8hPiUmn4OaNu6331KZE6ihk5m19Qmw0KUoSvR5GqbJ5gIRwoEYeVeeBiZf
uB2oaosHLC0Y+f9rRdZIyj0jIBRC+aHcJX0l4Pjw1QMfilofa+LGhYa2/WUGexHp
0WrgNwrjSgAWDm5MN3xeR4GVd2u8cIKnmomA3u13VJDfAlIgNJCm+u9IKcteYc8W
m3BywhwFNs76Kbh9uqxWV6jhHdFok3McPs42ZgO7Sj7MOTZm8Usp6aqhCjesVVwX
hb5zdSpVV2CkMeQ9lz6oiDDjHjs2Fg==
=RASF
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
