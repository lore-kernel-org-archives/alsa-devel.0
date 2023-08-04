Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82315C001DF
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Aug 2023 15:41:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 422A4827;
	Fri,  4 Aug 2023 17:40:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 422A4827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691163695;
	bh=bkzit33VmdoUD6BWlsNFe9JgzY2f8SKPYIRIBtcatOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dESBVfrTGoAlBFeNX+8nvrGCoJ9dW+pByRw4wsKWm+CSK40mOA7XG1kWttQJPHdMH
	 BxLJdjvJBH1tdO63uXUvW8Aed90RB85BCh71juWap0n+M2IHCM5P86hQDAtkJDDVN6
	 ZWiyRnMKsjNB8DuXIZJfw76VrjEHWTvrNT2i/XRs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 372EAF8053B; Fri,  4 Aug 2023 17:40:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 92C00F8025A;
	Fri,  4 Aug 2023 17:40:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55667F8025A; Fri,  4 Aug 2023 17:40:11 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2CC4BF80087
	for <alsa-devel@alsa-project.org>; Fri,  4 Aug 2023 17:40:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CC4BF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=A/wmZHio
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C4C79617D0;
	Fri,  4 Aug 2023 15:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3022BC433C8;
	Fri,  4 Aug 2023 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691163599;
	bh=bkzit33VmdoUD6BWlsNFe9JgzY2f8SKPYIRIBtcatOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/wmZHiopppHK/MJlnx0llX9Mksf28G/kXdY8g7/v4ybME3mj4mfRGE4txu7To0U4
	 D0DMqYnGWtVRN3lndOCOG5m+5uMh8laySuwipdk/uJQ4HJGUC8itVTsLuNcMKdfl2s
	 MR+VcmtgeKVECnsWusAU/h1GR3PJcsLkqmWNRYn4ppQFJmifI5/XhiHymw+docKAD9
	 C4mzEuj/Hr8CW8OFokEcGN9Kufe1/P5/TAjPy2B2KIogrK8jGerBeHyhw6FjXIWbr3
	 uAwE1W/fmb3mSdcVu/RH3zHN5C+d5WYA9y5NCMpfok1DJRWQhhhpRhZ9Ax5wRE4bgr
	 suzrzYJWsK6Ow==
Date: Fri, 4 Aug 2023 16:39:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: wlf,wm8960: Describe the power
 supplies
Message-ID: <20230804-track-polymer-dff0f803645d@spud>
References: <20230803215506.142922-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L0gVLHdTSEnPRpVf"
Content-Disposition: inline
In-Reply-To: <20230803215506.142922-1-festevam@gmail.com>
Message-ID-Hash: FXZOHN5ULADERHML4C3EEUFAHHOOKEJW
X-Message-ID-Hash: FXZOHN5ULADERHML4C3EEUFAHHOOKEJW
X-MailFrom: conor@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FXZOHN5ULADERHML4C3EEUFAHHOOKEJW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--L0gVLHdTSEnPRpVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 06:55:05PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> WM8960 has the following power supplies:
>=20
> - AVDD
> - DBVDD
> - DCVDD
> - SPKVDD1
> - SPKVDD1
>=20
> Add them to bindings to improve the hardware description.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--L0gVLHdTSEnPRpVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM0bygAKCRB4tDGHoIJi
0os0APwJQfgW205aF/eC8Y0ogViquNkLqRfa0+Pg/XQRRW156QD/Z10cvSfoQX1b
wvrDDHnT/uKDDleuREkMlMuf2E8PVAA=
=36x1
-----END PGP SIGNATURE-----

--L0gVLHdTSEnPRpVf--
