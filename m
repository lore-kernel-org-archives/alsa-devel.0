Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD020C5479D
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Jan 2023 16:05:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3EB71158B;
	Thu,  5 Jan 2023 17:04:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3EB71158B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672934700;
	bh=pp82hOsYNlkQhNttFMywjUKN/0qobYmD6BVqzQNn814=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=YIh+BuJx4D/dRbqcDVF4uxfBwppYKf5fyAD4pzX9oXCOGZEEN9PYBR97pcNqzLg0K
	 AQOOUaPRFMjxqToSgZABs0QM8InVtccNqeZnS91bn9NSxH+l/UzzL5OqHtWdvyp0AQ
	 zIEl76nzoIeHGZrONIqk75IafBfuovRj4F0kp+ac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65264F8047B;
	Thu,  5 Jan 2023 17:04:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11D39F804AA; Thu,  5 Jan 2023 17:04:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 68DB4F800C0
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2023 17:04:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68DB4F800C0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A563F1063;
 Thu,  5 Jan 2023 08:04:43 -0800 (PST)
Received: from R913NWR2.arm.com (unknown [10.163.47.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B9CC3F71A;
 Thu,  5 Jan 2023 08:03:58 -0800 (PST)
From: Faiz Abbas <faiz.abbas@arm.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, broonie@kernel.org
Subject: [PATCH] ASoC: dt-bindings: simple-card: Document simple-audio-card,
 plat
Date: Thu,  5 Jan 2023 21:33:46 +0530
Message-Id: <20230105160346.29018-1-faiz.abbas@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: kuninori.morimoto.gx@renesas.com, Faiz Abbas <faiz.abbas@arm.com>,
 lgirdwood@gmail.com, Deepak.Pandey@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, Anurag.Koul@arm.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The simple card driver has support for adding cpu, codec and platform
nodes with the simple-audio-card prefix. Add documentation for the plat
binding.

Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
---
 .../bindings/sound/simple-card.yaml           | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index ed19899bc94b..fa67c76d4dbb 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -205,6 +205,8 @@ patternProperties:
     $ref: "#/definitions/dai"
   "^simple-audio-card,codec(@[0-9a-f]+)?$":
     $ref: "#/definitions/dai"
+  "^simple-audio-card,plat(@[0-9a-f]+)?$":
+    $ref: "#/definitions/dai"
 
   "^simple-audio-card,dai-link(@[0-9a-f]+)?$":
     description: |
@@ -285,6 +287,27 @@ examples:
         };
     };
 
+#-------------------------------
+# single DAI link with platform
+#-------------------------------
+ - |
+   sound {
+        compatible = "simple-audio-card";
+        simple-audio-card,format = "i2s";
+        simple-audio-card,mclk-fs = <384>;
+        simple-audio-card,cpu {
+                sound-dai = <&iofpga_i2s>;
+        };
+
+        simple-audio-card,codec {
+                sound-dai = <&hdmi_tx>;
+        };
+
+        simple-audio-card,plat {
+                sound-dai = <&audio_formatter>;
+        };
+};
+
 #--------------------
 # Multi DAI links
 #--------------------
-- 
2.25.1

