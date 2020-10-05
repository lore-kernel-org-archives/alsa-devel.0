Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73004C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:58:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC94020776
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t+h/cbTt";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ee6k2yLk";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jzj1oGX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC94020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DDD017EB;
	Mon,  5 Oct 2020 11:57:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DDD017EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601891906;
	bh=jeiNWYte8XmCLmMRNCRlfoxJjvPZmkgA+c+vdcgDO8k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t+h/cbTtSApoZo49T6wAxZ1ZPOvQZhgv+s9YI7I00N2AHf8GGFgTVRtlYtPQwuNem
	 SqXIR7ad/Tob6Dw6eURDLQp2S3CZTnrnHx/XAhgxm9nf6bEekRkfgE3NFirnZ7zx52
	 U1yFdgrS0WQEm4WDStWla2bVOtZkxToeyF848pWQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 601DAF8025A;
	Mon,  5 Oct 2020 11:57:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCF7BF80260; Mon,  5 Oct 2020 11:57:33 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B84BF800EF
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 11:57:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B84BF800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="ee6k2yLk"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Jzj1oGX8"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 2E4035C011D;
 Mon,  5 Oct 2020 05:57:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Mon, 05 Oct 2020 05:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=jeiNWYte8XmCLmMRNCRlfoxJjvP
 ZmkgA+c+vdcgDO8k=; b=ee6k2yLk+LyqQFCNR7n2ySYFmgbTiWzg/1WobbI2ep+
 ySDdHMJrNFkrY0Jnmk1UsuridMyp0lO6Ni9yNxAYOjarhbn+jGbcaI39KVNYV7Eh
 hbr8gd98odoo7bKDFAFAG8u6or0ygADt5xMu8p9zOqtdVw2GmBdHh9MrHzhzxCnv
 PEuOVYOa5/khDKaogV2IiJgFqNa7lJ5LEACyk8xIDs+yu6f6O/KuM2ml6+zifZqQ
 UXZ/BxvyBBj9ZKBYAzDg3Svua8V0PO4t+sqAPQmK6xLP0wt5zH5Zjq3/ttLCrD3F
 K+wuwWh0PZJ5omDlDvw8dv6MtDdoCdfZdqiX9elgo6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jeiNWY
 te8XmCLmMRNCRlfoxJjvPZmkgA+c+vdcgDO8k=; b=Jzj1oGX8BaQ38TxgfE3iY2
 VepGaAr12WekXxuw0ieztCQGHv6LmDj3EEvRLeK8v+lNfPHyIN+ccUtlzenAvaNE
 1QRXomf5i0wD6uqhQl0uvM7rdUTwkazQe7eRAo4/7V46vNO8n8rG+W5EmXHvgeWD
 lJTpbmTG2kLcSryFXrkAc/U3M6lp4PJaMmD5blZZZDuTuu+GpQgkqJBWo++9Gobd
 T/43l4OBI7iy6OtLvaMmNiySSKhO48iRJLgVr32uDrnjP9oBU6eOryVWjHqRhK79
 QMjpY/AiPgag2adgx2sTe+5bQDOD7OfUtFb7eqVXx1Cz1TkXxbrVIbKdmWIiOaZA
 ==
X-ME-Sender: <xms:AO56X3YiP8oWXWBNNzH2fFPOz-m01jFBKr410357aRZ5fncUjlS95A>
 <xme:AO56X2bMlTatmkvbufrbIQuuSwXtT0uKjnnYQgQXXAJk70jc_I5C4vRwA8441Z3m7
 NvWF686Vxa8m_QS7DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgddvfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeefnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:AO56X58D1KxyK_RiWXekq1P28ReSfbvQd4Wibu1w7ZABg1T1JSZWxg>
 <xmx:AO56X9rQ_Y5UUOKVEqQTzwg8aI05NLzj_WDY_f_GXXionkqqWgVNBQ>
 <xmx:AO56XyqN8byaHVJBb1T4GZJgWpSiy2KZllBmC-LxV4MAxIMW7cZPEA>
 <xmx:Ae56XyI8Q9iXvT4g1mOLxVJr6hi2ZoXISAykPVxgpCy-VWlvgmjO5w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id A4C1E3064610;
 Mon,  5 Oct 2020 05:57:20 -0400 (EDT)
Date: Mon, 5 Oct 2020 11:57:19 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 04/25] ASoC: sun8i-codec: Consistently name DAPM widgets
 and routes
Message-ID: <20201005095719.7nkonjaeziyd4fld@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="veplexjr6kmshaoe"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-5-samuel@sholland.org>
Cc: Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
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


--veplexjr6kmshaoe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:27PM -0500, Samuel Holland wrote:
> This cleans up the mixer widget names. The AIF1 AD0 Mixer names were
> previously wrong -- they do not control the digital side of the ADC. The
> DAC mixer widgets were not wrong, but they were verbose and did not
> match the naming scheme of the other widgets.
>=20
> The mixer controls are not renamed because they are exposed to
> userspace.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--veplexjr6kmshaoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3rt/wAKCRDj7w1vZxhR
xWniAQD5dzisALP1Tl/pOp1XFrNcyIPm590bbaTGMGrfaElJ0wEAmInRmA9Q9Ub6
OLuQEDnFUgyCxQkMUSE4FCl+sAxDpwM=
=oUY1
-----END PGP SIGNATURE-----

--veplexjr6kmshaoe--
