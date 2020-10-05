Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D58C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:01:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845BC2078E
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tU3FjrrF";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="aOWrR0E2";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQStkGu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845BC2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9A3617EB;
	Mon,  5 Oct 2020 12:00:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9A3617EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601892063;
	bh=OkalKsYC1I9mUJOEmR1LdjsZfF0kOEsXJzQ043OLR8w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tU3FjrrFudOpA66pARuEnTeTkS0ks0Lwt0wEpiOB9fd0Labrb5ijl/Fyt2Ngbnx9i
	 YBqQrmyBltqLyAJdu9jq5HKBQWYSODJif4r+ZnZ3JVw2RuuUctrOtI8ofOiJp2NZSq
	 Ng5lmqY24lfOeXYxq0WMQ3zD4EINY13jBHL+uM+M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5FF2F80245;
	Mon,  5 Oct 2020 12:00:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DF79F8027B; Mon,  5 Oct 2020 12:00:10 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6255CF8025A
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 12:00:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6255CF8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="aOWrR0E2"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="HQStkGu3"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 0CF915C0151;
 Mon,  5 Oct 2020 06:00:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 05 Oct 2020 06:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=OkalKsYC1I9mUJOEmR1LdjsZfF0
 kOEsXJzQ043OLR8w=; b=aOWrR0E2JdWFTAXJMTjYqd3qiJ4sokh7HisawWITMIh
 dTN2nw7fFEp1DgVKoNDnFvzz8/t+H9pBjy3Ao+RHJEm5+W5tl4fzlqcdG600S6BJ
 iq78oQf9i6RhyTrRNeGLbmvPTRfh6zUsqY7LQFAAZ5P/wvdgRj0sRrUHG5oKJH3a
 DRg8GawAjVRiNFgtuGQ2ZgdKZcToLcOr5lkORI4waUPCuZ4vvfekj1I+HoSll9Dr
 6ETjClPq0p5ByfuWWiuYKoafpYFDKjIy9/8hQXYfAmh+EcLfbgtHZgeMZXUkuUNe
 ZVg7JWvsmL/UhO2yKEDsoYQtmW8HFl/nZCb+frx0HTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OkalKs
 YC1I9mUJOEmR1LdjsZfF0kOEsXJzQ043OLR8w=; b=HQStkGu3GyQU7LdDHZxUIQ
 0vGsH4uiwJZBov6bkh+M/BV/O5jA5192wb4wfPPj60N9l+2ECjU7Ka7BOHytmu2x
 yM/PqGfciCI92E5+PSzocrVDjUK0W+Qo4FR784AeCDSBwVlSs5BcN9VkgeQSgRsE
 SzRaO+NHMopPDWCjwUM26YpY7vtCGIxXu1HoT1t0//96s2Fpw80FwtDFChBzuNit
 B3uabfDQfiGcHCa128zg0N9D3fZ76B7iokU3rKLf6DTSZjzxqGNhoqqwpnDEVtWI
 sU7pLtPd2Zys8UkDk9WY1SWlfhhkswvh3j03NhDQJ6MfCxubgJuy2M9KjnGXDj1w
 ==
X-ME-Sender: <xms:pe56XxR7J0bC7puamwq2anIrCJmPkC7eC_1DVN6M2UaVQ-JRBPmhJQ>
 <xme:pe56X6x7yW0RxhLMz2SgIPc9Zvisd8LPjvJaWvCiofVdVyiUOQAwCcDAxKQANExp7
 fDI1398_CqrouEb9jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgddvgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pe56X22I1uViTGolferX0dYuWtOf7PsCC89SYk9akwswfFQdtpfr_g>
 <xmx:pe56X5BwSSqo3L2yBg2FR9ivre5PVGJ-uOTL4jHz8DchmP7tpwZ46Q>
 <xmx:pe56X6gRat1W3FotzUNHM8-lSfeNCdi1hj0K_4fhKfJf7LbTb7szCQ>
 <xmx:pe56X-hIee_jIVdY3JM299PvZFuNTLOIAealkm2wTeAE2rNmJic4qQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5D8F7328006B;
 Mon,  5 Oct 2020 06:00:05 -0400 (EDT)
Date: Mon, 5 Oct 2020 12:00:03 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 07/25] ASoC: sun8i-codec: Enable AIF mono/stereo control
Message-ID: <20201005100003.5vm5fyia6z7jy6vy@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-8-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6tyumugaboxyzjvd"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-8-samuel@sholland.org>
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


--6tyumugaboxyzjvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:30PM -0500, Samuel Holland wrote:
> Each left/right pair of AIF input/output channels can be swapped or
> combined. This is useful for sending a mono audio source to both sides
> of a stereo sink, or for creating complex mixing scenarios.
>=20
> Add the support to control this feature from userspace.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--6tyumugaboxyzjvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3ruowAKCRDj7w1vZxhR
xRoGAQCImF6eXM/9UsszE1OYSxKKguMMBJ9/viLyw1jmI622yQD/RbZlnXWV2O6p
uhmk8NRYSjZ2PQV2vhNRHLbAU208wgw=
=6tYn
-----END PGP SIGNATURE-----

--6tyumugaboxyzjvd--
