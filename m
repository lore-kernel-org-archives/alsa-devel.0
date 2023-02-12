Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCCDC636CC
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Feb 2023 14:55:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E5F2ED5;
	Thu, 16 Feb 2023 15:54:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E5F2ED5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676559333;
	bh=d6xopFInR0A/pTQ8VBQnZ0XquLmM0VM326XmH34u10g=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TKkb/3iokronftlUb6Fcmz4B4KaHGL6vZ4WeeHU9yOax/fMl4t6lcfoh94YqA1RBI
	 AaIK/cY+cqSlFRXAbwWnrm6FUe18LoyBBKxCgZ3ygOsegkjvuAZN03YOXl7ZbdU0v0
	 FUciywrNuOSkEdpVIpoS3X+fc5DxI01NaEjBNd9g=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FA9FF804FC;
	Thu, 16 Feb 2023 15:54:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AAFD2F804B0; Sun, 12 Feb 2023 16:41:44 +0100 (CET)
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6FC1DF800E4
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2023 16:41:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FC1DF800E4
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de
 [87.154.211.47])
	by soltyk.jannau.net (Postfix) with ESMTPSA id E6F8126F78F;
	Sun, 12 Feb 2023 16:41:35 +0100 (CET)
From: Janne Grunau <j@jannau.net>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	=?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 14/17] dt-bindings: sound: apple,mca: Add t8112-mca compatible
Date: Sun, 12 Feb 2023 16:41:24 +0100
Message-Id: <20230202-asahi-t8112-dt-v1-14-cb5442d1c229@jannau.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=j@jannau.net;
 h=from:subject:message-id; bh=d6xopFInR0A/pTQ8VBQnZ0XquLmM0VM326XmH34u10g=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuSX7Ccr21aeeiL1YfpZIaUNlz9XH+yfNfPDS7fTfEFX9
 vA4Gl542FHKwiDGwSArpsiSpP2yg2F1jWJM7YMwmDmsTCBDGLg4BWAi2qUMv9keZW9Y+T+47c3d
 PWsZ3yiGsKi9Ug9IYv0jYTvllMST22oM/2umt3nz/ljVdJdVuf/Yz9dNexRbDvf9iw2xXJ+4YnJ
 aIjcA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
Content-Transfer-Encoding: 8bit
X-MailFrom: j@jannau.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 6M3UPQQCJQ5RO5D4WEHPX6COKJ4DVR3Z
X-Message-ID-Hash: 6M3UPQQCJQ5RO5D4WEHPX6COKJ4DVR3Z
X-Mailman-Approved-At: Thu, 16 Feb 2023 14:54:03 +0000
CC: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6M3UPQQCJQ5RO5D4WEHPX6COKJ4DVR3Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The block found on Apple's M2 SoC is compatible with the existing driver
so add its per-SoC compatible.

Signed-off-by: Janne Grunau <j@jannau.net>

---
This trivial dt-bindings update should be merged through the asahi-soc
tree to ensure validation of the Apple M2 (t8112) devicetrees in this
series.
---
 Documentation/devicetree/bindings/sound/apple,mca.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/apple,mca.yaml b/Documentation/devicetree/bindings/sound/apple,mca.yaml
index 40e3a202f443..5c6ec08c7d24 100644
--- a/Documentation/devicetree/bindings/sound/apple,mca.yaml
+++ b/Documentation/devicetree/bindings/sound/apple,mca.yaml
@@ -23,6 +23,7 @@ properties:
       - enum:
           - apple,t6000-mca
           - apple,t8103-mca
+          - apple,t8112-mca
       - const: apple,mca
 
   reg:

-- 
2.39.1

