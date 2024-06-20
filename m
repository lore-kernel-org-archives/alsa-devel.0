Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531D0C2BA18
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jun 2024 08:51:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17F80E7D;
	Thu, 20 Jun 2024 10:51:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17F80E7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718873475;
	bh=rBkSeB69MknRRW1vvLLHZBCUsHjl3fAMU+GE38ZYnJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=flA4Mquf1Gz1c0P5/MQR50+dreRV0qXtcyoL0hJlq+e+Fi+7/kMR/jMsD681n4PpA
	 N2OSURjGAARlm/NN4xotrV+JHQ/gondYLTFicwZcZWNyEe36Ab0mNWg2LRwGWb81ys
	 hD2UrM31Kym50/5Raq8JMBzwW/RNT5FmpEDDtTZE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71F6CF80623; Thu, 20 Jun 2024 10:50:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E40FBF8061A;
	Thu, 20 Jun 2024 10:50:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A399BF804F2; Thu, 20 Jun 2024 10:43:49 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1BB23F80587
	for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2024 10:43:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BB23F80587
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=ew1lZeu1
Received: by mail.gandi.net (Postfix) with ESMTPA id 806CD20016;
	Thu, 20 Jun 2024 08:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718873000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQir0ryB/8aPBX/LEL6U1QothG+zRSSIaipi9sCzLmY=;
	b=ew1lZeu1oYh7noJ/c69BVNsPhRCTgkWHP3qwLlXxKKhYbGmkbHKPiXHyqURBfmqSYorKIm
	ScesK+S0610KGyeAzFMxdNifl136+7dKBnmCpdCAx8UtdDbqgk4Q+K/Fu8MmcJRUnXyEco
	aI8lxmr++LgOF8ZbFK5gZ80NcQ9Srn7oGRytUndRQtMbXrE1E9D2/NzYn3JAciPjbe/nV0
	fbWdYz4bqFuodE7bo8he2o4vth9amo92zSTDN+52ISW+898gFDU65YN4FIhuQ+i1cfnnOz
	LNJdsvWx4mTDJytFSARmGafznmz15swgkXh4wv7MOz2vBe4XOfKuwD+RIbgu2w==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 09/10] dt-bindings: sound: fsl,qmc-audio: Add support for
 multiple QMC channels per DAI
Date: Thu, 20 Jun 2024 10:42:56 +0200
Message-ID: <20240620084300.397853-10-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620084300.397853-1-herve.codina@bootlin.com>
References: <20240620084300.397853-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: ROIVK4OW4WHSR6YCXMM6AK2KPLEREBM2
X-Message-ID-Hash: ROIVK4OW4WHSR6YCXMM6AK2KPLEREBM2
X-MailFrom: herve.codina@bootlin.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ROIVK4OW4WHSR6YCXMM6AK2KPLEREBM2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The QMC audio uses one QMC channel per DAI and uses this QMC channel to
transmit interleaved audio channel samples.

In order to work in non-interleave mode, a QMC audio DAI needs to use
multiple QMC channels. In that case, the DAI maps each QMC channel to
exactly one audio channel.

Allow QMC audio DAIs with multiple QMC channels attached.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/fsl,qmc-audio.yaml         | 41 ++++++++++++++++---
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
index b522ed7dcc51..a23e49198c37 100644
--- a/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
@@ -12,7 +12,9 @@ maintainers:
 description: |
   The QMC audio is an ASoC component which uses QMC (QUICC Multichannel
   Controller) channels to transfer the audio data.
-  It provides as many DAI as the number of QMC channel used.
+  It provides several DAIs. For each DAI, the DAI is working in interleaved mode
+  if only one QMC channel is used by the DAI or it is working in non-interleaved
+  mode if several QMC channels are used by the DAI.
 
 allOf:
   - $ref: dai-common.yaml#
@@ -45,12 +47,19 @@ patternProperties:
       fsl,qmc-chan:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         items:
-          - items:
-              - description: phandle to QMC node
-              - description: Channel number
+          items:
+            - description: phandle to QMC node
+            - description: Channel number
+        minItems: 1
         description:
-          Should be a phandle/number pair. The phandle to QMC node and the QMC
-          channel to use for this DAI.
+          Should be a phandle/number pair list. The list of phandle to QMC node
+          and the QMC channel pair to use for this DAI.
+          If only one phandle/number pair is provided, this DAI works in
+          interleaved mode, i.e. audio channels for this DAI are interleaved in
+          the QMC channel. If more than one pair is provided, this DAI works
+          in non-interleave mode. In that case the first audio channel uses the
+          the first QMC channel, the second audio channel uses the second QMC
+          channel, etc...
 
     required:
       - reg
@@ -79,6 +88,11 @@ examples:
             reg = <17>;
             fsl,qmc-chan = <&qmc 17>;
         };
+        dai@18 {
+            reg = <18>;
+            /* Non-interleaved mode */
+            fsl,qmc-chan = <&qmc 18>, <&qmc 19>;
+        };
     };
 
     sound {
@@ -115,4 +129,19 @@ examples:
                 dai-tdm-slot-rx-mask = <0 0 1 0 1 0 1 0 1>;
             };
         };
+        simple-audio-card,dai-link@2 {
+            reg = <2>;
+            format = "dsp_b";
+            cpu {
+                sound-dai = <&audio_controller 18>;
+            };
+            codec {
+                sound-dai = <&codec3>;
+                dai-tdm-slot-num = <2>;
+                dai-tdm-slot-width = <8>;
+                /* TS 9, 10 */
+                dai-tdm-slot-tx-mask = <0 0 0 0 0 0 0 0 0 1 1>;
+                dai-tdm-slot-rx-mask = <0 0 0 0 0 0 0 0 0 1 1>;
+            };
+        };
     };
-- 
2.45.0

