Return-Path: <SRS0=NlLR=GK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327B5C433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 14:29:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A1E23118
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 14:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A1E23118
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D862D167F;
	Thu,  7 Jan 2021 15:28:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D862D167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610029782;
	bh=wq0bmkT0v1XJd/qFGy+kwVjV7IzBlnb2YgG9BaaPlAY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R7ixPISScrhuTy2itHaGABvrU8DYhvNmIC5nlzvAUM1BdsXpihjy9ZmDMZi1+HyeO
	 afVM58lKNkUXizS24R+mr9PYu0tTGkgATi8R4ERPZfw+Voxp3XqgHt4/F26rGjR3RN
	 krYz2tHAZlVxsP3v6TFbpfWMV/yjNn1axmGLU8rI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04133F800FD;
	Thu,  7 Jan 2021 15:28:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4597DF80258; Thu,  7 Jan 2021 15:28:34 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84903F800E9
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2021 15:28:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84903F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Rx27ouWQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45D3822EBF;
 Thu,  7 Jan 2021 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610029695;
 bh=wq0bmkT0v1XJd/qFGy+kwVjV7IzBlnb2YgG9BaaPlAY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rx27ouWQ6IOJLohgRuNphzufjwGjIZTKJdUtwm5WUXxfzOtwRWhIhg3DwfS/sxA/N
 2E7nOeEnaEupq/NmPzzorvpPmAGTXdZ5H0DL7XOGYrn4C+ygRrTkyD6daNGIYaCmjC
 +oW1fPsk31YHSy3CY0SXYce7qZxXilkgQUlFhTjacmsSL48lL29CWW6cOGld2Qg7Zf
 BiLYY1zGRuRH6pXwnsPLAhpe3eOkWZ7iSkEPr+lnOwENl6oXPs/yxdjzxvoD3PKXSJ
 iwq2xYGROQ8ujnneTRz/nDp+mmGnqQRzqJebZwmxsIspZ9rd7VosVzTxjfZwTTUvmb
 u/Fv6nTTnmvbw==
Date: Thu, 7 Jan 2021 14:27:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Chris Chiu <chiu@endlessos.org>
Subject: Re: [PATCH 1/4] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
Message-ID: <20210107142746.GC4726@sirena.org.uk>
References: <20210107090625.107078-1-chiu@endlessos.org>
 <20210107090625.107078-2-chiu@endlessos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <20210107090625.107078-2-chiu@endlessos.org>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, linux@endlessos.org, tiwai@suse.com
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


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 07, 2021 at 05:06:22PM +0800, Chris Chiu wrote:

> +static const struct acpi_gpio_mapping *cht_rt5645_gpios;
> +

You're adding a read only static variable with no way to set it.  This
doesn't actually do anything?

> @@ -3780,7 +3782,6 @@ static const struct dmi_system_id dmi_platform_data=
[] =3D {
>  		},
>  		.driver_data =3D (void *)&intel_braswell_platform_data,
>  	},
> -	{ }
>  };
> =20

This is an unrelated change which removes the terminator on the array
which will cause issues.

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/3GmEACgkQJNaLcl1U
h9CLFAf/evzCs5u2gB5dTDWM0EbQ+WNYz3+RPiTWt8YOnZcdvn7CNyuOxA4daHhN
qNtKWt3HL5iVv6N0QVm+KIApX1j/VAN1Wa+LKoSpJHh/+XlL2v2h9Gkcx/JqM2zi
JYUj35rMJnL+TotjeOw+dtDRsWueo3IUN86o2QJX5SLBFwUXMdSFkW9VEsLu+2l7
quPzgEelg/tSwEegKNlPPApb9uedQpKNy2w5gngtpSUQH8IGGxxISSAQF1Cdgt8h
mCVLS53h93BEajHCGRlv6GPuBKTkgRnvyzbYEHgmJEpGihxxQPHzvyzjj+OlAXB5
sSHjR+6+BfSP0CY+bG71x+PSPHwD9w==
=w+Ra
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
