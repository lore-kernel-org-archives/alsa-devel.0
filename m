Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F4C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:55:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83455207BC
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZoiYRJXh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+fivWev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83455207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02FAD17A1;
	Wed, 26 Aug 2020 20:54:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02FAD17A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598468104;
	bh=ebwKmGdOeprx83MyYGND4GRTRQNsNOFyBpZtZgqs8Ao=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZoiYRJXh/ELuQkDWZCi5x1sCMtoynC9a0ImiqVV5ayjMTjGQe8XPKHw+tdxrOogdH
	 EhmL3yaop0Ze+l+R5634UK3xLioTIZ2Ilg+wXbqBOpsH/6hm5dgnDCc8rwk4SUcXNj
	 vsVPBitulXjl5y8s0yAxPxdVOQnjx9yJk163uDl0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74642F801EC;
	Wed, 26 Aug 2020 20:54:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BA7CF801F2; Wed, 26 Aug 2020 20:54:12 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3D41F80105
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 20:54:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3D41F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="i+fivWev"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68FDA207BC;
 Wed, 26 Aug 2020 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598468044;
 bh=ebwKmGdOeprx83MyYGND4GRTRQNsNOFyBpZtZgqs8Ao=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i+fivWevpE6qI2mGFxVpJafBnuZ/slTzfAFWOdQKtHUr/6ZUUkMVX06ZKTMteu6dt
 0+prpbTseOZt2HYXQ0RZN/tccmGACVzYmzdgOWvd5mJFNLWfCJ6vcJ8GyHHWth7Cjy
 1EtbxnjeIdjs2CDqa9sCQjJDPchTyyvQ8oOSIDcQ=
Date: Wed, 26 Aug 2020 19:53:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: sound: Remove unused 'linux,hdmi-audio'
Message-ID: <20200826185328.GS4965@sirena.org.uk>
References: <20200826184851.3431531-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BuGwuXnZwGGQ9GEc"
Content-Disposition: inline
In-Reply-To: <20200826184851.3431531-1-robh@kernel.org>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
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


--BuGwuXnZwGGQ9GEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 12:48:49PM -0600, Rob Herring wrote:
> The binding was added in 2013 and has had no driver since 2015.

There is the hdmi-codec driver that covers such hardware and would be
compatible with the binding.  Of course there are no current users so...

--BuGwuXnZwGGQ9GEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Gr6cACgkQJNaLcl1U
h9Afowf/f/hzqNG+gezOm3/ICeb8uOkUWWmnaFDqY8sTo9Wx3WnTo73L+Yt0L4jj
MGJY2mPDjnpsL0CvNm+tLxCECxBJ/tXf7uXnDTj6xcGEMsFPZ9MXpyUwXsuoYXCT
rkm7PZv8Lnl1RkgCxY/ZOgGc9Kx3vKPb9ty1svN46ZQyWTxaZIw4n5Nbic6F5M+W
G/e/7SLtCNaKFt+hPIsijGW1R4aATIuk4YUDwt/oOUWrp8oAYnb1mRxoUsDR5sbx
RQYAR4ta8Ax7GdU849N+IShcGqpC9AwjBB7J84IRM6R0ZBB7xhyTgYqjfeXfkGIA
xDNkUiqUwl7VpZB2JhXOSA+D0Pqf8Q==
=nMG4
-----END PGP SIGNATURE-----

--BuGwuXnZwGGQ9GEc--
