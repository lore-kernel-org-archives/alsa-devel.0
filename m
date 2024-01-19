Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2CCC4725D
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jan 2024 13:57:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4EC8210;
	Fri, 19 Jan 2024 14:56:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4EC8210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705672618;
	bh=l0/za884R5eUTa07f55YxQqy7DfZrxLaUUD4sLnmbk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nRAQ1l/jolEJerOZtHQjIrZF21GDkkqwRBotiMkWLUarq4gTnK9cUQjPIi4gZlGjs
	 Iky3oJp4zAEJstYIm+kdFrWbM1M32lxR0t06tfp/ZuMoP/cQBufgMqociEupIFHbhL
	 DvireY/En4moJHHRuM5LkuWsSz0jDOKJyZ1ZvmdE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8DC2F8057B; Fri, 19 Jan 2024 14:56:20 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 592D1F80580;
	Fri, 19 Jan 2024 14:56:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03EB6F801F5; Fri, 19 Jan 2024 14:56:16 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 745EDF800C1
	for <alsa-devel@alsa-project.org>; Fri, 19 Jan 2024 14:56:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 745EDF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rfh+n78r
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 78C22617AE;
	Fri, 19 Jan 2024 13:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942BEC433C7;
	Fri, 19 Jan 2024 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705672566;
	bh=l0/za884R5eUTa07f55YxQqy7DfZrxLaUUD4sLnmbk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfh+n78r6QlJ5j2zP6yuOpdMGdBe4yl0B/T3wP/tHrBL0QyTTeI4rrGjkbZ+SKdmn
	 MLiHJRN9sxDw5rHKBukmySg0Pef7UMay2DYinmxno5gqPnT9/6FcrJTBZDJ6CBENDE
	 q3wrM0mPVopYxLSV9jKQ5/PEzRemlyI1c0HCZYED1jTwzlRhLpnG+proo/7zj3K/Ll
	 p+QV0nh8IYMAN3mj/bkjSqTOUnQWge+RrYDyb6OWPgS1cmx6UF4SsBWweS1/QwkGi3
	 +RAqGQq7zrYbGNrxbkPE18FbV0X6jVJMKjpSNWmVdMqB/LimuRjmzfa4mB7SEMIeoi
	 1javK/dz/OLsw==
Date: Fri, 19 Jan 2024 13:53:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Zhu Ning <zhuning0077@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com, yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com, zhangyi@everest-semi.com
Subject: Re: [PATCH 3/5] ASoC: codecs: ES8326: Adding new volume kcontrols
Message-ID: <Zap+zgGa7lUmYTNG@finisterre.sirena.org.uk>
References: <20240119112858.2982-1-zhuning0077@gmail.com>
 <20240119112858.2982-4-zhuning0077@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kwiel15OKD33+j0Y"
Content-Disposition: inline
In-Reply-To: <20240119112858.2982-4-zhuning0077@gmail.com>
X-Cookie: You might have mail.
Message-ID-Hash: YN6MQRXBWFABCO2JDTEQYRWX2ZUZVY6M
X-Message-ID-Hash: YN6MQRXBWFABCO2JDTEQYRWX2ZUZVY6M
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YN6MQRXBWFABCO2JDTEQYRWX2ZUZVY6M/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--Kwiel15OKD33+j0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 19, 2024 at 07:28:56PM +0800, Zhu Ning wrote:

> +static const char *const hpvol[] = {
> +	"0 dB",
> +	"-6 dB",
> +	"-24 dB",
> +	"+3.5 dB",
> +	"-3.5 dB",
> +	"-18 dB",
> +};
> +static const unsigned int hp_vol_values[] = { 0, 1, 2, 4, 5, 6 };

Volumes should be standard volume controls with TLV information rather
than enumerations.  I see that you can't just use a standard volume
control here since there's an invalid value that needs to be skipped
over, and it doesn't help that there's no ordering to the values either.
I think the best thing would probably be to open code a custom volume
control - this feels weird enough that it's probably not worrying about
trying for reuse.  Just have put and get functions that map 0..6 into
the register values for the volumes in ascending order, then you can
have a control that looks normal to userspace.

--Kwiel15OKD33+j0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWqfs0ACgkQJNaLcl1U
h9CQCwf/Ykq9S1mxVkoCUG2VxpBsGZWik42IkC5g9lNAadQIV5CHrVK2guNMtkJV
ugkMb6uH/mHNxznhDb8bGz5GDZD34h06WgRP0opgvkwDZvYUPXpGMCGsAqdT4VQu
jbUamSMK5SliqNe1mtubvNahctnjMAKrUadZFwt+PnM5zG13Gduw7NeOqxGHVvMw
TlqX7+LDRJabXJVTHRSrfKtAuAhL84CRj1GqEAviqH9CBtsRupxa/BQz8nUYLfT/
zQTrMhyqdm9OWO5bXK/r2bUAAxem0GIgLWTfyEQx0/3lp46KwZ7oeGIkDnDMn0Xv
+EX9eJu4amaOcwXHVS+T/pej58Gz3g==
=vdyc
-----END PGP SIGNATURE-----

--Kwiel15OKD33+j0Y--
