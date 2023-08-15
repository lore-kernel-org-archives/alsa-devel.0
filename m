Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83908C001DB
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Aug 2023 12:55:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8728C827;
	Tue, 15 Aug 2023 14:54:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8728C827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692104148;
	bh=dDxA4P/ZLn0zQb28IKxF87UEdyaPxIaZJh97gjQPCRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V2ETamKjBJBePamL/jGpQAiEnTMq/YpfMDjmf3Z/sZ/EJnFS7x1vaR64Qv2b/G/rv
	 5yJNY3/pZvyhWHu1x8jYOMpo5/fO7EJgUiDwLogrgfL+zU0mrj/cO4ENCVQz62SYaS
	 YdvUK0+Wa1w14ptoTOswT/tWXBxnH0Ot25mOW5pE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 067B6F801EB; Tue, 15 Aug 2023 14:54:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A9D86F8016D;
	Tue, 15 Aug 2023 14:54:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C9DDF8016D; Tue, 15 Aug 2023 14:54:54 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BF11EF800EE
	for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2023 14:54:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF11EF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QWVFPbj8
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1432B61D3E;
	Tue, 15 Aug 2023 12:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3732C433C7;
	Tue, 15 Aug 2023 12:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692104085;
	bh=dDxA4P/ZLn0zQb28IKxF87UEdyaPxIaZJh97gjQPCRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWVFPbj8W++h4LpRMo1kgy+7LokGjP+dYNiWn9M/OiNenkud+wNPDjergae57ty2d
	 jnI/+/NGZmyNnAaf6VxdGgvOyY1CxIZC/kYOcEquOde7/RfPvrI1UupMj89qfoH/d7
	 04lNatHOWvkk1GjeW+pkT/LXeko9fVSXyTPN1ccmWLTS2fYVk/KJBkrKuCO9ZJMNB6
	 1qrbSaxSPV2AFjMKT+MMJgJ2WUQDdxUXsmsdOYF/G5lPa+v8y/yblTUEObJd1K7dbS
	 m0kUoci+TqG18GhSv6Qnj1UYK8gfBhI1A7+YGh9h2rVI6h4aWXgfUovPB2/IB2L8EJ
	 8NslK7xU1FXRA==
Date: Tue, 15 Aug 2023 13:54:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: fix -Wvoid-pointer-to-enum-cast warning
Message-ID: <94c059a6-07bf-4887-8c67-b8b0724baa49@sirena.org.uk>
References: 
 <20230814-void-sound-soc-codecs-rt5677-v1-1-5c468c60fa37@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EmsSKH7ZmGf/qlZE"
Content-Disposition: inline
In-Reply-To: 
 <20230814-void-sound-soc-codecs-rt5677-v1-1-5c468c60fa37@google.com>
X-Cookie: The meek don't want it.
Message-ID-Hash: 5U3XEXYJ2M4WCWEP34NO7ZAIMC2MSMJ5
X-Message-ID-Hash: 5U3XEXYJ2M4WCWEP34NO7ZAIMC2MSMJ5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5U3XEXYJ2M4WCWEP34NO7ZAIMC2MSMJ5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--EmsSKH7ZmGf/qlZE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2023 at 09:58:56PM +0000, Justin Stitt wrote:
> `match_id->data` is a void* and as such is being truncated when cast to
> `enum rt5677_type` which is only int-width.

This doesn't apply against current code, please check and resend.

--EmsSKH7ZmGf/qlZE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTbdY8ACgkQJNaLcl1U
h9AUKgf/Vhx88QCeNdlUEOFEPe17Q9i+vhTRysJ3Y1UFUFNv8cZ5HOebgWf5eYTO
lf5rHb+Y+tuT0+8HCQHVJtVGI3/gZwDzIVusQvcBRsLjBtEafkkGqfswhD8k8e9d
nQ8XT6a4kPc4/GYvS+YXeZoOSiq97cPdbbdODPuQB6UmaQreXLChHHan1ya6gfcH
bCr12qm48qfAJsK9EUUTcvPFyMpnrwC5CWIBoGrdi6eSzRHbOa+rGxdgFWorYPxE
ua34eCXIOxhBhbF15pCD5VyuRTbitN7/fhQo6HC2eszsMyv7u7wKTS3pBFl2roDc
b67QT9S3kboOvHRDaJYu+Ekcxo8WBQ==
=77Zb
-----END PGP SIGNATURE-----

--EmsSKH7ZmGf/qlZE--
