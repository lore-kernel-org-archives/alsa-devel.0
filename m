Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5024EB64D8
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 12:42:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D31CB823;
	Wed, 21 Jun 2023 14:41:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D31CB823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687351332;
	bh=aL6DckeQqhxeXJ+WuLJARgTRPPZzjDdJnT+MPZDCF6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sHcA/u/J2cD53Nir8Yvyys63/u950e3or0Md4Cxd2JIn0zzKDxsf7uEAGGsWiV53k
	 BEDkCmnYPRj2gbc9JhFz6IvnOfoU/HNnYTpnvd8eeU82Q9Xoute+oeqpmEIzwVqB+2
	 QJtmUV54MMGkHO4kZu4hV7pJazBTlvH8pTtvDkDg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D00B4F8051E; Wed, 21 Jun 2023 14:40:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 348F0F80141;
	Wed, 21 Jun 2023 14:40:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D112F80141; Wed, 21 Jun 2023 14:40:51 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7086CF80093
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 14:40:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7086CF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kvSp8kF4
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9AE2461566;
	Wed, 21 Jun 2023 12:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB2EC433C0;
	Wed, 21 Jun 2023 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687351246;
	bh=aL6DckeQqhxeXJ+WuLJARgTRPPZzjDdJnT+MPZDCF6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvSp8kF4jV/e6RTzxfZji64OtTTCCt0vkStIzeRrQ4/qQnO2udZ/TVV0hgChWJlaU
	 rG1+H2odtzNgod3RQLKWJW/qfw2eg06N1xua/xpnxuWVf6HYCcS7DykrSfkiULYF06
	 Gnkr6IrhBZsEsaALJCsY7OixTiwcNXqqtvN1ClZ4L1uTpOF1aZGOw0FDrf12WwM3uH
	 NWl+p9UufgICDY4bYXaAjCa/XzO6juTPQK5qc+gWww0szlKBFzDH6sFI52la2QB/0K
	 i4zH8QwbFH8PBuDWLHhPLC+XP0yDzoeg+CRBMzttBBJ+zHyQtlR6Q9KJ/GAnKwdvDj
	 XRuAVkfFdmBuA==
Date: Wed, 21 Jun 2023 13:40:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com
Subject: Re: [PATCH] ASoC: rt722-sdca: Remove redundant sdca mask
Message-ID: <7e84b2e3-16ad-41c9-a4c5-9938f4ae8289@sirena.org.uk>
References: <20230621080750.13511-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7MK6z76w+SNrmMZE"
Content-Disposition: inline
In-Reply-To: <20230621080750.13511-1-jack.yu@realtek.com>
X-Cookie: When among apes, one must play the ape.
Message-ID-Hash: ZYZBGYVNA7FU76WKVGBNIEYOMB4GDYHZ
X-Message-ID-Hash: ZYZBGYVNA7FU76WKVGBNIEYOMB4GDYHZ
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZYZBGYVNA7FU76WKVGBNIEYOMB4GDYHZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--7MK6z76w+SNrmMZE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2023 at 04:07:50PM +0800, Jack Yu wrote:

> Remove redundant sdca mask for clear code.

>  			sdw_write_no_pm(rt722->slave, SDW_SCP_SDCA_INTMASK1,
> -				SDW_SCP_SDCA_INTMASK_SDCA_0 | SDW_SCP_SDCA_INTMASK_SDCA_6);
> +				SDW_SCP_SDCA_INTMASK_SDCA_6);
>  			sdw_write_no_pm(rt722->slave, SDW_SCP_SDCA_INTMASK2,
>  				SDW_SCP_SDCA_INTMASK_SDCA_8);
>  		}

Why is this redundant?

--7MK6z76w+SNrmMZE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSS78gACgkQJNaLcl1U
h9Akkgf6Axf63KSNGKEdrqK6Ln1hcrC5M78IJYxVjwpehRk/6Uau31OyE5OKjpyG
2NU3KcbAOYOicJwihRAJ2YmdfwlleF4w59Z7wBjDfx64z1DlREAqIdZsQIsc1Tb1
tUOe3De/EQLslzZv9TnV3KtaIhwQGyHGEO8wnMgCQ8+yvasIzu3jvnaxkhMDe+o3
YxewwwRVWEmKY54NvWLtqp/d5eI+LtZBBo4Iy3/tndSA/hluIfz2ABkk63xl3IHV
dwS/g4QO2fI0aSx3fTDM51naTLDD0bRT082Ub5t8zT4XyyXnQlPy5wU3HyfIyEtp
S/KCgGqK5VGjW0Wjinv6lSY8GH3bgQ==
=fkqe
-----END PGP SIGNATURE-----

--7MK6z76w+SNrmMZE--
