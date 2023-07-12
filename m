Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9630EB64D9
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 15:24:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28894845;
	Wed, 12 Jul 2023 17:23:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28894845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689175480;
	bh=CBAv5KX7B1FxLIzBzn77XTf0tZXAhjcehlFhJ5nOPUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vb1VZRcht8VqT6/ybOYeD6upd9uQlDFHo+Iq+zuOiBjKGffmJwmb8j/dmSBgqTn+3
	 iCjg+KvzOeqNRgQhy1G5khq9mBEznuLf8Kqn35yX7MGlFbf2rlDtmTX8QgG9+svYQ+
	 Ri3R4h6KUDu4NVd8VeoS9X+1xagn5BcrsBlVktD8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4EE2F80290; Wed, 12 Jul 2023 17:23:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88F0CF80249;
	Wed, 12 Jul 2023 17:23:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C281FF80249; Wed, 12 Jul 2023 17:23:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9D370F800D2
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 17:23:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D370F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=nsjDkFJB
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AC52361741;
	Wed, 12 Jul 2023 15:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F56CC433C7;
	Wed, 12 Jul 2023 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689175396;
	bh=CBAv5KX7B1FxLIzBzn77XTf0tZXAhjcehlFhJ5nOPUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsjDkFJB9zFmE7Ay55YaI48lZA52jOWabEH5yn0JedxtOJzs1afI845CQv2+MVRAv
	 +f1KY/IdnIivEpeJS5MvksIYH0aDkiIHaqTxXoHske/JJXyM9hUNzcY/7IEvlQzGHu
	 xr825FWBtEmgLPLVnNlTxLsyRbFBp6BLg0+bJZrkH+geZXGGjxI7FGha7g2KfJAQbK
	 agrGZRFxwpoANR6jCu9WY+kLX7YRBYYWf4xb9JFD8VbLo1hEJH4J09v+se3tbVzDtG
	 ABRcMLwQUDkDIk3ACD3GUKISPwCXJcJdaTSwM2RMMGWPr2A4lvxQsz9/cKwpdd85Vx
	 pHSlu9sLbhqFQ==
Date: Wed, 12 Jul 2023 16:23:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 0/4] ASoC: rt5677: Refactor GPIO and use
 device_get_match_data()
Message-ID: <d5cac1ef-1d44-4ab7-a933-b381108b1eaa@sirena.org.uk>
References: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
 <168916242630.46574.7633971537485557226.b4-ty@kernel.org>
 <ZK6xI8l7Vdp35yJG@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Ui5GpKY7zYS59Df"
Content-Disposition: inline
In-Reply-To: <ZK6xI8l7Vdp35yJG@smile.fi.intel.com>
X-Cookie: Dammit Jim, I'm an actor, not a doctor.
Message-ID-Hash: ZAZC3R6TFATMN2Y4Z6RU2OODXY2JBA4G
X-Message-ID-Hash: ZAZC3R6TFATMN2Y4Z6RU2OODXY2JBA4G
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZAZC3R6TFATMN2Y4Z6RU2OODXY2JBA4G/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--0Ui5GpKY7zYS59Df
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 12, 2023 at 04:56:51PM +0300, Andy Shevchenko wrote:

> JFYI: You might need to amend your scripts (?) as in the merge commit
>       the Subject is cut (I believe that your scripts doesn't handle
>       RFC2822 long lines in the email headers).

Report that to Konstantin, this is just b4.

--0Ui5GpKY7zYS59Df
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSuxV4ACgkQJNaLcl1U
h9BuQwf8C/mc0vg28M9xPMJZIMtURgHn6o5uk8aXPYVLajseTotKqn28i/r12tYF
aGSiMs8rAfxH56wyH65D+t/veFTg+B3+ZzttqhxU26p9JCRNLWBLpb/JeuTx8KUW
tD9cUr1koNQWtV6sCHRYs9hLOrzDElFGFARO9OCA5PeXgOZ+yQmC2JXNesPZob1L
GbVe7uOenBI2A+oBa8I6Z9xaIkSiMMf8qQlL79zZTIDQ2As6SPmzXNY9PoBitb/F
Xfwo1ckGRE/JWEB5AtUDXIKq7OjpULiGsNGK38Br4OFkPsDqe8UfvekqoSnZLnXY
qEZTl5YWzGY16cGbDhJsBrhRpUEniQ==
=Lske
-----END PGP SIGNATURE-----

--0Ui5GpKY7zYS59Df--
