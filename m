Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E33CC83F33
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Sep 2023 18:03:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61116825;
	Mon,  4 Sep 2023 20:03:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61116825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693850634;
	bh=AUxJ+uIwizMOJoV1uCMXbpEj6YaqWhamff8D6IHLwX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=D7hlUmdcFuVfbjrY1HhuvjFjWwh09IbRqmbsUHeDlTgdoj+Qvhh+oGdIi6diE7Gej
	 IbLXGJXiY/1bCUxG6DgKoBvZYPZ7NbvszIFtil83t5GGHahGcYbhw27VKDOYK+tmk1
	 tY/ip2OUb71p+BSZ5R0Qw9E5/ekGQs1RZgrHyrHg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 78FF2F80494; Mon,  4 Sep 2023 20:02:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 313B9F8047D;
	Mon,  4 Sep 2023 20:02:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33AB4F8047D; Mon,  4 Sep 2023 20:02:34 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3FFB7F80141
	for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2023 20:02:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FFB7F80141
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QSTIAgjG
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2D7E5B80ED9;
	Mon,  4 Sep 2023 18:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555CAC433C7;
	Mon,  4 Sep 2023 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693850547;
	bh=AUxJ+uIwizMOJoV1uCMXbpEj6YaqWhamff8D6IHLwX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSTIAgjGs3dXtpAGoceVxatGYn0ElTGlLnYOu6G/OS6SnMi3o9A7IFx4ukdw0BuO6
	 wK6vhpiuMMiwxIlxoWxSm1QDBqlsKBZJzv8ji9+vVQ9L3/vWjb+kzni3YlxSMtSCmO
	 I/ttMiMayGfRwU+xbL1xxXaCatQhNvVbwfPf77PdimZkMItKciwB4iejlbDiKiWIcK
	 nOknW/SZkNsiF6Q+p+VVnKbPtw1cmoZ0PSkhxFomUt+bIsd8hW/WOIrIEEsA823iov
	 9HHD31iUEZLwKuTVAQq4cTHR7gp6U8klTg3GNFj7gfbbsr7OxcsoxEojJH1JL+dchf
	 DjDmoXiOAp+sw==
Date: Mon, 4 Sep 2023 19:02:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
Subject: Re: [PATCH 2/3] ASoC: aw88395: drop undocumented, fake fade-enable
 property
Message-ID: <76c00419-1cad-493e-9127-e5f008868162@sirena.org.uk>
References: <20230904125309.43350-1-krzysztof.kozlowski@linaro.org>
 <20230904125309.43350-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M8rrkN6DA4ETQF4X"
Content-Disposition: inline
In-Reply-To: <20230904125309.43350-2-krzysztof.kozlowski@linaro.org>
X-Cookie: Immanuel doesn't pun, he Kant.
Message-ID-Hash: N3YH7XTFVYNP4FM6RQJRAPAHRSZGASN3
X-Message-ID-Hash: N3YH7XTFVYNP4FM6RQJRAPAHRSZGASN3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N3YH7XTFVYNP4FM6RQJRAPAHRSZGASN3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--M8rrkN6DA4ETQF4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 04, 2023 at 02:53:08PM +0200, Krzysztof Kozlowski wrote:
> The Devicetree fade-enable property was never accepted and is not
> allowed by bindings.  It is not used by any upstream user, thus
> considering that it was never documented, should be dropped.

On reflection this one might fit better as a runtime control.

--M8rrkN6DA4ETQF4X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT2G60ACgkQJNaLcl1U
h9AZ6QgAho8CEjwD1biZKHFqfYMDe1n/Q3yNyHRSzoUkoyC4r0UaDHPBSYl+Tkmy
90FBs7wKgjnHGV8HNY49tUXfzEVLZSn1A4sQOUD+10xRj4QJvnyo2LmQI522mu20
drOpy6gurB9aYm5YW31RusnnKgd1PCT4ISdCMQJHATA8F5mdJCPIBHpvwDEwThDb
b6BPTlOrx6FQkUTDfv+R3RGFqnF8yeRrJJrNGbZp4VaiiN0RmiWq1a7MDe++wVO1
ndlxWW8uzxUFPTrApG1h9Qa2xZv2BgiHl3dDw0vj6lN/uULIWUeGbRP9pORiXXPZ
vgSUQ9a02kW8enE9qMltrpZVGlBRwg==
=FB8e
-----END PGP SIGNATURE-----

--M8rrkN6DA4ETQF4X--
