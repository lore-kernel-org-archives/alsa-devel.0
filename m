Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9263BC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 17 May 2022 05:50:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACEDF1637;
	Tue, 17 May 2022 07:49:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACEDF1637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652766618;
	bh=kz6HjQUF+iZH6y7yhFmVMAQ32EpSUEXXZpfPxyEmfr0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a/If4MWjQ+O8W+cbbxrSZiR0FJGDk/xL9G9lEJZYuPunoT3pfLXq3qFU4841ptGWg
	 PXCTub8P0L0/ACkBtHEIa1TlgphzSOpCbjY/5hOKIBfzw14fLevKK+5ayocXbMB9q7
	 tToyWrRgmzHoiPtqpW6QQXLhsvgo3juPoeweLKzw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9B69F80310;
	Tue, 17 May 2022 07:49:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AEAF4F8047C; Tue, 17 May 2022 07:49:01 +0200 (CEST)
Received: from 3.mo575.mail-out.ovh.net (3.mo575.mail-out.ovh.net
 [46.105.58.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90A54F80423
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2022 07:48:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90A54F80423
Received: from player756.ha.ovh.net (unknown [10.109.146.173])
 by mo575.mail-out.ovh.net (Postfix) with ESMTP id D5BE0228B2
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2022 05:48:53 +0000 (UTC)
Received: from mesotic.com (82-65-23-224.subs.proxad.net [82.65.23.224])
 (Authenticated sender: dylan.laduranty@mesotic.com)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id 6DAEA29BF212E;
 Tue, 17 May 2022 05:48:50 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004b51d044b-0542-43a3-ac60-e8677916cc89,
 1BCD3FF435E24440D4B99C59F4910DCA014FE84C)
 smtp.auth=dylan.laduranty@mesotic.com
X-OVh-ClientIp: 82.65.23.224
From: Dylan Laduranty <dylan.laduranty@mesotic.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2 v3] dt-bindings: ADAU7118: add new entries for pins drive
 strength
Date: Tue, 17 May 2022 07:48:09 +0200
Message-Id: <20220517054809.8244-2-dylan.laduranty@mesotic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517054809.8244-1-dylan.laduranty@mesotic.com>
References: <20220517054809.8244-1-dylan.laduranty@mesotic.com>
X-Ovh-Tracer-Id: 3982589449486781644
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrheeigdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhestddtredtredttdenucfhrhhomhepffihlhgrnhcunfgrughurhgrnhhthicuoeguhihlrghnrdhlrgguuhhrrghnthihsehmvghsohhtihgtrdgtohhmqeenucggtffrrghtthgvrhhnpeegjeegjedthfelgfekgeekiefhveeludelteetudefheekkedthefghfekuddvgfenucfkpheptddrtddrtddrtddpkedvrdeihedrvdefrddvvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejheeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepugihlhgrnhdrlhgrughurhgrnhhthiesmhgvshhothhitgdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegrlhhsrgdquggvvhgvlhesrghlshgrqdhprhhojhgvtghtrdhorhhg
Cc: Dylan Laduranty <dylan.laduranty@mesotic.com>, nuno.sa@analog.com
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

Update driver doc with new entries for managing pins drive strength.
Add a table to describe possible values for each entry.

Signed-off-by: Dylan Laduranty <dylan.laduranty@mesotic.com>
---

 Changes since v3:
 Add missing commit description message


 .../bindings/sound/adi,adau7118.yaml          | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau7118.yaml b/Documentation/devicetree/bindings/sound/adi,adau7118.yaml
index fb78967ee17b..226693ebd446 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau7118.yaml
+++ b/Documentation/devicetree/bindings/sound/adi,adau7118.yaml
@@ -51,6 +51,42 @@ properties:
       maximum: 1
     default: [0, 0, 1, 1]
 
+  adi,pdm-clk0-ds:
+    description: |
+      This property set the drive strength of PDM CLK0 output pad.
+      Possible values are: 0, 1, 2, 3 as per the following table:
+      0 = 2.5 mA / 3.3V
+      1 =   5 mA / 3.3V
+      2 =  10 mA / 3.3V
+      3 =  25 mA / 3.3V
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [3, 2, 1, 0]
+    default: 2
+
+  adi,pdm-clk1-ds:
+    description: |
+      This property set the drive strength of PDM CLK1 output pad.
+      Possible values are: 0, 1, 2, 3 as per the following table:
+      0 = 2.5 mA / 3.3V
+      1 =   5 mA / 3.3V
+      2 =  10 mA / 3.3V
+      3 =  25 mA / 3.3V
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [3, 2, 1, 0]
+    default: 2
+
+  adi,sdata-ds:
+    description: |
+      This property set the drive strength of SDATA output pad.
+      Possible values are: 0, 1, 2, 3 as per the following table:
+      0 = 2.5 mA / 3.3V
+      1 =   5 mA / 3.3V
+      2 =  10 mA / 3.3V
+      3 =  25 mA / 3.3V
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [3, 2, 1, 0]
+    default: 2
+
 required:
   - "#sound-dai-cells"
   - compatible
@@ -73,6 +109,9 @@ examples:
                 dvdd-supply = <&supply>;
                 adi,pdm-clk-map = <1 1 0 0>;
                 adi,decimation-ratio = <16>;
+                adi,pdm-clk0-ds = <3>;
+                adi,pdm-clk1-ds = <3>;
+                adi,sdata-ds = <3>;
         };
     };
 
-- 
2.17.1

