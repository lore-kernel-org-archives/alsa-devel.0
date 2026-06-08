Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F3ACD8C9D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:32:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBC1B6026B;
	Mon,  8 Jun 2026 13:32:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBC1B6026B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780918341;
	bh=PWcx8/Dn+2xQh7F9PERadP/6V3dIclTt9+aSzlSjToc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XwtMfyGhDKD7FN2KPKsfHSB/Q1/+LBKSB9hX53JLoQQee5HIgAd+oSqcBLKaHK7GG
	 dbUnnl3R/1O2QEEvTf1WQT9jWeI7TuVC33Yf8xlrVd9ARii4NfWHIiG70syQCY16dj
	 jo5Ys3Sj8xcuNG+vPghn0t3XxFo7O4M7UiERuvVY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D17F6F806D1; Mon,  8 Jun 2026 13:30:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EBFFEF806C5;
	Mon,  8 Jun 2026 13:30:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 474C0F8001F; Mon,  8 Jun 2026 10:35:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=202.108.3.212
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780907756;
	b=EEXl368l7z5JjgO4jB9NTdZuwh/2ecLEL/V/T0YG9kVPVrpzt/8W3RfhsePmTIohiuMR
	 6935qZOTbaPo/Q82z++pBPyi1snQOvmHQ1ZfQO6Zl7QopEn5GZrVfA9v+hh4dRo2W3j1h
	 NBOqmGcPXMzKzQScpdgyz6n6UwQlXzPUr4f49DJMcJg/WUdnwQ/HqsY8g15QiHdUeBnMS
	 qWi8fLgqZKmAieH2jmCZSLzp7+pIoo55iLLZsZ+hVXr8Md9zHjQaQ677+Kq1qtNn4cfLK
	 awt73Kwima2ObY5uqMZQSZnvHfdIz0/2KvAIaFZeSI9F8+BQHlJnPx2FW+ZDUXCGzHA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780907756;
	h=From:To:Subject:Date:Message-Id;
	bh=PWcx8/Dn+2xQh7F9PERadP/6V3dIclTt9+aSzlSjToc=;
	b=KOODC5R/ynUsPd6hD6jatFqecpUTmlhQilR36PJevKF2ZADs/tPoJb2RbXmqko4XtiQ9
	 S4hQP+fCTHc+ReWJDIJxcnwUce45Jj3R+Jdnqq3cInOcDDNBGN3zkuQRI+6Z1EANvhrI5
	 rYCGRdCKcAsURTzjS6n8Yqtp1ViVl3xGptuzJW76IRyc9xt9tVvL5hEYXgFYDQgnrB0cV
	 I0j2fF6gRW8nTQcelWTJ7nH16WzZPvXb4IUW5zxtsFdVXwpbgB4GuYL68cxFK6Y3KkuoE
	 tJD/wMAyPVk3RmBaifkqB2ZDHJSOkoxAOOleeSXMESz+XAVZPPpw3Eeqe3NHir6zo5g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=202.108.3.212
Received: from r3-212.sinamail.sina.com.cn (r3-212.sinamail.sina.com.cn
 [202.108.3.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 798FFF8001F
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 10:35:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 798FFF8001F
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.38) with ESMTP
	id 6A267EDF00000BB8; Mon, 8 Jun 2026 16:35:51 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 5B284E84CEFC4205A5584B854CE328A2
X-SMAIL-UIID: 5B284E84CEFC4205A5584B854CE328A2-20260608-163551
From: Michael Zhang <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org
Cc: tiwai@suse.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Zhang Yi <zhangyi@everest-semi.com>
Subject: [PATCH v0 7/7] ASoC: dt-bindings: ES8389: Add members about HPF
Date: Mon,  8 Jun 2026 16:35:40 +0800
Message-Id: <20260608083540.12581-8-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260608083540.12581-1-zhangyi@everest-semi.com>
References: <20260608083540.12581-1-zhangyi@everest-semi.com>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: I5PGJX7SSCI7XX4BBVHMAPZEHFANSIUX
X-Message-ID-Hash: I5PGJX7SSCI7XX4BBVHMAPZEHFANSIUX
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:30:12 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I5PGJX7SSCI7XX4BBVHMAPZEHFANSIUX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Zhang Yi <zhangyi@everest-semi.com>

Add members related to HPF

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 .../bindings/sound/everest,es8389.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8389.yaml b/Documentation/devicetree/bindings/sound/everest,es8389.yaml
index 75ce0bc48904..eb4639f60f09 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8389.yaml
+++ b/Documentation/devicetree/bindings/sound/everest,es8389.yaml
@@ -38,6 +38,22 @@ properties:
     description:
       Interface power supply.
 
+  everest,hpfl:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      the HPF value of ADCL.
+    minimum: 0x00
+    maximum: 0x0f
+    default: 0x0a
+
+  everest,hpfr:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      the HPF value of ADCR.
+    minimum: 0x00
+    maximum: 0x0f
+    default: 0x0a
+
 required:
   - compatible
   - reg
@@ -58,5 +74,7 @@ examples:
         #sound-dai-cells = <0>;
         vddd-supply = <&vdd3v3>;
         vdda-supply = <&vdd3v3>;
+        everest,hpfl = [0a];
+        everest,hpfr = [0a];
       };
     };
-- 
2.54.0.windows.1

