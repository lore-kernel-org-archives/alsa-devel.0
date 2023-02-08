Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3396C636CC
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Feb 2023 14:21:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E34C6836;
	Wed,  8 Feb 2023 15:20:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E34C6836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675866086;
	bh=IRarZelYPmBHrTv8mYRAQ2aRcwLzEdk+ohpigPdbaOQ=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bLoDNyVWtEeFnoijmVZV2zN1VxpFPzhr1AAj2O6xLKUIZi44lFjJ6ETvUFst9xl7+
	 DtLosVCBdr9jCDNxgE2baSV/XRCVGLrXxCtGkHhQw7TrPKNPIptSq0k+xjk726i6h8
	 O4mwqijGePy7deVG0xkP2Pa0g8qZ4eMYgmvORLlM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C2C3F80558;
	Wed,  8 Feb 2023 15:19:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A44CF8012B; Wed,  8 Feb 2023 15:18:54 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 581CEF804CC
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2023 15:18:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 581CEF804CC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=kX27tt2A
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net
 [82.11.51.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: tanureal)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 29AB466020F0;
	Wed,  8 Feb 2023 14:18:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1675865924;
	bh=IRarZelYPmBHrTv8mYRAQ2aRcwLzEdk+ohpigPdbaOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kX27tt2A0op5ijS6BRs55dT7wGT/5eGHN6IWw3UIu6yBLbyw9YrqcjBS4hXZom//S
	 7/5LiPYoWhS1tRL8ANOpq4RcxF7ghiKh5DZFITEU5PdqmSdctWqCRZYcs6C92yDQ0H
	 5E1EhMGvDCVBa2ZCcZunSQgb0R48xAbaqnEMrmHeTWQJfbjEud9g/5mmFQ4KEs7NpL
	 GmFsaSDNe46hJxSI8Ivp0qjbfazwjEgtNW6akBcF6PBQDfx6k8UM2o6KUbpx2+hxPu
	 WXW2uil13hPcEoxctJswaE/HoWIm/+DIzj4R/grdU4lhVmlLttkaVEJ2NMjLTYweaO
	 VQoCWMY89SlFw==
From: Lucas Tanure <lucas.tanure@collabora.com>
To: David Rhodes <david.rhodes@cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 4/4] ASoC: cs35l41: Document CS35l41 shared boost
Date: Wed,  8 Feb 2023 14:18:39 +0000
Message-Id: <20230208141839.1097377-5-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208141839.1097377-1-lucas.tanure@collabora.com>
References: <20230208141839.1097377-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: E7AZ74TJR55GVIVMUB74HNE3YWSWTT3H
X-Message-ID-Hash: E7AZ74TJR55GVIVMUB74HNE3YWSWTT3H
X-MailFrom: lucas.tanure@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E7AZ74TJR55GVIVMUB74HNE3YWSWTT3H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Describe the properties used for shared boost configuration.
Based on David Rhodes shared boost patches.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 .../devicetree/bindings/sound/cirrus,cs35l41.yaml      | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
index 51d815d0c696..74f08a6cf95c 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
@@ -82,11 +82,19 @@ properties:
       boost-cap-microfarad.
       External Boost must have GPIO1 as GPIO output. GPIO1 will be set high to
       enable boost voltage.
+      Shared boost allows two amplifiers to share a single boost circuit by
+      communicating on the MDSYNC bus. The passive amplifier does not control
+      the boost and receives data from the active amplifier. GPIO1 should be
+      configured for Sync when shared boost is used. Shared boost is not
+      compatible with External boost. Active amplifier requires
+      boost-peak-milliamp, boost-ind-nanohenry and boost-cap-microfarad.
       0 = Internal Boost
       1 = External Boost
+      2 = Shared Boost Active
+      3 = Shared Boost Passive
     $ref: "/schemas/types.yaml#/definitions/uint32"
     minimum: 0
-    maximum: 1
+    maximum: 3
 
   cirrus,gpio1-polarity-invert:
     description:
-- 
2.39.1

