Return-Path: <SRS0=A1sP=CN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDCBC43461
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:19:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1B920748
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iNLPdrPE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="XM/22yqT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R3TN3552"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1B920748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FBAF1AF1;
	Fri,  4 Sep 2020 11:18:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FBAF1AF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599211172;
	bh=ZNvaM+CYXdQnUp+vb+XfGuigeWUmn2LideIG2s/TfsQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iNLPdrPERVIJ2sVSayIiqJnBBJwpddYGJqfsXJJukkZQDTfqgvBvn1mAklpzQ0LA+
	 VWtt7rWAC2DIDLYWZtI+8XvJuSY8G+1ODtYAop/DSOkk1IYNpb326pSoGS41sdqkuW
	 3WkJ5nVrRmJpZOJLXiNfB8UcXcNLvmUKUDsH40lo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4232BF8025E;
	Fri,  4 Sep 2020 11:18:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48362F80268; Fri,  4 Sep 2020 11:18:03 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04746F801DA
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2020 11:17:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04746F801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="XM/22yqT"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="R3TN3552"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 88B625C00C0;
 Fri,  4 Sep 2020 05:17:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 04 Sep 2020 05:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=ZNvaM+CYXdQnUp+vb+XfGuigeWU
 mn2LideIG2s/TfsQ=; b=XM/22yqT5YHx6nsTiSiJVpKkcQQrCq9yoLbKDfGa2ls
 +7tgnULhUOJ08NBr5zw0Lnvx7IZ9CWQz4f5u6siv9xE7O6c3hbp8yUFGk46wHqww
 eE3gof/nqwK+krzu2Zp20QsCovUih1ukyaq1BGeD44OdC+fhV1ypYt2oEOr1sJnk
 c9wKRuyUs9Us8JBdjSJh13KBpZ2OyhxeD1q4q29jB8BH5oiLCEnQnNCkoXaNF7Fu
 xz0Pi/xUu5qRJBlA1xOsKRANaZRNmvPbt6jNF7bbkn/jyK5LlI6qnBGPxvShPqx5
 JWnUQwc4ABgksacSPVczllBDWJo0C6ceoH83erjQ8JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZNvaM+
 CYXdQnUp+vb+XfGuigeWUmn2LideIG2s/TfsQ=; b=R3TN3552rTIDUjWDQEtrA1
 6C441UyqEyXzY1TTZdOXf0S1wdpPlgvpx38/aeXCbCjfb6bDzIg04F2GXhs/4nIh
 mm8HLoefzj/jtru+CmQF0acWJ0woxECP9lKxOdT7iqX26132US/d55G4kjZTC/AM
 YJR27mHzYEd4znvgZfpcWfG4pe1UBW2aOFAtu4i01nlOIXk0n8JYyNTbW7D+lL8C
 aDvG+wbh7b40rLCNMh5JqHLOR7vCqmEVXUh9bUu5pv/AneKD2uwj4Dr1plK/FPA9
 npFEF07k7hP16H+Vd4m6YAswBFv3aamKdwzf3ozthR6jHtHD7eo1+Oidi8gJdZGg
 ==
X-ME-Sender: <xms:QwZSXwXr-iG4hRIl6KnmAOdFUkOLv6Mfl8zWFV-AHQk44R7Z2vm7fw>
 <xme:QwZSX0mrji0avk4tIZxgfX-vDfx6ZPuizeRcvNrFoBud4NQ2st8No1FOc5ztVVVDA
 VmfpCoxQOshtsNS1Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegfedgudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
 gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QwZSX0bcTsDWpHmMMBlj_tA-w-C0djTvlXpXTQ2UmSgfXk9h7QHSLg>
 <xmx:QwZSX_UZ5sSSxy5rPFnUeG3DECeOGVZiUzWTtUNixbNvp3KB2b_krw>
 <xmx:QwZSX6nvajHCf5rMMSAr8ro6akeUpT1iRhyVevSnFv-1oRb_-bY8SQ>
 <xmx:QwZSX8WZDZ5k8q7EJemiVGe1zIevU7cLizMNXTC_KQHLewrzdXrREQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 27D203060057;
 Fri,  4 Sep 2020 05:17:55 -0400 (EDT)
Date: Fri, 4 Sep 2020 11:17:54 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 9/9] ASoC: sun8i-codec: Manage module clock via DAPM
Message-ID: <20200904091754.gqwtj6hjhgrrbudv@gilmour.lan>
References: <20200831034852.18841-1-samuel@sholland.org>
 <20200831034852.18841-10-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="etloxsebhaa6d7ke"
Content-Disposition: inline
In-Reply-To: <20200831034852.18841-10-samuel@sholland.org>
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


--etloxsebhaa6d7ke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 30, 2020 at 10:48:52PM -0500, Samuel Holland wrote:
> By representing the module clock as a DAPM widget, we ensure that the
> clock is only enabled when the module is actually in use, without
> additional code in runtime PM hooks.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--etloxsebhaa6d7ke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1IGQgAKCRDj7w1vZxhR
xZxKAQCD/2/1W2VmcevYTA04jhWila6rZ5bVzofOrsZMYXDQHwD/S/ajB67MRi9V
3WWmvc+1ekhwHjWMEwfNhM2J2VtZ1As=
=gijx
-----END PGP SIGNATURE-----

--etloxsebhaa6d7ke--
