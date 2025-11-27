Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F0FCFD2F6
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Nov 2025 11:15:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3FAB601FE;
	Thu, 27 Nov 2025 12:14:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3FAB601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1764242107;
	bh=hnylFDNiB2RskzMImuvbdxX/ijKlS7OOQ/eMp7B9Xik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IhMi/VHgBDadgVHAI9sP/v64DnkXXpA/zZNU0pbhxFIP+/UC97VCLSzO79alUmjXk
	 LCy/I3qP05SEdlEFKrfHFTrJYhD7kzBmlVjerHfC0c0zMgqx6+0eGI+0xhyUg/z9Vm
	 PdCuaRozY60RRnTKI+J5olkZYRNcJYVeQw23ZWYs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94127F805C0; Thu, 27 Nov 2025 12:14:33 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E195F805D2;
	Thu, 27 Nov 2025 12:14:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A755F8055C; Thu, 27 Nov 2025 12:13:52 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A7951F80087
	for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2025 12:13:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7951F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bb9J9g71
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1E33160141;
	Thu, 27 Nov 2025 11:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE09FC4CEF8;
	Thu, 27 Nov 2025 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764242027;
	bh=hnylFDNiB2RskzMImuvbdxX/ijKlS7OOQ/eMp7B9Xik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bb9J9g71hk9lklZrbxKpksypwhs8MjjXdtXGvTmsMezYP4147YFMnXftcKwjkxGob
	 j7R/3MwaT4fEskvuOOlmoLv8iQ/mVRTFzX8OaJQMTnRAPQuS4eGtd063BbaPGgM89C
	 zEwEbnM1ZjaEi2dLi5J0g10eHSiwMXWCLeW8s1y+WbQ+nk69abEiH16ZZekmBeqQjK
	 DOd/bmzPrO0aX6MGeBETZpYhiBbIZJ8wWHFJKYJ9PgyRVcSQM22JjsBX8dghOp5fO8
	 gsED1Tfh7cijSD3cbaRWdAIGyLMus7r/0idPra01vHPhX5MYgvlzURXmngraahUjqJ
	 JrQ/E17aeNSAA==
Date: Thu, 27 Nov 2025 11:13:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v6.18-rc7
Message-ID: <0827deaa-1b97-4902-af08-98bea70487c9@sirena.org.uk>
References: <25d5b5826b2e8d821caf7a37dea59186@kernel.org>
 <87jyzc9erk.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZVKWcNAbUDNYy2F+"
Content-Disposition: inline
In-Reply-To: <87jyzc9erk.wl-tiwai@suse.de>
X-Cookie: But they went to MARS around 1953!!
Message-ID-Hash: 6UTVDBQCWW7YVAHKE32HN5ESBX5BONY2
X-Message-ID-Hash: 6UTVDBQCWW7YVAHKE32HN5ESBX5BONY2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6UTVDBQCWW7YVAHKE32HN5ESBX5BONY2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--ZVKWcNAbUDNYy2F+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2025 at 07:21:51AM +0100, Takashi Iwai wrote:

> Pulled now.  But not sure whether I'll send another PR for 6.18.
> Might be postponed in the next week for 6.19 merge window.

Either way works, I don't think there's anything there where that'd make
a huge difference.

--ZVKWcNAbUDNYy2F+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkoMmcACgkQJNaLcl1U
h9AO0Qf9FmD6C72FkRelmiKuo5Aq0lKbAzi9T0gUOyblaSYkqHixta+3zS+YWDZI
oxkxDY8pzwRspiYAIno5+je8HBSEpfdybxcAJKnID0UkRlT2gqOiP2gqFEwIpVLo
RvslafLOs36VGzs8/i1UAlkKuhGj12ulpyPONg6wyd2Iu3VxaomoiXw6zfiijTMq
tbak7jQ1dTGPx4zado872SpJZ204oLAmReGp6JZonVgSGyvE88i0N5f1WblwtK0l
AJID0jGzBjgBTYUow3agNMJ7YzKNswHG470tsyr3jf1HCgCogrRVCbN6QNonNajh
KImKvQe+UIRnK8iu2Gr30LL2ySIJRg==
=ysCz
-----END PGP SIGNATURE-----

--ZVKWcNAbUDNYy2F+--
