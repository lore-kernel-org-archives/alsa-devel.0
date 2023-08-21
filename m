Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BA6EE4996
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Aug 2023 15:47:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B156836;
	Mon, 21 Aug 2023 17:46:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B156836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692632842;
	bh=DXrBW2VJ76u0qVfmft5avHbG1deyDq+corIBjd53wc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ke4eLZnTJBOsioZ1CJIPHYWifVCNCwdluPf8wJOBulQff9ibmv2Fo56fEDjSOMX6A
	 q1q6HViKv8vBRuAzlS7gZHJT6S78lrxJzKT9DToKUFY6Vns7EgtASNC8uKcui+ru4e
	 047+60ZNKaXBmcO6cUQO/Ucy0z/8dSRonNJcJbtM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9120AF8016C; Mon, 21 Aug 2023 17:46:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 14D26F80199;
	Mon, 21 Aug 2023 17:46:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 369D5F80199; Mon, 21 Aug 2023 17:45:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6EF55F800BF
	for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2023 17:45:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EF55F800BF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SKVE57PR
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0996261CDC;
	Mon, 21 Aug 2023 15:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC65FC433C8;
	Mon, 21 Aug 2023 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692632749;
	bh=DXrBW2VJ76u0qVfmft5avHbG1deyDq+corIBjd53wc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKVE57PRlBtesE3gZdkizeZ6WGvgRsETyqu6TWNmpAvStHVujOjQzFG4oLBobshxc
	 RztHW+B/KH2ieaUPmT5aF/dO1xLAtAVP40P2CMIHbG0BTsAsvi/S8+MCjyhqCOVnfD
	 QRzwKXcd1KEMAsEmcX8WVwO1bwWGsv9ssQ8ru4/5Te27MzFSbhYmiX1rG2wmYoSwb+
	 Oap0su4emwsccN90z8N3AdZUkGlLQdEILBTJMLgduA7VOzB7z+VejrHGrgmA4tEoGY
	 rM/iZcMuPy880GtnTWFf4jCzF+wRhOlf/KMj3LFdSur3yyqiEdB3k4BJ25wUquqHij
	 KylNtp/whrn7A==
Received: (nullmailer pid 1720300 invoked by uid 1000);
	Mon, 21 Aug 2023 15:45:45 -0000
Date: Mon, 21 Aug 2023 10:45:45 -0500
From: Rob Herring <robh@kernel.org>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sunxi@lists.linux.dev,
 Albert Ou <aou@eecs.berkeley.edu>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-riscv@lists.infradead.org,
 Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/5] ASoC: dt-bindings: sun4i-a10-codec: Add binding
 for Allwinner D1 SoC
Message-ID: <169263274519.1720239.16779866504888120217.robh@kernel.org>
References: <20230805180506.718364-1-bigunclemax@gmail.com>
 <20230805180506.718364-2-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805180506.718364-2-bigunclemax@gmail.com>
Message-ID-Hash: MGAPJI5TFLQF6GSXKMR4YOEXNQNHPS3M
X-Message-ID-Hash: MGAPJI5TFLQF6GSXKMR4YOEXNQNHPS3M
X-MailFrom: SRS0=A38r=EG=robh_at_kernel.org=rob@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MGAPJI5TFLQF6GSXKMR4YOEXNQNHPS3M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Sat, 05 Aug 2023 21:05:01 +0300, Maksim Kiselev wrote:
> The Allwinner D1 SoC has a internal audio codec that similar to previous
> ones, but it contains a three ADC channels instead of two, and also has
> a separate clocks for ADC and DAC modules.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  .../sound/allwinner,sun4i-a10-codec.yaml      | 64 ++++++++++++++++---
>  1 file changed, 56 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

