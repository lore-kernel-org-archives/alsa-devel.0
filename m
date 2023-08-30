Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884E0C83F01
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Aug 2023 21:01:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F97E208;
	Wed, 30 Aug 2023 23:00:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F97E208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693429296;
	bh=oZMG6qL+Cu510IHDOLGg0aYCjrQvUEyoDQ865p6UfDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QxmlTcgbC65UJq2rd00nNhNT9wCiNE43Bk0E30ku6n5dvf8pwjvbUHgkSj40hPQIo
	 EFDidTg4NvzLBzjTl8TF1XkQK6nMdDtvXCM+yqC8YJXvqemE2PEQtb5EFQx/lBAgCA
	 U7RNEt5YZyu+PzT7usBOX6XTteWtAVOl2WwGDBv4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 251C8F80155; Wed, 30 Aug 2023 23:00:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A9AE9F80155;
	Wed, 30 Aug 2023 23:00:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AED25F80155; Wed, 30 Aug 2023 23:00:09 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 80714F800D1
	for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2023 23:00:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80714F800D1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OB4uqQ96
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D775061E9B;
	Wed, 30 Aug 2023 20:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89589C433C9;
	Wed, 30 Aug 2023 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693429198;
	bh=oZMG6qL+Cu510IHDOLGg0aYCjrQvUEyoDQ865p6UfDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OB4uqQ962pARB6pbatc4FmftlW6tKKcmCeBxCx6Eq1S4NhQOhXxEcsEN8JIiNjeOF
	 7pkba2CcWngAGDN8v9sorAjxwbmroDYlgeKSu8c+yg0BKHc4kdx7bK8bsEJQe6uSd2
	 LLKqTQya6xEYJUtRIM4iagEb0+KGvavUM7aYTLnFSMTD9++E3LYc9u1lH8tVqDKEiV
	 5jooumYpngLMAYBd/I+tixLEqrjnpUza/V264FcShy13PyEhVqKhhSba6+DyEhWmLt
	 IsXoDLS4r/bP4d+ev3W6YRdW76fxwJJK1eoqN54ucGt1at+BQPSW54TnQxnDXRwI0B
	 08F1buRuVzu5g==
Date: Wed, 30 Aug 2023 21:59:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/4] ASoC: cs35l45: Checks index of cs35l45_irqs[]
Message-ID: <737c4114-5b54-444c-8a6a-de4e98566513@sirena.org.uk>
References: <20230830195536.448884-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AUDHTcx1/kKY0ynM"
Content-Disposition: inline
In-Reply-To: <20230830195536.448884-1-vkarpovi@opensource.cirrus.com>
X-Cookie: Immanuel doesn't pun, he Kant.
Message-ID-Hash: IXHRON7VZNZDKG4QGNCEJFD4NBHTUR7O
X-Message-ID-Hash: IXHRON7VZNZDKG4QGNCEJFD4NBHTUR7O
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IXHRON7VZNZDKG4QGNCEJFD4NBHTUR7O/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--AUDHTcx1/kKY0ynM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 02:55:33PM -0500, Vlad Karpovich wrote:
> Checks the index computed by the virq offset before printing the
> error condition in cs35l45_spk_safe_err() handler.
>=20
> Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>

Who actually wrote this patch?

--AUDHTcx1/kKY0ynM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTvrccACgkQJNaLcl1U
h9Bcpgf+NYLkQOJ3teKC3UN/Bwy5w9yMYjIu3JvSBXR1ejzGVt3epy7Dbb09yaU0
eASqB/UndJgt2v2lasHruMx/WXZlwFRkjhGwFb9KlkUclsn1cSlwo7fEim/ZDorq
p71rxw7E5Eg25KnSshbR3JHnsyr7IiQ3fzp+Fl/Lkl2Nf5JCM0X+iAfCmhUhjF0n
sf60aQvyfST6HJrhxh6+opioyPvwDSJtKcYicJpYNjsbphj1Sew2zN9meoR8SBBv
IuZGEXSRkuUGB5phFR7T/crx2SXZoNAAWoe+0vEl8bNaeCIZo3PXUcydNgJeJmWk
jcT+DHEnQhtac3PYlhxuQ39wI3g5qw==
=mocu
-----END PGP SIGNATURE-----

--AUDHTcx1/kKY0ynM--
