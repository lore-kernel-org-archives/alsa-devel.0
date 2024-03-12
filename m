Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8107C54E58
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:07:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D025F50;
	Tue, 12 Mar 2024 18:06:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D025F50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710263219;
	bh=Uf8cg6osnMFBO1t7rBso5/vOFhBOjgmGncJZngxzjd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Kyei9o6csrSLuEMqZ1UeZHa8qoBL95ySna1cAGMydAzZEjpeGS39jkFPc0LPxymsR
	 UINumiRprU4Dwp2YZ4Ny2PtBMaL5Gf4R7mmpJE6/w4IRqjnUBf3zrhrKHw/0yxsWo0
	 2YMUCJVRSSJOfsoqwElVLqfor393aJnw011rTBw4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7839DF8057C; Tue, 12 Mar 2024 18:06:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E776F805A8;
	Tue, 12 Mar 2024 18:06:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E849F8028D; Tue, 12 Mar 2024 18:06:18 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4443EF80093
	for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2024 18:06:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4443EF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CWlQBO2E
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 65A1361221;
	Tue, 12 Mar 2024 17:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81B7C433C7;
	Tue, 12 Mar 2024 17:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710263172;
	bh=Uf8cg6osnMFBO1t7rBso5/vOFhBOjgmGncJZngxzjd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWlQBO2E9oi3J8WUGd90L9LO2vDZLFT+81t05eP656l7cBjK3l6oWS9y5NKtS1R7X
	 U6wMfU1LQOVNb9i7DeYX6419qcMQvciG6vlfHXLuXqZRkVM7ig4HffyFj5v32KYiyt
	 wG6krudxbbtJ0WCKYPGCMzA9aLV/ZIOYRUoGtoU+MnDU0Cl5LZvm0hrwbUsf5URGXq
	 1DSj5XKVHBouzyRGExUR3KFxl+ebHxWwVeTOXFyYUDAg9uyR/iJ76c8d5GNX7NeWm+
	 SaZE6RIp2VkOBzVQcfGo1Sjng0/fBMpMNwXeSYGf+lINPhAIW2CuCFb/p9v27D9jNq
	 VgJ6NzjxAebig==
Date: Tue, 12 Mar 2024 17:06:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>, bard.liao@intel.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/5] ASoC: makes CPU/Codec channel connection map more
 generic
Message-ID: <b9de4fd1-ef4a-4c30-b3cf-e36931be90f1@sirena.org.uk>
References: <87v8a64f3d.wl-kuninori.morimoto.gx@renesas.com>
 <87ttpq4f2c.wl-kuninori.morimoto.gx@renesas.com>
 <e7121fbc-c814-4153-9f17-82ad5de13e64@sirena.org.uk>
 <87a5n46xjk.wl-kuninori.morimoto.gx@renesas.com>
 <7248b107-db87-4409-b93c-f65035d0a6b4@sirena.org.uk>
 <1jo7bje6da.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qzyKJgoXE2W54kV4"
Content-Disposition: inline
In-Reply-To: <1jo7bje6da.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Neutrinos have bad breadth.
Message-ID-Hash: SJXHR3QYVAUAUGFULYQT57LR4BLTLQXK
X-Message-ID-Hash: SJXHR3QYVAUAUGFULYQT57LR4BLTLQXK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SJXHR3QYVAUAUGFULYQT57LR4BLTLQXK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--qzyKJgoXE2W54kV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2024 at 05:29:25PM +0100, Jerome Brunet wrote:

> Mark, I suspect the boards you have (like the libretech Alta/Solitude or
> the kvim3 maybe) will show the same thing.

I don't have the kvim3 but I can try with the other two (modulo pain
with u-boot), it'll be tomorrow now though.

> I can't really test right now, sorry.
> I can check and test further later this week.

Ack - so long as someone looks into it.

--qzyKJgoXE2W54kV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXwi34ACgkQJNaLcl1U
h9B7/Qf8Dc4u7Q+xnQLjQXA481ZwsFRElrEC9u+wbJQEdPez1XIjaGTq7sLnf1HR
mEEJprcCx0y4lwZI6kfgLAy8P8eOSJycRM6EASGbevwvANWDsKpkxrGPwVKVdHCI
NgJcX9ULB+RliBq8x+syp0tWLhqo6OzqJ55xNHJTothmmfZgFH0oRdcBNE6kiqbH
vMB7NhBlzq76bsorOHdKZDlCjOzPgYBElMWxEGPyRMBdTzgPVKzkSefrFmKZlxIR
16Z1XZKpKTCIasuRhCSmyubAYXk9/Tg26kyfK2IVxFUgVYUNnm6pTeHp2wX/BgDO
jkgP/TkCFXRJT+deLdtTysoWkQC4yw==
=Y0PH
-----END PGP SIGNATURE-----

--qzyKJgoXE2W54kV4--
