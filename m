Return-Path: <SRS0=O8MK=6T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F573C47247
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 12:23:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC7520663
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 12:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WgGNjW59";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksv8mqPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC7520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72FF91736;
	Tue,  5 May 2020 14:22:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72FF91736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588681424;
	bh=fJLPF1B84qgnQ44zWI2Ou20CmHcAw3Np9P7BmOuy1EA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WgGNjW59KgOH8wWrUpH3KDLW2YPyq8raCaYRd5YV3mXZ3k2Oq+y+JJlrBuJ3ddjtR
	 vsDdi3cOU9QIS2GvEmz+vJ9qt8NA4rlYygGYVvrKHlRstGRCoJ2UmvHAzVp0iMbTgU
	 Ymgnt+Hq37KgCAHQwwXg0ACiXozDkgy0QiysrRI8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8157F8015B;
	Tue,  5 May 2020 14:22:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23D5FF8015F; Tue,  5 May 2020 14:22:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C4B7F800AD
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2020 14:22:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C4B7F800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ksv8mqPT"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2108420735;
 Tue,  5 May 2020 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588681368;
 bh=fJLPF1B84qgnQ44zWI2Ou20CmHcAw3Np9P7BmOuy1EA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ksv8mqPT1MaAXmpgZcjclfcgnuDxL+fif4Y59dh56w0vvUcfTb+3O6upXL9TbMEX9
 GJM+Pq3kZdgH7WbDQrCZ/RB7FNIfdWxKFh6jmiBcEwRY2fFqpaW3MzXWyfszT+imss
 DAPh3UEF+kAUcFRp0GmKVeGr1JqDy9ztRISFS9dk=
Date: Tue, 5 May 2020 13:22:46 +0100
From: Mark Brown <broonie@kernel.org>
To: "RAVULAPATI, VISHNU VARDHAN RAO" <Vishnuvardhanrao.Ravulapati@amd.com>
Subject: Re: [PATCH] ASoC: amd :High hw_level while simultaneous capture
Message-ID: <20200505122246.GF5377@sirena.org.uk>
References: <20200505114023.251409-1-akshu.agrawal@amd.com>
 <20200505115107.GD5377@sirena.org.uk>
 <CY4PR12MB182949DC53DCCCDAC02112E7E7A70@CY4PR12MB1829.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline
In-Reply-To: <CY4PR12MB182949DC53DCCCDAC02112E7E7A70@CY4PR12MB1829.namprd12.prod.outlook.com>
X-Cookie: Poverty begins at home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
 Colin Ian King <colin.king@canonical.com>, "Agrawal,
 Akshu" <Akshu.Agrawal@amd.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 12:18:45PM +0000, RAVULAPATI, VISHNU VARDHAN RAO wr=
ote:

> > Simultaneous capture on dmic and headset mic is having issue with high=
=20
> > hw_level being reported.

> Actual issue is :

OK, this is information that should be in the changelog so someone
looking at git history in future can understand what the change was
doing.

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6xWpUACgkQJNaLcl1U
h9DPwwf/e+0pjKHNtp9v5sem2RW277rv77fuAh4hmF0Egqfd1N2SaCixeSX8Jjpb
8LC3fQCexbSIOlQY4V6W9/lylqyL+jq+8XKPS37FR4KWbtHWFqFIGzIxO5ySfFZr
8zLQlLcHJftxlgWfdoE1gPzueigS+S5SsAvRmcQmPvF1Kp+LO5/l5YLTm5zEvNBa
jYvem3tZBfKpc7UzolX009RJj1iiP4PUeMpJ69yYs6B0anwW40EQ6yAAS/jl0EXS
gP8kTeWiFg5Ww9aO3RnmgW6gOvNhQI45vNIp09qr/GXyEBbrRvV22/A8eJhQNDpu
pfYnRWvirdDNyeTyKP132njYtiYOgg==
=EL4P
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
