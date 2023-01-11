Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370A1C5479D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Jan 2023 13:51:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B138E747;
	Wed, 11 Jan 2023 14:50:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B138E747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673445068;
	bh=6oHgtmSl8WNmDwl22+JOCXB6qKPnm2EYrN9SzFL34ak=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GHr5NEodF54x7XoZ51euNcvUQYfpv1RkjgmcsWTSw+uHriLiFxabsJfTxoT1JjqRq
	 sXgaWwTD21Z4/tdCag8H3AtrwzmPjjOYRZEIpIURTxg0z7mYTZky7ZI8qYxlYrMMr7
	 DeO4VLCR703YzT6M14T66Liury0pzLA+i63gROP8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40569F8053A;
	Wed, 11 Jan 2023 14:49:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 100CEF80539; Wed, 11 Jan 2023 14:49:30 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52F6EF8051B
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2023 14:49:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52F6EF8051B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=ByaSXOKv
Received: (Authenticated sender: herve.codina@bootlin.com)
 by mail.gandi.net (Postfix) with ESMTPA id 9E34AFF802;
 Wed, 11 Jan 2023 13:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1673444966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9EnZLjG+M9U2ONqhUBGVZCcyMyK2X5wHaN45jR1ceg=;
 b=ByaSXOKvk4XEECyLn27Tk4Ldxvxm05KVnKRViSa66Hk/L1mzTW0KAhZ6+m64s+qGIQCqM+
 elsDF/epIy4V/u2A0zVBt2P49YhXxtnhz/EEMQw12FAkQSf4MOWbu/lZ0NpdyLMDXALo0U
 c87+3x9imIyZz+9/2Ul+WphA2uyg/+LOVsQCfjMHB0TDWuz2vUdZxvSQFcz0UELsZjq2np
 uO8GxdPQ1RhJFZGENK9PdGKov9nFqu+XwcT/Hl8sFe9TfkWs2gCdFGP5aXLT6cA//M1k3v
 vwKzbAx661jtzhKC/OV1y/HvrRMlRTofhyIAdU3iD/U/PtWLVNVDjTYVkTd8KA==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 3/3] MAINTAINERS: add the Renesas IDT821034 codec entry
Date: Wed, 11 Jan 2023 14:49:05 +0100
Message-Id: <20230111134905.248305-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230111134905.248305-1-herve.codina@bootlin.com>
References: <20230111134905.248305-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

After contributing the driver, add myself as the maintainer
for the Renesas IDT821034 codec.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9dcfadec5aa3..31115a7e01c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17809,6 +17809,13 @@ F:	Documentation/devicetree/bindings/net/renesas,*.yaml
 F:	drivers/net/ethernet/renesas/
 F:	include/linux/sh_eth.h
 
+RENESAS IDT821034 ASoC CODEC
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
+F:	sound/soc/codecs/idt821034.c
+
 RENESAS R-CAR GYROADC DRIVER
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-iio@vger.kernel.org
-- 
2.38.1

