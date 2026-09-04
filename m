Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57357C79F80
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2026 17:48:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA5E160200;
	Fri,  4 Sep 2026 19:48:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA5E160200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788544106;
	bh=okkv6UDrUqy+DEthbwY9aepwc87vVJuEScNT8yiV0m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qVG3qfypkcksKC5i0DWAtBSwgkaKuGNdRmf4XQfxIlRp6cKHuO89Gyx5Ff8vngUEx
	 Oqon2W/yBUCRONIofwCf7HlQKF4YHjusIhVGVD+yV5dtONE91lLcnxlMV55m3tEVO1
	 80xpeonccqs2Ppdnpe6NwfGTldkNNmyr87Jh6dDY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B844F805FD; Fri,  4 Sep 2026 19:47:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45E30F805FE;
	Fri,  4 Sep 2026 19:47:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3560F8049C; Fri,  4 Sep 2026 19:47:46 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788544066;
	b=H1ptCXdUTAsA/RAK14gLepriRoC587MlTm9YjuD/1/S3TOc41AegdhkG7No8EbsITl7a
	 2PAvUHLa1+KHzZzrra79Bj2/P5Lt/yvu9KeNDgC5O2KSP7QLZJa7g5X9rEkUWS6QFHFoT
	 xXIK0/eRciAao3sgPT/f/DvPNmaeCpvVnGy8aX/4cXn3H0ozISDVoQND/8Z9KoGv7oCNB
	 XFTC4EkeFr3SAY3Zduf/PGU0GRiB7LnPpwBivHPVeSq+CVZCkEUe9oifi/xxe4lvwraJ7
	 4Sk/AS7NOfEFPuhcPJ3yXMlnLzShdrMPeDCKW91NhFglLurH++3htPvyHV8a6pXZLxQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788544066;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=okkv6UDrUqy+DEthbwY9aepwc87vVJuEScNT8yiV0m0=;
	b=OBm8E08Vbt8MGZKOAMyP/Qw9k9XtfsHckg6rwVGG5is4EqSNPXino5VyBsOOFP4TJIzW
	 f/9/Qf16lpvReju0t7VbnOVmt/heZoqryiP1YxIiximOClthjKR7+TIFOaV6f3He2+wbr
	 WFdHQBATz73N86CGu+S63773gPmMZKD05zcylJPVO9bztfeAfLIlt5Ia3wNjw7NmJKbUo
	 hlkHG8kmrRwphRyAOrHBz+B8gqIWbcqlTGT4PaRG0wz4kDY+1qaXeTZn4bvKOZjtT7P/O
	 BL818s7QshpTBZ5/l6oc4PMg3DsnJhM/pOmgNZmRoTB64+dqBsoFvtcJRwFOiwH9EGg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PgYY4H6S;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0118DF80185
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 19:47:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0118DF80185
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PgYY4H6S
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D4FA600D4;
	Fri,  4 Sep 2026 17:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3401F00A3D;
	Fri,  4 Sep 2026 17:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788544062;
	bh=eCOtz/eK/E9rW0zcIgRUL/87v/TZ7l09UIY9gMQ0ON4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PgYY4H6SLf3R3NvzSgbSF8zwixvalL785pqcXnnjfVilM5MHOLP2q/ffzk06OyAoX
	 VaUwXmq7mMiCpFOf6nOSVAUBcCkD0FuM9CUdEDEhATyK3yxaU+xCxbZ7v5o4QUk5jO
	 /gDsiFlp9YnG2027R7tXCvOE3nvKG6X1eSd87GYcMTT/aHkwZvWjlFaOR/fVH7Z9UL
	 g3V4JiTMTm0S+cChiolaIXHiH5o7dqvBbbKhmdfZCv4cNXRQa3iTnONU69XMCyj+ro
	 nNrd5JhZn6/Goi9se+ByzUwGPe6RwEfymQNd7kGfu4sUbmlwE+tHUg5K9/4rjOXFpW
	 2xAh31NDEz3Kw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 0FA0B1AC52F1; Fri, 04 Sep 2026 18:47:39 +0100 (BST)
Date: Fri, 4 Sep 2026 18:47:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
	krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v2 1/2] ASoC: codecs: nau8360: Set DAC path to bypass
 mode when DSP firmware load fails
Message-ID: <apsEO6K6Qo1ADH-y@sirena.co.uk>
References: <20260904060035.196399-1-YLCHANG2@nuvoton.com>
 <20260904060035.196399-2-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RAsO9G6pITb1+7kJ"
Content-Disposition: inline
In-Reply-To: <20260904060035.196399-2-YLCHANG2@nuvoton.com>
X-Cookie: My vaseline is RUNNING...
Message-ID-Hash: MSDUYJMPS6E6XJ54CACPPMGTH3MRTADG
X-Message-ID-Hash: MSDUYJMPS6E6XJ54CACPPMGTH3MRTADG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MSDUYJMPS6E6XJ54CACPPMGTH3MRTADG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--RAsO9G6pITb1+7kJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2026 at 02:00:34PM +0800, Neo Chang wrote:
> Automatically route the DAC path to bypass mode if DSP firmware fails
> to load, ensuring basic audio playback remains functional.

> @@ -1702,6 +1702,8 @@ static void nau8360_load_fw_work(struct work_struct *work)
>  	if (ret) {
>  		dev_err(nau8360->dev, "Failed to initialize DSP: %d\n", ret);
>  		nau8360_dsp_enable(nau8360->regmap, false);
> +		snd_soc_component_update_bits(cp, NAU8360_R12_PATH_CTRL,
> +			NAU8360_DAC_SEL_MASK, NAU8360_DAC_SEL_BYP);
>  		return;

We don't generally do things like this, we rely on the user to fix up
their configuration, but equally we don't have a good mechanism to flag
problems with firmware download to the user.  It's not something we
really expect to go wrong.

Since the register being updated here is a user visible control if this
does kick in we should also generate an event on the DAC Source control
so userspace knows something happened.

--RAsO9G6pITb1+7kJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqbBDoACgkQJNaLcl1U
h9DbNgf5Ack5EEylaxiBYfX6x0Ca5h2XClwAfPmBuqKkqf3atu8wy5q4fqj8ovn7
j1pAU2ZEW3NcXbtu8ppR+rOGRwfj2xV7xNkNkvl+g8SSVAMeGxDuHCDIhhSRuTSE
VeTVDbGYPYzO8yFwAGjycjDN3JMOCJCcVOEZbbesEGW7kQsCnyjvg0DEbUAB8j25
8234Y+J3EGB2xFhFhg2jR9YFpEhRgRnH6K9ns+or1yC0tBTJCd7/zbCx8dvndpOC
RkQuR7AWRnI8oqKw+qz6cvDnt6+oNxcR6wZ+xmbDWuUr8ZCS6Gnask3wix7vQ7jh
Q/dc8QhLV72gdTYFtoVpPAq0Wsk90Q==
=walo
-----END PGP SIGNATURE-----

--RAsO9G6pITb1+7kJ--
