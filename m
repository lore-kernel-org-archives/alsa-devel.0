Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D69C388F9
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:51:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41DC2463C
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Azu7C2o3";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gtgMuXDG";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EF1KDrT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41DC2463C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16902169C;
	Tue, 27 Oct 2020 18:50:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16902169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603821086;
	bh=o0QZYLWc2DJfF5NxyW7s/sWWeb3sdM3P9zlIU41d1fc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Azu7C2o3/xVfQGXdgpcDXb2+iUIYeFAqe1Or4x/O7/ZXjo7hS6xtn4o9HippEd79Y
	 8gR0Fivcuzfrbub8SH8AMq4VZS4h8pt7oc/wxpfurT7MZa32mGyww+yjJ9DjmPClW4
	 cQ8+UNSOE+CCmmEXUY8LnHej9N3aqE6FggIljU+c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9357EF804BD;
	Tue, 27 Oct 2020 18:50:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0841FF804B4; Tue, 27 Oct 2020 18:50:22 +0100 (CET)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D6F4F804B4
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 18:50:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D6F4F804B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="gtgMuXDG"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="EF1KDrT1"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 00712580429;
 Tue, 27 Oct 2020 13:50:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 27 Oct 2020 13:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=o0QZYLWc2DJfF5NxyW7s/sWWeb3
 sdM3P9zlIU41d1fc=; b=gtgMuXDGFAqFV5I7iH5evdN/pbtYoM/mtLK7uiphFmh
 33+qh/K2PI9c5o1uFJa5Phw2uTxzh8gooBNm8Q4FP31SoJAczVcBKIfKckFdTtEp
 UKzPSuCakH/GqtXAkgHS2Ldz1ciKiRmnVq9Saf/0ej/sVVQ2kDKdQe2z/khfr5OI
 Y7j6zLCt8hlnrOTkB30+Hh4bJTIjeVeNSdclssh9cz+CYb1GwKNT9HUhJn5k7EZJ
 w5LdfJ1DvqX9IAsdiSqO+EkfkatbpBb9O0qxQdReHuHRLkEjI1TTtJ/LDgG6iw3x
 uSjXtAZZ5v7xYwna1WCmJVNQIStP5FSU60BbGpj7Q/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=o0QZYL
 Wc2DJfF5NxyW7s/sWWeb3sdM3P9zlIU41d1fc=; b=EF1KDrT1QDa64D1eW2tN+A
 kA9JNmvZLB5fEWVVTPMGuSYCoeK6jSu+OVxFYiCaBK/G0Q0dqG1hM3OKqjeOFE1+
 48CNWZnDlpxqiHcnfyGfufTTGoANR/ECCW1faS+HtV35a/W3nA+L03aFEnZ30ojY
 59EXl6ctSD6Gp1P1gZGiOYMMFxIpU0392mR1shQBTfP6Gkd6WWZz/NQlq9mKFv43
 LtWn9cffbT5wwwGbWSB41B1x6c6cuXPVWVQhM7fa5xNHRpQAOLdt/jre1lvrlwZ5
 zM6gHXJoupVuCg1Zc9ivYCdn/JC2glbGqnqhIWM5hzKxIOyU5VM24YRhJAOWwXig
 ==
X-ME-Sender: <xms:2V2YX2_5K9WBK3-CchRoyEeaoF2TK0d2Y9RWuLTFxxNOnvYhJ2cnxw>
 <xme:2V2YX2sKHcLUlsOt3lZfsInJsY9eLwPZy2bpNvXWtRSQWiKrm7sBKzPO_wsTXcP6l
 7CYrN8tND4jAaTHz60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddutdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
 gfevnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2V2YX8DpvRnlY3TiH9fzB4uFGFc551J-6Gq1MEXBcv3LfZ1ZgUb8eQ>
 <xmx:2V2YX-dywtc0Y8xzBZucOCdBDB8ltgGMM6vvIJ4whZYJkiBrkifRtg>
 <xmx:2V2YX7M6PgyHaQQz_cR1qhM3d1R0xWv-kCiu5JzBmSJpkFtfMCawbQ>
 <xmx:2V2YX4mzRNqIzZrwna86uqN1f1PfdEvDyykdfsCEnyFPobpyuch7og>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7B7E93280064;
 Tue, 27 Oct 2020 13:50:17 -0400 (EDT)
Date: Tue, 27 Oct 2020 18:50:16 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v8 03/14] ASoC: sun4i-i2s: Change get_sr() and get_wss()
 to be more explicit
Message-ID: <20201027175016.ffx7lokjbscczvox@gilmour.lan>
References: <20201026185239.379417-1-peron.clem@gmail.com>
 <20201026185239.379417-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n3kf2kspvasr6u7d"
Content-Disposition: inline
In-Reply-To: <20201026185239.379417-4-peron.clem@gmail.com>
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


--n3kf2kspvasr6u7d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 07:52:28PM +0100, Cl=E9ment P=E9ron wrote:
> We are actually using a complex formula to just return a bunch of
> simple values. Also this formula is wrong for sun4i when calling
> get_wss() the function return 4 instead of 3.
>=20
> Replace this with a simpler switch case.
>=20
> Also drop the i2s params which is unused and return a simple int as
> returning an error code could be out of range for an s8 and there is
> no optim to return a s8 here.
>=20
> Fixes: 619c15f7fac9 ("ASoC: sun4i-i2s: Change SR and WSS computation")
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--n3kf2kspvasr6u7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5hd2AAKCRDj7w1vZxhR
xVSBAQDIaorGTe6Rg23npM5DFosGwhRlWf76CAmWy54Djr4NLAD8Cg2M6OPV5jLz
SpZ7bjMKgmFzWBBZXLpQO/+25PAGjwU=
=ej0g
-----END PGP SIGNATURE-----

--n3kf2kspvasr6u7d--
