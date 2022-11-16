Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3272C43219
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Nov 2022 03:47:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F314AEA;
	Wed, 16 Nov 2022 04:46:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F314AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668570447;
	bh=EOk3aeNr67BAfVzcLO7mOEK1Lo1jF8UuiQrot757KhA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BfQIyD9BZiPOoDLw/lFyNYJ1aODgHOMopkFRtGuCML21lEl69yDzLwy+X3c12U0Gp
	 Hs379GJwyE6aU74tnbN1Atzz/zJdQr0/W6/EGi1uW3d68Cv8saQOTB+Zi+MhRVLoWa
	 X9w8gVqGof38V92LThdUQgPdkB/qir0ex06oiIQM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F2C1F80163;
	Wed, 16 Nov 2022 04:46:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C2EBF80169; Wed, 16 Nov 2022 04:46:35 +0100 (CET)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 637A8F800B8
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 04:46:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 637A8F800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="f2dnLkFh"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="kC8zSkhN"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id CA9B85C018C;
 Tue, 15 Nov 2022 22:46:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Tue, 15 Nov 2022 22:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:sender:subject:subject:to:to;
 s=fm2; t=1668570383; x=1668656783; bh=98Wqu6kwTkpQx0diKFaT1wM6I
 4WeLKlWxy3HOKKiaiw=; b=f2dnLkFhJVUrqrjGX0/qdstmEFGgn+VxQmigbZZPB
 FnayAaZGHGOaoBv0ZxdmsdA92zKkBOreIe8TiuK2FK7J54QwcfbAPu/BBWmOukSi
 am6T93Vwl7m/EU3NwezMVyDyeO28vd0kSP1E5sXAAUPMnTmfJRQ+ZAOPbZY0eDWo
 uW6pbAeXdhmJYFMcoXH30Q47AR3eeMkCKcMNxwEPVCS/1tDETXHQyGCY+JXA/+Pt
 UumYQA4d6NEchsbfd7xmVlDadh/N9vV75IPbi5UsH8iIqBw/Rb3OuEjuPwDqHV3P
 spros1h6uO6TFd6AmRkuiojXaTJ696ywRZAFx3DFoiM7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1668570383; x=1668656783; bh=98Wqu6kwTkpQx0diKFaT1wM6I4WeLKlWxy3
 HOKKiaiw=; b=kC8zSkhNKfuHZORd/Hu+Qa/racxzvBAmNX+Oz9VyIT0CoJUExfR
 cwOHzGgz/0OZgJQRjzRBJiM1D46IQ+n6eeD8nxOt8Xv0IeQQR02Vga1/WDCsNEs5
 v3l3hpyh3D5rxwZ6h16SJJs7vKE07iXVgw0G/1cVekRQLqzoYyLnI/qmtkLnWjzx
 wPb0y/XNs4A6ILifWLiZY7jK3pjQzM/QavGOj5zkfmB/r33Q1NYzQPxzTfU5dHaY
 uTHkeIdiHzorKhXTJbCGdwVS7C8aeuEvevwlIhJoV52A7r9NtjCcdiowPEVKvLOp
 hFOKbcC8BBwIyckGqlQFckZ5h4t9WLqLHhA==
X-ME-Sender: <xms:D110Yzp5saybWSvKd9XP3Ui_OCEOEZuEhtp6qYbDVIJ6te_XNC0piQ>
 <xme:D110Y9rV6E9Uhl-57QnRq2ALFkXWIZ_3Cl8aojjPTwht-NI2GpzMPRQD2-zeX5La2
 7TmJ69felIhi10-Hw>
X-ME-Received: <xmr:D110YwNCnV7hUClUYsSCSF2HDy-IZ8aOq1DqaqxHL1gaxhJyGfy27vajiysW0_A7J0MytOhoUkk4CpWxR73IN2Qd_sndY3swFxZ0R3wBTFoe1gLqnwODYtl4QVeImx7-oZWjPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeehgdeivdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
 jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
 htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
 keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:D110Y24560usaTLVIht-_dnsK5ZG8aLHjMX01d8JwBK8AE4eV4-fig>
 <xmx:D110Yy4MbDqv2BpA1rkX80wWEBtYkmOwEYYzVGhZz55Wj9q-iIeD_A>
 <xmx:D110Y-gfQZKz3-TJaMNZeSXJ4YijeyefH-K7u7Oep7MqGSp7SDfgCw>
 <xmx:D110Y6j8flhLVh8U5IinzOVINi9l5vaeA32U7GAjamV5-zhAHssuTg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Nov 2022 22:46:22 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Ban Tao <fengzheng923@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dt-bindings: sun50i-dmic: Add D1 compatible string
Date: Tue, 15 Nov 2022 21:46:21 -0600
Message-Id: <20221116034621.37762-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

The Allwinner D1 SoC has a DMIC codec like the one in the H6. It appears
to be register-compatible with the H6 variant, and the existing Linux
driver has been tested on a D1-based board, the Lichee RV 86 Panel.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../bindings/sound/allwinner,sun50i-h6-dmic.yaml           | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
index 2f12cabe4c71..0920f2f81a1c 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
@@ -11,7 +11,12 @@ maintainers:
 
 properties:
   compatible:
-    const: allwinner,sun50i-h6-dmic
+    oneOf:
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-dmic
+          - const: allwinner,sun50i-h6-dmic
+      - const: allwinner,sun50i-h6-dmic
 
   "#sound-dai-cells":
     const: 0
-- 
2.37.3

