Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F611C2BB85
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 10:34:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC90F221EB
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 10:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S9mkoCIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC90F221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 236C51616;
	Thu, 16 Apr 2020 12:33:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 236C51616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587033262;
	bh=FSCrJVIHrHP1m+H2f5bWgdd26OKdJg2LRMbZ6X8EL5E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S9mkoCIJKFSthe41QTdvf4hnmFbdwkYRLsAuBNV6NZksVaClfPR698rd/HxNf+TSa
	 GlnVHEy8TAsbQsRvAL02op25B4mFjohKN+Jgs9WiYPub+iqua4gy/FpIGrv4Y81jda
	 2uYrPOhKmEdAUy9mqJxiedmUu1k/YAQtQYsiHwE4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AF3FF8028F;
	Thu, 16 Apr 2020 12:31:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 011F8F8027D; Thu, 16 Apr 2020 12:31:22 +0200 (CEST)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1965F8014E
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 12:31:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1965F8014E
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:fd83:81bb:c1d7:433d])
 by baptiste.telenet-ops.be with bizsmtp
 id TNWz2200j4dKHqf01NWzN6; Thu, 16 Apr 2020 12:31:11 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jP1nP-0001cz-Q0; Thu, 16 Apr 2020 12:30:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jP1nP-0003zO-OP; Thu, 16 Apr 2020 12:30:59 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Stefan Popa <stefan.popa@analog.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Kosina <trivial@kernel.org>
Subject: [PATCH trivial 6/6] ASoC: Fix misspellings of "Analog Devices"
Date: Thu, 16 Apr 2020 12:30:58 +0200
Message-Id: <20200416103058.15269-7-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416103058.15269-1-geert+renesas@glider.be>
References: <20200416103058.15269-1-geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmaengine@vger.kernel.org
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

According to https://www.analog.com/, the company name is spelled
"Analog Devices".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/codecs/ad1980.c  | 2 +-
 sound/soc/codecs/ad73311.c | 2 +-
 sound/soc/codecs/wm8782.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index c4414c725c1f945a..43b1337bac37f70f 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -2,7 +2,7 @@
 /*
  * ad1980.c  --  ALSA Soc AD1980 codec support
  *
- * Copyright:	Analog Device Inc.
+ * Copyright:	Analog Devices Inc.
  * Author:	Roy Huang <roy.huang@analog.com>
  * 		Cliff Cai <cliff.cai@analog.com>
  */
diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index 10daf61f02940b46..b98bf19f594e097f 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -2,7 +2,7 @@
 /*
  * ad73311.c  --  ALSA Soc AD73311 codec support
  *
- * Copyright:	Analog Device Inc.
+ * Copyright:	Analog Devices Inc.
  * Author:	Cliff Cai <cliff.cai@analog.com>
  */
 
diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index aa5577e364d01360..f89855c616ebe6e6 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -7,7 +7,7 @@
  * Author: Johannes Stezenbach <js@sig21.net>
  *
  * based on ad73311.c
- * Copyright:	Analog Device Inc.
+ * Copyright:	Analog Devices Inc.
  * Author:	Cliff Cai <cliff.cai@analog.com>
  */
 
-- 
2.17.1

