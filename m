Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022D9C2BD09
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:22:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5F5622AA;
	Mon,  1 Jul 2024 14:22:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5F5622AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719836559;
	bh=57mSqvK5F8icDZvtosz8MW5pSg98mK2P/IkbkOYFjBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dHLGQLwTyj694DJIvVa0H6JczUL5v7lZq5sF7H+w7zbDed32rmOWI7tZzlcwne6Bw
	 yt27UYZ8aTB7D9BS4eDpCaSt3OPcSzFem6yJto99gHXa7YgUN6B+DPIFdAy5Ak6+Dq
	 4ZE7jBj6dv/eX+V5WQfNEnqa6KQ6ZofjVAew9G3A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56BB6F806EC; Mon,  1 Jul 2024 14:20:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 00032F806DD;
	Mon,  1 Jul 2024 14:20:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A908F80266; Thu, 20 Jun 2024 19:58:04 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C76E9F801EB
	for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2024 19:58:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C76E9F801EB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=timesys-com.20230601.gappssmtp.com
 header.i=@timesys-com.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=v2Dr1uz9
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6e349c0f2bso138732766b.2
        for <alsa-devel@alsa-project.org>;
 Thu, 20 Jun 2024 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718906280;
 x=1719511080; darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLJSsUsQJimHeyehvy4obxzFbfnPiiocs4Of944Xm3I=;
        b=v2Dr1uz93QxOvgWvC9mtI+VbE6fJ7gw+zHNKv/3CD/z+PXe+TAdLoslPrJIcJABT1p
         Z9+qSxqN9oYNn2j5RnzteicEIVgnHDos474QUGedPETyGebE5/pDPuElTfEF3UzQ8QxF
         dcV2xp8FeMLSP+8q+2xGyTVLbxLE8cf3l7kx3AlC+W+TEv0qr9GvE5VzZAXpzfLhSNkO
         6661z+UPiJWxIDBm4UWUolugAU1SeZHcxgMbkAeH+rzho1y+pdoILSD5EBUp00OTbqM6
         K8Crdz1SaDb+spi3spoj626Kb/k3TxXqU5txwmYTtvlhXl/SZZ4C3IiWvpE+/WxnolXK
         +JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906280; x=1719511080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLJSsUsQJimHeyehvy4obxzFbfnPiiocs4Of944Xm3I=;
        b=euunJZI2Wblp1zkwm+U54d/LKbHKqPdZe/+mSDJs8vGM80is604pfxjEPXtpCaWnEW
         8baDmmw2AwC/TURwJ+jlppumefhZH58OcEK/9SGxil+K2xxNX1I+dn0pQqH7tbGlVg+n
         GnJb08/cUYos1lgQBFQsv4luSU/Wnl6EvHCoh8rhihJklJhDsgtH18n5r8LodAnlnrUE
         UxFmX20StTe+F3KSvwyx2TGUUfZukIy+L/R2J78uiwFb6GfeOqro3Ho6XjsjRil7KAg1
         KELC0FV7FA2zyQ1kBq9tPvMoASCZIHQcPrBRsS9l1tl+DAuDqXFWLLn6lwD0LLQ/g4ov
         E+rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcOZTu4HTMvFlh0J/C/O7CcUd3gla1LHTbVAiMuDHdrWN79Rtl89QseyE6z5FG2GquHhIDIGbqbXTpsytQpjQaIal7d8AKdz8vIag=
X-Gm-Message-State: AOJu0YwAes6k/qYwzKKJrCu2yWoAjhbguSZvA4vZAboq5HysKw6+XRMn
	veu8HRTUn1G28f7r5U5b7c31zxJXXafP7RdNqnv3ZacGXlyDaw/jMBaDJJ2dhVk=
X-Google-Smtp-Source: 
 AGHT+IGXtwYdokrlfBxhK8FxTp2sWYE+r/rA8OXrz8ajsAvjdcVPMUue0BkFzpXPCbEPXWGLdile5Q==
X-Received: by 2002:a17:907:8025:b0:a6f:147f:7d06 with SMTP id
 a640c23a62f3a-a6fab7de093mr273780966b.77.1718906280266;
        Thu, 20 Jun 2024 10:58:00 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f42e80sm781370766b.186.2024.06.20.10.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:59 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	Chancel Liu <chancel.liu@nxp.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Markus Elfring <Markus.Elfring@web.de>
Subject: [Patch v4 01/10] dt-bindings: dma: pl08x: Add dma-cells description
Date: Thu, 20 Jun 2024 19:56:32 +0200
Message-Id: <20240620175657.358273-2-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: piotr.wojtaszczyk@timesys.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 4RAA56UQFKMHQIT4CUTHHHUX7A3J62VX
X-Message-ID-Hash: 4RAA56UQFKMHQIT4CUTHHHUX7A3J62VX
X-Mailman-Approved-At: Mon, 01 Jul 2024 12:20:06 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4RAA56UQFKMHQIT4CUTHHHUX7A3J62VX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Recover dma-cells description from the legacy DT binding.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
Changes for v4:
- This patch is new in v4

 Documentation/devicetree/bindings/dma/arm-pl08x.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
index ab25ae63d2c3..191215d36c85 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
+++ b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
@@ -52,6 +52,13 @@ properties:
   clock-names:
     maxItems: 1
 
+  "#dma-cells":
+    const: 2
+    description: |
+      First cell should contain the DMA request,
+      second cell should contain either 1 or 2 depending on
+      which AHB master that is used.
+
   lli-bus-interface-ahb1:
     type: boolean
     description: if AHB master 1 is eligible for fetching LLIs
-- 
2.25.1

