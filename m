Return-Path: <SRS0=sQP2=IP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFE7C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 21:00:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A08264EE7
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 21:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A08264EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E7EC16BC;
	Wed, 17 Mar 2021 21:59:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E7EC16BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616014830;
	bh=Qpko2zqQ22EMYpkbeGOEMykAHb+czU/7CJ6kcP9qaeM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tmd1yNME4oIb1LZUTt/+XTWI0cs8zvcUolKsh68d4J6y1s/+OsTwu1pufaidhPcgE
	 MOKvnYUa/8t1QjXEyYwqF0Uqap1FpZtAYmuMXSS4hkuLcd7AruFzkrU5q4/YKrX4nj
	 byvl8OSm9XKDRO3kR/QHtW157litI/cyYxu1mjmk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DAF48F8013F;
	Wed, 17 Mar 2021 21:59:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C600CF8021C; Wed, 17 Mar 2021 21:59:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E00AF80124
 for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2021 21:59:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E00AF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QhafIsIb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 272FC64EE7;
 Wed, 17 Mar 2021 20:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616014770;
 bh=Qpko2zqQ22EMYpkbeGOEMykAHb+czU/7CJ6kcP9qaeM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QhafIsIbTpo1OmXivCeyX++mRHtw7Otx8tyoW+eq9CrJmAIezwCccmeq0pXpeZ7XS
 Cc38vx6WvjoCv9JCLsePgrEVv4AJKIW/L7Pv3AgLG+UZal7bky8AOGTWAexPbMOh4s
 r64kmnoOzIdcVFEw6N8znvGK+5nQNMHxYoh32Zz7jnKAyD+AGEFxrysHP4EUawBhb2
 hKHX5ZEVA0UEFDl+AWUf/x/eWNZaASFLyb7X/4s48F29I97JoPJwNH25608YTOoqAU
 fZygjKzmSndON9Ls4+mcNP67cGo8i/oIGTuLTko4akiFZNU9J1+YfKzlDIZGPn6Lm9
 h4ZwrDUGl1GAQ==
Date: Wed, 17 Mar 2021 20:59:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v4 3/3] mfd: Add Rockchip rk817 audio CODEC support
Message-ID: <20210317205927.GG5559@sirena.org.uk>
References: <20210317202117.29926-1-macromorgan@hotmail.com>
 <SN6PR06MB5342682A0FDE5D84738EE760A56A9@SN6PR06MB5342.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <SN6PR06MB5342682A0FDE5D84738EE760A56A9@SN6PR06MB5342.namprd06.prod.outlook.com>
X-Cookie: Please ignore previous fortune.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com
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


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 17, 2021 at 03:21:17PM -0500, Chris Morgan wrote:

> +#ifdef CONFIG_SND_SOC_RK817
> +	{
> +		.name = "rk817-codec",
> +		.of_compatible = "rockchip,rk817-codec",
> +	},
> +#endif

The of_compatible should be redundant here.  I'm not sure if the config
guard is really useful?

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBSba4ACgkQJNaLcl1U
h9B2Fwf6AszWvO+M73oPaSaWYBxCpDVdJXnCT+iRim1p0K7KJOHhl/E2HTXmd7ai
D5AkjZvCb4tnxbToWBlWVOq605Cz1oNK5c/Z66H+EO9oJ0OxNG/KkIqCdvlr7PLM
em1JHPrg2tvgYoxS2H2WbJdAwTvFZbxz+nIL+nkghCono50W7K+1rSHzpvFAqBWe
NwFpgu8DgAvZWZDWQ41jQEeTIdYJAYRBcoQsSL6WI0up9I+2yp7XufNBYDzQ4kf5
iWN4rNCLe4XVQ/QUwswUTfs3/sBxD81mLN9ssmOAsfIYkMo6wGUN2D28UnHxurcL
1PE17/uqxxYQVcAs43gIcWtqMtSkLA==
=yMdI
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
