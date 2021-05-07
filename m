Return-Path: <SRS0=FKDJ=KC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510DDC433ED
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 08:10:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEEE61431
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 08:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEEE61431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59BA81692;
	Fri,  7 May 2021 10:10:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59BA81692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620375053;
	bh=c815wVM/S9O9d+XTlQdv7IX8sgvLbANJa8EBMVzRcGY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cMXmy1MbjD67FdpdNhao/oErixwHfqpo4JpJjiT8DktxVP6iR1eHd3IN7kjEjkFK2
	 YyiOdcZBVToUtCNMRSctxYtQZ8aAJDCWJI62Ib9cZ+BPfUJMeEDoFWjYzZ9F4UQvwh
	 Mv0RnexjJibMfUlUrLgiGb4uM9jSESQhaAp85dA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD2B1F80257;
	Fri,  7 May 2021 10:10:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4EF8F8025F; Fri,  7 May 2021 10:09:59 +0200 (CEST)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7411F80105
 for <alsa-devel@alsa-project.org>; Fri,  7 May 2021 10:09:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7411F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="AC2k3XX/"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Jm75Z1jo"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 41F6058123D;
 Fri,  7 May 2021 04:09:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Fri, 07 May 2021 04:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=W1CZtGGfJPRYLuVe9lYsOpidBYI
 J9lZUWGVXHC3ow7U=; b=AC2k3XX//H84MBeRQqNs8q5xtCxn3+uPKx4tY6/wn3t
 YOjdYSH+avurYGjZJ+R5YL1KkyzlmHDXrFYU7G80gCcC6g8nUEbFazUuhZpw+Hnj
 HNTiYmUZbgzAwYIfLkq2z1B8zfZh1vVfPZBR6Os/C5O+N3u/A29QwlWlAo4XVS7W
 HLM5CS1adsytTjV277ttb2JZQcqNuxwwu89IVVDWqROl6LsyqisUuo+PodZe7NI6
 MX3guHyMP2w35SSVykytK6H44wTpQuPiOCfChdaECthy0XbvwIbLw1XIOU14GP7B
 v/57ldjmIFjDYvfqFm4A7rWMnO5zA8ccuGo/edO0qyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=W1CZtG
 GfJPRYLuVe9lYsOpidBYIJ9lZUWGVXHC3ow7U=; b=Jm75Z1jomnWRHmfILmh/8A
 J/QW11u3AjUI2HWfRknakvz5iKeZ9qqSVftiefND8301nDCQqLnBxp7rtDovQE2p
 XHwfqPF9xYas2JqgU0sR7FuWkU+t1PS0i6qJ1gdkGw026T0bUo1o/FcPreAgpaZ2
 sFYIx3tbbkVlzmvy05pIiZ4ZUA+XivkLBdTTIYUXPLRXF4PIOO7APyWaFv6z7Q+z
 SrkEsxW9smnYUeXHPcWZxvVaAVS7JUYC2stEgg1/FHxg8KiBwq96OW+wMXSR05pU
 uCC8D0uHBzkm4rMkWrqrApTJVxQ9ZcSTRUEtQ2v78Qus++2nIKwLpbDMWn4TCwBQ
 ==
X-ME-Sender: <xms:yPWUYDNI4MxBq0XGSqkSHtzmAoujiluf5SopazEDTZLnUWpwp_zG4w>
 <xme:yPWUYN-rVs0jgH_E43pMgET88_AYW5CWMG79xDFOnmg6r9eiYdGJ0x8T206GmnxXH
 Wy6FF02WmEZ-vn053c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeguddguddvudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
 mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
 htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
 heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:yPWUYCTgRRc8_7QL6LopK3Q1hA3rbO81OMd5tXGHzQIRwiKTEyC4jQ>
 <xmx:yPWUYHszNM4ftu2Yy-9Xp9_P0X_xZhnA-1mGlTq-IBBIF0jitXbgaA>
 <xmx:yPWUYLcxIg5binSnUuaWgIg-0Zf6oNWsvj2tpY1mtcyUtV6w_gyeww>
 <xmx:yvWUYP4oeVQW_PYHXszOJ_cJFfazAiSgWkbhvZkCpXjkDX0c5Zt-Og>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Fri,  7 May 2021 04:09:44 -0400 (EDT)
Date: Fri, 7 May 2021 10:09:42 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 7/7] arm64: dts: allwinner: pinephone: Set audio card
 name
Message-ID: <20210507080942.lxysxdbrviv3ys7m@gilmour>
References: <20210430035859.3487-1-samuel@sholland.org>
 <20210430035859.3487-8-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ihzax2lsrfyfzrwp"
Content-Disposition: inline
In-Reply-To: <20210430035859.3487-8-samuel@sholland.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
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


--ihzax2lsrfyfzrwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 29, 2021 at 10:58:59PM -0500, Samuel Holland wrote:
> From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
>=20
> Add the "PinePhone" name to the sound card: this will make
> upstreaming an ALSA UCM config easier as we can use a unique name.
>=20
> It also avoids an issue where the default card name is truncated.
>=20
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> [Samuel: Split out change, updated commit message]
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index 51cbfdc12936..02712f85f6bd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -433,6 +433,7 @@ &reg_rtc_ldo {
> =20
>  &sound {
>  	status =3D "okay";
> +	simple-audio-card,name =3D "PinePhone";
>  	simple-audio-card,aux-devs =3D <&codec_analog>, <&speaker_amp>;
>  	simple-audio-card,widgets =3D "Microphone", "Headset Microphone",
>  				    "Microphone", "Internal Microphone",

Isn't that reported to the userspace? I'm not sure we can just change it
without breaking it.

Maxime

--ihzax2lsrfyfzrwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYJT1xgAKCRDj7w1vZxhR
xSN6AQD3KXo1qhUktSUrwtB6Jar0ZYG1x/hRV26hfMJERuIbsAD9Fu05Zz34S5pC
FTlOdQdVY1o8ms2ebETiDcmOOEJolww=
=Eg+P
-----END PGP SIGNATURE-----

--ihzax2lsrfyfzrwp--
