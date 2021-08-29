Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1D5C432BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 15:14:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFA061056
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 15:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBFA061056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dnyon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DC4E1760;
	Wed,  1 Sep 2021 17:13:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DC4E1760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630509258;
	bh=d+2QNTvIoV14dRg4l4dGxY/K6mqRrojAgpr6qjkd1vY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tn1t08qNPpq8+9+I2UnZTPxN21Z1BRUILH8Gkfj4z2IHuXnLaSEiYZbJ7KFKrLcqz
	 l1shKQq25cLlYlETIIGhSxPm5hG1N1QzzFZsnxRvHh1KcP4aQdCORIJ2GhymR5S0my
	 9fehdSpNK7+uYXj6nnYW9+jjPRMEJL9arnc8EzFA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15991F804D9;
	Wed,  1 Sep 2021 17:12:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37F8AF8025B; Sun, 29 Aug 2021 17:50:18 +0200 (CEST)
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2ADDF80169
 for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2021 17:50:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2ADDF80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=dnyon.com header.i=@dnyon.com
 header.b="Osy384ie"
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by dnyon.com (Postfix) with ESMTPSA id 44C304047D;
 Sun, 29 Aug 2021 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
 t=1630252202; bh=d+2QNTvIoV14dRg4l4dGxY/K6mqRrojAgpr6qjkd1vY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Osy384ieHriXcIo+oFdAZN118xCPRIeNgdh3SG47Yuvxa8GT3a7PTQAHpNvqleZ71
 A82drEb1RMbHvlB+SOE2fySWzXW/9s//juzRTYmD1wZJySnxSn06bhdMxnVK52z5eH
 43jwf/rzq6mR9tyJ1IyHbanN5niGc7Krc1SmQXOlHLKMpQurB1k3OKDVRGjEzbwoVw
 IYIe2YV3Fl2loGuCKL9F9Nze+qU+Wb6MRvNomHoGXx5Y9ahxk6hIfpFFwlDpo82Jjj
 HX5yMxELFE/PCrbbQxYdY2Gh5q0cMldXwyyFpNF57YBjUvHGuUJOsH5lrhbhjKd6sq
 GRPkDNrfzAPXA==
From: Alejandro Tafalla <atafalla@dnyon.com>
To: 
Subject: [PATCH 2/2] dt-bindings: sound: max98927: Add reset-gpios optional
 property
Date: Sun, 29 Aug 2021 17:45:44 +0200
Message-Id: <20210829154545.383119-3-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829154545.383119-1-atafalla@dnyon.com>
References: <20210829154545.383119-1-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Sep 2021 17:12:33 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Alejandro Tafalla <atafalla@dnyon.com>
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

Add the reset-gpios as an optional property because some devices might 
not need it to work properly.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/max9892x.txt b/Documentation/devicetree/bindings/sound/max9892x.txt
index f6171591ddc6..73733fb60136 100644
--- a/Documentation/devicetree/bindings/sound/max9892x.txt
+++ b/Documentation/devicetree/bindings/sound/max9892x.txt
@@ -30,6 +30,9 @@ Required properties:
 
   - reg : the I2C address of the device for I2C
 
+Optional Properties:
+  - reset-gpios : reference to the GPIO connected to the reset pin, if any.
+
 Example:
 
 codec: max98927@3a {
-- 
2.32.0

