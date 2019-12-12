Return-Path: <SRS0=r47B=2C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4A2C43603
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:49:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479C522527
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nfhDS6yD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479C522527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C1DF16F5;
	Thu, 12 Dec 2019 17:48:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C1DF16F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576169348;
	bh=sZb6IM9j/7VCu3igqkZPn38KDIobyWyPmUul2sKghL8=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nfhDS6yD5qnj2rstX4aqH1OKcrtV7Y9b+YKtSoFzqk7PiwnD7jPwPHPUcP3briFjz
	 cfuWsXTBSEUFlud2zhLlU9d9J01Rte/e7AWL7smjfElnCauNfgEuBlON1kQC3hibJs
	 OddZ66fys0rX06ENyDaJHd5SYFYA7UOpvItkH7Ak=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5D96F801D8;
	Thu, 12 Dec 2019 17:48:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1627FF80139; Thu, 12 Dec 2019 17:48:16 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 9ACA3F80139
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 17:48:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9ACA3F80139
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6378930E;
 Thu, 12 Dec 2019 08:48:11 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6B6C3F6CF;
 Thu, 12 Dec 2019 08:48:10 -0800 (PST)
Date: Thu, 12 Dec 2019 16:48:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20191212164809.GH4310@sirena.org.uk>
References: <CGME20191128152110epcas3p2b205b4b55f6d8bfac42fcb8faaade93c@epcas3p2.samsung.com>
 <20191128151908.180871-1-tzungbi@google.com>
 <8aceb9ec-aa6e-1fa4-cee9-e22084c141e8@samsung.com>
 <129540e9-a4e8-3d01-41bc-e7c9c04bbefe@samsung.com>
MIME-Version: 1.0
In-Reply-To: <129540e9-a4e8-3d01-41bc-e7c9c04bbefe@samsung.com>
X-Cookie: We have DIFFERENT amounts of HAIR --
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org,
 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, cychiang@google.com,
 Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, dgreid@google.com
Subject: Re: [alsa-devel] [PATCH v2] ASoC: max98090: save and restore SHDN
 when changing sensitive registers
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
Content-Type: multipart/mixed; boundary="===============4738326992772696617=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4738326992772696617==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 05:02:50PM +0100, Marek Szyprowski wrote:
> On 12.12.2019 15:09, Marek Szyprowski wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> >> +static void max98090_shdn_save(struct max98090_priv *max98090)
> >> +{
> >> + mutex_lock(&max98090->component->card->dapm_mutex);

> The NULL pointer dereference demonstrated above is caused by=20
> max98090->component->card being NULL here. Adding a simple !=3D NULL chec=
k=20
> here and in the max98090_shdn_restore() function fixes the boot issue,=20
> although the deplock warning is still there. The question is that is the=
=20
> max98090->component->card being NULL is a normal case or something that=
=20
> needs further analysis.

It'd be good to get a bit more analysis, the _shdn_save() call looks to
have come from a userspace write and we shouldn't be exposing the card
and hence the controls on the card to userspace until it's fully
instantiated.

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3yb0gACgkQJNaLcl1U
h9C/Wgf/Y7I6BrvNaFrXEHzt/taVhn/ZZlQSgnHib0N9rpkW7Zf1L//y4/7mCnDu
qJGJ5JruhXB4XgVIlHKcLVOLf56SLMRIMyFg/hg92q0osUO1B3otOdzHRoWLXlms
VAJK9oarfeMgC3YZ3Z0DGKTUlpco0nl9QCs34Rv0E0Aff78l82UBpbDjjnntXGI+
ljNTxjoMrfsiyY4qORmoj8kOrEqamZPawYLLOxmyd9NKCbAldAOXj0cBJ82y8/ua
unOYRfbXfswv5Ah6w3xrjUo/2Zqbc9s1PgQl4J2pYxyROaIUA4LNdq3a1UUjRth2
BBzbbMKZt6G+oBpRzW9dAuknlEIwqA==
=5wJQ
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--

--===============4738326992772696617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4738326992772696617==--
