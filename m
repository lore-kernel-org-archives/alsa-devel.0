Return-Path: <SRS0=jEei=6M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FF9C83000
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:01:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BBD206A1
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GPL8wzWU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="f65ebsSB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N5AWIvge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BBD206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 063961683;
	Tue, 28 Apr 2020 10:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 063961683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588060882;
	bh=u4sl3gbuBEV6uT+8FENxUo76FNkmoXZRMoKDeC9YjYI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GPL8wzWUpdCnjdLVYruZxtGNmZuadk0oBL0gnDe6vsjY+MCobiHhgVKrepkk6xok1
	 v7auXRlISNqa19zDwIon7o6nCI7Dzj86NfHeR/6/WP4FOxjxHX1cEN6rhW0g1r9SN8
	 9rNJ5gKu/FHHg2giQ9eATuYXVsD3opZ7bNVmBvow=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91772F80136;
	Tue, 28 Apr 2020 10:00:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E5E5F801DB; Tue, 28 Apr 2020 10:00:29 +0200 (CEST)
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BFE0F800B8
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2020 10:00:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BFE0F800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="f65ebsSB"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="N5AWIvge"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 7D59D580305;
 Tue, 28 Apr 2020 04:00:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 28 Apr 2020 04:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=QKnGsgk4OM0TOmaItjELfauJeFA
 9d1+f5+xcE296M/w=; b=f65ebsSBuYtNvUzQD1D/EKKPdF7I4mR18U6NcIicujK
 7pEHbeW6Z2u7Nd3WjPH0wKdMKrxF9yGtt1XDFHslN2xjlIN1SCW1RZXcNBRRsYJ0
 /ADAwcNpeD6+9UrVgkigOCh8U+D+AqDX+zMSbqkk6mOOu8KAl2CU6FMFQJiy/c+n
 bV6SILCzbPXecC2aEOp26y+jc4aP+BOT4A9jW/6fOeZOYkRKs4C1Lj3UQp/DOl1q
 x2SvazWn1pjzTPdzifW3dJZqafVrhcvaFGMLb3cDjSmHprH3w+dmtVlf6GlvFEmY
 oj0IGlqXzHIjhRTD0RQRMBW52VMg7+//cRqK1UXZGxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QKnGsg
 k4OM0TOmaItjELfauJeFA9d1+f5+xcE296M/w=; b=N5AWIvge0CixkUA4JOg+0U
 Rnm7noh+st93ixLYq4lhVEZbD1Mpl4JTEs+sTfeeXPO6SY56E8RDbc5+XW1BPWXJ
 mVyHrbVJKJ+9qA0B25xCfT8kSBCc55ZmtLBs1WMaUYim0BKGFYvbmxF/Ta948plH
 Lv5Uql0NWvS11Q3fHkzbSJsM8tW9VWe2PJD6bFTJ63XwvFpNwcIzFraPxTaOFl0l
 4n1OgHAAqebDzTR9hDKAYFnRd4+OOhATKKVOf2zuwk9L67eZ3prOyTMRGSvleStF
 1hIcKoO6M+R9FpizMYfNp7ys0A3F5Yqe2VCLWIFn0iebka1ItnxmmFCGbjMW1YaQ
 ==
X-ME-Sender: <xms:l-KnXoyUO1XN3ffF3xnEd7HHPe9yeZ-OseJDr6mNtoWWa4rZUvI86w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedtgdduvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
 drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:l-KnXs91k7lnVuYQAjLtdkPJbsBG34LFPAAjrncgcT2VBJdn9R5YzQ>
 <xmx:l-KnXoj3KeSihdw2k43jvBVlm_suW6AOgfhOab1MBXCk6DuJqe2WjA>
 <xmx:l-KnXrH0700yoQE9hAaubCUwvDeHNBVTurPnVUmxtUNiKO_2OR4pZw>
 <xmx:mOKnXrmGsRPT5O5irMYC50hvK-Nu-adIK3BIFGBZzmENBTRnRczDGw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3BE253065E8D;
 Tue, 28 Apr 2020 04:00:21 -0400 (EDT)
Date: Tue, 28 Apr 2020 10:00:20 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH 4/7] arm64: dts: allwinner: a64: Add HDMI audio
Message-ID: <20200428080020.35qcuylwq2ylmubu@gilmour.lan>
References: <20200426120442.11560-1-peron.clem@gmail.com>
 <20200426120442.11560-5-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l7t7g67wc3rnzd33"
Content-Disposition: inline
In-Reply-To: <20200426120442.11560-5-peron.clem@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
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


--l7t7g67wc3rnzd33
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2020 at 02:04:39PM +0200, Cl=E9ment P=E9ron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> Add a simple-soundcard to link audio between HDMI and I2S.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index e56e1e3d4b73..08ab6b5e72a5 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -102,6 +102,25 @@
>  		status =3D "disabled";
>  	};
> =20
> +	hdmi_sound: hdmi-sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,name =3D "allwinner,hdmi";

I'm not sure what the usual card name should be like though. I would assume=
 that
this should be something specific enough so that you're able to differentia=
te
between boards / SoC so that the userspace can choose a different configura=
tion
based on it?

If so, it's really too generic.

Maxime

--l7t7g67wc3rnzd33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqfilAAKCRDj7w1vZxhR
xUrBAQCbumUlWsmdgdc+kpR+FkqE+YcGoZOrfRXqGiqZpskC0gD/Xu0cJh7MGRSA
crG2mlpqdCmsMDhoXZAU05/rhM98oQA=
=Yq8j
-----END PGP SIGNATURE-----

--l7t7g67wc3rnzd33--
