Return-Path: <SRS0=h5q8=J3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC60CC433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 04:00:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C5761419
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Apr 2021 04:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C5761419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2071A1678;
	Fri, 30 Apr 2021 06:00:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2071A1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619755252;
	bh=0Lg4ULP/nMjVTZMR/E7a+ihzfnh/vGNCsQz/1RsCPao=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YjFIbpwz5cDFdE0d5FLkzAGIxwUPuo0CCL5Xez5y8vEVxg7TCmJb5EADv7SpONXhJ
	 qWYPXrnyokZmekgUPbL75OaL9VmchVtzouzMqo4vtT0y/E22FaZiKeSeZXFxF3gZy9
	 jVWl823vxNhbyiMaBy5foKe/hosUndP95NeONVbg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE78AF8025E;
	Fri, 30 Apr 2021 05:59:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0379EF80425; Fri, 30 Apr 2021 05:59:11 +0200 (CEST)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 252D5F800E4
 for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2021 05:59:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 252D5F800E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="p7X+/8zV"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="AwUnA8+k"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 73E4D58098C;
 Thu, 29 Apr 2021 23:59:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Thu, 29 Apr 2021 23:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=C/zv9YAufZEA1
 vYQZ89gyFjqQ5tKRBiTvd9OZQm7wS4=; b=p7X+/8zVRC7OM40ixXor7PStlAf1B
 d+fNjICLPlm7O2B1ySMbXOrsSQv1RYYl6fIVW2mNAwh1fiSGtJojBTKMW3k+VmHy
 yjoaBRZIchoE7h4troyMEUKU04LB1wBcMKH3+1VhkHzou7A7LlIH/zAGLQtqzxOZ
 tANQwDh0GwQvSu++j7PuawlbM1C9hnmFp7vunN9wGkkG5XLOlYLBQUInSzhXo6fF
 tqGngYhNEOs7TrN2h+UfJDdspYSSqO3MX32KZPy4ZQbFRq8KiBuGcfzCLwAtl6GN
 x8U0DWCg0tvbE6EBoMyo5J9s5a83igXxsGfcmARVSIgWoBw8jWmKyo/pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=C/zv9YAufZEA1vYQZ89gyFjqQ5tKRBiTvd9OZQm7wS4=; b=AwUnA8+k
 otv4GjsfgS/kRNyRZADBOpKQMrJ3616aHugx7CPyZJ65/X0reIOr7KukHTe4WmMQ
 RjlgLFtDpDYNq8ZRb9ddHKmJfE4X6Mz6zTGm639bwuH7uyNZHmWkpaeVJ81sfAKT
 J+XxkDmHco5uq5r3NY27wBGrxozUxM8hRiw9m2ZYJuTDwSv1IFw6X3E5NzVcPtvZ
 42oB8nd88KvQgNBwfr2CxlQKqR/FBMZ/5ozoYancNLYfgSuNT/E9FgFrA+N/qgMg
 yN8AxmG1Px02qA5Eq2qVfjNx2sekjEzRqyquDNLdroQPRT+6EBkIMYTK+sl8IRW+
 dJ2RBH4shXXu6A==
X-ME-Sender: <xms:h4CLYHEcWZ5Qd0-n7d4TaD7b8-TE3lWyAUW0GhvCKLeN4GD1_iOSJg>
 <xme:h4CLYEW-oPmd4CtO_h4u6piOvYszuFNmPWzNO6Uxuv-Hp1Pz7YZNPSWGfuy3_R0qD
 fW3dRHzp807TWm6kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvhedgjeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
 gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:h4CLYJJZX-kPUviKas-CZ1w3kv6CkPJa6lvnQIx4P-waSTanyJTcgQ>
 <xmx:h4CLYFG7jXs-fj6O-ypKcLAdXk0uHTmrcHlEWkx0Zrzw0uWYsHZLvQ>
 <xmx:h4CLYNVLkxqUY2-bw6t-m9LLFHXo9MmdzfsvPCRFeM7iWAbuqjsdYw>
 <xmx:h4CLYFRSPNiupws35jXNVXHU1xtD7cfrLxWnT4a7RSDPocV-G10FxQ>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA;
 Thu, 29 Apr 2021 23:59:02 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/7] ASoC: dt-bindings: sun8i-codec: Increase
 #sound-dai-cells
Date: Thu, 29 Apr 2021 22:58:53 -0500
Message-Id: <20210430035859.3487-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210430035859.3487-1-samuel@sholland.org>
References: <20210430035859.3487-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
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

Increase sound-dai-cells to 1 to allow using the DAIs in the codec
corresponding to AIF2 and AIF3.

The generic ASoC OF code supports a #sound-dai-cells value of 0 or 1
with no impact to the driver, so this is a backward-compatible change.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../bindings/sound/allwinner,sun8i-a33-codec.yaml         | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
index 67405e6d8168..19f111f40225 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
@@ -12,7 +12,11 @@ maintainers:
 
 properties:
   "#sound-dai-cells":
-    const: 0
+    minimum: 0
+    maximum: 1
+    description:
+      A value of 0 is deprecated. When used, it only allows access to
+      the ADC/DAC and AIF1 (the CPU DAI), not the other two AIFs/DAIs.
 
   compatible:
     oneOf:
@@ -50,7 +54,7 @@ additionalProperties: false
 examples:
   - |
     audio-codec@1c22e00 {
-      #sound-dai-cells = <0>;
+      #sound-dai-cells = <1>;
       compatible = "allwinner,sun8i-a33-codec";
       reg = <0x01c22e00 0x400>;
       interrupts = <0 29 4>;
-- 
2.26.3

