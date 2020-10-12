Return-Path: <SRS0=KIty=DT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A2C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:59:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A64D2076E
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FJtMIsDG";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="sNqTujZF";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYXTngJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A64D2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFEC9167F;
	Mon, 12 Oct 2020 15:58:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFEC9167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602511188;
	bh=sEZcyXmHBZEDouzMk16DQ7A+uj0n9Hmw8HMTAmUqJfE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FJtMIsDGq/XZEP5s/9pB4hcGUoxmgEY33ycnXrvefrYvLRLPsPT4euhE4r/YGCXn+
	 puDS5qukep3gTRmfCZixSK7mQpftGnnI2Wb9vgQT7voLe8bUHDWbaWMFB2zHAo0efI
	 4FQIn85I71AeRnSBiex7AjAtBtrbZQf4lOSx42Fc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68985F80141;
	Mon, 12 Oct 2020 15:58:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 621DEF80217; Mon, 12 Oct 2020 15:58:57 +0200 (CEST)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9B44F80141
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2020 15:58:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9B44F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="sNqTujZF"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="eYXTngJG"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id E644B5802DE;
 Mon, 12 Oct 2020 09:58:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 12 Oct 2020 09:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=sEZcyXmHBZEDouzMk16DQ7A+uj0
 n9Hmw8HMTAmUqJfE=; b=sNqTujZFyiNiSFlovqDYbgmqHijW/8SVF36UDKYU/tU
 J/nk7oXUFQX7UD7rs5Y6GbMsXrbvNQCPZabRxPYLevz8+Cmc4epqgShk3HvHQkt0
 qdrNpT6Ig1skcbAFNGbJUQ6BR9voFaT+MXr3lbLrDuFeFp7TNIqQcan2t7jeq1S0
 0FO3p7lfq4fbMwO6Im3/fVtcQ1HMDqZdfyW0uBCKs9sRjO35iLyOrt+4weDOeiFt
 9EboT8moNnJc3PFKABj2rF09KctylrVgAYIdZM0WDLCmHM72/ViByTI2zy2l5mm4
 8P0U7Y3MR12GIwamvxyXK3JGshlhHkG9VCKknT5ivAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sEZcyX
 mHBZEDouzMk16DQ7A+uj0n9Hmw8HMTAmUqJfE=; b=eYXTngJGlD5XLuscT3f0ex
 DOhZj5i7CgiqFAuuJmlMKnfhJW4ib8I1mq//bAaWM/0VGNWwA52a2WrhT9/CQbST
 fQsPhNPwujfdsipbjxlY/NtxTEJ0CqYYrOHH4en9uQMFQj1EwHvfK+iFNh8mzPKU
 MWjQxigheo8gWq4jYPyEgIw757x1Eav+e7xTq9q4DQz6DOX4ui91E4rfxPxCLgAx
 ETthHhQBuiD8wk9EWYFArC4m5s23OTUMGrmE1NfYP44XQlwH7qQY5dHm9hiCn1Qn
 M3zYSiTOlAw/ubC5hnQNs1bPMY/F0+UGoN3rNdvEmhyG44yzbdxuNUIF+V3+6M9Q
 ==
X-ME-Sender: <xms:FmGEX1R9UOYg1BipFqTFO1G4FFVuoZZO0hvxY3LVcDhrEA0foITvAA>
 <xme:FmGEX-zwRAqNLFzxYyw-L0af-HpfZ6HBpI0qaAsv4syQ2I0KOqWS-EOWFtzsYBPRZ
 zi8Kxzzhulcd33S8tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheejgdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
 veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FmGEX630vghiH5FBREanLrOx6Jk3-ZWpNdCioDXorraeIE0jUBpV7g>
 <xmx:FmGEX9AHgSPckErYJ9-I5o5IXw34A6ccxuyOW-Y7t_LqBXVBvAVA-A>
 <xmx:FmGEX-j3-NoJ9WyhNitdQD1ptwoy670KMcqVDnT4yq8u1Sb17lrBcQ>
 <xmx:F2GEX_ZgaIP_SSeCWTSSC5MS5yw6_JhptqZgR98wYt_gZj5BnYu25w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 577493280066;
 Mon, 12 Oct 2020 09:58:46 -0400 (EDT)
Date: Mon, 12 Oct 2020 15:58:45 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v7 01/14] ASoC: sun4i-i2s: Change set_chan_cfg() params
Message-ID: <20201012135845.s6tknsnjrtsuoacf@gilmour.lan>
References: <20201011202224.47544-1-peron.clem@gmail.com>
 <20201011202224.47544-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="g3qoejqmxfoskuxo"
Content-Disposition: inline
In-Reply-To: <20201011202224.47544-2-peron.clem@gmail.com>
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-sunxi@googlegroups.com, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 linux-arm-kernel@lists.infradead.org
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


--g3qoejqmxfoskuxo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2020 at 10:22:11PM +0200, Cl=E9ment P=E9ron wrote:
> As slots and slot_width can be set manually using set_tdm().
> These values are then kept in sun4i_i2s struct.
> So we need to check if these values are set or not.
>=20
> This is not done actually and will trigger a bug.
> For example, if we set to the simple soundcard in the device-tree
> dai-tdm-slot-width =3D <32> and then start a stream using S16_LE,
> currently we would calculate BCLK for 32-bit slots, but program
> lrck_period for 16-bit slots, making the sample rate double what we
> expected.
>=20
> To fix this, we need to check if these values are set or not but as
> this logic is already done by the caller. Avoid duplicating this
> logic and just pass the required values as params to set_chan_cfg().
>=20
> Suggested-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

We still have an ongoing discussion on this one in the v6

Maxime

--g3qoejqmxfoskuxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX4RhFQAKCRDj7w1vZxhR
xSBFAQC6KZxQXo2wkmG7IYJL8mCSpdD6xPNJqcknI6+pUmt2uwD/QQEBR+rIzK8+
3i5szDEx6Z3mAunz7uCj/u9/KpumUg8=
=PQvS
-----END PGP SIGNATURE-----

--g3qoejqmxfoskuxo--
