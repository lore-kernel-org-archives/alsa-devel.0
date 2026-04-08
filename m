Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7D41073C93
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:50:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6D3F601F3;
	Wed,  8 Apr 2026 14:50:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6D3F601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775652648;
	bh=uIX++eqhousvTHkT2TBGpLw1tEa/G6cCzBdiqoAD6sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dQxDQbVnrcXht2ZQoGKaHwUdY9Dp0fdVjZA4ud45jpryqHL8s/e2PeFueAzLpihr0
	 Jrfp+/s/nYMJfB7wJF+7tA8rQEgYjHpVbR2dLJJbmmy6ol1f+V9U2/fKtJhg+RU/z+
	 NDZ5d6hqOTWdtbj31qFkh5bjDVfa9Y7JA1yz3B3Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2585DF805E1; Wed,  8 Apr 2026 14:50:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E7A9EF805F1;
	Wed,  8 Apr 2026 14:50:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59D3DF804CF; Wed,  8 Apr 2026 14:50:06 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1016F80154
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 14:50:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1016F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bdRLVJo4
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DA0B143281;
	Wed,  8 Apr 2026 12:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBCAC19421;
	Wed,  8 Apr 2026 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775652600;
	bh=uIX++eqhousvTHkT2TBGpLw1tEa/G6cCzBdiqoAD6sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdRLVJo4oCwcEf/TyLF+LhigjSqx8/YjQxFQl1uEcFj25y80/uYN3XRpVnXNi3eJg
	 snGxe0NI9nOL+XfaT2lhhmwFYsSUU0vNL7+/1niqs7/rZ35QbUGlAxEU3TG9W623j5
	 x7eNcYqo+kkB4d/A8AkZ31fH/1nOnG42haxNznLbJwi+Fos4KkJSyw1yBlr+8SrNlg
	 7kj/JV7zEVtrPfmfalXnb+qeedztEWx7rQ0gq+nedE5wDiQPxnIUFA4OLLq792w6AQ
	 OPjSac7IFzZDHGomJUWWWs7RbnuwI+PCUL4ajPuN2DIHivyC9s9DkFArKQna8GRSQT
	 7BA24Gi30gbDA==
Date: Wed, 8 Apr 2026 13:49:56 +0100
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com
Subject: Re: [PATCH v3 1/2] ASoC: rt1320-sdw: kcontrol for brown-out feature
 update
Message-ID: <d1a616bc-470a-4ff6-badc-018c64ee68ab@sirena.org.uk>
References: <20260408053716.3757937-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="df+57VIgfL2hRHYQ"
Content-Disposition: inline
In-Reply-To: <20260408053716.3757937-1-jack.yu@realtek.com>
X-Cookie: Often things ARE as bad as they seem!
Message-ID-Hash: C775DNRYTEDLJFYSHFRS7EE4SI772WU5
X-Message-ID-Hash: C775DNRYTEDLJFYSHFRS7EE4SI772WU5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C775DNRYTEDLJFYSHFRS7EE4SI772WU5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--df+57VIgfL2hRHYQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2026 at 01:37:15PM +0800, jack.yu@realtek.com wrote:

> +static int rt1320_brown_out_put(struct snd_kcontrol *kcontrol,
> +				 struct snd_ctl_elem_value *ucontrol)
> +	rt1320->brown_out = ucontrol->value.integer.value[0];
> +
> +	if (rt1320->brown_out == 0)
> +		regmap_write(rt1320->regmap, 0xdb03, 0x00);
> +	else
> +		regmap_write(rt1320->regmap, 0xdb03, 0xf0);
> +
> +
> +	return 0;

This doesn't return 1 when the value changes, so you'll be missing an
event.  mixer-test should tell you about this.

--df+57VIgfL2hRHYQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnWTvMACgkQJNaLcl1U
h9B3agf+Pska+DsCZEnSvT8gMsXjEiBH04MbopBttee7bHveB4l8SNfwY6FvSG/H
k+Sp3wSpxR215lQF3wrYmdp2ZB6HeiG7xLw85izx+J+p9TcIYFpGayQc4zr8CDIA
smQ18HkbLPD3idtvXibZaOAiWqjPYlo5gQ2ptYldyPx6PyshgCQX/dveMjdmHWGR
ZGXyBo04+kwBBB7f44VSdTSzzFouAFfJeJaj1qZgE8wgJ0VKcQ3YyM7kK4BV14pm
1NVBYhwY31/SEsx601kCDXQYQn02JJdBe2c/scwSV7mVMyiIZbWXAdonRCe738cx
WFYbYD3Nd+RrQBotn4eU4KoLu8fMMg==
=KqHN
-----END PGP SIGNATURE-----

--df+57VIgfL2hRHYQ--
