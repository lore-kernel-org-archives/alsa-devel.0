Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78162C77B7D
	for <alsa-devel@archiver.kernel.org>; Sun,  7 May 2023 23:39:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C87E811AB;
	Mon,  8 May 2023 01:38:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C87E811AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683502780;
	bh=hF4mlKMlmMVNKZO62c7NA6hnJlzvS6iWMHHTpIElN7Q=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aV5Xc+lJOEZN8/yS9V5jfAxgUhHLQUX5PylIQBZdco+oUC6Q+4U+NR7M4WyYelByL
	 azp/MCQoV/oZnu+TFzutQluZoEdS7/0mvKv+vwcHV4uu+/rpHeQ83hHgxiTFdA0MkC
	 qa0EOW0gwuwwugg4KTOrOpLjTpm79QRBmHo+RvK0=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 55173F804B1;
	Mon,  8 May 2023 01:38:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 726F0F804B1; Mon,  8 May 2023 01:38:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 08316F80310
	for <alsa-devel@alsa-project.org>; Mon,  8 May 2023 01:38:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08316F80310
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NQOWjd+s
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5D95861017;
	Sun,  7 May 2023 23:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A744C433EF;
	Sun,  7 May 2023 23:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683502697;
	bh=hF4mlKMlmMVNKZO62c7NA6hnJlzvS6iWMHHTpIElN7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQOWjd+syz5RhKdo7VbAJZBTQdfSyojBI+X86DPYncJQm4WVoji/SDAcydCEotyAI
	 fUaNCfGnzR+kzfcv7rxFPUHxOLIiF2VrPkzAh/A0TwjNeJzilbUKo8wRMrN+uJVQri
	 x31lVR2ZrxOtbqJii0X2lDKoCmWr5pF7j4fdvDxzAkK2GEPS2PLlv1cmot8IshI0wJ
	 EbJqfK2OuGWIhm1tYXwACsTfwsmNnb6CqHmfvLE6jekjOl49HynrKaXTh77GKDTOVn
	 Kn2YMc8KRkxccEwALPm6ugb60Sedy0eCiyyRnPo+oirqdwEQ3LuQoFzZYUihrPDsqZ
	 BZGG9SqIrKV9A==
Date: Mon, 8 May 2023 08:38:13 +0900
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 6.3 01/24] ASoC: jack: allow multiple interrupt
 per gpio
Message-ID: <ZFg2ZWqEBkPsJk+Y@finisterre.sirena.org.uk>
References: <20230507003022.4070535-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tbAMK+HB7r9NrqN0"
Content-Disposition: inline
In-Reply-To: <20230507003022.4070535-1-sashal@kernel.org>
X-Cookie: Avoid contact with eyes.
Message-ID-Hash: RGX6KLS4E4GOZOWY72HCLGMS6HUGYZZS
X-Message-ID-Hash: RGX6KLS4E4GOZOWY72HCLGMS6HUGYZZS
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>, lgirdwood@gmail.com, tiwai@suse.com,
 alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RGX6KLS4E4GOZOWY72HCLGMS6HUGYZZS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--tbAMK+HB7r9NrqN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 08:29:57PM -0400, Sasha Levin wrote:
> From: Svyatoslav Ryhel <clamor95@gmail.com>
>=20
> [ Upstream commit a2d4051b0bd6dffcd736888ae89a550d6f60b060 ]
>=20
> This feature is required for coupled hp-mic quirk used
> by some Nvidia Tegra 3 based devices work properly.

This is a new feature, why is it being backported to stable?

--tbAMK+HB7r9NrqN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRYNmQACgkQJNaLcl1U
h9D06wf/RQ36tbWP2zfR8KTbtG1xEapzGfQXR0iXraOH5jidrnt7NY8YygQqG/ps
ZAIr/BJRryQaar1+hT95dwMZ+aDPuHPF/+uXTxvzKvg68yaJf/K98zAIx2nIVksX
A2M0DcCRHf3uwNWEE8Cp/Ho0zfrn5SsKCkYQr1nB9/6Dj/MDHx6lkk4yCyVvcbVs
sSXY8LSzXWJYeir/xiEEcFvpUhywo9dFr9vSjYmvbNljOdt62pPBhuf/gg8v3X1t
i5mNXXjhZ2+awaaDlJBgQhbxD8kEnJ8hpSkhB2BIgiBXnE8+2BN0W6HTKcoNw3jl
XxBwmSkhhXgoadmCQxa5ZDlqsvmjRQ==
=QChS
-----END PGP SIGNATURE-----

--tbAMK+HB7r9NrqN0--
