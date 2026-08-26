Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B810FC5DF97
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:20:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2492A6025B;
	Wed, 26 Aug 2026 17:20:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2492A6025B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787757643;
	bh=/EhSTVyMRvH1ZrsOqPUQS6lF97pGd760mnYd+lPjepk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qOeKMEzna4UbRcsDFWJCBVzKjVMOMeMxhjlfNYMV+xjUxs75LM4pVJL7DmMdmUXg1
	 HgL7fzIo0tkCbUErqWrp/9WPfYEPl2UNANpg1EbTH2/OJz9B16mdS2EGot2UiLVD9t
	 fPSBzrKkiHO3G3Tyo9GOVedbTOa1pcRsLhijguWk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C218F80601; Wed, 26 Aug 2026 17:20:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A587F805FE;
	Wed, 26 Aug 2026 17:20:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CB92F80525; Wed, 26 Aug 2026 17:19:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787757598;
	b=W88pbEFU14+fdhESuDnptGNGLz3IVvzEs9EppzaEGEzTK+/pWqmx4Be35j4cCNJ3QVV2
	 LNTWmyIKxxqcDSfIAFF9PMj0Q/IDaF9rJSiJ4aZFWZzlfMxdNx0Uacbup4/tJqIsB5oxc
	 42NF1jzUrh28c8B4zk0fvStTrXna+bTfxhxHvGjqqvsjWvD7WGTjEsfgu6rMsBGp09nTv
	 xMN7rHTmF4AkSpGItqiH7gf6aJ/T5GZCctBb1ZYmE/j+IJoHtiaHezdukyums5P2nE/BW
	 FWjoT3PWzmRq15S5EPaKtWq69yt1erOurdr1AVIHRAXIFJsiSn2FgYR56sCcGOxeDSQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787757598;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=/EhSTVyMRvH1ZrsOqPUQS6lF97pGd760mnYd+lPjepk=;
	b=ZWhgoBQevIfkaUk2B/78k7EoipsvP640FYxPXVEq350Y3t54kgDv5AceMRnkdazm/NFI
	 4FYwwmeOc5bN0LQQeqY3eDk/w2heUdFuWBkBnoPqxW4Vw6g+QJXcolIEBSHvS+u/fWn9A
	 A1C5EOYNVn5D+rsv7pvMTvAOEZOoBqsIlG4s5dUd42+xgqs2bfn0Ghzf69C8je6ecqR29
	 zEM3UHbbXtj9aIx51FzQrYU63AnF5oQt/rVt983AdTt3lO8zJ6pipGRv46ZXqyrZcEH4c
	 +JCj+Udb0woqsojH7HQ8mRDDXxTz2kOY/l4+ZDSmz6X9lRZp8FhJ7fPaIQ8ls9J/oVw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=baiGS0ec;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EB6ABF802DB
	for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2026 17:19:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB6ABF802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=baiGS0ec
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F9736020E;
	Wed, 26 Aug 2026 15:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6610A1F000E9;
	Wed, 26 Aug 2026 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757594;
	bh=/EhSTVyMRvH1ZrsOqPUQS6lF97pGd760mnYd+lPjepk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=baiGS0ec/NQRSuJUVRR7rANxNNCsCDdwxfmQPA48kfdREeX0JzQFy+Z5Pv2sXJzX7
	 OKCHJmyquRyluyR+QJZ+AW6mo3RUsRt6Cde1qJEB85A+jy4j9QA7xPQVraxnA8MMRb
	 ov1QOtL8CM7LS7fNI1sflnrb5b8PD06mbnKdc80VV7YpzjOaVFJ6oeBR+3vUN+j5hi
	 ozh0YJeCOFqdQadPCh+4YLzDXq5NO6HzCvMJa5xXQLZonAaPb5N+PhvqrThjEvL1fR
	 /xkLy0OmItlbF5gy3R6YCLZFdPqoIXbBSYl6jcD6wzjyfu6ny7VcG1s3sX4QHVCW+2
	 WAZRgyRI5TqrQ==
Date: Wed, 26 Aug 2026 16:19:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Sushanto <seditorofficial@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sun4i-codec: Fix OF node reference leaks for
 analog controls
Message-ID: <f85f13cf-15a4-406a-8348-ca18a9e3c3ab@sirena.org.uk>
References: <20260825141035.784-1-seditorofficial@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hiQ//mDqVcF3f7in"
Content-Disposition: inline
In-Reply-To: <20260825141035.784-1-seditorofficial@gmail.com>
X-Cookie: Obey all traffic laws.
Message-ID-Hash: AEFLMBJUBQU6CRYO6MZNNHI5FCC622KA
X-Message-ID-Hash: AEFLMBJUBQU6CRYO6MZNNHI5FCC622KA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AEFLMBJUBQU6CRYO6MZNNHI5FCC622KA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--hiQ//mDqVcF3f7in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2026 at 08:10:35PM +0600, Sushanto wrote:
> The device node obtained from of_parse_phandle() for
> "allwinner,codec-analog-controls" in sun8i_a23_codec_create_card(),
> sun8i_h3_codec_create_card(), and sun8i_v3s_codec_create_card()
> has its reference count incremented by of_parse_phandle().

This doesn't apply against current code, please check and resend.

--hiQ//mDqVcF3f7in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqPBBUACgkQJNaLcl1U
h9CZaAf+PNSZtr30Psfd1D71HSSAJAQqew/fXp6EhxqPNu/88MCkIeI/EPnvaQnB
Y0verE4QxaeReuDBqIF4GRjswmiVHYwxzKr6Xeo3ko+KASuiN8qf9uqzcDxYwv5o
TiYmunH7jLyZFfB8vzxlik1avzqRJpm86Rgqf1WAGjHPeyYbe89kl/JBE3a8BNE0
vY43az8n2RTferb/3Lu4GZ9iN3gXn5TYcSlPDHkm5x0NmrfBQGuZ6jGJnMP6pu2a
EuPvO/TP/7uvYP/2HSxBxZ3y+KD/uQMiE5yFlwLKrTNeZCkoupFbUeX+kYvX/0vM
SiXD48oPc7rskQVbSSumQiwa08T6dg==
=A6Rx
-----END PGP SIGNATURE-----

--hiQ//mDqVcF3f7in--
