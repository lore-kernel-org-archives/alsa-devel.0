Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20B1CA0ECE
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Sep 2023 07:01:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E223474C;
	Tue, 12 Sep 2023 09:00:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E223474C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694502086;
	bh=ER1H68SueDeOVjjouLYuVpxZRqEwX0KelXq1+5eSUyA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=aLxTgKPSBJMBX40dShocqozL5FPAW/o2+h8x64AnOZC7AYN1SI8MTwp9lN417BGaa
	 YgbnBKpT8oEUq9GJomC+wbUcmkFz0Gqw3gGoeihoswyCGnFdzNAHHkRKvZNUt74C2F
	 PbhymgXSYtcueOq3rJUSgiQH27hqYBh9QcfYopAE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23668F80579; Tue, 12 Sep 2023 08:59:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 93AC3F80579;
	Tue, 12 Sep 2023 08:59:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28471F8055A; Tue, 12 Sep 2023 08:59:40 +0200 (CEST)
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com
 [115.124.28.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5433EF80246
	for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2023 08:59:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5433EF80246
X-Alimail-AntiSpam: 
 AC=CONTINUE;BC=0.1476062|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.302725-0.000405716-0.696869;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.Ud9dop-_1694501955;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com
 fp:SMTPD_---.Ud9dop-_1694501955)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 14:59:22 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	rf@opensource.cirrus.com,
	shumingf@realtek.com,
	ckeepax@opensource.cirrus.com,
	herve.codina@bootlin.com,
	wangweidong.a@awinic.com,
	13916275206@139.com,
	ryans.lee@analog.com,
	linus.walleij@linaro.org,
	sebastian.reichel@collabora.com,
	fido_max@inbox.ru,
	povik+lin@cutebit.org,
	arnd@arndb.de,
	harshit.m.mogalapalli@oracle.com,
	liweilei@awinic.com,
	yijiangtao@awinic.com,
	colin.i.king@gmail.com,
	trix@redhat.com,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] ASoC: dt-bindings: Add schema for "awinic,aw87390"
Date: Tue, 12 Sep 2023 14:58:49 +0800
Message-ID: <20230912065852.347000-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912065852.347000-1-wangweidong.a@awinic.com>
References: <20230912065852.347000-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TQTF7UP4C43TM4C7CUEYB2ZDI6VTJDPR
X-Message-ID-Hash: TQTF7UP4C43TM4C7CUEYB2ZDI6VTJDPR
X-MailFrom: wangweidong.a@awinic.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TQTF7UP4C43TM4C7CUEYB2ZDI6VTJDPR/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Weidong Wang <wangweidong.a@awinic.com>

Add a DT schema for describing awinic aw87390 audio amplifiers.
They are controlled using I2C.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 .../bindings/sound/awinic,aw87390.yaml        | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw87390.yaml

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw87390.yaml b/Documentation/devicetree/bindings/sound/awinic,aw87390.yaml
new file mode 100644
index 000000000000..ba9d8767c5d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/awinic,aw87390.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/awinic,aw87390.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic Aw87390 Audio Amplifier
+
+maintainers:
+  - Weidong Wang <wangweidong.a@awinic.com>
+
+description:
+  The awinic aw87390 is specifically designed to improve
+  the musical output dynamic range, enhance the overall
+  sound quallity, which is a new high efficiency, low
+  noise, constant large volume, 6th Smart K audio amplifier.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: awinic,aw87390
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  awinic,audio-channel:
+    description:
+      It is used to distinguish multiple PA devices, so that different
+      configurations can be loaded to different PA devices
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - awinic,audio-channel
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        audio-codec@58 {
+            compatible = "awinic,aw87390";
+            reg = <0x58>;
+            #sound-dai-cells = <0>;
+            awinic,audio-channel = <0>;
+        };
+    };
-- 
2.41.0

