Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D0BC2BBD1
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:45:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C96206CA
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K7hh5EBn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1drDQVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C96206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA65E168F;
	Thu, 17 Sep 2020 21:44:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA65E168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600371935;
	bh=LYsXBy9sReRqQb5R0+Xnz3acCFNHtMFk7zRgh1xaaw8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K7hh5EBnnwdUWHVUKyK/7p7fkSTfScs4blE8cwDS5MXb79kRrqh1ysyZQjCy1t8Px
	 oeXuUV9n6p0bdVkqbmumNKafI25V9HPUwXN/s9N8FjpMKP4Wb5Nap6v3bEOY7WC29X
	 un9Q489EtbT/wEStjt0ta99funQFDTaxX1yYsj4w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FB61F800E8;
	Thu, 17 Sep 2020 21:44:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3EBB4F80212; Thu, 17 Sep 2020 21:44:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9842F800E8
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 21:44:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9842F800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="V1drDQVx"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D90F522208;
 Thu, 17 Sep 2020 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600371876;
 bh=LYsXBy9sReRqQb5R0+Xnz3acCFNHtMFk7zRgh1xaaw8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V1drDQVx2rMepCPz0mJg6bq5sI2mBY6sNvGn9Z/f5cAblLwriZfbQeVzMUtCpxy8J
 Y1CPxMehWt5H/+h7QvR9AFBYeHVen7dPxx+WY+wTPMxh4tacR5U4Bw49bh4a51KlKb
 HdOT/BcVQLKiR0Th4LI3BTTlKtnudxuk365OrUq4=
Date: Thu, 17 Sep 2020 20:43:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: correct interrupt flags in examples
Message-ID: <20200917194346.GI4755@sirena.org.uk>
References: <20200917185531.5767-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline
In-Reply-To: <20200917185531.5767-1-krzk@kernel.org>
X-Cookie: If you fail to plan, plan to fail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org
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


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2020 at 08:55:31PM +0200, Krzysztof Kozlowski wrote:

> Changes since v1:
> 1. Add acks

Please don't resend things just for acks, it gets noisy.

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jvHEACgkQJNaLcl1U
h9BRMQf/XzQJgoI2JZ8w3TYpefwva8RNnWE4vFscAEspB7e8/KO/uj733ap3E4c1
4T33seEQS7l+VHjEALZInN+LZub6H/YCak5iJ1gTQQalejVy5W64AXafh7sg58pp
J/0xo7RSTjJ/YcHMPNQtVVMUyOzT58RLddpKSZBe9N0CkAxb96kzC6odgp/rwrh5
lp5O+G286wR6j4Rm0hWLz7/Al5IhA20xOY2Hn5hbMdfjhkKe1hBejKqCSwTJbhI/
kRHdyQapGDJ19AeJeBArysPAf2swCvXUhzFYNgild0RJGmz47dY/RayKeyZoiK4g
I0/pjJ4h8n+iknjMwFHw0+pS8Lao2A==
=QHk9
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--
