Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA8BC2BD05
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jun 2024 11:33:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B3C9850;
	Mon, 24 Jun 2024 13:33:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B3C9850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719228812;
	bh=4v1R/s8DMj1NQlm6q1bpb9B/Uo71D4iZJ1zW2gFYYZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pY0ue84adJpg5UqkkFgjGvmUCKVx5K2XQ7MSz//pSuX0BWaj/DLatY3XHoyCXuh5X
	 u7/NQows3AaKvnvQ08FEmHfr9uDsmuU+4XwX5Xac+RJzM3dYgkez/A1WZom16FBNNp
	 115Zu41tebsp/3mCFWQBnqzd5g1qfs1CVhbGWjaA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82AB4F805BB; Mon, 24 Jun 2024 13:33:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 01F5CF805B6;
	Mon, 24 Jun 2024 13:33:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6C00F80495; Mon, 24 Jun 2024 13:32:54 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 99AC6F800E4
	for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2024 13:32:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99AC6F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QRsuipgq
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AFA2760BAD;
	Mon, 24 Jun 2024 11:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0161FC2BBFC;
	Mon, 24 Jun 2024 11:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719228767;
	bh=4v1R/s8DMj1NQlm6q1bpb9B/Uo71D4iZJ1zW2gFYYZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRsuipgqn6l/HVv0yidtp28NS2UoMne7aCp9EZ9jYA61eYRq9dct2v4fugJa16+vG
	 xju0HldVwsQknFR0tNqgmpH3SMY1CQTs1ZPP23nY4KCeGLnm8Zi21UlB/2bbLLPBRf
	 4leK8nw/5NE909RTM3NtL+jwC8+qqxNxjMFzauLyL1iOpMjwO4EYC1F1LDMzmkDH1a
	 JUG62l8YZjM+CP/AdenCmGTNlY/Y9qH4i0HsPXoPNjsrjGTWnUDDaMclT811jjxCND
	 QxqW90q8N0XImsLr8ZaqUpS+yUpmGidgdoFmuVefpBNuIuFMcOV2em1tEFfOKqZ8Pk
	 vzewmp2TgdCig==
Date: Mon, 24 Jun 2024 12:32:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Zhang Yi <zhangyi@everest-semi.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com, yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com
Subject: Re: [PATCH 2/4] ASoC: codecs: ES8326: codec can't enter suspend issue
Message-ID: <724f8849-905b-4c11-9dac-4d1a5357d76e@sirena.org.uk>
References: <20240624030607.4307-1-zhangyi@everest-semi.com>
 <20240624030607.4307-3-zhangyi@everest-semi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rKc5k2XtOh9o22p0"
Content-Disposition: inline
In-Reply-To: <20240624030607.4307-3-zhangyi@everest-semi.com>
X-Cookie: Allow 6 to 8 weeks for delivery.
Message-ID-Hash: LCD6PXV455KL66RVW6VR5IS5EIXAERUT
X-Message-ID-Hash: LCD6PXV455KL66RVW6VR5IS5EIXAERUT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LCD6PXV455KL66RVW6VR5IS5EIXAERUT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--rKc5k2XtOh9o22p0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 11:06:05AM +0800, Zhang Yi wrote:
> When widgets "MICBIAS1" and "MICBIAS2" are active, the codec cannot enter
> suspend mode. So we removed these two widgets.We replaced enable_micbias and
> disable_micbias with regmap_update_bits to make sure the codec can enter
> suspend mode.

Should mark the widgets with snd_soc_dapm_ignore_suspend() to allow the
device to suspend with the widgets enabled.

--rKc5k2XtOh9o22p0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ5WVoACgkQJNaLcl1U
h9DZ9gf/dWadgF/Ci7jwRki/uaF7O5arGuJKE9rxQ+P0Ev013AOf6jeDUAFnGd8v
XrbCFTat71LSxyV3SeoOOHWjBE8PP1p/GC6gcop46AbnYu4UsMEkTJsUtYI3jJPI
wzlncUdSIa+M4gafS6vVEkgJEieQTiqAyUHXpkIemb8EJApQlAfKZv0NNg6YovAL
LQqjMRtdXs1TZAxRBVk+xx5X8hFEhKvprUJw+kB5/3WC/qLawMuwWs8CcPyAxoPZ
Bm2XVCLSfVr3Oe75TlShzwwBY4y3pgkb/IkLlBK8ISspERsvStlwYc8dYahS+oYE
MZ7yqMDABPW+6I6AaxuAR/Qr3guoEA==
=uhLV
-----END PGP SIGNATURE-----

--rKc5k2XtOh9o22p0--
