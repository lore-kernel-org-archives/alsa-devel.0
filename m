Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1653C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:56:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E930320644
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kE7mnj8X";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="OJMX7z0T";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cHoI2gDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E930320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 384C417FB;
	Mon,  5 Oct 2020 11:55:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 384C417FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601891789;
	bh=ODmJmm1tBDFFN0m1eB2lf8tcUekrn2Iz7wKdI9sz+ZM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kE7mnj8X4/aovbUtcOfaQQNTCVBzJln0bUSbV5oz9wN8rwr0wiF9VzbcatKJVOFJB
	 OCa3ZbEseQy1OQ63G3P0bjuImVH0m9JHKc1L2BnIGrZOPU+CUrzVHVr+HRKgpGLlnH
	 0l9ujLDDGJhNOmY6oaoM1va6XvPy9zVT2mAP/pkg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96B68F802DC;
	Mon,  5 Oct 2020 11:55:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FA7DF802DF; Mon,  5 Oct 2020 11:55:08 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5380F80245
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 11:55:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5380F80245
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="OJMX7z0T"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="cHoI2gDa"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id D72965C00E3;
 Mon,  5 Oct 2020 05:55:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 05 Oct 2020 05:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=ODmJmm1tBDFFN0m1eB2lf8tcUek
 rn2Iz7wKdI9sz+ZM=; b=OJMX7z0TQznbV3q9qUPjLKDR6g+cv9h7YMdggvv2RCo
 cuFWII9NdVJReWgrPmE7V2I80Lbn/Ov40PcrpUftYsOE6ofzxZRqwepl6c5FMmvh
 7I27m8hAL1t7K3yo5y2wq1/R4DBHc9Ln0tIGyNhIST8BvbLldqitw/t20BDNNaW+
 Nwh0lo5EvUK2KybPxdPiy5S7vl2v+PI/tRgGoXnfAjjO3c6K7Lq6K7PVRvsmMgt6
 s57X5ezKKfOgrW3MbCX3nrH7kZhWDpPZuWwTbdKDODoVCHmoLQBqgXK4zJ3nPXh0
 g1vd/4Ucz+59VLc94VDo4NkVRx+qsIvh/mm0erZ7SXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ODmJmm
 1tBDFFN0m1eB2lf8tcUekrn2Iz7wKdI9sz+ZM=; b=cHoI2gDazxvJJ/6OLoRFlo
 kiqcKP37eb7gdSVPMo11Bpk+HIHUUJqgnOWO/rK7mwL2RGvxQ38X/48hZiw8yVkz
 L+3M/AgvokAAUTxz3aGkhLxZcWw4dw3+0q8nAtldm+MuaTAMdhs9FVxZwFjMvnxA
 Agx0sdcUAJECwNCONCjvp5haFqa9c4uS5ZvhmE1RSR/fmpITjLuGnmBxxbD7VJdf
 LEHJPDBAzl49ZzCtFdADWFWjYp5Cj2KriUV2i4so2dDeiaFzg9X1jRwgfDq29X51
 JcuCzFGbwn0ANeb3+DePZB58LilWL46WgNkz4X2R4q/RzpGDU5ASqLKh0oAxeLIA
 ==
X-ME-Sender: <xms:dO16X7vI8WMyNkPp-vtfNBmLvrpX_oe5MQyOUxWUwOBP686au82zlw>
 <xme:dO16X8eVpEbMa3AQ7O0GoVe6_B4CvnzCarhhfVDtm6q1VWCVRg10iFm_Ibg1z4KWw
 T_tMbue69BAlYWXmBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgddvfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:dO16X-zneI9aR6jNg6XZXuosIVtPk4WO-0CCdJBcMKDNddhRUC8EMw>
 <xmx:dO16X6MzTHHIsr__MIuZpZAqmE_WE_9hNWdMQqrdzP4S4z1A5OzjUA>
 <xmx:dO16X78yXuQ026RwACjNtzqXgss0iJLWZMXEW8ybE7gy7ORo2TxsQQ>
 <xmx:dO16X8Mfi6nIO-KEAFVJuyGU8a-9_lafIx9OyJawK_Z-66giWSZrNA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5D1FD328005E;
 Mon,  5 Oct 2020 05:55:00 -0400 (EDT)
Date: Mon, 5 Oct 2020 11:54:59 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 03/25] ASoC: sun8i-codec: Sort DAPM controls, widgets,
 and routes
Message-ID: <20201005095459.qnsyyitpizpdgs57@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kucdcmwacaveldse"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-4-samuel@sholland.org>
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


--kucdcmwacaveldse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:26PM -0500, Samuel Holland wrote:
> Sort the remaining pieces of the DAPM driver so that they are all in the
> same order among controls/widgets/routes, and so they roughly match the
> register word and bit order of the hardware. This nicely separates the
> AIF-related widgets from the ADC/DAC widgets, which allows the AIF
> widgets to stay in a logical order as more AIFs are added to the driver.
>=20
> No widgets are renamed, to ease verification that this commit makes no
> functional change.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--kucdcmwacaveldse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3rtcwAKCRDj7w1vZxhR
xQdoAP9wDU5Pd9TTgeSgwBIK8Vwl4iYgXMJ4L+uonDPB0gHNygD/R6COTvszRw6v
15hl7dBWlNQadtMZNespBQciQHOdQwc=
=2dEz
-----END PGP SIGNATURE-----

--kucdcmwacaveldse--
