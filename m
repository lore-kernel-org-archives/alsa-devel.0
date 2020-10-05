Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEFDC4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:40:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7A7206C3
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sCzk+ZqP";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="i3UXj9Sh";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IuFQG2uC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7A7206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 480DB17A8;
	Mon,  5 Oct 2020 13:39:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 480DB17A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601898011;
	bh=weqS5lxewny8DqfssrSq/R//xlr2DLh+OVQqRJJwUMM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sCzk+ZqPmacrpRh9K1RZEcHozNR44cJivYk6ReRFbGQDcbA06ej3BXKuPbAuXsDHm
	 pcHByBxhnFg41rDkAoQtE6Kk3fZCs3bG2ACHbM59YvDwV0R1Di2aRFm1o6FFKqBE99
	 7cQgvNCgdaUtdyV6P7GE7Uh4DL8oFVM+x1ZJQ7q4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1040F80245;
	Mon,  5 Oct 2020 13:39:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC756F8025A; Mon,  5 Oct 2020 13:39:19 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25682F80245
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 13:39:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25682F80245
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="i3UXj9Sh"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="IuFQG2uC"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 088575C012C;
 Mon,  5 Oct 2020 07:39:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 05 Oct 2020 07:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=weqS5lxewny8DqfssrSq/R//xlr
 2DLh+OVQqRJJwUMM=; b=i3UXj9Shf04SVVIgvF4ndbKiFjxyZtuvSJ9LL+jVmyZ
 5NZHMN7sP2nafb5nN/8y8G0Z+fK1vjWLAR+/yyQq4SyxnLAlTzLpQwCktwXFuk7j
 Arynh05DXHQq8NiN0t+u8wS7CuAvzcboqRrM3CwUsk1Z5u8gfHuhNmLEaKaPm0b0
 ENcEmWQGTz8auDKd9l4cae5rVGo5S9yOprPUhHsrn0iUHa1/c7OCuStSpujpfaQ2
 xy5zdyh61lz25h0sP8QQ4LQqDFI2hd9/p7w3opnIqLzZjUNfqe9jftSW8qNCku3q
 1XLD1ayEKhbRYTv43d09O6tkQ1Xc+CQxKdrltg/RdBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=weqS5l
 xewny8DqfssrSq/R//xlr2DLh+OVQqRJJwUMM=; b=IuFQG2uCrMsNf+8fC31lym
 J4EkA+Szk1UoREKqRaCgN8jev3gVdnymuRDgH8D2+scwE4LClDRrtt9bi0/9YiDo
 a6oxLeFNaF8qs2aBX8+0y+aUKNfVuvtY+49QXKGvclCQNvMhDyg0CuwKXQwFOz+c
 cG41V5di1mmRTQpNS2JQ+9zC9KYgco1OSR8R8YdsJLXRmCPmPNIIG1rrAioZKUQB
 G76AFleLKkzszl0LmyW3YmLYJzmuiCHBgHh7XV/+V/ID7i9joRGRUWbvtc8ZGI5V
 Eu02ZyevjmHcrk2QIDoDNZm7EnHvxpWiYJyIrN3vc8QPeYeyc4Pe9BviOjnihMMQ
 ==
X-ME-Sender: <xms:3QV7X9uJ0dR8m_KQeNZi0Dopy5TfXUZEjXHOngLEZ4dOrmVJZxHVKw>
 <xme:3QV7X2eQ7CbjQCmKOxrFlNEfTmdoeLCKnar8L62oXG41Y6qu56Unc8zBZqT_B40L8
 DGDFdBR4BdApvRnCMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdeghecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:3QV7XwxeyoS4B_9AfxUaJ5QMMLzsla3SE4M3TaE0pEO-yy_F0bN4DA>
 <xmx:3QV7X0M_nLo-ZYJr80aX7-r5oEf54SQb0fkOJaxGf-yaCKoDxjEAhA>
 <xmx:3QV7X9_lZH17x7tsZ2a_ojOzHImMhuKcdq1ukgbEAbzZE4XCyHaW_Q>
 <xmx:3wV7X2MCR7zk6tt-xOJl158tCqFGmy8MolyxbXW3F6mxzV_VP8uZVw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 35BE33280059;
 Mon,  5 Oct 2020 07:39:09 -0400 (EDT)
Date: Mon, 5 Oct 2020 13:39:07 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 16/25] ASoC: sun8i-codec: Enforce symmetric DAI parameters
Message-ID: <20201005113907.tov27ifqon6s3eje@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-17-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fpdfnc3qlyjpag2x"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-17-samuel@sholland.org>
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


--fpdfnc3qlyjpag2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:39PM -0500, Samuel Holland wrote:
> The AIFs have a single register controlling DAI parameters in both
> directions, including BCLK/LRCK divisor word size. The DAIs produce only
> noise or silence if any of these parameters is wrong. Therefore, we need
> to enforce symmetry for these parameters, so starting a new substream
> will not break an existing substream.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--fpdfnc3qlyjpag2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sF2wAKCRDj7w1vZxhR
xetcAP0ZMIQdr14FfISHa24wiVN1sZD7ZEmNUIsZQrFp+AeP8wEAqZdUkpXypixX
AVbOASy2ODp2UNkAFDT/jG/pABr1fwg=
=x+Qh
-----END PGP SIGNATURE-----

--fpdfnc3qlyjpag2x--
