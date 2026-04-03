Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB89E8536F
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:42:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E43A601FE;
	Fri,  3 Apr 2026 16:41:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E43A601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775227322;
	bh=ibcg/0c32l63ELnz6pcHv0xUM+Jh8xoFMgT/DG4WjUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NEOM0EfVxWLVpFLOt1IaBYzhcM++7vfuOj+WlesqnbqRCYFIt+u1u3dQVa8PMPnjP
	 /43HhcZVthWPDNIp+C0L084jbn3858Oqx8VD0T/Mpq2KuK7bkFKjsksf5hbmxGlNEo
	 rBQkYowS/zHtYbLj5mc3G4G4dqWqULJIA4/tQxGs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 233BFF805E9; Fri,  3 Apr 2026 16:41:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DD49F805F2;
	Fri,  3 Apr 2026 16:41:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C11EF8055B; Fri,  3 Apr 2026 16:41:18 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 91FDCF8003C
	for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2026 16:41:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91FDCF8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=g47xt+fc
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4A24E60123;
	Fri,  3 Apr 2026 14:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93C3C4CEF7;
	Fri,  3 Apr 2026 14:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775227274;
	bh=ibcg/0c32l63ELnz6pcHv0xUM+Jh8xoFMgT/DG4WjUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g47xt+fcI3o8MMhA00xZZwUrsUSzoh1yTpVBh9ylCfGHL/vbpmh0jmCb91bGhW346
	 YANfjpgBZxHb8M6Co7KELDSiSpSpyQNzjlEci+PcLlXvjrq4W87fqtBCW1wEc2Cq0b
	 v0dHgJMaiALVkCrUQdl1WkyUjA/FOyZc1+cPuOsNcmJI6rXN4LqBoX0OSUQ28NGJRB
	 izkDjMe/BANOiECIky5Bar9XTnJiRAvnuZaTSWiYTxrmzqYd9UjFhRvgy3HTyM39K0
	 E1OmQSWB8m9Yefusd85Lr6SRfGcBaK5QX/D6UEXFomexVicVAdRmt8yxmVGc8baicf
	 zN9lJMPbsrbMg==
Date: Fri, 3 Apr 2026 15:41:08 +0100
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
Message-ID: <fe1e50f4-30cd-467c-8db0-8af7a9a3abb8@sirena.org.uk>
References: 
 <SA1PR04MB8467CE79DCA58DF65FD9A798935EA@SA1PR04MB8467.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zmpnob42kQqUYH2A"
Content-Disposition: inline
In-Reply-To: 
 <SA1PR04MB8467CE79DCA58DF65FD9A798935EA@SA1PR04MB8467.namprd04.prod.outlook.com>
X-Cookie: The Korean War must have been fun.
Message-ID-Hash: YE5HFBLLTQP3CWIDSJLKK5HUEJX55QP2
X-Message-ID-Hash: YE5HFBLLTQP3CWIDSJLKK5HUEJX55QP2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YE5HFBLLTQP3CWIDSJLKK5HUEJX55QP2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--zmpnob42kQqUYH2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2026 at 02:07:52PM +0000, Tomasz Merta wrote:
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
>=20
> The STM32 SAI driver do not set the clock strobing bit (CKSTR) for DSP_A,
> DSP_B and LEFT_J formats, causing data to be sampled on the wrong BCLK
> edge when SND_SOC_DAIFMT_NB_NF is used.

Your mail is pretty mangled here, there's a HTML part and the patch
appears to be appended after a signature, it looks like all the tabs got
converted into spaces too.  If you're having trouble sending b4's web
submission API:

   https://b4.docs.kernel.org/en/latest/contributor/send.html

bypasses your mail infrastructure which tends to make life easier.

--zmpnob42kQqUYH2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnP0YQACgkQJNaLcl1U
h9CehAf+KeIAvH9Na4hWFjXfP9Vk5S2dwRr3ytLXIbhh7UH/s2xaoP70u8WyBDSl
4OQapxRTHOuPfq8a/o/or1KXCgl+zsOFW3WOfwYIAd5yiqjcQQCFwUfv/yuzurAh
ungTZRxN6rqEKKgeUbbFHAPU+5SIB9+wD1S2P4IVRDf3vrpW3FsOmh1uPmh9wM7b
QGZpUu3MHHJhUXMJ2smG5MIaTY1+47VPCPjsqNo/xIn1iFBsSx8ibuFYJRXBz11O
0fxpLliVt0IZUmHjhRSw3DsmUbZUA1SgNX63JTGc+bVarqrnHqF7z8tTKdot6UeQ
6nFxKe5DR1YdEAD9wKW6XfoTaV9HYg==
=Gdk7
-----END PGP SIGNATURE-----

--zmpnob42kQqUYH2A--
