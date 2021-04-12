Return-Path: <SRS0=Xjxi=JJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81386C433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 10:09:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D078561288
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 10:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D078561288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65FD5167A;
	Mon, 12 Apr 2021 12:08:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65FD5167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618222153;
	bh=gwloCHxB/Xn7kRKmL5pkdZAAPl4ImRhy5M4XC4YpqP4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YgIP3Mgvkp9LzLg4d4MgWbT7vTWvtVsaI8EmK6rqN5mVZ/YrP9MNEw7P/mg0HXqvk
	 8/AvEXKSM7JbNeoJdOUVBaN9WxqMr28GXa0X5QcLWf788cgD8jPgT6ToAvRtu6mek+
	 mptK+28nHR+/5y2SEzA//dmJILjOQc3h1QnW4z0M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF185F8032C;
	Mon, 12 Apr 2021 12:07:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29A4FF8027C; Mon, 12 Apr 2021 12:07:29 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DF6BF8025B
 for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2021 12:07:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DF6BF8025B
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FJkrD3ZtdzlXMT;
 Mon, 12 Apr 2021 18:05:16 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 18:06:59 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, 
 devicetree <devicetree@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] ASoC: dt-bindings: renesas,
 rsnd: Clear warning 'ports' does not match any of the regexes
Date: Mon, 12 Apr 2021 18:06:38 +0800
Message-ID: <20210412100638.3349-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210412100638.3349-1-thunder.leizhen@huawei.com>
References: <20210412100638.3349-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Zhen Lei <thunder.leizhen@huawei.com>
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

Currently, if there are more than two ports, or if there is only one port
but other properties(such as "#address-cells") is required, these ports
are placed under the "ports" node. So add the schema of property "ports".

Otherwise, warnings similar to the following will be reported:
arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dt.yaml: \
sound@ec500000: 'ports' does not match any of the regexes: \
'^rcar_sound,ctu$', '^rcar_sound,dai$', '^rcar_sound,dvc$', ...

A given binding should just use 'ports' or 'port' depending on it's need.
Both are not allowed at the same time. The check is done in "allOf".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../devicetree/bindings/sound/renesas,rsnd.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index 384191ee497f534..32b10fc3789eeac 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -115,6 +115,12 @@ properties:
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    patternProperties:
+      '^port@[0-9]':
+        $ref: audio-graph-port.yaml#
+
 # use patternProperties to avoid naming "xxx,yyy" issue
 patternProperties:
   "^rcar_sound,dvc$":
@@ -258,6 +264,12 @@ required:
   - "#sound-dai-cells"
 
 allOf:
+  - if:
+      required:
+        - ports
+    then:
+      properties:
+        port: false
   - if:
       properties:
         compatible:
-- 
2.26.0.106.g9fadedd


