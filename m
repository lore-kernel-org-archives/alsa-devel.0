Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F60FF495E
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:44:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD658601F0;
	Mon, 30 Mar 2026 15:44:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD658601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774878289;
	bh=e/lfGg3pPoXB1XOHi7NUqmDi2GKRyGRTPgz9ddjcYHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OL11nSFJfKp+BO8s7NwpMn7LWBSUXUvmGM0/fiRDkj9zTfSMHvXAbxjx9WKs4mlLQ
	 ihB6ro8/S8KG8aeugeWsD7EjhiaTHUtX9etrO7KLoKcPjjDIJPJcYer9yW3SMbhJUx
	 Etgfz+v4rKMEjtBTzWvjYckEPzaCJMjzckylFEfk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54B6AF805ED; Mon, 30 Mar 2026 15:44:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 208F7F805E4;
	Mon, 30 Mar 2026 15:44:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8158CF8052D; Mon, 30 Mar 2026 15:44:06 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A7AEEF8027B
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 15:44:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7AEEF8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pjuyCHlu
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 97B1243B46;
	Mon, 30 Mar 2026 13:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C34C4CEF7;
	Mon, 30 Mar 2026 13:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774878241;
	bh=e/lfGg3pPoXB1XOHi7NUqmDi2GKRyGRTPgz9ddjcYHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjuyCHluZPe8wbzLraaUAD91gw8cavqkQwKE8UpZsG3ce+EFtn/4TM5lhhPlqs3n4
	 J4h60dNemcBI+hefSGPMRw0+L3Nnfx9lQyLvJfOiLtOzqA3ZxI/jFTNYS/ymbRcHmv
	 UQ9+yA3g9SwtmV+nQoxnkj3Xht4md50neXtfaaWEa+XAi00uCOQn3XVICeciPEr9f5
	 slJM1RJf9NsGM4uontjlCIJsrhFZGjtSe4iDIfs0SLgR5t5+6J+lCwUimsxW7DP9/o
	 QMMYEtqSblGY2WpltIXe/SdMlLvxekaqWQSJGt2qyFRLh1xWiOAWUjZ4BdANdzrZIM
	 1UgWKTjc4OBBQ==
Date: Mon, 30 Mar 2026 14:43:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	superm1@kernel.org, Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: amd: acp: update dmic_num logic for acp pdm
 dmic
Message-ID: <03a53820-a076-42ed-9ab2-3877396f99f9@sirena.org.uk>
References: <20260330072431.3512358-1-Vijendar.Mukunda@amd.com>
 <20260330072431.3512358-2-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dI3HTm/r/Y3gRSFj"
Content-Disposition: inline
In-Reply-To: <20260330072431.3512358-2-Vijendar.Mukunda@amd.com>
X-Cookie: HUGH BEAUMONT died in 1982!!
Message-ID-Hash: IYQIA2OR7LW6PV6Q3WI62BUDRHPMK7IM
X-Message-ID-Hash: IYQIA2OR7LW6PV6Q3WI62BUDRHPMK7IM
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IYQIA2OR7LW6PV6Q3WI62BUDRHPMK7IM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--dI3HTm/r/Y3gRSFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2026 at 12:50:27PM +0530, Vijendar Mukunda wrote:

> +++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
> @@ -535,11 +535,11 @@ static int mc_probe(struct platform_device *pdev)
>  					  " cfg-amp:%d", amp_num);
>  	if (!card->components)
>  		return -ENOMEM;
> -	if (mach->mach_params.dmic_num) {
> +	if (soc_sdw_quirk & ASOC_SDW_ACP_DMIC) {

soc_card_dai_links_create() (which could perhaps use better namespacing)
checks both dmic_num and the quirk.  This doesn't seem properly joined
up (and perhaps the code shouldn't be as spread out as it is)?

--dI3HTm/r/Y3gRSFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnKfhsACgkQJNaLcl1U
h9DXcQf/Req/nIvPby0oETVo+xflG1uDXBGro/Em5r7Rw1fbh2SHDKC8vSHW3aXf
QMTfSXUkKv57R5N3hqqE2deHwFcnePQq1VvcJAUV841z1GaQ1CfC0yegldOdnI4h
/jgH19Shd+sjf0/d5bpTlBJaA2KTlXtzNHr3jUFmiJDgKvyRRcjaYIzKf+EjxAnV
NSWHr8UJgQxeS0gZid17tUYceYWVDXz3EBLG//LKoN/f7UYa5t0OFnQESITrp6oH
f7FGFGnXcENX0xZJgIBED/k6csChtrVRmpqygrTFD6DW3ByDrsV/jLxhKi9vnwJA
s4U/2PqYUMEgshUtvJJ7Z13i3L+/Rw==
=12eD
-----END PGP SIGNATURE-----

--dI3HTm/r/Y3gRSFj--
