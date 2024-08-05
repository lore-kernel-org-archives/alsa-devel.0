Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3316FC3DA7F
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Aug 2024 14:35:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 931C559B5;
	Mon,  5 Aug 2024 16:35:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 931C559B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722868530;
	bh=7NPQrnLmKomB8dVE0yVfIXBwKOpLM0u7n9p/PPQ7BXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dzm2N1yBZM6lpOz9d9j2jSEJoEpKJgJzUw/mhTyj95I2MZxwKjHJZJeI6f9BPv0I+
	 1LHSh/wNxXpZXd2a+K5j3O06mEe0PljTQTlG44I826/quX/LGul1SmfYs+rBFGn2Fg
	 JJd4mAaZlECAzbgTVvA4CFsSwS/jb5bCM/dHe9Z8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DB880F8057A; Mon,  5 Aug 2024 16:35:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D70CF805BD;
	Mon,  5 Aug 2024 16:35:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F3CEF8057A; Mon,  5 Aug 2024 16:33:48 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 29AD1F800B0
	for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2024 16:33:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29AD1F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=FHJy2VPQ
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9EDD3CE0A7C;
	Mon,  5 Aug 2024 12:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28902C32782;
	Mon,  5 Aug 2024 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862090;
	bh=7NPQrnLmKomB8dVE0yVfIXBwKOpLM0u7n9p/PPQ7BXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FHJy2VPQiNZnE7ZeWks7hMPfUFbgWhdDrCwT712wOXVLDPOxPwg7dK7H6Q0FOyqM4
	 9EZ0LDI5bGUM5eBxR3iNJb1PuFaTA/riRtiSWcs6T+l+JN6MsZcI9TkkNWtnb3IWMS
	 xhieZki+WGLDsMHQrGxxWm9Ayt5+gjF92OpgDzrqGB7p+31I1Plnt4/v+KcTxdmm3F
	 SobaZUvO8v0ipGlW03d58vG9ErEKGpV6Q1KwK4EQ3+eBzBQleHH9oSUwfViusZdn5I
	 iBTxlHiSn4V44x5sRvVDDonFg6nt7Xb/VfXUxIl9UFNlQne1axtANnn0bXtHVjiWeW
	 xqbXN/1AoQkZA==
Date: Mon, 5 Aug 2024 13:48:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	zhourui@huaqin.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
	linux-kernel@vger.kernel.org, j-chadha@ti.com,
	liam.r.girdwood@intel.com, jaden-yue@ti.com,
	yung-chuan.liao@linux.intel.com, dipa@ti.com, yuhsuan@google.com,
	henry.lo@ti.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu,
	Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com,
	cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com,
	savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com,
	jesse-ji@ti.com, darren.ye@mediatek.com, antheas.dk@gmail.com,
	Jerry2.Huang@lcfuturecenter.com
Subject: Re: [PATCH v1] ASoc: tas2781: Rename dai_driver name to unify the
 name between TAS2563 and TAS2781
Message-ID: <bbaa05e8-4f4b-4ea4-ab57-3b5fb77ed8c8@sirena.org.uk>
References: <20240803032717.175-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DDYajqUCQj3cvoaz"
Content-Disposition: inline
In-Reply-To: <20240803032717.175-1-shenghao-ding@ti.com>
X-Cookie: Goodbye, cool world.
Message-ID-Hash: WJEGKLS4JL2ODPCPHO5DVPRSAMOBA4ID
X-Message-ID-Hash: WJEGKLS4JL2ODPCPHO5DVPRSAMOBA4ID
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WJEGKLS4JL2ODPCPHO5DVPRSAMOBA4ID/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--DDYajqUCQj3cvoaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 03, 2024 at 11:27:14AM +0800, Shenghao Ding wrote:

> Rename dai_driver name to unify the name between TAS2563 and
> TAS2781, remove unnecessary line feed, strscpy replace scnprintf.

As people have previously said and is covered in submitting-patches.rst
you should be submitting one patch per change, not combining multiple
patches into a single change.  Each of the tree things you describe in
the changelog here should be a separate patch.

--DDYajqUCQj3cvoaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmawygAACgkQJNaLcl1U
h9APbAf/R3qFOYmRDX5yo5NRFAuvqgKawnlgMNTLrqlkyYgySSIFtNol6VWDWBoR
xhDwbWnOH/IOysx7cOMAvr5FRqkzfIANLs6jld081UvoyAsSuXuPXip+5yQ5G+7C
99zQQt/8j+S1OdDowgk2aCcvynbcBwEzRMHrPjDxtuwUE/a833MeskZoiO0GIdWK
+Eh2rl8xHsVVdvxGJyB5cJbd1lG5567onIhJyaqpFEGlR0/Js7yjWIwk02TG/Z2v
YVRjX+iMUlq2Mu9eLEK8InBXTEaZwrarCnoTkkVg/ZsmWX34UmyK/BCEP5F85vj8
kw6AqgdCfcRypBY+tv11PHGzRcnDFw==
=EMF3
-----END PGP SIGNATURE-----

--DDYajqUCQj3cvoaz--
