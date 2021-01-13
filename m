Return-Path: <SRS0=Rjjp=GQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FDDC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 08:49:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9E623139
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 08:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9E623139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9435516C9;
	Wed, 13 Jan 2021 09:48:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9435516C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610527770;
	bh=bVJT/Q8IBEuVeFQlj2dlnwHwIZl116udo6yzVQtdFgk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y5MWdqZL4L73x6CEIR/ySjdYlcnTgT/75AU19vwSUZWFBw1w/aKUcJ7QvJcZrFOqj
	 46Pce6PbL5MBqcyZ1lx0KFSE6v/HKWX9AKaYy7C/rNL+mqUxmzfD3bI52PaToH+HAB
	 4BExynU0kRxCgDh2Zsw033sRbqANANae/oEQyDvc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D341F8016D;
	Wed, 13 Jan 2021 09:48:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A630AF801ED; Wed, 13 Jan 2021 09:48:37 +0100 (CET)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C329AF8014D
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2021 09:48:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C329AF8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="L7YQ88jS"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="mXEHiI89"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 4A8AC5C03A6;
 Wed, 13 Jan 2021 03:48:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 13 Jan 2021 03:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=54FC/UrhpoPn3dwBbob71WsFOF+
 RG/zilAC6ndIFeJ4=; b=L7YQ88jSPHsL/s4rPZKDqgzSM2gfSRsNNuTWy7XXlhd
 9EjF22n8DAhKKOdM3fnWSOAEhZVSqHuDUwJzDQKJT3iGw/DnkZlIL2rVRqJvDM4i
 wdaHhfN/WFBrIV092d+NbPR/qVNm4udMSQX+O5VT+h+hVpPraXE/Gmi5er1fMOEb
 +FtJfoRR+oOtGjpNt9PN9qxjpBhuW2lPM+ufD9F8YLbUoOZlDD83mF7y33IhOOw7
 AKJJ8UOBGCTdLTuYYpAEJSaP+hNtqloCfZqrJFuUWHsyZD1A+pig8NxhrDtrSmSP
 UpOj+pj4Zaf/74DJZ/sW8U5M4lLdlqEfK5nBhAscovA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=54FC/U
 rhpoPn3dwBbob71WsFOF+RG/zilAC6ndIFeJ4=; b=mXEHiI89sGndK5hA5yvBFz
 eUI/0EMjHhvuy7YX7G+NR3Q1E3qhGcH27F/6WbJVH4PCkpipMGw/DndwbKiApsEM
 it+6Oh+0Ta90T4GiTrLsER1gJ8SGqIUXAqAP5qLxNj8Qy+RV+ntr8UPpFFuL/b9a
 aFyPreWQP2uMWcR4bPuSxmDwTxgkMLE/JS3OUYDmgQ/LF85ukT4IvYji1ihKfL2k
 8qP/IfWdJeQyOiakV99okrTw0c46t9uNOwhpztYyFjarl6Cues4RBaJutKY78IZq
 15v5W7y49MjjzS90oeuS6PlUu33yhgXt1AQoVD9L96V5DhT5xZSbLSkuKA214jlQ
 ==
X-ME-Sender: <xms:2bP-X3lDszcVZIVkAIOUmFHxhFYdD9DT5xXF4XhIEy8a2U7T8k2rvQ>
 <xme:2bP-X62MdC-M8B3TcyO0-TcjZUQi1bksQTea35ffYUVGyp8duE_-83zjufOzaS2OJ
 Sc0h9aT-dYx_JUxYJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddvucetufdoteggodetrfdotffvucfrrh
 hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhmvgcutfhi
 phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnh
 epleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieehgedunecu
 kfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2bP-X9qr35cc5YDK8ndamD0soQU46HD2IPKJR68oYA1wZjzcoWYFTw>
 <xmx:2bP-X_lzfVzvfl_SbUWDLUKCWz6nvYMQBoZRi7do7St1GUDqj6xPWA>
 <xmx:2bP-X13baytSsObXiZAv78PPL2sfNyAEfxjfcARaYTNABd2PdveqWQ>
 <xmx:2rP-XymcfobYvEEAMVGm6s-0dMAempdOxKVTim2bN5zTzBh6eibl_Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id E17ED240062;
 Wed, 13 Jan 2021 03:48:24 -0500 (EST)
Date: Wed, 13 Jan 2021 09:48:22 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 1/7] ASoC: dt-bindings: sun8i-codec: Increase
 #sound-dai-cells
Message-ID: <20210113084822.4rx67gcgqnb63agu@gilmour>
References: <20210113060615.53088-1-samuel@sholland.org>
 <20210113060615.53088-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="voku56fj7iadly7o"
Content-Disposition: inline
In-Reply-To: <20210113060615.53088-2-samuel@sholland.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
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


--voku56fj7iadly7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 13, 2021 at 12:06:09AM -0600, Samuel Holland wrote:
> Increase sound-dai-cells to 1 to allow using the DAIs in the codec
> corresponding to AIF2 and AIF3.
>=20
> The generic ASoC OF code supports a #sound-dai-cells value of 0 or 1
> with no impact to the driver, so this is a backward-compatible change.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml  | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-=
codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-co=
dec.yaml
> index 67405e6d8168..3e02baa1d9ce 100644
> --- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.y=
aml
> +++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.y=
aml
> @@ -12,7 +12,7 @@ maintainers:
> =20
>  properties:
>    "#sound-dai-cells":
> -    const: 0
> +    const: 1

We should make it clearer that 0 is still ok, but is deprecated

You can do it with:

oneOf:
  - const: 1
  - const: 0
    deprecated: true
    description: >
      Whatever

Maxime

--voku56fj7iadly7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/6z1gAKCRDj7w1vZxhR
xbcAAQD8BOXQ4mhrW8k34p2W/LdnOcWWWyDGx6stQULk2BU7VwD/X5vR9Bpz5gzT
EYllDxi05aukw+nSebapy6q+jWFy/wk=
=SsHU
-----END PGP SIGNATURE-----

--voku56fj7iadly7o--
