Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF88C4332F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Nov 2022 18:22:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFE341683;
	Wed,  2 Nov 2022 19:21:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFE341683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667413369;
	bh=nT5ZYip6ykx0KuIPyyYFqsRIdtNMhO9TwzCn0g2rnOA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZJtTyAUAiBokqDD1qNmu4fxAhqoWFnmdATOdN0iTUvv+4eYaCwtWyHhrSLmHDhnhn
	 ewiT9MBOL3l5W/2JBXVdTNpAZ8KFgsRTXTSx38JwREQJPc5LN/jvLQMbopgmDui2fC
	 dDvTebN4/TuDuQ458NkCm6QkXU2jkTl78MtfFLv4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFE00F8057D;
	Wed,  2 Nov 2022 19:20:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58777F8057A; Wed,  2 Nov 2022 19:20:22 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3ADF9F804EB
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2022 19:20:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3ADF9F804EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="U6T/zZ1o"
Received: from notapiano.myfiosgateway.com (unknown
 [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 4DB7C6602946;
 Wed,  2 Nov 2022 18:20:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1667413214;
 bh=nT5ZYip6ykx0KuIPyyYFqsRIdtNMhO9TwzCn0g2rnOA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U6T/zZ1oQgFPo591b9rXyFM7G48u1J0BMKzZX6A9EFo+URmWGIwR2nTi8wsKoK5/P
 MrcxZzjRmBjDyj7NkA4ZR28MVBcMeibpOQj8qwzIeDa3o4ETcBOoWjCw5xMJjjoJdR
 5ULSNgo0+OulqriO4/fo91kCBOXktrAwxJ6b1y7ua9HbDHNNJ7U8gbzd+QrWLw7yJb
 YxJx1CI3Lqz6s01sdYBAQMptNzMbGhqDGsQrS2YYfqwc+s0lgOUArJw/Qgpl/MP+QJ
 GHWCJbnJGStTBzsU4zvHjzZ6LHwmBnms42KdhIg0SIOxR36R8TS/H9qVRKMpvnhsJn
 tZnQoq5zmvaZg==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v2 4/8] ASoC: dt-bindings: rt5682: Add DBVDD and LDO1-IN
 supplies
Date: Wed,  2 Nov 2022 14:19:58 -0400
Message-Id: <20221102182002.255282-5-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102182002.255282-1-nfraprado@collabora.com>
References: <20221102182002.255282-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
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

The rt5682 codec has two additional power supply pins, DBVDD and
LDO1_IN, that aren't currently described in the binding. Add them.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Made names uppercase

 Documentation/devicetree/bindings/sound/rt5682.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index 89e6245b870e..5e1d08de18a5 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -17,6 +17,12 @@ Required properties:
 - VBAT-supply: phandle to the regulator supplying battery power through the
   VBAT pin. Either MICVDD or VBAT should be present.
 
+- DBVDD-supply: phandle to the regulator supplying I/O power through the DBVDD
+  pin.
+
+- LDO1-IN-supply: phandle to the regulator supplying power to the digital core
+  and charge pump through the LDO1_IN pin.
+
 Optional properties:
 
 - interrupts : The CODEC's interrupt output.
@@ -87,4 +93,6 @@ rt5682 {
 
 	AVDD-supply = <&avdd_reg>;
 	MICVDD-supply = <&micvdd_reg>;
+	DBVDD-supply = <&dbvdd_reg>;
+	LDO1-IN-supply = <&ldo1_in_reg>;
 };
-- 
2.38.1

