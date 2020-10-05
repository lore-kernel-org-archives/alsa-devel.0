Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A95C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:00:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9D920776
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mQfsJxeM";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="nBJWnvAo";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VbgmYZDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9D920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE9F317EE;
	Mon,  5 Oct 2020 13:59:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE9F317EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601899235;
	bh=Q897tT8ubWR5jUvQHUMctBSuXaQszl7lev1kFoxWyhQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mQfsJxeMtZTth7Pi3CE6cQKgHmiRhbob4WP8eGkz8g1Vfh4VYAcOvB9w8+pYdOLhp
	 K3s7TJRbgdFV9GRYHIVX/kyfuM/ZbgRmkTU/m1Iug5yCPzs3j3dI5FnhSklXIwJhAV
	 mWkT2pBRcz8gB3upjiUi1g/TaDuRsgw7PXNx5uI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3618BF8025A;
	Mon,  5 Oct 2020 13:59:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A93A2F80269; Mon,  5 Oct 2020 13:59:43 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 886C3F80121
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 13:59:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 886C3F80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="nBJWnvAo"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="VbgmYZDe"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 75EEF5C016C;
 Mon,  5 Oct 2020 07:59:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Mon, 05 Oct 2020 07:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=Q897tT8ubWR5jUvQHUMctBSuXaQ
 szl7lev1kFoxWyhQ=; b=nBJWnvAoK//RQnwLHXVaamj0TZD9axahq1PvmX5oHKr
 M36gVJsCWqz41mlvuiyrdahIa6RIFu+rjqnS6Q4IeOuxJ9YSWT1LFtJvy1oJzVXC
 4TQlUB5coV3gndmt1zAyPiy4mnhyyLhtmNLEevKcBtJLxDaKfxtOnrcTBPuMbTwG
 53DnvBE13EsTHpDdiyYGQ3fqc8u/iVG2p++1T8Ebq0joiltou73sV+occKfYNWtS
 p/1ChINJUiGupAN+Ok7heLIARXM6p7Lju2Hors3NB/q+m0SYDwSpk7zHbyaPUrkc
 g1lwZjBF/SMump/EdW64S3WsOPDocsy9AAic1RkJf+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Q897tT
 8ubWR5jUvQHUMctBSuXaQszl7lev1kFoxWyhQ=; b=VbgmYZDeg7gS6JS4KpsvwT
 wPGqZio8PmRNgsW1zCx2NfX4lK3GIw0IQBIHvPpHlWN52Ts50XOs+Xkdf94QUVXT
 cmoRVVCyQWA5LG4dZkfHSeJuhq8YOHfMlP0CTCr4bO2D7VN7s268A7jQ0Tz9PZyo
 Rt4pAZh7Xv1mA5I4nZXTsXeIIpQJCusZFAd9mJZbGCDbedWjQRtcxcPzmV0bF60w
 9YmaAD4s3lN0SSDlf9UVCUD5Z6VMEY7TzdrF1wy+x6k1nIjJ37DB0IV1h3u3pfUq
 mFz9HighppAr+gC6d10h9eI6mcjKfRipdclX7cdVccyBErqPThF1L16z9SOkVhzQ
 ==
X-ME-Sender: <xms:qAp7X7qvBgwkEkBzGgVCocJ4wXxLqun9B-Xz4I0_vS6Ger5FJauK_Q>
 <xme:qAp7X1oKKLSNKuejN2ppXJWs1t3XzgQGwCOooQG5QoBTMwwFxFONnNAdQYQF0xYDd
 od0-8kX7x68psTytv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdeglecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:qAp7X4OcsTxnXkJ_gzAGsMXQdtRt1DJnL9z_hZX9Yz4ILOK2KvLcog>
 <xmx:qAp7X-7B5JETdLWROqkH20YfQNtdsAMp0DbWK5cUZjI6x0LtMBXYXA>
 <xmx:qAp7X64qTgzGUFCZG58FkLzn5LUSS21LTjyg7Sda5VfE3vVsTwIBSA>
 <xmx:qAp7XxbfcHH6sNNMZuSMnuEZGqNdulTb9aQIW544eq2QD-4nW9muiw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id EB4433064610;
 Mon,  5 Oct 2020 07:59:35 -0400 (EDT)
Date: Mon, 5 Oct 2020 13:59:34 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 19/25] ASoC: sun8i-codec: Constrain to compatible sample
 rates
Message-ID: <20201005115934.srtcf5f74kfc4rol@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-20-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="svg53ayom7l4t3od"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-20-samuel@sholland.org>
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


--svg53ayom7l4t3od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:42PM -0500, Samuel Holland wrote:
> While another stream is active, only allow userspace to use sample rates
> that are compatible with the current SYSCLK frequency. This ensures the
> actual sample rate will always match what is given in hw_params.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--svg53ayom7l4t3od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sKpgAKCRDj7w1vZxhR
xd9pAQC/j8ToJOZuhDga2Xzm9h4rkaQuXqqemTxlrn3E4pb0LQEAreN/HZlgti9b
CM2uL2AYaJty/gHyCrfWkzutUz57CQI=
=CK7x
-----END PGP SIGNATURE-----

--svg53ayom7l4t3od--
