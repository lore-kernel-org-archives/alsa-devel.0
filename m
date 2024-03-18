Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35758C54E5D
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Mar 2024 13:29:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47D84192A;
	Mon, 18 Mar 2024 14:29:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47D84192A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710768592;
	bh=H4T7GRxUc7yBWQ/u7+eX/MPNWtS9olwvn5w3951JJzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=toLQ0NaBgFwW7Ny2gsANitZpJuwFjbebW4nwR8snHNti5NhxRSo/nSJX6kH0tYlIq
	 iV18UWWAeGaCWBBy6jSWEemF0ZZDtZG/5jb6hDuLjh/RFOnu+HA2J+MC8SqAScFj/X
	 dPd/pPDLdyuh3mBLWiYeR7zntmRiOfJ8CCbHR8Bw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43B6EF802DB; Mon, 18 Mar 2024 14:29:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BFCD0F805A0;
	Mon, 18 Mar 2024 14:29:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2F553F804E7; Mon, 18 Mar 2024 14:29:12 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 795C1F8010B
	for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2024 14:29:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 795C1F8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KPwx81na
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A1B7ECE08C6;
	Mon, 18 Mar 2024 13:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDDAC433F1;
	Mon, 18 Mar 2024 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710768532;
	bh=H4T7GRxUc7yBWQ/u7+eX/MPNWtS9olwvn5w3951JJzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPwx81naHa13NzOUadChg3ZXXlM4Sfuiu0hyjqME8CSu7bbn6dPXX9fM3Av51MWwp
	 lC6BjSjjKXisOf6Kvo0k30BSGCQfHKEVSPAMVo8LAwdYWGTUZUMS5aHHFpJ390HQE+
	 KystrWwhb03wJgV+GuBOFmbQN4WUyAEUbeJhFnSroQKxi7YHBnKb5X335rck3OiuZ9
	 ORW1KLzz9YcbC7cPhtj5UZHvZ5wZYTZeVlMIjuTMINnEH3fjFVqS6Fc1MYzCQHwGpv
	 wfrxRv5tLvclqRosigeSDxi4ltoMjD44u15AGBfr1C1z9WAHE4aRdcLrAEkwvokDGa
	 apDTwQGa95aFg==
Date: Mon, 18 Mar 2024 13:28:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	christophercordahi@nanometrics.ca
Subject: Re: [PATCH 04/13] ASoC: ti: davinci-i2s: Replace dev_err with
 dev_err_probe
Message-ID: <0ee075c8-7c74-444b-9024-ad5440c36789@sirena.org.uk>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-5-bastien.curutchet@bootlin.com>
 <6102130b-b496-4e75-9b9f-f960484848fb@sirena.org.uk>
 <20240315152332.57c8fdc4@bootlin.com>
 <2f58922d-8964-4693-ab8a-612eb2f427e1@sirena.org.uk>
 <622b8b7e-7bd1-4e88-b705-79f7077b754a@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdrGDqd8KEdxafwD"
Content-Disposition: inline
In-Reply-To: <622b8b7e-7bd1-4e88-b705-79f7077b754a@bootlin.com>
X-Cookie: Alaska:
Message-ID-Hash: LG33HJ5UI42S32ULLAI3Z3YPCIKJ5MLP
X-Message-ID-Hash: LG33HJ5UI42S32ULLAI3Z3YPCIKJ5MLP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LG33HJ5UI42S32ULLAI3Z3YPCIKJ5MLP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--sdrGDqd8KEdxafwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2024 at 08:40:24AM +0100, Bastien Curutchet wrote:
> On 3/15/24 15:40, Mark Brown wrote:

> > I'm not convinced TBH, the fixed error code smells pretty bad.

> Ok. I'll keep the dev_err() for the fixed errors then, and use the
> dev_err_probe() for the others, would that be ok ?

Yes, when we can get a deferral it's the right thing.

--sdrGDqd8KEdxafwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX4QYsACgkQJNaLcl1U
h9DEsgf+Ny9qlyRP+/by6BPfHGXB+skGcS3TPXz/GIAnirpIiVrZg4hPTC/uSxWF
kuUx+m7UnPWUrUm7rBjDOhBNBpF16YY06MguCTLpBoOJ1f79tVB6Pn/8afzpGWS5
GjmCKVR8riUNwbh+/WvWF6t9FPMnjRWYPqudsy8w/Bw2zgkDzFCYUhKzdfhii7bp
TxBsaLFP8c+OT4plH/ofuW/RJNidJwn/f2cC2PWF5pv3uv2s3Jy4IAl/KvKRaYzl
Q+H3bGkfGslxduSxefjqGmB5WW0eFmOfefTZ0OVckvp5GdORBWPp8uGLq+Ge+sh0
poWhOCiuHaeY5JEeyFx2YXhxaFrCLw==
=wK3n
-----END PGP SIGNATURE-----

--sdrGDqd8KEdxafwD--
