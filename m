Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80426EE57F8
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Sep 2023 11:33:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56F5186F;
	Fri,  8 Sep 2023 13:32:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56F5186F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694172828;
	bh=+qSIAZksfKxDM/K85aG0fWiH6N2GKiCNwUA/WSqTZio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UPR93dTaxmKMhApUefOdZ9mxnQhV1FVKAJe+yq7Ju8qzz50fMDaY7Ehw6AGVYDLYY
	 loyg+vixybNCKmaxcQJoRXVCRneYxIFHmraI1RZniv8GHVsxndOn/lMhUODmhvs4wO
	 pZrPS6mepmQHOHqnpc54BWgvoLFe8hIeK3K5CYag=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8D4DF80558; Fri,  8 Sep 2023 13:32:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28B0AF80494;
	Fri,  8 Sep 2023 13:32:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA87AF80494; Fri,  8 Sep 2023 13:32:17 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EBA71F80431
	for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2023 13:32:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBA71F80431
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=P4zD/Cpd
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 02E57B82030;
	Fri,  8 Sep 2023 11:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB75C433C7;
	Fri,  8 Sep 2023 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694172727;
	bh=+qSIAZksfKxDM/K85aG0fWiH6N2GKiCNwUA/WSqTZio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4zD/CpdQFgwV7gECTT9oQX3RilGXHsKGHp4eSAphDPntlF+8y+AWJSrzNcexlCkS
	 2Tdq2k3dej7StV8+vAIWe9diWz3T4dY0zt+p9FqPT79SfWhOxZtJUFuAA3isA3C+yi
	 8Bn7XGF04uyAN55OPDuNpuX4G/ZI7bSgWo3UqYLexkV+GAS5PaySlDLFjmVfq+K1e1
	 eXtoKf0rkhyiF0hEunah6lqhqrlXK/xl+fqIfRBmVt+kucq0Dnq1TvRZuHgKvCajoa
	 R5ojpaJ/6X2uf0OVqBjI9t660JztcY+wRc4eRvjXKyBER8vtlfeWLA3Wrm27XlMHmQ
	 Bgv3aOGbkco8w==
Date: Fri, 8 Sep 2023 12:32:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc: perex@perex.cz, tiwai@suse.com, shuah@kernel.org,
	alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ALSA: remove unused variables
Message-ID: <c71fbf31-5c1f-47f0-9e71-a2e35cac2d3a@sirena.org.uk>
References: <20230908081040.197243-1-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Br3Il55jz3CmY9Rg"
Content-Disposition: inline
In-Reply-To: <20230908081040.197243-1-dingxiang@cmss.chinamobile.com>
X-Cookie: My EARS are GONE!!
Message-ID-Hash: C7RIPN3P27VZE2XSNKD4GWA7BVDQLXHZ
X-Message-ID-Hash: C7RIPN3P27VZE2XSNKD4GWA7BVDQLXHZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C7RIPN3P27VZE2XSNKD4GWA7BVDQLXHZ/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--Br3Il55jz3CmY9Rg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 08, 2023 at 04:10:40PM +0800, Ding Xiang wrote:
> These variables are never referenced in the code, just remove them.

Reviewed-by: Mark Brown <broonie@kernel.org>

--Br3Il55jz3CmY9Rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT7BjEACgkQJNaLcl1U
h9AmEwf6Agw2NIcZRz7UbcGNYFEgM1Sa6znuAsY7bjEVL3M4aCkORUTZPRDm26/0
KzxAld/MoA7pWfH5tj3/9My3yHgwrd3VRXmHpSCwRAh3AWeGDb3wne6/P82GsLCo
FxnpAvCHLL4YZ31eJ3oKAWNRWyMFsbOq1eZTsv6ijOifNhl9iKgrurLM2355V9ed
/K8t3+8afSesYyh9mMti3uZRsPhFZOlSoX0Zhcus1BhKAuwiax/6Wv2QBek1Vbbh
wl00Sky9Z7F3jW6zgnNqyRqSRhnu/YK2VDjYbmguHq1rc3BI/7O+I4kak8cS8MKo
PYTWhO7gdy1E8noxD/PxcLVIccnWTg==
=95/n
-----END PGP SIGNATURE-----

--Br3Il55jz3CmY9Rg--
