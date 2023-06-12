Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07EEC7EE2E
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jun 2023 12:32:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 749AD84B;
	Mon, 12 Jun 2023 14:31:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 749AD84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686573143;
	bh=cvt4qSEMq/xa7Zrcpq+YtTKXlgndf6d5qkmGg4fmBF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WW546xkgbRCtjR4ip62ssqzSTQ/vx4DcG0sVAdvyEAimdz1hTp/SqVS55pk2ovpmn
	 bq6CXdJGh+6eZ4pd/Tk7d7VnT5dA6F6ba+C/LmwLyNIKU1AA9SrXIJHjJtCtOYALwM
	 E5DFnceKcQsDuHA+30ah2HKJzIOVSqzMyER/Zm+A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36E0DF8058C; Mon, 12 Jun 2023 14:30:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 53E02F8058C;
	Mon, 12 Jun 2023 14:30:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4E02F8056F; Mon, 12 Jun 2023 14:30:20 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6DBCBF80132
	for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2023 14:29:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DBCBF80132
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=YGKZRu7k
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1686572998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5N9NSA3ycLJUSucfBk1k0lUH03RfOeo/UXNYngARjpo=;
	b=YGKZRu7kczGFyQhYuKljB2H0wcRlSjCvrJZD4Qt0DkQMhhwcwYyKzpVCyOiSfd3DUbq1dA
	owP7TbiaJxnSfH3BxuJjA2hBU1KnPzVQrAjGXk6ZpqcISmaJY+Vby6UV/n43ekKfT8Y00s
	JSoPUt86Nc2LGk+pMT1Lo7cMFpx+zFlPoNqHOHJEArYidq3hEcNydXzLK+BPbwpnHCBaPi
	7Sr0d9LJ73yLetnEHdtS/mEDtI7LMP8BRAx+/ZK3Fjn10OoEeMXTeXBUmMLV+ad4Xmg7WZ
	BmLCeKt2lu9csLU2P/+zQlHhqEHWdKiono4xRrViTOUDbsKfgmEvR/qdiQe3nA==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 1036424000C;
	Mon, 12 Jun 2023 12:29:57 +0000 (UTC)
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 02/12] ASoC: dt-bindings: simple-card: Add additional-devs
 subnode
Date: Mon, 12 Jun 2023 14:29:16 +0200
Message-Id: <20230612122926.107333-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612122926.107333-1-herve.codina@bootlin.com>
References: <20230612122926.107333-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7DDGDRL6RMWU2EBBAVNPTRZROCE4USVR
X-Message-ID-Hash: 7DDGDRL6RMWU2EBBAVNPTRZROCE4USVR
X-MailFrom: herve.codina@bootlin.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7DDGDRL6RMWU2EBBAVNPTRZROCE4USVR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The additional-devs subnode allows to declared some virtual devices
as sound card children.
These virtual devices can then be used by the sound card and so be
present in the audio path.

The first virtual device supported is the audio IIO auxiliary device
in order to support an IIO device as an audio auxiliary device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/simple-card.yaml           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index b05e05c81cc4..59ac2d1d1ccf 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -148,6 +148,15 @@ definitions:
     required:
       - sound-dai
 
+  additional-devs:
+    type: object
+    description:
+      Additional devices used by the simple audio card.
+    patternProperties:
+      '^iio-aux(-.+)?$':
+        type: object
+        $ref: audio-iio-aux.yaml#
+
 properties:
   compatible:
     contains:
@@ -187,6 +196,8 @@ properties:
     $ref: "#/definitions/mclk-fs"
   simple-audio-card,aux-devs:
     $ref: "#/definitions/aux-devs"
+  simple-audio-card,additional-devs:
+    $ref: "#/definitions/additional-devs"
   simple-audio-card,convert-rate:
     $ref: "#/definitions/convert-rate"
   simple-audio-card,convert-channels:
@@ -359,6 +370,48 @@ examples:
         };
     };
 
+# --------------------
+# route audio to/from a codec through an amplifier
+# designed with a potentiometer driven by IIO:
+# --------------------
+  - |
+    sound {
+        compatible = "simple-audio-card";
+
+        simple-audio-card,aux-devs = <&amp_in>, <&amp_out>;
+        simple-audio-card,routing =
+            "CODEC LEFTIN", "AMP_IN LEFT OUT",
+            "CODEC RIGHTIN", "AMP_IN RIGHT OUT",
+            "AMP_OUT LEFT IN", "CODEC LEFTOUT",
+            "AMP_OUT RIGHT IN", "CODEC RIGHTOUT";
+
+        simple-audio-card,additional-devs {
+            amp_out: iio-aux-out {
+                compatible = "audio-iio-aux";
+                io-channels = <&pot_out 0>, <&pot_out 1>;
+                io-channel-names = "LEFT", "RIGHT";
+                snd-control-invert-range = <1 1>;
+                sound-name-prefix = "AMP_OUT";
+            };
+
+            amp_in: iio_aux-in {
+                compatible = "audio-iio-aux";
+                io-channels = <&pot_in 0>, <&pot_in 1>;
+                io-channel-names = "LEFT", "RIGHT";
+                sound-name-prefix = "AMP_IN";
+            };
+        };
+
+        simple-audio-card,cpu {
+            sound-dai = <&cpu>;
+        };
+
+        simple-audio-card,codec {
+            sound-dai = <&codec>;
+            clocks = <&clocks>;
+        };
+    };
+
 # --------------------
 # Sampling Rate Conversion
 # --------------------
-- 
2.40.1

