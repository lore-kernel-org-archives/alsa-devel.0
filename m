Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FC1C4727D
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:59:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4867B2080C
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PjuDLzWz";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="GsQPiz2E";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AyG1grSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4867B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD23A17BE;
	Mon,  5 Oct 2020 13:58:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD23A17BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601899181;
	bh=frq4zfoblNrqad94dFzpjgZn6J0EzlaMR/5+2/jQDiA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PjuDLzWzgTIqHynVKwIBD6y8Zvm0tZcb7lL5BmYG0ygMxUd6yA1HjEI6MDiUpeaDq
	 3Bua/IRAACJVG1ERqt/sZ0uLHrUQHTNw5G8Bu6Hniabdul7de8lw5ntSsmc5O+j2JW
	 7vho7TQblfZh3cJ6jS4ywX7UjtqTXIG6eJR8uog8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F867F80245;
	Mon,  5 Oct 2020 13:58:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33323F8025A; Mon,  5 Oct 2020 13:58:49 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BE50F80121
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 13:58:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BE50F80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="GsQPiz2E"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="AyG1grSn"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id F34275C014F;
 Mon,  5 Oct 2020 07:58:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 05 Oct 2020 07:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=V+uFLpYx6nAJ77NtMIURoXi08Dk
 JIviDPy8V3YFs/48=; b=GsQPiz2EP1RQzggToSL7NKobinp/Dt6NFTRqoxgslnR
 Cltip6fehazqBaSRys5Kh04rpgqFS4VwQgGJhKvf4GYENAg7uxqcT0ssLzuyKB2G
 mRFEGnhgntV/dC7NjXryOBSPXJ6IA3IWrYZOA0cRrOSC3tPiiyc9R8L0f3KZLOXT
 dm0NZK/Ms4it0ALmy8W1alP+qDu5qTHBs7ytyQusbhJjpYjXULkjhzsIppsx0D+2
 +kjNImC6qV1AjLqpuojoa4GyPovzgbGetc2i7TxouI+P77vGMj6lmtCSz3hBdL+B
 EvDzwPm3mU4Sw2vUJWOevpBCdfnyk9sJ0AY+x/R3xIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=V+uFLp
 Yx6nAJ77NtMIURoXi08DkJIviDPy8V3YFs/48=; b=AyG1grSnD2XqOl/+zr5CT+
 hzS9FiwlafJLnxkWslEwQolWUs64bWn110ZvMlXTBTWS2AqVkIY2nAh/VHNgX3FM
 Baxqs+XnYq1OsQLdhHu8CHe8O/hqLz8khtrGjebQqJBXhSmbgmqjEZabNGua/ql2
 Y9/E9rcSQTZ3tIDksYfDNBfGCjDWeXXVxxFnHyZcUNfokvlI96gn3jN37pBZATTg
 kIdz+reiVyP0ZcqXE7tUgNQCe5MADkIco44mhGg2VJ2cfNZhCF1XQlyP9vXXYQG7
 dX7QFvi+KYrL/z2XvK8mKk+J6SR0X8zzsOIGKtEZDLAeUNRKI/HmHIp2w+27pDTg
 ==
X-ME-Sender: <xms:awp7X23BvW1NQ2T8iGLWhiZWhuW_-JUBA5s0k6oiPEAN_K7qAsH2jw>
 <xme:awp7X5FlBVQooTLQ1W5osFj07s0K6U9ouXTRIJ4Gg9YXrK75xBglo5i0Z_JIQMxic
 s-Qbfkcr4j-Aq3xdwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdeglecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:awp7X-7cmPZMeiIMSE9Y_ylFHf1v6m_Kqk72htreqg-HAJL0_Fz5Kg>
 <xmx:awp7X31R36lxIlOn169o0muJuEHYDlDa9tDh2_Hfc4-jpgcJjzPweA>
 <xmx:awp7X5HEy7jA-S5GKmMWWYdGlDbVXk2WcSOrinLiws0_YLRdwPokrA>
 <xmx:bAp7Xw12R7jpSf3o02erwvx1rsDaZA1ERVauwo0c0Uq9wOJMmhCXCw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0F1573280059;
 Mon,  5 Oct 2020 07:58:34 -0400 (EDT)
Date: Mon, 5 Oct 2020 13:58:33 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 18/25] ASoC: sun8i-codec: Automatically set the system
 sample rate
Message-ID: <20201005115833.rbs3bujsofkznpik@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-19-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="75xucdkd6m3f3jlz"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-19-samuel@sholland.org>
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


--75xucdkd6m3f3jlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:41PM -0500, Samuel Holland wrote:
> The sun8i codec has three clock/sample rate domains:
>  - The AIF1 domain, with a sample rate equal to AIF1 LRCK
>  - The AIF2 domain, with a sample rate equal to AIF2 LRCK
>  - The SYSCLK domain, containing the ADC, DAC, and effects (AGC/DRC),
>    with a sample rate given by a divisor from SYSCLK. The divisor is
>    controlled by the AIF1_FS or AIF2_FS field in SYS_SR_CTRL, depending
>    on if SYSCLK's source is AIF1CLK or AIF2CLK, respectively. The exact
>    sample rate depends on if SYSCLK is running at 22.6 MHz or 24.6 MHz.
>=20
> When an AIF (currently only AIF1) is active, the ADC and DAC should run
> at that sample rate to avoid artifacting. Sample rate conversion is only
> available when multiple AIFs are active and are routed to each other;
> this means the sample rate conversion hardware usually cannot be used.
>=20
> Only attach the event hook to the channel 0 AIF widgets, since we only
> need one event when a DAI stream starts or stops. Channel 0 is always
> brought up with a DAI stream, regardless of the number of channels in
> the stream.
>=20
> The ADC and DAC (along with their effects blocks) can be used even if
> no AIFs are in use. In that case, we should select an appropriate sample
> rate divisor, instead of keeping the last-used AIF sample rate.
> 44.1/48 kHz was chosen to balance audio quality and power consumption.
>=20
> Since the sample rate is tied to active AIF paths, disabling pmdown_time
> allows switching to the optimal sample rate immediately, instead of
> after a 5 second delay.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--75xucdkd6m3f3jlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sKaQAKCRDj7w1vZxhR
xcMoAP0VnmnL+YZV1XZJZnqzg/CJMusgUc589nBY+ScRNBMUdAD9GgC2Pkd19b5N
8Utf9wLt408n2EvTGP5C5TigjVif2wU=
=nbq2
-----END PGP SIGNATURE-----

--75xucdkd6m3f3jlz--
