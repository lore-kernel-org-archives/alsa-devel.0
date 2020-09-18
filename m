Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F87C43464
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:20:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C042321D42
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rhKkoyCk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="myX2BtAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C042321D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D91D116B9;
	Fri, 18 Sep 2020 13:19:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D91D116B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600428019;
	bh=MsHAcHW7aH++paDGdWzrEb54PdjaLyqzMLktk5Kc1cU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rhKkoyCkRWsxX+Gz6qpfu9qG/ZIEvBl3dGVfooLzw2cw88EVy6MyB4wsOSS9Lmm2X
	 zL28T6jVi3aS/sVl6WqW/yi6cQ/01at15DOKKay44n/bkU/sxWBxKmChlXhd/+wIHC
	 X9vML8qAW7pahy+Li6ADNHMcHFpRKcOrZwVsFUJ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A92AF80150;
	Fri, 18 Sep 2020 13:19:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AEDC6F8015A; Fri, 18 Sep 2020 13:19:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3C2DF800E8
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 13:19:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3C2DF800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="myX2BtAE"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9BA3721D42;
 Fri, 18 Sep 2020 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600427954;
 bh=MsHAcHW7aH++paDGdWzrEb54PdjaLyqzMLktk5Kc1cU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=myX2BtAEzZUSkE8tvtPHDRXahOOD8k9Ubiolzed8AKc/hHGVuKVAsGjT/WNYJjgNZ
 9tT3n/BA9VOH3NnDLVwarGinaahFaCHdcG9fWKGuENAxsnyWwU+iwvQIfUjmIpzwp3
 LLQojBsHk5QMRst7AbU5sXHk3zNx7SPuJrsIV/IU=
Date: Fri, 18 Sep 2020 12:18:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Camel Guo <camel.guo@axis.com>
Subject: Re: [PATCH v4] ASoC: tlv320adcx140: Add support for configuring GPIO
 pin
Message-ID: <20200918111823.GE5703@sirena.org.uk>
References: <20200918073229.27348-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <20200918073229.27348-1-camel.guo@axis.com>
X-Cookie: Beware of geeks bearing graft.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Camel Guo <camelg@axis.com>, tiwai@suse.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, kernel@axis.com,
 dmurphy@ti.com
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


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 09:32:29AM +0200, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
>=20
> Add support to configure the GPIO pin to the specific configuration.
> The GPIO pin can be configured as GPO, IRQ, SDOUT2, PDMCLK, MICBASE_EN,
> GPI, MCLK, SDIN, PDMDIN1, PDMDIN2, PDMDIN3 or PDMDIN4 and the output
> drive can be configured with various configuration.

This needs a DT bindings update for the new property (I thought there
was one in prior versions)?

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9kl34ACgkQJNaLcl1U
h9Caawf9GXOYrnjVLp87TQZt8xe7Ma3EOFI2Tc7RfEd0fV9GhihVv06LXY61dCC9
vGoDaFvEJ5XJhiN0AXHz8qG7/LhTWP7oM/EWTP7c6SP3HPclcyBet8v4Dnisp1TJ
S41dZp6tDDTM8Cmm45Uk9M+9KBz61XDHnx+VlhPVrUZ/6ta+iUd2huMi2VH41chs
pwzjHmc4Pzle5Yu0SfydG4F0m8X+zsiWIEXiiuwDDP3K8Gj01oZLoVsSY1VUD0m3
DIzPdFyH+3PJrT+aKIfUcYDpVaWr2mx/48X2H6zIRtbgso+3fhocd8e9VAj2PdwN
JO5+gqFHeNjMWH7e5xYPs7y+YBgshw==
=CrlN
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
