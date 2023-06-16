Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38F4EB64D7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jun 2023 19:32:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00D3982C;
	Fri, 16 Jun 2023 21:31:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00D3982C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686943918;
	bh=m6QSCylXY1bTSEE7pUAQZ0/7778yGcYDggobDzunS2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rViFKU0MyaH6ZHJgKiudwl9DJZFEV8D97J5TVqx2Qkox5X0mMnlFxVO7UTIACdDTB
	 PokdOM6has48M7alb7g0sH4G7/OhcXYBRkRok9Zk1JDfRxLxcyJOBImtvofZ7rHlRY
	 p8RXTmlH1Ynbn5Hnb5IZMgtQNwyrs40g2JJF71CI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDEA2F80155; Fri, 16 Jun 2023 21:30:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5664FF80149;
	Fri, 16 Jun 2023 21:30:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E65DF80149; Fri, 16 Jun 2023 21:30:38 +0200 (CEST)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 51106F80130
	for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2023 21:30:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51106F80130
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C23661C0E73; Fri, 16 Jun 2023 21:30:32 +0200 (CEST)
Date: Fri, 16 Jun 2023 21:30:32 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 5.10 13/21] ASoC: soc-pcm: test if a BE can be
 prepared
Message-ID: <ZIy4WMDkMqxNoEg/@duo.ucw.cz>
References: <20230531134415.3384458-1-sashal@kernel.org>
 <20230531134415.3384458-13-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yvTgwKKZUIxy1Uk0"
Content-Disposition: inline
In-Reply-To: <20230531134415.3384458-13-sashal@kernel.org>
Message-ID-Hash: RP4ZWMVWC5KJLXVSVNV6VYZPNP24R7VQ
X-Message-ID-Hash: RP4ZWMVWC5KJLXVSVNV6VYZPNP24R7VQ
X-MailFrom: pavel@denx.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RP4ZWMVWC5KJLXVSVNV6VYZPNP24R7VQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--yvTgwKKZUIxy1Uk0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This problem was detected on Intel IPC4/SoundWire devices, where the BE
> dailink .prepare stage is used to configure the SoundWire stream with a
> bank switch. Multiple .prepare calls lead to conflicts with the .trigger
> operation with IPC4 configurations. This problem was not detected earlier
> on Intel devices, HDaudio BE dailinks detect that the link is already
> prepared and skip the configuration, and for IPC3 devices there is no BE
> trigger.
>=20
> Link: https://github.com/thesofproject/sof/issues/7596
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
> Link: https://lore.kernel.org/r/20230517185731.487124-1-pierre-louis.boss=
art@linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>

">"s are missing in the email addresses here.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yvTgwKKZUIxy1Uk0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy4WAAKCRAw5/Bqldv6
8jfxAJ9S3GBxXVwaCu+rl0V8uD4d0NhSzQCfdgQUlcP6kcQ9GCBGGC1LfpdXS1E=
=eOOG
-----END PGP SIGNATURE-----

--yvTgwKKZUIxy1Uk0--
