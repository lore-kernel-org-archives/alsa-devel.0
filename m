Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2C0C54EAA
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Jan 2023 12:10:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87BAFEAB;
	Mon, 30 Jan 2023 13:09:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87BAFEAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675080612;
	bh=wy5L39BFMKrQQvzhCUrefjNpUTQMmUcvw5a7H2/NVdQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AtFLzOoP6aaGFEMZNW6OnsFnp5CTab3YOR82WNk2sTPhr+50gEzEdY2Dnu0iqTJE8
	 rSwPcFI7pqkgmyypV5anRBB2yBG3hZFhMi5KuD7P9hwG6akgNDnPrlY29m2o65duIU
	 UUC8yw7BZCJOxHbzJgyUk52x1Uz6bO7XWQ/6S2Ss=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0725F80579;
	Mon, 30 Jan 2023 13:08:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6215DF8056F; Mon, 30 Jan 2023 13:07:58 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6AB0F80567
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2023 13:07:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6AB0F80567
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=1SzI5Jb4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1675080476; x=1706616476;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wy5L39BFMKrQQvzhCUrefjNpUTQMmUcvw5a7H2/NVdQ=;
 b=1SzI5Jb4Sd6lJ0sIBqeSAqgzg4aX7itbi5tzA02O4IpXvRWpIVTexOIj
 AKMsGedCLo8OJYKTDqSiLXDEswE74hWiacDbTUI/OYvVA4i1MtEZPCLpg
 ecoMXsZhMdt8qQ2ORnV68g1IixKLi7ZXaP78DAsd8DnHLBLyIkZfHOg+3
 MebY3Q8pHEvuITaF9iXG9823PUW6ivpag1DMt3FF7YagQZE4SVk1NOwXK
 vq8IxUnk60e9NPEJCS/n0c4tu7BpJX1Q5P5DgTaCoZUY0aOY+Xw/qQAMh
 Nsu2dztNIysxk3458KmX4iw32CDPGkNLXCrtgYd4PWHKA8UpdXQhwBHCB Q==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669100400"; d="scan'208";a="134605337"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 30 Jan 2023 05:07:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 05:07:45 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 05:07:41 -0700
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/8] ASoC: mchp-spdifrx: remove struct mchp_spdifrx_dev::fmt
 member
Date: Mon, 30 Jan 2023 14:06:45 +0200
Message-ID: <20230130120647.638049-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130120647.638049-1-claudiu.beznea@microchip.com>
References: <20230130120647.638049-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Remove member fmt of struct mchp_spdifrx_dev as it is not used anywhere.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index 90b2fb3a9844..46fff31321f3 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -235,7 +235,6 @@ struct mchp_spdifrx_dev {
 	struct regmap				*regmap;
 	struct clk				*pclk;
 	struct clk				*gclk;
-	unsigned int				fmt;
 	unsigned int				trigger_enabled;
 	unsigned int				gclk_enabled:1;
 };
-- 
2.34.1

