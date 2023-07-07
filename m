Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07F7EB64D9
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Jul 2023 13:24:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 852F920C;
	Fri,  7 Jul 2023 15:23:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 852F920C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688736258;
	bh=NHCxkwb/m5V0S7DCsQ1y4xdBpD1W9GlLedhbup59uxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cbATJ0O8oXxdL5naxK2jdFfsROrx2+YFQZ5XQmrsYXd0Ra6vdzC1hUwKkiPJy5hko
	 ZaJn+Qv3/Es3/bpVgla/jq7pUsc7qTw1L4BOn7u7HlQHkkKYO5hipq29sB93QuoRbK
	 fTOY5cTZiRZMQromN1kednsH1uEAjr4b5+GwBmcQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CDF9F80104; Fri,  7 Jul 2023 15:23:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DB3E0F80093;
	Fri,  7 Jul 2023 15:23:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ADC0BF80125; Fri,  7 Jul 2023 15:22:57 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7146BF80093
	for <alsa-devel@alsa-project.org>; Fri,  7 Jul 2023 15:22:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7146BF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uTi+H3Wd
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C40AF61900;
	Fri,  7 Jul 2023 13:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1990C433C7;
	Fri,  7 Jul 2023 13:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688736171;
	bh=NHCxkwb/m5V0S7DCsQ1y4xdBpD1W9GlLedhbup59uxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTi+H3WdfHPM9Byxcm2uOHye+pl0xSXW+NfUsQ2T1zjOFGAvJdUSuxZTA/NL7BxrV
	 fmc5hIq2P1DY6FKKo4OLqdf7zMj0GhlBpQSe8CbmAgz6k7lQzWOIV0dvsg9gY4nj/b
	 fe5qRdVwrg/cT18TVNUNYkRGo+aaQCRjq//shCKUoW7NlcBfa+VSO6mcsouBmp+r/Z
	 xsZ5a6S2HYt6Ma3/6Brph4A4s8SR6dYCsVo4ALeyVsR9YvkCTcz/LBv0BScgRl6z8G
	 GiL0BTmgsyY3V2VyaCZWzRhXNLwQXC5+tRftUA4asvU19qN3Fvm2VekpjfWSUZs6wf
	 mS/YMTZmyuJHw==
Date: Fri, 7 Jul 2023 14:22:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan@kernel.org>, perex@perex.cz, tiwai@suse.com,
	lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
	kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
Message-ID: <3450ef1e-cb20-4242-b482-41d3d34c4564@sirena.org.uk>
References: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
 <ZKfAUOOcGoBanHHu@hovoldconsulting.com>
 <efaf5960-bcc5-6d52-5552-e1505a13b635@linaro.org>
 <87y1jrkgdx.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5wVyCaq/6JTHUGMD"
Content-Disposition: inline
In-Reply-To: <87y1jrkgdx.wl-tiwai@suse.de>
X-Cookie: Victory or defeat!
Message-ID-Hash: H5EHL3FFSFQI4QO7RACJTYQWADH4EYQI
X-Message-ID-Hash: H5EHL3FFSFQI4QO7RACJTYQWADH4EYQI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H5EHL3FFSFQI4QO7RACJTYQWADH4EYQI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--5wVyCaq/6JTHUGMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2023 at 03:20:10PM +0200, Takashi Iwai wrote:
> Srinivas Kandagatla wrote:

> > yes, the highest value corresponds to lowest dB which is why its inverted.

> Ouch, that's a bad design choice...

It's moderately common - typically in these cases the control is
described in the datasheet as an attenuation control rather than a gain,
and this usually corresponds to the physical implementation being only
able to make signals smaller relative to the reference.

--5wVyCaq/6JTHUGMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSoEaUACgkQJNaLcl1U
h9CsMwf/SZvOJmKt2vqSP+P7xpCmdnZuh5IZm0EUCIEuuA293OaTfe1+amJOiCPB
/wIC4KaE4nYOKYq7VltaO9ytlJuUPbTgYSJDaLuA/N54rNmkhc5LPUfpb1U7vhUS
PtFvtPDhHdiEgSAUHMJ+hFg3+dacjO39J/5X/8mhVJQefrSK7wZRfuaiBbhgxIpU
AKRTLYxDE8wAQwoRmPqpfTOQaDZ3FJ88FeK0LBtVwCPc0jVEXzIE8zUanWxXeNZv
riUd4goWN9XLteCM9iFu2WlCrPVrTwJj0ICAGOJMxHM3SpACSu9GAn9JIy8aDaR3
LpUiI3ukZByAEAt6HOo/dh20Hl5aLA==
=BUAJ
-----END PGP SIGNATURE-----

--5wVyCaq/6JTHUGMD--
