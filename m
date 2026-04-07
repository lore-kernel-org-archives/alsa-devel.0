Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F184FEEF2A
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 11:54:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 959F2601EF;
	Tue,  7 Apr 2026 13:54:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 959F2601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775562861;
	bh=81UCFkPSusex4GmC+Y85/hvgzegpWkjrUV5/bZWlTZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=X7Lr/3B8mRsMf6Z4n8tSdh/r4W4ncy10MVMiNwm7QtF2ohqsDr2nzWjkUHEFQS1xK
	 8elF4GvO96v6nvctMW0LvI64t/UIXC9i0L/aoBgcCXcEVigftcxjb+ESKVEFmyAi6J
	 ChZIsJIKOnu/HYGDi8OUsrFN1en5UhZpcOl+wLJY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 213DAF805F3; Tue,  7 Apr 2026 13:53:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C73FF805E4;
	Tue,  7 Apr 2026 13:53:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3AC1BF80548; Tue,  7 Apr 2026 13:53:38 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C3ACBF8001F
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 13:53:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3ACBF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TbLU9v4/
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8FA13600AC;
	Tue,  7 Apr 2026 11:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EC2C116C6;
	Tue,  7 Apr 2026 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775562810;
	bh=81UCFkPSusex4GmC+Y85/hvgzegpWkjrUV5/bZWlTZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbLU9v4/cc8KfvMORMKJvc7+bLiwyXRd6uznC+lAdS3kbTUKst3sBSyYCGZmzIFw9
	 7wDsmNDskDfqoDlItODwk6V8XJlVdrI5DRG6aRj4E0yk17nygbakM27gkK2E1ZSv4O
	 cg3Oi+v2lNH5RelVAYSwauSPudm6l1/gNcRR5fdYhIZABRHWnlw4o71+zlMjx2s7Rw
	 7CzxDlQGZA8IAF05jiQf0cJNMx2XGD4bN1JgKOj8i4jm+Ujcogsx5bcrGP/1r9Keb2
	 t9wetgw8kk5tcc10SH7h2UVYfmmoAiurw8Tv7nZxRDdFOGNPeJ10rccYdOhNlyY1wq
	 Sc5vn3I3uimGA==
Date: Tue, 7 Apr 2026 12:53:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Tomasz Merta <Tomasz.Merta@arrow.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"olivier.moysan@foss.st.com" <olivier.moysan@foss.st.com>,
	"arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Subject: ASoC stm32_sai: fix incorrect BCLK polarity for
 DSP_A/B, LEFT_J
Message-ID: <9b0a5620-b075-4808-a033-8e9171341a36@sirena.org.uk>
References: 
 <SA1PR04MB8467F5A56C565316DC5C1EF2935AA@SA1PR04MB8467.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CDtN4iSQoPsycoIG"
Content-Disposition: inline
In-Reply-To: 
 <SA1PR04MB8467F5A56C565316DC5C1EF2935AA@SA1PR04MB8467.namprd04.prod.outlook.com>
X-Cookie: Now, let's SEND OUT for QUICHE!!
Message-ID-Hash: EDRNAGJGDKWQOWS6VOYCH653FCJGMAUC
X-Message-ID-Hash: EDRNAGJGDKWQOWS6VOYCH653FCJGMAUC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EDRNAGJGDKWQOWS6VOYCH653FCJGMAUC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--CDtN4iSQoPsycoIG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026 at 08:06:01AM +0000, Tomasz Merta wrote:
> From 553c09cfa84fa801fbd8dcd5c9ae96e94a54ee31 Mon Sep 17 00:00:00 2001
>=20
> Tomasz Merta
> Software Engineer
> E: Tomasz.Merta@arrow.com
> Arrow Electronics | arrow.com
> From: Tomasz Merta <tomasz.merta@arrow.com>
> Date: Fri, 3 Apr 2026 10:33:11 +0200
> Subject: [PATCH] Subject: ASoC stm32_sai: fix incorrect BCLK polarity for
> DSP_A/B, LEFT_J

It looks like the tab/space thing might've been fixed but this is still
very mangled...

--CDtN4iSQoPsycoIG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnU8DQACgkQJNaLcl1U
h9DyvAf/Rt2CH1P5hJqmRtVbipB1zP7s6plYwyWWK4scyfs22d0+G+bPrVM0h45A
ye3OsFSPEKhSfQLwziSEcPSypARuBZLnrxOaQxuK0NK3GjusOk+AAcHJSggTEUsc
dswtziesZx+XCL5KhNP+SsdazSk/bXityi12kq4bVO2lsH0jTqnmpt2PtFuihrG+
PIOD09BXCI+K8s2rqbNZnDX9OzicNPCmDml/11048YzX8gEN5glo5FiWwKOtR83d
gFnj3G5DqBdBTvZl5qSUXv8QWRk3nSVFsqaYjRa7ek6BCa0nEdK7u2LN2wDrHkx6
n/8mvu5s2y7hBttzz9c2cBCdWcOOdQ==
=m0cC
-----END PGP SIGNATURE-----

--CDtN4iSQoPsycoIG--
