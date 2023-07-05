Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BF7EB64DA
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Jul 2023 11:46:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7823B83A;
	Wed,  5 Jul 2023 13:45:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7823B83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688557567;
	bh=oxz0YWhPo3gaIFgIg1uSn7lqMi7NCf0v9R1HokIZoUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MqRReZbPMa7DiruIQbRqN8emTw/gKv4inpnLHO5ccbVJURZFJ3BX+Oasy9ZfDBdiu
	 TxHfrtvBF72i8V/DMyrFHz/VhKNe/Xx/2jtewk3XDMr8avrwKNGnl+mdDlQQx6s1Qs
	 UTYJNaIejWQQ+mvMCTrPvgXjpEkqTgu/LDYD3BSE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2DFEF80125; Wed,  5 Jul 2023 13:44:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A5B1F80125;
	Wed,  5 Jul 2023 13:44:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11159F80125; Wed,  5 Jul 2023 13:44:50 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C9B0AF80104
	for <alsa-devel@alsa-project.org>; Wed,  5 Jul 2023 13:44:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9B0AF80104
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AVuRY8xR
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2D96361515;
	Wed,  5 Jul 2023 11:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA23C433C7;
	Wed,  5 Jul 2023 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688557483;
	bh=oxz0YWhPo3gaIFgIg1uSn7lqMi7NCf0v9R1HokIZoUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVuRY8xRMBn7/74c2xTqTzJKe+EZ57fcmpaARwgWRKVcjdH1I2phHbYkcWaNrLcXT
	 GUJRq9pNVLqSbcJ7FBNskVTW65kM7W0BDdGdJJncnV1uFdls1UD2rY7ydG+OfoSd3y
	 tKb0lF92brE/UxWcgvz3Rxh3/em0v0MAXVvc0Oggt8+awce5fXekrCjFRlcVd1O9sf
	 MCGYdaxe0gI8StY0WuLJSK+qsWxGFcZG+LKhI7Q/9eZu/FL/Op0ZkVv1j3tAHSvxRD
	 pFagnQLzWz6rxD9LOpbOiG7Fq0SBvQVT6Tgic/JSkjTelIPMk6yJISm4q1BkoA1n02
	 3JGGSaL621iBg==
Date: Wed, 5 Jul 2023 12:44:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Suti <peter.suti@streamunlimited.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	alsa-devel@alsa-project.org,
	Radek =?iso-8859-1?Q?Dost=E1l?= <radek.dostal@streamunlimited.com>,
	Martin Pietryka <martin.pietryka@streamunlimited.com>
Subject: Re: snd_soc_dai_ops.startup called for all codecs
Message-ID: <6ceccfa7-aab3-4964-9c70-eb231972fd33@sirena.org.uk>
References: 
 <CACMGZgY9SLGJ3d+66DxXwddwh2LTw3BXeEWUBGN=7fyrO0QkeQ@mail.gmail.com>
 <ae06b00a-f3f7-f9d1-0b58-4d71f3394416@linux.intel.com>
 <CACMGZgYcjGghOkvcyEvCYsK+Y+xUOF5S6CNoedV1P3k7MSzcrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LOy+G/Q4UT1kEEaC"
Content-Disposition: inline
In-Reply-To: 
 <CACMGZgYcjGghOkvcyEvCYsK+Y+xUOF5S6CNoedV1P3k7MSzcrw@mail.gmail.com>
X-Cookie: Don't feed the bats tonight.
Message-ID-Hash: CWX7GZOA7YFZBGC2IZUZZ4OCR7TCANIK
X-Message-ID-Hash: CWX7GZOA7YFZBGC2IZUZZ4OCR7TCANIK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CWX7GZOA7YFZBGC2IZUZZ4OCR7TCANIK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--LOy+G/Q4UT1kEEaC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2023 at 01:37:15PM +0200, Peter Suti wrote:
> On Wed, Jul 5, 2023 at 9:45=E2=80=AFAM Pierre-Louis Bossart

> > We will send a patch when the merge window closes, see
> > https://github.com/thesofproject/linux/pull/4434

> > You may need a similar test for the startup?

> Would it make sense to add this check for every callback then? I still
> don't really understand why only hw_params() and trigger() needs such
> a check.

Probably.

--LOy+G/Q4UT1kEEaC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSlV6YACgkQJNaLcl1U
h9DyBQf/SseW3LeIzmOjzob2CproPDwtWVLpUCYUKGgW/Rgs+Eir+/VbGYiJXo8g
AHJ5kLYNRiJbKiCzgSQe3931rFK6+Yc3qCviIc5toGwxeuwfCDfDdDB0EqG2OdZi
N9KC6x5w0A2V8KdGcxKdKIeQ8XRrp9x8DEfaPAwea6hM7+vK8VFWXN1JFHGu27dp
X6/7I1LR52sS6LXjwyT70HMqkRJRwiVy6GNCl1Vhljb7v+5uJ350ZAzepJfhJxFY
P2dPEC/wRpwfJNCOU8tL/BTLypWl6MT19qeIOkaOJ4a5TDy0NzUoM0lTru/hEPo/
taHwuh6rD3IMW9r4x7JNSxmRK0aLOg==
=Joya
-----END PGP SIGNATURE-----

--LOy+G/Q4UT1kEEaC--
