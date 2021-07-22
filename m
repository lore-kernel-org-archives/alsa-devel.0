Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA49BC6377D
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 07:59:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3035C610CC
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 07:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3035C610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2BA716A5;
	Thu, 22 Jul 2021 09:58:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2BA716A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626940743;
	bh=AmjNaPpcMZbuPBgPeWdymE9ru8WvVFOs7PC457yGNiI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FiFXJE2HJ9LxX6d2zeeTSfAv1yD0WD1y5epCBRcOj0demV4kBedsU4uz8ezJHxJWX
	 FBa2dNOggEDsl7wy7cVZb7SZH9cg4VPVaGsjP0f3A7ATzRtV4Yrjk2TC+CY2tikuuN
	 dyKe4AnR8yNPyhSciZonePPFW9/zHJEsJzKLXA6s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80748F80218;
	Thu, 22 Jul 2021 09:58:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30EC3F80227; Thu, 22 Jul 2021 09:58:11 +0200 (CEST)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E074F800F2
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 09:58:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E074F800F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="B+Jms/YW"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Qa8nY2a7"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailnew.nyi.internal (Postfix) with ESMTP id 5141A5817AC;
 Thu, 22 Jul 2021 03:58:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Thu, 22 Jul 2021 03:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=k
 kCGDZ4mp1QSn53GXPFjfkumzgPnIst+r1z4DaNYle4=; b=B+Jms/YWtvM00vl0i
 OoWuB6C0ciNyzgWCcoNJUtnwcDf5VFK1VBULqZoUANTA27vz85OCuH++4UJHpcZX
 Yv5+u4Y44uPCcaxFVce8usaw2p7rbjTni2+NhFkdtLZackes5zi1IpLxHG109CoI
 RRGUDvqnvtkmIsWsI2Iv5qUICnDEPwcGXB9UOe2+cD0zzUh8+b6KMzs3Z6/UtZTx
 bJAig6IKmnQy8hR9fX+AjZUcvG6JzZf6h2/NrBTJi7jjryJNI0Y5EpREwOxlf3tT
 jkXp8tWOGgaN+QrOgxUJylKW7XaYCbOOwxHYbQjWdygmdm8BTqU/MJtSSv/ERFp0
 bHy5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=kkCGDZ4mp1QSn53GXPFjfkumzgPnIst+r1z4DaNYl
 e4=; b=Qa8nY2a7JffMOPw2c0BYaZKyr8/OeYJempoB3LGboH6v1yBXBaWe+dyCb
 iCGFe5jZEifVHPglag1E/KYgbsqazUbXmdtkZ+7zAGG5C7vXe6zJrW7eeOgc7viW
 anrl3Gn1iAtjrVKVPYBoBGmaItRgcYQ5KePqIHfuN18rIiGW/+upOyOQYGqA22ov
 MjXnlF+bRh+8QJiUOkZxSeVsggBo084f8mAtGw8NMPHNDnxyF72BbUhGaovgldmA
 T3sHDxNhz/a+4NrFEYGYknsO7t3bxc1EPpZEMMViQj+JK1RRkNvMXCr8YPGVVz6r
 x5vBP5D3e3lBM8bdQANGGXFAiHLGg==
X-ME-Sender: <xms:DSX5YJDEpAmvebqbeILbgCdPpZx8ci5VTrquEzvYiV18lq2MSn_ChQ>
 <xme:DSX5YHgtd4CEzuGAMozP6H5hNpiXTLAgPLMbSqK7xsMLYBu-KP6ljHPbbzkq7vol6
 UfyqmsIP9AaQkxzNzQ>
X-ME-Received: <xmr:DSX5YEmEmLf4SKIX_p3RgpaLSwKgFeNbrJ-KQJ41sReOM5NNiUIEtxpqpoE4JNfhftpVeeu-rQrqgOl2LcYJUb7M5Tv4NW1oXJdD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeehgdduvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
 mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
 htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
 gedvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:DSX5YDxV-biFnyhZ0cdJzMEBe-4L-IBxRZd8a2yfWu_hVRbGBFgS3g>
 <xmx:DSX5YOT2UJzaKny3oOH3FsR3gkqLh35ZN5eMTgHe0huUYXrF8nl5aQ>
 <xmx:DSX5YGaTYB9ZzlGPjT_Xzt349DXY5Lkse68Kvc8Bvj1OQMQugjgsEw>
 <xmx:DiX5YP88PibDkgB6g3y_bHYTNuq3nOhQTuvvnUK4hi-VdNBEZaKYgw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jul 2021 03:58:04 -0400 (EDT)
Date: Thu, 22 Jul 2021 09:58:03 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 02/54] ASoC: dt-bindings: Convert Bluetooth SCO Link
 binding to a schema
Message-ID: <20210722075803.42ltzog3sltbeivh@gilmour>
References: <20210721140424.725744-1-maxime@cerno.tech>
 <20210721140424.725744-3-maxime@cerno.tech>
 <e0ba4dab-abe9-9f4b-2795-e85041efa451@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e0ba4dab-abe9-9f4b-2795-e85041efa451@sholland.org>
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-sunxi@googlegroups.com, Liam Girdwood <lgirdwood@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
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

Hi Samuel,

On Thu, Jul 22, 2021 at 12:35:33AM -0500, Samuel Holland wrote:
> On 7/21/21 9:03 AM, Maxime Ripard wrote:
> > Bluetooth SCO Link are supported by Linux with a matching device tree
> > binding.
> >=20
> > Now that we have the DT validation in place, let's convert the device
> > tree bindings for that driver over to a YAML schema.
> >=20
> > The value expected for #sound-dai-cells wasn't documented though, and
> > the users were inconsistent. The example didn't list it, and across the
> > 4 users we have in tree:
> >   - 1 had a cells value of 1, but using only 0 as argument
> >   - 1 had a cells value of 0,
> >   - 2 didn't have this property at all, behaving as if it was 0,
> >=20
> > It seems like the consensus seems to be that it should be 0, so let's
> > enforce it.
>=20
> The driver has two DAIs: "bt-sco-pcm" and "bt-sco-pcm-wb". If
> #sound-dai-cells is 0, only the first DAI can be referenced from a
> device tree. So to declare support for wideband PCM, or explicitly
> declare a lack of support for it, #sound-dai-cells must be 1.

Yeah, I knew there was something else to it :)

I'll fix it for the next iteration.

Thanks!
Maxime
