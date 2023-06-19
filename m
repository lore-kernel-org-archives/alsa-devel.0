Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D18EB64D9
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jun 2023 17:44:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B2FD832;
	Mon, 19 Jun 2023 19:44:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B2FD832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687196694;
	bh=QmULr4A39ToJDl2Z3lOKq1ZRZqqnqgEluIJ5NuB7Z6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IOBO6wQmxCrrq7WaXXYmxbFWKu59q8qBCpPq0y11oIsto9dBW2ULsptEXV7LFPcEv
	 sbfpA920oLdS/ZGoZBjSkiKWU+jEm+wx29rXG8mcy74UfxMKmgjRmeVLQT3E2KPRLh
	 wafkSzZGt51Jzmxf0iNsB0pE//+G+22DQvSe7K7A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F733F8052D; Mon, 19 Jun 2023 19:43:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C90F2F80217;
	Mon, 19 Jun 2023 19:43:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B401F80217; Mon, 19 Jun 2023 19:43:34 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 402D9F800BA
	for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2023 19:43:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 402D9F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZfKHzdPG
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 253E960DE1;
	Mon, 19 Jun 2023 17:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DB4C433C8;
	Mon, 19 Jun 2023 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687196601;
	bh=QmULr4A39ToJDl2Z3lOKq1ZRZqqnqgEluIJ5NuB7Z6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfKHzdPGyASgwbmQvZzlQoE/GAiW9t9nBDzvEdT1+k5O8zErlPig2Vnypq6gZQapi
	 0nlH6ntJe8A6ifan6Lre5qrYlTLlO7lCchWRSde5wJfFqbFzPuyOU7ASyM4LV5yUPw
	 0C0EDMuGAMpH2XfkijDPdI+0+QmQX+OahUfP0AyLuv3hdQ/ULL9KoBw7NWf+hcNO55
	 btPwXRLGupYXyxhISKBzlNHVFdzHF801qBbLtIlS5pm3gQ03l+BfszbFWgc8rhrQnf
	 D7Vk9KYwmsIrFMLhLhlvW65X1yh5caGuRQG2jYqa83MDN/Xhql21D0t+7QrAR1xtbb
	 BUhykkEvt33/Q==
Date: Mon, 19 Jun 2023 18:43:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	David Lin <CTLIN0@nuvoton.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	Antti Palosaari <crope@iki.fi>, Sergey Kozlov <serjk@netup.ru>,
	Abylay Ospan <aospan@netup.ru>,
	Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
	Michael Krufky <mkrufky@linuxtv.org>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Akihiro Tsukada <tskd08@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 4/4] ASoC: nau8825: Replace copied'n'pasted intlog10()
Message-ID: <060954c0-3435-4e7b-b705-4a2484f59581@sirena.org.uk>
References: <20230619172019.21457-1-andriy.shevchenko@linux.intel.com>
 <20230619172019.21457-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Em2WtDmrif0Q+GHr"
Content-Disposition: inline
In-Reply-To: <20230619172019.21457-5-andriy.shevchenko@linux.intel.com>
X-Cookie: Prevent forest fires.
Message-ID-Hash: UPY3X22BVWW5VAFBY2KUIX4EXGG2VH5O
X-Message-ID-Hash: UPY3X22BVWW5VAFBY2KUIX4EXGG2VH5O
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UPY3X22BVWW5VAFBY2KUIX4EXGG2VH5O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--Em2WtDmrif0Q+GHr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 19, 2023 at 08:20:19PM +0300, Andy Shevchenko wrote:
> As the code even references to dvb_math.c, which is now available
> as int_log.c, replace its content by the calling respective API.

Acked-by: Mark Brown <broonie@kernel.org>

--Em2WtDmrif0Q+GHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSQk7IACgkQJNaLcl1U
h9BEEQf+NR9HrzFdL3tpgECwfvwclK/PpGqn0e1EHp3uUhFELXJ5ln8miBpEcG5W
Lfgd7DHDBQbeFeDupp6gLeK9ktbISgxUG7xqtI9sX/5HDppLQYif9bo66XUMpr0M
2aQskN0wmvQU9H+6BORN8WpmpOWIOyot3XYe7Ie7WEUGmaM6zasYsDJ834mm6HtU
swSsAHSqpMvKtfXOm1wGhVKNzbY3unDFX6i989Icc93DL4mfNVpz/trOCPYHUcEf
7Tv6DxKAZbi091unxVHkcAlYgQPTZvRZ04hxwsMGeEnp5d306BAkZHqI9l7z8IvL
45evpQ2IMAe1zMkbzQAFUCvth/F0Mg==
=4IxJ
-----END PGP SIGNATURE-----

--Em2WtDmrif0Q+GHr--
