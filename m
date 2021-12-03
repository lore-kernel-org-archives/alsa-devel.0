Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AE2C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Dec 2021 13:51:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C76522C0;
	Fri,  3 Dec 2021 14:50:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C76522C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638539500;
	bh=EUOOj1w5o/+kj169E0ovMXoLxYesUiGRUYC6RdweQy8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9BLRZS+y1mMP4c711WFsPtvGh7UGmOoODpLXqZyuqSqkNkiX9HWliZuA+5o9b8+j
	 VNBVvSSbvrk2jEJYU5JWX6jUUZJSbSBOZ2Q70MY2urqlA895FC8cz9xV5E7hKFh88a
	 dFuSFxNIwXTOmcvuCPtN3YWwVgZHacEv7u2xxdag=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96B7BF80475;
	Fri,  3 Dec 2021 14:50:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0EF4F8025C; Fri,  3 Dec 2021 14:50:06 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06A18F800D3
 for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2021 14:50:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06A18F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=fail reason="signature verification failed" (2048-bit key)
 header.d=collabora.com header.i=@collabora.com header.b="X7YFdJ4S"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: adalessandro) with ESMTPSA id C20161F46E6D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638539400; bh=EUOOj1w5o/+kj169E0ovMXoLxYesUiGRUYC6RdweQy8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X7YFdJ4S5uPncfB66kSY/ujNMHRrPRuCMZ7xNTVBSyp+xHujyxIwl8TVi5RJM/OIF
 qFACkQCk0Kmu+kwz9RNIRthQUfHR//fehHk7z2bPTCs7+aEN6zUKKuL9nXwZiYIC9u
 j/yR9r0FCnDfIbILm/d6xoqhEYFUULV0LvIgU1m2i8ewP/H2Euqyv8yroEOX5NPXb9
 SzLC/NCiWhHFLg9ndrpL+5nIWfksHSxdhPWilngCvqEXvCKlD089aKNkrum4QfXRRt
 MnCOLIs8qYo5MJGuFz+rUS0X/bO6dJTFqSUP7g6rxLYfi8ZK8e+ClIIgHEUM2wa2ys
 nge9Z6jKKi3Jw==
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] dt-bindings: tlv320aic31xx: Define PLL clock inputs
Date: Fri,  3 Dec 2021 10:49:28 -0300
Message-Id: <20211203134930.128703-3-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
References: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: ariel.dalessandro@collabora.com, kuninori.morimoto.gx@renesas.com,
 Xiubo.Lee@gmail.com, tony@atomide.com, shengjiu.wang@gmail.com, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, nicoleotsuka@gmail.com,
 broonie@kernel.org, bcousson@baylibre.com, michael@amarulasolutions.com,
 festevam@gmail.com
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

Add constants for the different PLL clock inputs in tlv320aic31xx.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 include/dt-bindings/sound/tlv320aic31xx.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/sound/tlv320aic31xx.h b/include/dt-bindings/sound/tlv320aic31xx.h
index 3a845fbba992..4a80238ab250 100644
--- a/include/dt-bindings/sound/tlv320aic31xx.h
+++ b/include/dt-bindings/sound/tlv320aic31xx.h
@@ -6,4 +6,9 @@
 #define MICBIAS_2_5V		2
 #define MICBIAS_AVDDV		3
 
+#define PLL_CLKIN_MCLK		0x00
+#define PLL_CLKIN_BCLK		0x01
+#define PLL_CLKIN_GPIO1		0x02
+#define PLL_CLKIN_DIN		0x03
+
 #endif /* __DT_TLV320AIC31XX_H */
-- 
2.30.2

