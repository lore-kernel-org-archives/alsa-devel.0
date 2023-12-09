Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19174C4167B
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Dec 2023 08:17:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D9F2DEE;
	Sat,  9 Dec 2023 09:17:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D9F2DEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702109839;
	bh=8uiQoXrAE0/J7rHNP+dncSfFy0He924o58HK9Rx1Pro=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZHTigcYqFSVXRouKCGgO4kzBfU9PpK0peVlu0SVvMCN0KmPh2MFMry4AydHxvstV7
	 tONts9j7BdBCT4WynFj9nLBy7gJOhMiTwptioRySgNgKCBHn/V07rcfRCjFW9vGk9M
	 C/3/sQH7xgblGwrhe+I7+e2/6AC46c2EYeJbmMsk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E56D9F8059F; Sat,  9 Dec 2023 09:16:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A9585F805C4;
	Sat,  9 Dec 2023 09:16:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF851F8025A; Sat,  9 Dec 2023 09:08:54 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7D2FBF800F5
	for <alsa-devel@alsa-project.org>; Sat,  9 Dec 2023 09:08:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D2FBF800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=ti-com-17Q1 header.b=g+vN7t84
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B9882TF054908;
	Sat, 9 Dec 2023 02:08:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702109282;
	bh=0A5dgG5e8t8hFbkQsmKr04qZPph+V/aEN1MHzvY6hVo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=g+vN7t846qj5ar33iUK3xG4DCTVpHewbFh+WreOVj0+96UgZuN/xh2pzD9Hy++IJi
	 SNZy0EtiMnxzKMlMCFFMmncwACGZu+FvsMkONh40PZLxVPO/CgT3vw4CZuKwGZzpdj
	 qab+YHefwogK037ppf8Ctp9+nLHTota2DserFPro=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B9882xl019101
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 9 Dec 2023 02:08:02 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 9
 Dec 2023 02:08:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 9 Dec 2023 02:08:02 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.163.83])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B987lHF122124;
	Sat, 9 Dec 2023 02:07:58 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <soyer@irl.hu>, <tiwai@suse.de>, Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v1 3/3] ASoC: dt-bindings: Add tas2563 into yaml
Date: Sat, 9 Dec 2023 16:07:42 +0800
Message-ID: <20231209080742.1290-3-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20231209080742.1290-1-shenghao-ding@ti.com>
References: <20231209080742.1290-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Message-ID-Hash: C37DKVR7ABT22MWU3WMMAFVYQEEWRWRL
X-Message-ID-Hash: C37DKVR7ABT22MWU3WMMAFVYQEEWRWRL
X-MailFrom: shenghao-ding@ti.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C37DKVR7ABT22MWU3WMMAFVYQEEWRWRL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Support tas2563.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 .../devicetree/bindings/sound/ti,tas2781.yaml   | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index a69e6c223308..84e197e15df4 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -11,11 +11,11 @@ maintainers:
   - Shenghao Ding <shenghao-ding@ti.com>
 
 description:
-  The TAS2781 is a mono, digital input Class-D audio amplifier
-  optimized for efficiently driving high peak power into small
-  loudspeakers. An integrated on-chip DSP supports Texas Instruments
-  Smart Amp speaker protection algorithm. The integrated speaker
-  voltage and current sense provides for real time
+  The TAS2781/TAS2563 is a mono, digital input Class-D audio
+  amplifier optimized for efficiently driving high peak power into
+  small loudspeakers. An integrated on-chip DSP supports Texas
+  Instruments Smart Amp speaker protection algorithm. The
+  integrated speaker voltage and current sense provides for real time
   monitoring of loudspeaker behavior.
 
 allOf:
@@ -25,16 +25,19 @@ properties:
   compatible:
     enum:
       - ti,tas2781
+      - ti,tas2563
 
   reg:
     description:
-      I2C address, in multiple tas2781s case, all the i2c address
+      I2C address, in multiple AMP case, all the i2c address
       aggregate as one Audio Device to support multiple audio slots.
+      For tas2781, i2c address is from 0x38 to 0x3f; For tas2563,
+      i2c address is from 0x4e to 0x4f.
     maxItems: 8
     minItems: 1
     items:
       minimum: 0x38
-      maximum: 0x3f
+      maximum: 0x4f
 
   reset-gpios:
     maxItems: 1
-- 
2.34.1

