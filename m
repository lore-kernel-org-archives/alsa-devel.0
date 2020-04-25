Return-Path: <SRS0=c9Fs=6J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C2EC54FCB
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 18:49:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83787206ED
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 18:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FuPzEvx6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="P5+CdrR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83787206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7EC81679;
	Sat, 25 Apr 2020 20:48:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7EC81679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587840540;
	bh=vB3ZKEo8rDHEl0IWQ4a9jcMqs45uDpwVPQfYX9368No=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FuPzEvx6lLL4Ctr8pRYx+CfsBcN6xb1we6pE4p9gWBATQ9lP86BMAuLPr83WJK9in
	 GWpULlt/wki06dFggyL949B1WWjsOv0jhMRjgY/JzgAeqHt16RF6+okF/ry7hOgfTA
	 K/UZDvarqu+j1zbhIyKVRHYfBEiIePkg7Tb8QZqM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36316F80159;
	Sat, 25 Apr 2020 20:48:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DC7BF801ED; Sat, 25 Apr 2020 20:48:08 +0200 (CEST)
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 129AEF80159
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2020 20:48:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 129AEF80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="P5+CdrR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1587840479;
 s=strato-dkim-0002; d=gerhold.net;
 h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=uAG86XGPqen4Dg22kJ3CPVajRoqLcvh1DDi1F0/W7Ek=;
 b=P5+CdrR91Ecp2e8sfM9DsvNuJo5Vf5kkjfmXUxE6lVyEPi4X27tUpEnoMuWyMrMZAN
 KuioY5p5241h/rTaVLy+XveMh1KzkqwehharRRBcfHshPmPVi0FOd8ff20fvgGyzB48D
 NSuIGenrRloPfGW+Q5drUmTL3q4MvVCVo8Zy93Aymib1RdDeYuEWeurXqlQiZNdzbH7b
 6llZ/Uv81cQL6/iThrZ/bP6ONwKU8MlFJnuM2K9x1iD1TrBAeGk7o3efvci5/tB2wqiN
 Rdzt/YlCZx+JCvcr3vyOSIEByDfxZhSe8ZabJUz/j7EpPwKxP0KSxWu8nZH0U5gVznTZ
 Acew==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6IlKY="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain by smtp.strato.de (RZmta 46.6.2 DYNA|AUTH)
 with ESMTPSA id 60b02dw3PIloKDT
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 25 Apr 2020 20:47:50 +0200 (CEST)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: sound: lpass-cpu: Document DAI subnodes
Date: Sat, 25 Apr 2020 20:46:56 +0200
Message-Id: <20200425184657.121991-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Stephan Gerhold <stephan@gerhold.net>, Patrick Lai <plai@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Kenneth Westfield <kwestfie@codeaurora.org>
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

The lpass-cpu driver now allows configuring the MI2S SD lines
by defining subnodes for one of the DAIs.

Document this in the device tree bindings.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
  - Clarify number of entries for qcom,playback/capture-sd-lines
  - Suggest more generic node names (dai@...) for children DAI device nodes

v1: https://lore.kernel.org/alsa-devel/20200406135608.126171-1-stephan@gerhold.net/
---
 .../bindings/sound/qcom,lpass-cpu.txt         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
index 21c648328be9..32c2cdb3d32f 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
@@ -30,6 +30,8 @@ Required properties:
 - reg			: Must contain an address for each entry in reg-names.
 - reg-names		: A list which must include the following entries:
 				* "lpass-lpaif"
+- #address-cells	: Must be 1
+- #size-cells		: Must be 0
 
 
 
@@ -37,6 +39,20 @@ Optional properties:
 
 - qcom,adsp		: Phandle for the audio DSP node
 
+By default, the driver uses up to 4 MI2S SD lines, for a total of 8 channels.
+The SD lines to use can be configured by adding subnodes for each of the DAIs.
+
+Required properties for each DAI (represented by a subnode):
+- reg			: Must be one of the DAI IDs
+			  (usually part of dt-bindings header)
+- qcom,playback-sd-lines: List of serial data lines to use for playback
+			  Each SD line should be represented by a number from 0-3.
+- qcom,capture-sd-lines	: List of serial data lines to use for capture
+			  Each SD line should be represented by a number from 0-3.
+
+Note that adding a subnode changes the default to "no lines configured",
+so both playback and capture lines should be configured when a subnode is added.
+
 Example:
 
 lpass@28100000 {
@@ -51,4 +67,13 @@ lpass@28100000 {
 	reg = <0x28100000 0x10000>;
 	reg-names = "lpass-lpaif";
 	qcom,adsp = <&adsp>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* Optional to set different MI2S SD lines */
+	dai@3 {
+		reg = <MI2S_QUATERNARY>;
+		qcom,playback-sd-lines = <0 1>;
+	};
 };
-- 
2.26.2

