Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0DEC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:39:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C219207D8
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VyY2MZVh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hXvY1bBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C219207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D69FD190B;
	Thu, 25 Jun 2020 17:38:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D69FD190B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593099539;
	bh=LBnAqOWvMF0TwLhGFH/6+nLIeIq3MkoxXPwGb1WfbZo=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VyY2MZVhgkkZBOmxrd7EVZyVLUCcDJItHQTv9/k9B5f6G4WtyO793SJXRsvqSaDUu
	 WYVou0muAvRnKcvf3Ox4EHlOk6a5FVh+9G+RMmuGnKf/7KsrwsS46OdfudFIpQMdnh
	 IpHErj1aG4OD7HkZ2BgXLhlK+jI2Xljd1SYYCRtE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B910FF80277;
	Thu, 25 Jun 2020 17:36:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E6FCF802A9; Thu, 25 Jun 2020 17:36:09 +0200 (CEST)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A61C6F80277
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 17:36:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A61C6F80277
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="hXvY1bBA"
Received: by mail-yb1-xb4a.google.com with SMTP id s7so6306074ybg.10
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=EFwYktgb+C9BYJHmu4sWEq4oKpCBtteUl7A5uy2GvuY=;
 b=hXvY1bBAik21jodL1xH+xztiZ0BH1qhw9qEM1TIlNqxE/E58OC9JNA2ELWS74b7+fx
 T3dhYNMcCtOBHicFTj7ZecjcLzHYaSx23pnRqwzBQXF4H0EJft6pR0miShp+x3xo0fva
 g3GBp+gbWPQhU8xW0dP8z/SeXiGzo1GB4iJVyuM1hFCsz+hEdK0NJMWbj1sUMi/TpL7G
 dAQ86DSl+K+bwdFl3QD61S6xmyAUK+B/+/QjqC1Rcxe7gt9H/YMllHHqViS8hX+Alkur
 BkoW3mjUqbAL7kb06UlkWANghPV5hcyQ+W7pgD22gp9Gc60qwO/CmsGhpSswxH5Nuhj9
 hC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=EFwYktgb+C9BYJHmu4sWEq4oKpCBtteUl7A5uy2GvuY=;
 b=CpVih+/TtzHN3ji0ap1v82rnk5vtOocD/LRmAoO5PczOMf6X3XQH/07TKSsDkCSF8I
 aOufBYpEWOp68FVHQ7TvDTDuqAMk/pEozWCL0wILBtJT2WxyykFeCcl8++mHMX+D1OBm
 sg/yCQuaBSK+BbAjSwlweQ8w2LxyLQQeAwfEoE8hwr1sXVOJRlOdXq5dB+0stVjcNL5Y
 WvPnx6pVpXBg68MToOockQBa529FGwJeJ4C92dFak8hEC6+I1Tn5XxGExq6qmG3B5MyN
 43qpi2aN4z6hWiIXW2ZrSwmDBcg4yRkSzWPS3xsQ/VDy+UHP04MZKw2g9kFb9O+amKIc
 NKvw==
X-Gm-Message-State: AOAM530CpSsNPd8iWsIZeO31cg5e6d/NlUtf7a7Cr+LmLQzsUcyg5Daf
 GLvLhigZ7+bUvfDjamHsVJU8ptNg/CW+
X-Google-Smtp-Source: ABdhPJws1siCEPawyCnky3MCrEEnI0np3dsitr9yXn3ymNEJMHk1ScmAn+/Dbc1LT9K1p7aCSgvNx0JfRWJL
X-Received: by 2002:a25:4cc8:: with SMTP id
 z191mr51525018yba.211.1593099365099; 
 Thu, 25 Jun 2020 08:36:05 -0700 (PDT)
Date: Thu, 25 Jun 2020 23:35:43 +0800
In-Reply-To: <20200625153543.85039-1-tzungbi@google.com>
Message-Id: <20200625153543.85039-4-tzungbi@google.com>
Mime-Version: 1.0
References: <20200625153543.85039-1-tzungbi@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 3/3] ASoC: rt1015: add missing header inclusion
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

To fix compilation error:

error: implicit declaration of function 'ACPI_PTR'
[-Werror,-Wimplicit-function-declaration]
                .acpi_match_table = ACPI_PTR(rt1015_acpi_match),
		                    ^

Adds the missing header "acpi.h" inclusion and sorts in alphabetical.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/rt1015.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 1f61b4aa4353..548f68649064 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -8,23 +8,24 @@
 //
 //
 
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/delay.h>
+#include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
-#include <linux/i2c.h>
-#include <linux/platform_device.h>
-#include <linux/firmware.h>
-#include <linux/gpio.h>
 #include <sound/core.h>
+#include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <sound/soc.h>
 #include <sound/soc-dapm.h>
-#include <sound/initval.h>
+#include <sound/soc.h>
 #include <sound/tlv.h>
 
 #include "rl6231.h"
-- 
2.27.0.212.ge8ba1cc988-goog

