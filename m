Return-Path: <SRS0=hLTZ=7B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F3AC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 10:55:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB85D20709
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 10:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mznyfRSC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL4LDR+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB85D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 059BA170E;
	Tue, 19 May 2020 12:55:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 059BA170E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589885753;
	bh=JwpEaQSiLQuQv5RIYqDPeia3Omt50DGSeUCzmDisDeg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mznyfRSCKpfmTKt63x49OwdwBegYLzN2DSbUoizPeGEbcM/yjtyTRaKh2fkSX9ujg
	 zUaJ43JAMPR6duPIFCyOkvb40Hlg5ftmgPIu6uy5+vGbAnNh70569AdTPTkLbx3CQP
	 KFZrUSnhfPwXDEc3bLjZYmPdxtuXvPPcGhVQV6zw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFF76F80110;
	Tue, 19 May 2020 12:54:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24A15F80256; Tue, 19 May 2020 12:54:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C759DF801A3
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2020 12:54:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C759DF801A3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uL4LDR+J"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B6EDD206D4;
 Tue, 19 May 2020 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589885677;
 bh=JwpEaQSiLQuQv5RIYqDPeia3Omt50DGSeUCzmDisDeg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uL4LDR+JG648mnqpWkLQCwPi8yq/aZJlo2BBZuj6WisDSLMUlabdfWEe2An0ZniGB
 Cq3jt3jt/K5LWWIdmQjYhgWe7qvcKZXndPJTMHnYOcu3oqQa3uRd/imnXTXJ327KTf
 g0VEfQpYXtqjSd8B0A5x7px78ion2jcxANPrbKn4=
Date: Tue, 19 May 2020 11:54:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH v3 05/14] ASoC: amd: add ACP3x PDM platform driver
Message-ID: <20200519105434.GC4611@sirena.org.uk>
References: <20200518171704.24999-1-Vijendar.Mukunda@amd.com>
 <20200518171704.24999-6-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <20200518171704.24999-6-Vijendar.Mukunda@amd.com>
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


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2020 at 01:16:55AM +0800, Vijendar Mukunda wrote:

> +static int acp_pdm_audio_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

This is empty so can be removed.

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7DuukACgkQJNaLcl1U
h9CYkwf8C9eHs8yr7jhGj53tKJK52Lj10qkyyyfgtrY3p6zHf2v8cBZD511s9v2K
eZERPaUWBrbdC4toT6WHEayTFNcVeVlKjPkHIHi6aPaw34uwOUf8bFRpKSNYxflP
4nX2SRx87F1XCXsoUpp5zSlCLJxGQ6qFA0/LORGlUnTQNvPpEAJufkdG0AICbazO
yIXp18Eeb4JQR83xw9Bk3Rwc16Rpw/PmoQd/Unk5JYLVdA3UccOmIh0idQPkphhr
KTNet2+6B2qRzPS000ahCsU5QNQIfEABr26x67iZf+jMcuOVWfnU2VxJpcZ4wYZF
FJyyNaXRwwnBzmzKn9Qi0bjGG71seA==
=o+rg
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
