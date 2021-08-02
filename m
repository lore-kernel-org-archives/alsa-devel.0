Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B969AC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 11:19:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB2B60FC2
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 11:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0CB2B60FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE65D1790;
	Mon,  2 Aug 2021 13:18:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE65D1790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627903185;
	bh=0tiDKALHkNGQENuKLSHpauGLnLkvI9TxIs0ny+A9Kx0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NH7yGiAXm/BcuEk9nPPnRELk6wTlcSX3e5U+JJJclCV3aVLxXI1ZJ8AKdEkMuflSJ
	 A11x6V8r+rN7xcXC3zGBnf7M9FSP4BUUoxc/dvwZz/k+agTfBM37mFxWcMOG1SydIR
	 +aIxzjYebKaN382Wm02a8iqulxgVruM9/FhHyUe0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82BF4F8014D;
	Mon,  2 Aug 2021 13:18:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50FBCF8025F; Mon,  2 Aug 2021 13:18:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D753BF8014D
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 13:18:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D753BF8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cu0SiyOK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7051260FC2;
 Mon,  2 Aug 2021 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627903124;
 bh=0tiDKALHkNGQENuKLSHpauGLnLkvI9TxIs0ny+A9Kx0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cu0SiyOKcaqLADyCxVtNkR5SZqg2uaQKgQh+KDA/x3bHOefbaKICOJQwF4mk7yusn
 6hmN6WK5/1jMvxHdUW5+ECD9s95WAjFx1hbWOND1ZH9ZrotWS3GtBfcqT4DdhNQrmF
 t9edolTSG7UZfeYh3SVI7M4zV+0l4L2KdPbxYItRMhEsnGTAe9loXIMJi/HL7W57sY
 nXwJe8eyPZq/ABGpn9HD9w6PKDRhjHD6dlAO99fVUR0tBHhDS2pxN83Ze40ekQ0DIX
 wgPmRse7FvUGaZ7W4jctHE9Wgte19WDj3UQr1awXihxA06IKwEFfxJGJjOQ7pZAY2h
 LzuHOTZ0tgW7Q==
Date: Mon, 2 Aug 2021 12:18:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 00/15] ALSA: Improved WC memory handling
Message-ID: <20210802111830.GB4668@sirena.org.uk>
References: <20210802072815.13551-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20210802072815.13551-1-tiwai@suse.de>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Daniel Mack <daniel@zonque.org>
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


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 09:28:00AM +0200, Takashi Iwai wrote:
> Hi,
>=20
> this is a patchset to enhance the ALSA memory allocation helper to
> support the allocation of WC pages more generically as well as
> supporting the fixed size buffer allocation.  It allows us to reduce
> lots of redundant code in various ASoC drivers that still haven't used
> the standard preallocation.

Acked-by: Mark Brown <broonie@kernel.org>

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEH1IUACgkQJNaLcl1U
h9B1Ywf9HmUR4VCjwPiF4umt8qdgC69KexbbNl4BrVvNxz+iEQCPYkSTDTbA1wVL
uRahDc+Z4hFG+TraFr2w/zMbyXLxYBNjAnw2p8YRZlODbMWRcuXR4HkqvDYTRxPH
9FqzdYLWWx7JHsIi6E4s5kYPKwK3cg7FBT1ZSKn69VpJM/ZDHquirzCbHhZ1Tbf6
pLSzdVF/D877Bj/peFxtZl8FqwTlWGUPxnX5m3sCt3KOhOmL6KY1pKtCzuxPwalL
kPzMlrybensnrFuQZKUgRHTybpLADZhuHTI8+EJqllIJLVeOrPHHzUAivoDSJFSM
8EcoNrTyxHXn/gstUeea6HbogJT+vA==
=Ehbw
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
