Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C832BC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Apr 2022 20:32:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03D3E15E0;
	Fri, 29 Apr 2022 22:31:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03D3E15E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651264338;
	bh=iA81JYnLAQQ56KXiWfdUYhI2+oyfPVXJFjeDzQn33UQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GnJwJk+O+yffCiC6eFdPWTVEiVuvNw4qL8sicGWDTFu/EGwzsLZhheIq8qDPgWyA8
	 LnEuB2bvYNN/XxHsRaGV3757xwztOpF2CTUdBvi1/tURrfUo9UXN+ibA3rRabOiiUs
	 gJ+hRDG0E5OArJSFIugJKzI4fZSGud3FHBQ9iygg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10C4CF8012B;
	Fri, 29 Apr 2022 22:31:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41581F804B2; Fri, 29 Apr 2022 22:30:59 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3DF8F8007E
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2022 22:30:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3DF8F8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="IEXLTWvq"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: nfraprado) with ESMTPSA id 13ED91F469D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1651264251;
 bh=iA81JYnLAQQ56KXiWfdUYhI2+oyfPVXJFjeDzQn33UQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IEXLTWvqDvhD8CXoQFsb1+gzKNMCACdb8rlEhLrPyFd5Ezy+kLRcmFRgNDdCBsuKN
 F24McZ6t0CsiSnp6455dCY4H1vu7lXGmcYxl5ke4thYo5fhgXDCtnWhmwohSXFFCEj
 HR3NsmGWzRONXwoUFTxpZ98PUXsHAO6evwLPcOIAtkBXwsmkitIWiu1guxTspIsf2W
 I1oW750Zw+95Up0iRS8Enhwhs6IwLCwc7gx+FF85yE0Y6AuXegjBGms3Z/+t5khTEL
 tMxYkikxZsfLJf6KdIeL8LLyPo6mozWksZutDOsDDeMHPdcQdcmlNv0c3MRm5bX/y6
 35CkcCaxg8KMw==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Date: Fri, 29 Apr 2022 16:30:37 -0400
Message-Id: <20220429203039.2207848-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429203039.2207848-1-nfraprado@collabora.com>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-kernel@vger.kernel.org,
 Shane Chien <shane.chien@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

The Mediatek AFE PCM controller for MT8192 allows sharing of an I2S bus
between two busses. Add a pattern for these properties in the
dt-binding.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
index 7a25bc9b8060..5b03c8dbf318 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
@@ -54,6 +54,11 @@ properties:
       - const: aud_infra_clk
       - const: aud_infra_26m_clk
 
+patternProperties:
+  "^i2s[0-35-9]-share$":
+    description: Name of the I2S bus that is shared with this bus
+    pattern: "^I2S[0-35-9]$"
+
 required:
   - compatible
   - interrupts
-- 
2.36.0

