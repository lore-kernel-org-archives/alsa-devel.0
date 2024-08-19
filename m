Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CACC3DA4A
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Aug 2024 18:31:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA04782B;
	Mon, 19 Aug 2024 20:31:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA04782B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724092302;
	bh=P/L3NgyYytfwnB4TlqzeCccYfyAfsEKejKjDYh6MX/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VA1BkTfaMAn+KIjlS/KiLg1YLRD6H18URC6guSAEOe51Gye0+y3kz2am0NlFZUfaC
	 BYMpvV1hk19B9Q63315kigCTGKoqsOsU6mwoyYOv46cFtbUtrgmp1iUNkor0ZH27Bg
	 cg+aO0p+aodsYDyDLYoYSQLmkA+GueLmQZfeJmCo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 948FCF805A8; Mon, 19 Aug 2024 20:31:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 253E6F805B4;
	Mon, 19 Aug 2024 20:31:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A034F80494; Mon, 19 Aug 2024 20:30:57 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5DF53F8014C
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2024 20:28:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DF53F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VKzQTHGS
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7F35860C71;
	Mon, 19 Aug 2024 18:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA196C32782;
	Mon, 19 Aug 2024 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724092129;
	bh=P/L3NgyYytfwnB4TlqzeCccYfyAfsEKejKjDYh6MX/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKzQTHGS2YGCeP0P8MP0bRGqWkR+/F2JGntV29VBmI4XfPMTUZY5lZ6uj7ZNBvaPD
	 rI032Y/PaqT15K7kKMDPXP5E5w8/S6ohD6U4xgvC/haIp0waXk/ZgGo+rzxUoUFSEW
	 oaRmGe+66VLkbM4AcPI65pN70FOPfEyE9UOiIX6gFo5df3GqH4m5icj3dIAX0Tllyn
	 hJ9ABt4cWjNSXnfs50e/dhyUN3AzCVAKgMt9I+52mGTghDfper+Nd8M69Ma40w70AN
	 r8qXB4YnK+0AEE3DJC1UVbK1de5Oxa8aKcY55QAKYUe1skL0E9zmEAk5wXJmoe+9We
	 Mts2jeg7PaMzw==
Date: Mon, 19 Aug 2024 12:28:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-sound@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	alsa-devel@alsa-project.org, Conor Dooley <conor+dt@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ASoC: dt-bindings: samsung,odroid: drop stale clocks
Message-ID: <172409212644.2046966.8530485462629543956.robh@kernel.org>
References: <20240818173037.122152-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818173037.122152-1-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: IDTV7MOT6X2IGCT5J3F34PME7EEBTDOU
X-Message-ID-Hash: IDTV7MOT6X2IGCT5J3F34PME7EEBTDOU
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IDTV7MOT6X2IGCT5J3F34PME7EEBTDOU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Sun, 18 Aug 2024 19:30:37 +0200, Krzysztof Kozlowski wrote:
> Clocks property was present only to allow usage of assigned-clocks in
> the sound card node, however in upstream DTS the assigned-clocks were
> moved in commit 4afb06afd768 ("ARM: dts: exynos: move assigned-clock*
> properties to i2s0 node in Odroid XU4") to respective I2S nodes.  Linux
> drivers never parsed "clocks" so it can be safely dropped.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/samsung,odroid.yaml | 5 -----
>  1 file changed, 5 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

