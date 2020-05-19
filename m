Return-Path: <SRS0=hLTZ=7B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B89C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 10:55:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D538920758
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 10:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Uzz1b5QG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIXyByFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D538920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16ED916FF;
	Tue, 19 May 2020 12:54:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16ED916FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589885700;
	bh=qBze0eKQDsl7WiwiqnNxBhLPEVnlSLmSXmQrKtbswH0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uzz1b5QGn62NAiQ+psfqttdY1WaHSxP4XdVB8n4+IWG4fXjjsfmU6QmkC2rMibQl0
	 WUlbpLSzCWKx9dU6gHMfOwdJfd52/vw+o52qOGlPL10P+QpjGF0zdetSPBvP1zFDFQ
	 7eeUDDUI3ePvXWS4xjJsWoaWVgZQ9aFhkiDoXyRI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 781CDF80161;
	Tue, 19 May 2020 12:54:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC438F801A3; Tue, 19 May 2020 12:54:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3754BF800C9
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2020 12:54:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3754BF800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZIXyByFV"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7D39F206D4;
 Tue, 19 May 2020 10:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589885642;
 bh=qBze0eKQDsl7WiwiqnNxBhLPEVnlSLmSXmQrKtbswH0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZIXyByFVIICNZnZruvMQlj0UBiC5xiRrzPkxMc64SKd+Qww7DsI0meewtMefvyzGf
 BEbKwkNas0aBJxkflAhd99IUFlZZxxNA7RdaLmTOBxzQ4NIqCE5tFdx37Hwm/ihQbF
 iKOhvHaKrBem03evoGEy09nxnqQ9rp7PSLFhfNxY=
Date: Tue, 19 May 2020 11:53:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH v3 04/14] ASoC: amd: create acp3x pdm platform device
Message-ID: <20200519105359.GB4611@sirena.org.uk>
References: <20200518171704.24999-1-Vijendar.Mukunda@amd.com>
 <20200518171704.24999-5-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20200518171704.24999-5-Vijendar.Mukunda@amd.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, alsa-devel@alsa-project.org
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


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2020 at 01:16:54AM +0800, Vijendar Mukunda wrote:

> +	adata->res = devm_kzalloc(&pci->dev,
> +				  sizeof(struct resource) * 2,
> +				  GFP_KERNEL);
> +	if (!adata->res) {
> +		ret = -ENOMEM;
> +		goto de_init;
> +	}
> +
> +	adata->res[0].name = "acp_pdm_iomem";
> +	adata->res[0].flags = IORESOURCE_MEM;
> +	adata->res[0].start = addr;
> +	adata->res[0].end = addr + (ACP_REG_END - ACP_REG_START);
> +	adata->res[1].name = "acp_pdm_irq";
> +	adata->res[1].flags = IORESOURCE_IRQ;
> +	adata->res[1].start = pci->irq;
> +	adata->res[1].end = pci->irq;

Creating the subdevice is good and sensible but this is basically open
coding what the MFD framework does.  The subdevices should probably be
created with that instead.

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7DusYACgkQJNaLcl1U
h9AXMgf/TfmULYSv5JAQ77UrCEigA4YYFOf5BH67Xp9FPt88aV9Q/6m4jnaMqeOm
CLALkk5pAXeMjNgY7bXMxULhoctt/TdbOZZ2DHgqRl0RoFAYvYFs6Bg3fW8814yK
DvQuJAl9/bNvq7h2ICPFAI1M6ZzwRG69dWpidDfyoYykzVrvG4ZbcgQJrTRujJOA
+ZPIbrYBTT9AUS6mfGVnSD4Fb+S3M4ffU3Rk3uFgZR/zl2Gw87nJi5Jv5FKtKvbp
sLo8qdrGEKi+tDvLEKKIcyeYRlYvsqOGGMahp735BE5MuLx/Y219XrSjiDAdOkkp
PBPSJ9CVCcvLTcolotZSzm8Q7+OaWA==
=/lPZ
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
