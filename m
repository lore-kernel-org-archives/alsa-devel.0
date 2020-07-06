Return-Path: <SRS0=aG7p=AR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E7BC433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 05:25:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C194A2067D
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 05:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hXxxMUzO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="XxkxVykz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qHN3RnzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C194A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 504BD1654;
	Mon,  6 Jul 2020 07:24:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 504BD1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594013119;
	bh=qqcTrt1S9WmQ9Z3ANHKZn0/p6MeBRjl8KA/a+ywaFkA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hXxxMUzOwYfVXDguXfJ5bA8JLvUTM1iMHdL6HrbZrQ8Per3fkST32CgWj1+dsbi6k
	 9zxWlbC3yEjjiHXEHZTpdKqvOKzJKfWlujDdWEpskyPc7SWciVmfS++Lt6HyRw+0+D
	 IG8ePP1HXfBoTuSqksVi9XHiPym9Q/RvavdhwYvg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C765EF80150;
	Mon,  6 Jul 2020 07:24:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61E98F8015A; Mon,  6 Jul 2020 07:24:27 +0200 (CEST)
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8BB3F80125
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2020 07:24:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8BB3F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="XxkxVykz"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="qHN3RnzZ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id A1BFD5804D9;
 Mon,  6 Jul 2020 01:24:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 06 Jul 2020 01:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=qqcTrt1S9WmQ9Z3ANHKZn0/p6Me
 BRjl8KA/a+ywaFkA=; b=XxkxVykzNjq1Ig3avm0J5owdxx9mxKUnsfDFMfJ3QYy
 I3kyowcQr68Q8bYnY1Kf3tuCwgaVtbOwrECl72SAwK39gb73OlOZIH35T1PHoV2T
 CFd9gTL5AoWzcuouGAbrhz6Be2i0rY/RMiEUXyL3H2Z70bjgWG3AWvZArDNFzlGt
 PuOej3sYEUUB4vQ463kZXbZB6k9oxHFOPzVwA57iMEkH7Az7GYYkYIIvy1YIdXpi
 a/woGzW+MsW+a5w7rso9YGrRrYnwGkLzBK3F1swdmll+yhIzqZrSH4Ea5RgUqIO3
 bcsdGHdOViQ0e7uJVc2f5DoAObMuhGqq/LnBl+cbiwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qqcTrt
 1S9WmQ9Z3ANHKZn0/p6MeBRjl8KA/a+ywaFkA=; b=qHN3RnzZrED/BLLtVW41LL
 FKroyEWMH0NqFCehoSNpb34IG9ZiPwEOIVAVEz+bmgz4365edJ5eeL7dPmeI8QBH
 GvF24Rg6HN2Uf/YSQPZ1vfoPWWPyUl0lHYtpkeaqOzrkusRl2SpWqGIrHlN1kW8N
 V4I2phZhsICjUDgOAIZS1MTwPi3rXemr/Vs1G+pMfeFfiDcxQfB3jnt66oSDa7zW
 UiFveU1g8WbtB/AwovWWn1Hbw5lx0QytMsXu+uun/yjYIOxF9k04cvmYZL/W8gVk
 Nw5ndJ1zx2ZzYwdiJKNmHopkYg84RTiHLQysMxtGWr0cdGj5qr9dRTvsQusijVFA
 ==
X-ME-Sender: <xms:hrUCX42IHkfFaxICK6EJFOauQuROSPKr4JvO5MuC485cQIhaW2MnoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdelvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
 veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:hrUCXzHuoCYcSi6rYRarfzU6QzREhmGRgZxbicYU4YtmazSd7Ob5RA>
 <xmx:hrUCXw7JERM3I-DKe57rt34HicGwiuuGGztYGhqk9yrl9SQitCXzkA>
 <xmx:hrUCXx2bANuk7PKZYScTaNXMTvG_0FbBycnQyFcT3xOaWrhzd61z6w>
 <xmx:h7UCXz8-a7MdBY-xRPmd38SGkdBs_a7On6y4n5cBs82Uv36DSH2ruQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 14E0D3280060;
 Mon,  6 Jul 2020 01:24:21 -0400 (EDT)
Date: Mon, 6 Jul 2020 07:24:20 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH 06/16] ASoC: sun4i-i2s: Adjust regmap settings
Message-ID: <20200706052420.k2ggqpnb22pcqgyy@gilmour.lan>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-7-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cgcntdw5vnpge4k3"
Content-Disposition: inline
In-Reply-To: <20200704113902.336911-7-peron.clem@gmail.com>
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-sunxi@googlegroups.com, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
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


--cgcntdw5vnpge4k3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2020 at 01:38:52PM +0200, Cl=E9ment P=E9ron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> Bypass the regmap cache when flushing or reading the i2s FIFOs.
>=20
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks
Maxime

--cgcntdw5vnpge4k3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXwK1hAAKCRDj7w1vZxhR
xSYJAQDpkLyk6Txs2qDTp05ZoUuIJ8mt50NcgYgzKq98a9c50wEAh9RWsf0GcbDn
/XYnwdbRBF9aQb9Y9C9lJ0pMLkSg7gk=
=p247
-----END PGP SIGNATURE-----

--cgcntdw5vnpge4k3--
