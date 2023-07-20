Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EBBEB64DA
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jul 2023 14:12:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3B7D1FA;
	Thu, 20 Jul 2023 16:11:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3B7D1FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689862355;
	bh=G8euv+WfQDtkbWySwB4rZDIeP/Tk4RHlZrv1viz5hVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PGQONqPTFzEXLiRjWd4KivTLE6tBzzO/KnIlc/LrciCfz6n0s/Q1TKl5DbmT0LxFz
	 06ocVilyxBAC27Tc8dG0s6iN+IQgJd0v3aBlaYRRdpAFac/i134l/O/jwXZl31s6fM
	 mKYiDa0tEuGxU6bHjoSaYcZdPBbFP8Zfo+JD8L4Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B260F80548; Thu, 20 Jul 2023 16:11:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C87F8F8047D;
	Thu, 20 Jul 2023 16:11:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B7EB1F8047D; Thu, 20 Jul 2023 16:11:15 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 58652F80153
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 16:11:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58652F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ifyMOxLs
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5362261B05;
	Thu, 20 Jul 2023 14:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC06C433C7;
	Thu, 20 Jul 2023 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689862268;
	bh=G8euv+WfQDtkbWySwB4rZDIeP/Tk4RHlZrv1viz5hVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifyMOxLspguRukAdTr0+Jg4UA5BvKsQrOw7Xkq1XGN397PzpCgrjUEx8BJL9Hu9Pt
	 iUaIzumQsLWzupbQDDW8t4JDOWT12cogKuy4hUgpyAey/6AM8jt1ILIf6p6h+fuzqm
	 qxFZ0GTaaa2a/IwIC8onB3RPm3aZHbH/ksvtqo5fIcuLU+u9t/kFHscGpLoTp63kxo
	 bt2tOntVwhS/lu/U0R56IrJg9RzGS79U/izn6uU1CbuIlHWvSGW2LFmQ5eBZ9YyVCT
	 7sMST+Y0YaeA3PoFxpBqfMbxA8aNbF55/eU2y9N7o0C7wuJH44uCJ0JSfPuCfUxwst
	 fMlOw23wSnLMg==
Date: Thu, 20 Jul 2023 15:11:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v1 01/11] ALSA: cs35l41: Use mbox command to enable
 speaker output for external boost
Message-ID: <56e50829-b93d-48ef-9691-5c78229a4b5c@sirena.org.uk>
References: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
 <20230720133147.1294337-2-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6K/jTXohBWi27Iqj"
Content-Disposition: inline
In-Reply-To: <20230720133147.1294337-2-sbinding@opensource.cirrus.com>
X-Cookie: Ginger snap.
Message-ID-Hash: CPPROIJERN3K5MBEQEBTN2I7WIJPVVFX
X-Message-ID-Hash: CPPROIJERN3K5MBEQEBTN2I7WIJPVVFX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CPPROIJERN3K5MBEQEBTN2I7WIJPVVFX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--6K/jTXohBWi27Iqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 02:31:37PM +0100, Stefan Binding wrote:
> To enable the speaker output in external boost mode, 2 registers must
> be set, one after another. The longer the time between the writes of
> the two registers, the more likely, and more loudly a pop may occur.
> To minimize this, an mbox command can be used to allow the firmware
> to perform this action, minimizing any delay between write, thus
> minimizing any pop or click as a result. The old method will remain
> when running without firmware.

> In addition, to ensure the chip has correctly powered up or down,
> the driver will now poll a register, rather than wait a fixed delay.

That should probably be a separate patch.

Acked-by: Mark Brown <broonie@kernel.org>

--6K/jTXohBWi27Iqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5QHcACgkQJNaLcl1U
h9CSggf/fWKATarmWnlKrAg5ClZia9/eeWSg0KKHc06sQbmmP/KEhtCBpkvFTBOP
I15i7IhT3RoZgCuxf7TnbYKKJa5kfk38EIjVALr8tFA2JdhZduFP8uT25kcAoeMO
G6o5abKdyupUKaB0Aw40lDDZ125HszaGVkN7iz/xDGTdtnPnpvhL1Py6r9jBbxDk
YdOAxE0V3shZLMfpeKa1zPjlS/yg0PF+jIuYW/nb3Ebp8GuNaF5bSxI1Zqaq9u4s
7ecg09LG+cVWG2DcrJ2O559FEQ0Apvx3bvVBDX2vG0ZuO7tDPFgrZrfKpmXnGW56
RWZlhomLpsJYb82MQVGLNzSLd7gIng==
=b/2M
-----END PGP SIGNATURE-----

--6K/jTXohBWi27Iqj--
