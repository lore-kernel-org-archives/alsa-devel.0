Return-Path: <SRS0=2Byq=DF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0B5C2D0A8
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:57:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC292158C
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mN57st11";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WZM48iBF";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A4aQVk9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC292158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77BBA1EEA;
	Mon, 28 Sep 2020 10:56:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77BBA1EEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601283421;
	bh=wUSUu2G3aVIryWaeA7vOSq4b5ntZ2lJ4mb84/YsXOuI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mN57st11bKm/jG6wLzdJF5ba7O5AMlPt3ccwGKOcoL2v2OLzIuXWz4wvX1rN2wo9C
	 U4ihDEFUM3OHPj2Oea5gvufIuSi1SYh/XUMCsbfBZKdlv7sAgYZw9q0fDPkU0IZISH
	 llOhsiXlj7GXltkmzhT0lLr+w9opaUFuStDdRzPw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2437F801ED;
	Mon, 28 Sep 2020 10:56:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C49BF801F9; Mon, 28 Sep 2020 10:56:09 +0200 (CEST)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 340FDF80115
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2020 10:55:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 340FDF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="WZM48iBF"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="A4aQVk9q"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 58758B74;
 Mon, 28 Sep 2020 04:55:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 28 Sep 2020 04:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=wUSUu2G3aVIryWaeA7vOSq4b5nt
 Z2lJ4mb84/YsXOuI=; b=WZM48iBF91gdKnDjQ7uhJ0/RIFRw5RhXsOOeZlZJCKo
 ysOwTqjBtlBCZj08M9nF22EmaxFAVEoLPCI8HL/0jdPlzcH2YFICniXpCoLiPtqH
 VpOBH47bt+ui/2YfhU/yW5VfSsau0KQrKRpIe0o0c/LA7MH8NR/XbJViG+pkL2jD
 B/g/l2T60cdiT268BZyz1XUMfVw55IQig/jerb/vptjxlA1X6M9x6a83g0v0CBK5
 Bmmq1FDcnqounb0O4rwjBb8ol1ZrgQbcaIJowXG8EgIrm6mkVObuBjZaEx3BtVfa
 XrLcZKvTOl2wgSLOTL7PgfwIArfBy2SMIZW7HfyAtbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wUSUu2
 G3aVIryWaeA7vOSq4b5ntZ2lJ4mb84/YsXOuI=; b=A4aQVk9qURplYZemoSbP0T
 EUoSZyu6BP+ZXw6FNbxPs0GVkLXlfle+zceapwfhWF20BfQ34PdGbXpWpcwdus8w
 T8ByrOAMTp9PAVFOq7Dw8hBc+2GLY+/0ycOmDjNEUvrO37DrvgPHjPIMrlXu/3SH
 5q8/uU/TxEl/IcgFyNTAaaq99scwACFHzeUlUBgrJI8c5BAIL7QKXasqfwACLnP3
 OKdCTsL3Z0OzDIGDuPBTeNGz7iGRXdtW0uJDyfeK4dvfUEvLgEi//GS+qrpG9FgJ
 z2gTBIwFOb2DHf8rlSu69xN17a5yR33Xj3A8eP4bkmOVhqRwYRi/uXVd98IT2DcQ
 ==
X-ME-Sender: <xms:F6VxX9h8l3bdAdhKV7_ZeWNJSwUX_O1_FpWJwZe1u_C2JnuMPQGRKQ>
 <xme:F6VxXyBUwEdfOyLmpzIxGe9WCsxP_0R9KFUgHeaQKe4QIaeVg9mSAC_s3igP0_uM7
 w1WHRnZF_vmQISJkGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigddutdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
 veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:F6VxX9HpWJ2SssBbPsr8cR0GdgkIsAFIl4TChPshZo0Qsl62OBNPrA>
 <xmx:F6VxXyTAfPBcPd-lFgiNOUKT-Dk05hFMJ2dwQsw_6WiFT0kUbPlw0Q>
 <xmx:F6VxX6zrMQ_V4GpMBxdfOcUtIBmmlvBxqky092uEANXubuudMIwvkA>
 <xmx:GKVxX1qlyUa-jOEbIeG-OVdzvi-kstcBwRc9s__r2vQLN4KC_S3NA-TUoVc>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 50723328005E;
 Mon, 28 Sep 2020 04:55:51 -0400 (EDT)
Date: Mon, 28 Sep 2020 10:55:49 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v4 02/22] ASoC: sun4i-i2s: Change set_chan_cfg() params
Message-ID: <20200928085549.izpgwdtkq5cwa4ut@gilmour.lan>
References: <20200921102731.747736-1-peron.clem@gmail.com>
 <20200921102731.747736-3-peron.clem@gmail.com>
 <20200921122918.kzzu623wui277nwr@gilmour.lan>
 <CAJiuCce0thGcH19vMtDX0X8-9S32Y7kC2bnWo_6-SHozF8uDAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z5fpfx6vrqwdiuav"
Content-Disposition: inline
In-Reply-To: <CAJiuCce0thGcH19vMtDX0X8-9S32Y7kC2bnWo_6-SHozF8uDAA@mail.gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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


--z5fpfx6vrqwdiuav
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2020 at 07:15:13PM +0200, Cl=E9ment P=E9ron wrote:
> Hi Maxime,
>=20
> On Mon, 21 Sep 2020 at 14:29, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Mon, Sep 21, 2020 at 12:27:11PM +0200, Cl=E9ment P=E9ron wrote:
> > > As slots and slot_width can be overwritter in case set_tdm() is
> > > called. Avoid to have this logic in set_chan_cfg().
> > >
> > > Instead pass the required values as params to set_chan_cfg().
> >
> > It's not really clear here what the issue is, and how passing the slots
> > and slot_width as arguments addresses it
> >
> > > This also fix a bug when i2s->slot_width is set for TDM but not
> > > properly used in set_chan_cfg().
> >
> > Which bug?
>=20
> Do you mean my commit log is too short or is it a real question to unders=
tand ?

Both, actually :)

Maxime

--z5fpfx6vrqwdiuav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3GlFQAKCRDj7w1vZxhR
xYJzAP90E3Ebs8ekSnakjeM+AFop/3Kt5use/kVDKsSr/V2JlwD6A8+jug6YBRDY
7kZEe3Y1iUyb4oLqEpjNxunahn+yfQA=
=0O29
-----END PGP SIGNATURE-----

--z5fpfx6vrqwdiuav--
