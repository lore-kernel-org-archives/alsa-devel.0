Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB80C48BE5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 08:50:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC9661209
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 08:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC9661209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 277D41672;
	Wed, 16 Jun 2021 10:49:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 277D41672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623833425;
	bh=AtTrFMTYSgn/w/QkhgwiP/RgTtBQlPjBg8dMFNL5dUk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pJhWSmpBX3vI/Axv8GQSmWO65qTWbbh0oKK2tIqDZ2y59auyEsO8ZMsBKEWGkPTl3
	 Gil24Pj26V1h6V/DrQdDUZbVwrr1v4uGlAfoj+BfZQW2SqoBgHGTtlaUhO1sRFrEgX
	 QKw7Xs5sya2CFpMrV3xbPNCMGfi7zi60mN+J7oFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAD54F802E8;
	Wed, 16 Jun 2021 10:49:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1272F80423; Wed, 16 Jun 2021 10:49:33 +0200 (CEST)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77764F80148
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 10:49:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77764F80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="O9toReIo"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="gf7mv0fC"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 277DC580609;
 Wed, 16 Jun 2021 04:49:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Wed, 16 Jun 2021 04:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=h
 wLAiqJqpm5oEawixERPmrijjk4aP6MKJESch0uKUAU=; b=O9toReIomtjLeV+ER
 mN4yMF5EtW62dXfPS5Ft4j58PuOpy65v3gYXHKbuUUOD8rV6BuqaagIk4n33dHs+
 /hYgRJoAA/2dinBop1sifaj0YMAgFjXUQXIaEQAD79BgRikYpMHSTTU9Id2H188u
 jP743/EB8hGA5sU3KhyWqOzJh6BigW99rjmmeRGxsGqbngguI1RJvtD8y9L4Manf
 M097IBXtWByB6Pnqy+bb8CEkhmRwD7VOJvsKj0rACgoGWwHRQW+F18fAoRAh/4xK
 lKNQTupLnex63KyEwNlaoWJNzoJPn8ZDGWMBhiTg+20mygaJ11/PQDJoumNUu0jc
 I3R2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=hwLAiqJqpm5oEawixERPmrijjk4aP6MKJESch0uKU
 AU=; b=gf7mv0fCUeXJCXfwAWkcxMTeb99PWPBl+Wt7CKktgnwMZi8s5gIfNqRKm
 rsfBBipKnur/G7pXbjwkVnt+ySkZPetRCmUw7+dClz5Ina6WP+sf9VQnMDNGVSkF
 rmYftPavpZIQ2KBpJ/rpZWmgKEru/clt5s68Gp5Ndwv0oo0/BckjISm7ZH0ycQp6
 TGnRxVcRkvww9j+3CVaIo4dQXOfHnrcFaHF+xT3q5UOiEPFYILK4SiaebzdYpVRu
 ARMZvMkG9+pBmMoJqXXQUM46CvkKo9ydpIMB0RZmUv5c+oTZ+HmQEb2VJTR4Xs2C
 P5GKBBc78deZ+4Ymb+sKD+wNbfHtQ==
X-ME-Sender: <xms:ErvJYBPlVedHQSjYyP-tlCfAI7cJyVj15eiSyALEqes9n8kk5UQABg>
 <xme:ErvJYD-325p1fYxMGjzrOM02mxcKFyjre2-hN-ILTWMjtb-X4f56SiOgANCKOFb4t
 VQONLOcZYFTJewiMN0>
X-ME-Received: <xmr:ErvJYAT4o92_eB0uVteBhtlgpVOdvCbbW95OCNahsjBm4_1m0feAwKHmU8ewivf_Wr7e6sRjuDiwrEwaAKzBKZh0R4PIOha9YeQJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtqh
 ertddttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegt
 vghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepgfegvdelgfeuveevueekvedtje
 fguddvveffhedukeejjeejgfejfedtvdeitdegnecuffhomhgrihhnpeguvghvihgtvght
 rhgvvgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ErvJYNudNxBs7ng4vP9-yua7-0u1XI-Uca0DD_qJVik2bkOt-6rimw>
 <xmx:ErvJYJe8qIvUs0yR78yeNt6ovXcgKuKuHx6CaCatU3HblQxBR7o9Yw>
 <xmx:ErvJYJ2SYl56_x-ktRufe2BuDRnq0OoC97njcVrtsJLt7pCBfLuwjg>
 <xmx:FLvJYF7rq1EjBsZ9TvCmpT4e8KMPY2aVFgUVSpQoY_NDQASghrV4IQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jun 2021 04:49:22 -0400 (EDT)
Date: Wed, 16 Jun 2021 10:49:20 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Ban Tao <fengzheng923@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for
 DMIC controller
Message-ID: <20210616084920.y6yjic4sau6ungv5@gilmour>
References: <20210615130737.2098-1-fengzheng923@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210615130737.2098-1-fengzheng923@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, jernej.skrabec@gmail.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, wens@csie.org, broonie@kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

Hi,

On Tue, Jun 15, 2021 at 09:07:37PM +0800, Ban Tao wrote:
> The Allwinner SoCs feature an I2S controller across multiple SoC
> generations.

Which SoC generations?

> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> ---
>  .../sound/allwinner,sun50i-h6-dmic.yaml       | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun=
50i-h6-dmic.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-=
dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmi=
c.yaml
> new file mode 100644
> index 000000000000..81d40c374e44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.ya=
ml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/allwinner,sun50i-h6-dmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner H6 DMIC Controller Device Tree Bindings
> +
> +maintainers:
> +  - Ban Tao <fengzheng923@gmail.com>
> +
> +properties:
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  compatible:
> +    const: allwinner,sun50i-h6-dmic
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Bus Clock
> +      - description: Module Clock
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: dmic

The convention we use is bus and mod

> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - "#sound-dai-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spdif: spdif@5095000 {

The label and node name seems wrong?

> +        #sound-dai-cells =3D <0>;
> +        compatible =3D "allwinner,sun50i-h6-dmic";
> +        reg =3D <0x05095000 0x400>;
> +        clocks =3D <&ccu CLK_BUS_DMIC>, <&ccu CLK_DMIC>;

You'll need includes for it to compile

Maxime
