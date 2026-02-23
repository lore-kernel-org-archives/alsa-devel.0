Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877E9EA4FB3
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Feb 2026 12:19:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2427A6020E;
	Mon, 23 Feb 2026 13:19:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2427A6020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771849151;
	bh=Q51khbtprlIfIBq+1lgnkPbgwJZhy6bFpFBozlneKcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Iwy4CoDfQUXPDE7UNQFRbT4hifnEIeEFuQQoUSbD7Z+WMZmqdftSE5DGK2H0Uuga4
	 jBoNMgPRSMpq6Oqp0lrBDx9e0WFZ8o2Rmq+hobeaqD94Ayc1fcSbT83jYmcntF1LFn
	 dbk+GkbWEv1ERihpHalXxv2XYEhGO1cRcBOTQ8ac=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE2B8F80510; Mon, 23 Feb 2026 13:18:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DCC1F805E9;
	Mon, 23 Feb 2026 13:18:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A35FF8025A; Mon, 23 Feb 2026 13:16:13 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0B540F800D2
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2026 13:16:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B540F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bdwNm1BI
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D31E438F7;
	Mon, 23 Feb 2026 12:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74466C2BC87;
	Mon, 23 Feb 2026 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771848965;
	bh=Q51khbtprlIfIBq+1lgnkPbgwJZhy6bFpFBozlneKcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdwNm1BIIxKJYqafa+ODbIFIIlhHzFekiTOipCC3mOmnroCJAIkVY5S1gxx3m8siy
	 Ohc55q36tzwO6RcT//mLf/7R/1rW6+1NuKwtS2cTGtmR4w988E/xg93ug69JVMvLCn
	 2ns4gGC98ftE+TJD5hXNfqaPIrmHUOP1VvoHX6jKTNQdneB58kWiaqqr+Rw8KB4dxC
	 zjxrfnnKiktmfF+uLcNTpDUa1/7jFf/5JIEoTR/c0pjuyRz2ymH//YHclqAS3e+6BZ
	 aBs4dkwgee2DxnOSocF7/kJJEWOPFsI7VjMHGKY6bi/hX4xer6QjjSVKx9spohDQ78
	 5kENfwsuorOzw==
Date: Mon, 23 Feb 2026 12:16:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Honey Tydik <tgaraev653@gmail.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ASoC: Intel: sof_es8336: Add DMI quirk for Huawei
 BOD-WXX9
Message-ID: <46484386-8d44-41c9-ae9e-c76b856c5ef4@sirena.org.uk>
References: <20260201121728.16597-1-tgaraev653@gmail.com>
 <CALBQW2vDSzmzdF4vsn8SMvvwFcG4fp3_KG2oZOnJpcX0MspBEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ehSz5N+SP+6wrb/5"
Content-Disposition: inline
In-Reply-To: 
 <CALBQW2vDSzmzdF4vsn8SMvvwFcG4fp3_KG2oZOnJpcX0MspBEg@mail.gmail.com>
X-Cookie: My LESLIE GORE record is BROKEN ...
Message-ID-Hash: BT5STAWQ5OFPOYCS6UYXULFEOXQP6REF
X-Message-ID-Hash: BT5STAWQ5OFPOYCS6UYXULFEOXQP6REF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BT5STAWQ5OFPOYCS6UYXULFEOXQP6REF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--ehSz5N+SP+6wrb/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 11:40:45AM +0300, Honey Tydik wrote:
> Gentle ping on this RFC. I'm still investigating why GPIO control from
> DAPM event doesn't work on Huawei BOD-WXX9, while the same code works
> from probe context.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--ehSz5N+SP+6wrb/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmcRP8ACgkQJNaLcl1U
h9ANewf+NAhKhUfZhzRNPxqSjybfcaqUwF/gdPnQXxE/20pjG+ht7+DTrpPsLl9F
qPnbTkrTlco0mxfY9llycP10bWh+DQB4UwD8t6CcAECiSlXgGfGINcK1yFJP5HzL
p7HhPqcJ3iVxSouM7/E9lgaKpKPPykZZ7EvxzvdQd/KI+qS+R9Bmal3bA4BWx9o+
yJo34UNoCb047QWSVecQTR530j7KqY9olorZtRx2QGAu6dCeE6zCjDIeFYjqpFry
2vHwC29QhKYRQp42uZIGhuHr8ovs4KYyNGWzC6bsvIWsPg67DQdPNPbedqBL8ChR
A0EOYwTYjrTHYW8cWCD+aQjn8i0E9A==
=Xdtc
-----END PGP SIGNATURE-----

--ehSz5N+SP+6wrb/5--
