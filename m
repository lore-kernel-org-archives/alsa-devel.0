Return-Path: <SRS0=Jhnj=L7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B81C07E95
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 16:23:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3745160238
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 16:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3745160238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 636C5827;
	Wed,  7 Jul 2021 18:22:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 636C5827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625675015;
	bh=U29NvKLbcyYlcwK2WiH8Qg9N0ElTvijubsFCX8RsD9k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rlCItFM0PpyJQBoEFONUkoTOKYuI6M9mbxjYFzst31RI+5v1ityuzsZMNFYuR8fOC
	 gWrkMUVJSTTbACijdQdHEosFkfVtiuMKhbf1YcgiU9mVZcUAsTWSmI2YSFxCuPV3Vx
	 kf5YkLuz0Z/EtdiygY5J/wBmtWOqbedT5vE5k+Uc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2C1DF8016C;
	Wed,  7 Jul 2021 18:22:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19B4FF80224; Wed,  7 Jul 2021 18:22:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF2EDF8014E
 for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2021 18:22:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF2EDF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uYN+Gk7V"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61C0061CC3;
 Wed,  7 Jul 2021 16:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625674958;
 bh=U29NvKLbcyYlcwK2WiH8Qg9N0ElTvijubsFCX8RsD9k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uYN+Gk7VQwPPove29S/489tRyCRhspLDGXO4/Ccs0UVHj6wBCyqy/tmhHNI2YBa3H
 lJDJ/oUOuDxRzplHWfaAcQb6ocN0GRPo71cmSer1Zm9O6ZRP7kPwfY7hzcI/NOZHAr
 lCI82roMiHqzTRpEVmDJFKyUYMfuXfgC/rMoocj3cV5NoIOMHJ30N/RYYpq7z3LsBA
 mPsBJS7vXT37b3LI8Fbtm34+GZSUDK1sXDEgR8PWgfyB8DbXtx2O6QIZZ0psX0D1X2
 9TiDwI5CYyEEEZnrAO6ELHSgbrj05kBOBw4eeR5QU4SjozlZM003I7cbmHxJ68OCwY
 FLXmM0KBlH7UQ==
Date: Wed, 7 Jul 2021 17:22:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 04/12] ASoC: amd: create acp5x platform devices
Message-ID: <20210707162206.GF4394@sirena.org.uk>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-5-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline
In-Reply-To: <20210707055623.27371-5-vijendar.mukunda@amd.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com
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


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2021 at 11:26:15AM +0530, Vijendar Mukunda wrote:

> +#define I2S_MODE 0x00
> +#define ACP5x_I2S_MODE 0x00

All the other constants are namespaced so why the plain I2S_MODE?

> +	val = acp_readl(adata->acp5x_base + ACP_PIN_CONFIG);
> +	switch (val) {
> +	case I2S_MODE:

...

> +		break;
> +	default:
> +		dev_info(&pci->dev, "ACP audio mode : %d\n", val);
> +	}

Given that anything other than I2S is basically unhandled should we
perhaps print an error rather than just an info message?

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDl1K4ACgkQJNaLcl1U
h9DWMwf+MVbmxxNWKlGb8aozFC2M2Dp6VTwCCLIhTlRCW6L6EFSLxLLsBUyJ0LKN
H+AujbMfenRvP8qX3Vw+CoKzoJBF3mEWty7IOgeIXn/b/52JbMb+JMoz5bO76WNh
bv78UzpEzlKoCd3tssHeEvmD0hhiytjLu3yku90M+H4EtToNr11dtj1aJJI9ZF+e
j4TtxE79SaR9/s5Z7MJ6Y+3cJTCPWckqn6QyrjA5oanKFuvqjaQDIg1Su9/7xpMo
qE3cQsMKhV84R3qMU0yZ+hLOGW8mJmtWSTSDq26UH2zha5HqnzX2Bk+mKIX86Jdu
FgbUlzggVIj2T8TMxclwAx8wpE0KSA==
=nmcF
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
