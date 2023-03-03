Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB00BC64EC4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Mar 2023 17:45:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61BA3115E;
	Mon,  6 Mar 2023 18:44:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61BA3115E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678124734;
	bh=dRC2oYePSy+NpN70Oi3SVOL0aqbil/NIkk8MGh7RPYY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qpR4lCYULFGAWfMSz+DbMg/dHeT8diqWMS0AncbFdFzUJMVrHjYWKZh+YMbbTRNKL
	 Z0Qi/KKKcYAVtTimrdMOpUTjN5VAVH3AdinDM0ZoEnlcr+W5SXqjJW982cSfd/WBnV
	 9JeUEuKsh8J3eE8bYfAdXHD9icfs6QJd66ue8AOw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 475A6F805DF;
	Mon,  6 Mar 2023 18:40:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA448F8049C; Fri,  3 Mar 2023 11:04:22 +0100 (CET)
Received: from out-13.mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 19BF7F80266
	for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2023 11:04:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19BF7F80266
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=rd7E5pCy
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1677837852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hcYJmRGskfPRmhAdzc8S9FcZG/yfwAAq4mWaDd/Lugo=;
	b=rd7E5pCyZo37krxzehhlmD8gXrWZwmbdUMFvbrp5i9bDxMKlI0Kc5NyoCp1VzrEkLFV+sX
	zrFtUmqhONVRfp0Kf/fkeivHwOZWJbvgacU9S9x8tZsfZrwS6e/SKi7nwAczGrUORuoXge
	vJplx83DQ7aWwI3+pCGEmXnybm7CFIE=
From: richard.leitner@linux.dev
Date: Fri, 03 Mar 2023 11:04:02 +0100
Subject: [PATCH v2 2/3] ASoC: dt-bindings: maxim,max9867: add clocks
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230302-max9867-v2-2-fd2036d5e825@skidata.com>
References: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
In-Reply-To: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Ladislav Michl <ladis@linux-mips.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Benjamin Bara <benjamin.bara@skidata.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=richard.leitner@skidata.com; h=from:subject:message-id;
 bh=Iw/3nRyv551zpvZ9GVbHR0uIwA0KwrzA9i3bmK0aYNU=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFIYj0k9KNl0Scd945wXUcxPbVI3u8f7HnqVNbO4qWraz02s
 E8PbOkpZGMS4GGTFFFnsjbna3XPL3lcq6uTCzGFlAhnCwMUpABMpn8PIsOXiWQPl98q7PjyZs2PFzN
 fb/574dlby0Qol92zDb/7KGW0M/x36pip5rDGsn5FlEb95gul5/Ys/05V2Xjp0x9njZei9XzwA
X-Developer-Key: i=richard.leitner@skidata.com; a=openpgp;
 fpr=3F330A87476D76EF79212C6DFC189628387CFBD0
X-Migadu-Flow: FLOW_OUT
X-MailFrom: richard.leitner@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: JXJAUGPBSLM2UXFXUTODCJMAUOOUVSE7
X-Message-ID-Hash: JXJAUGPBSLM2UXFXUTODCJMAUOOUVSE7
X-Mailman-Approved-At: Mon, 06 Mar 2023 17:40:46 +0000
CC: Benjamin Bara <bbara93@gmail.com>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Richard Leitner <richard.leitner@skidata.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JXJAUGPBSLM2UXFXUTODCJMAUOOUVSE7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Richard Leitner <richard.leitner@skidata.com>

Add clocks property to require a "mclk" definition for the
maxim,max9867 codec.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 Documentation/devicetree/bindings/sound/maxim,max9867.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
index 74cd163546ec..6f27029b137d 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
@@ -35,9 +35,13 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
 required:
   - compatible
   - reg
+  - clocks
 
 additionalProperties: false
 
@@ -50,6 +54,13 @@ examples:
             compatible = "maxim,max9867";
             #sound-dai-cells = <0>;
             reg = <0x18>;
+            clocks = <&codec_clk>;
         };
     };
+
+    codec_clk: clock {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <12288000>;
+    };
 ...

-- 
2.39.2

