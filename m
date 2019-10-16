Return-Path: <SRS0=FfYG=YJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED06EFA3728
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:02:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A692067B
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o4wbyKj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A692067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF5AD845;
	Wed, 16 Oct 2019 14:02:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF5AD845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571227377;
	bh=AXl6uL5aQdjuuyt4nPdgmctaL1sN/jd80HFo46T0BCw=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o4wbyKj5/yN2ywJIgjoYtgCMgzHgjqZCetas/fMFSxS6sNHamI7pPhkKVUnv/sqHW
	 s5tzW2rgAGUQ9zZN583wMixxnGQmtNbN33g0t9WOH6jXoWzcKcGSF4FOZ9s6Wl4/Oa
	 /JuhdlHAJyJvK/CKsPD2y2VlHLfF4Ea/J+0wDks4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7476FF80322;
	Wed, 16 Oct 2019 14:02:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85683F80362; Wed, 16 Oct 2019 14:02:04 +0200 (CEST)
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBF4FF80322
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 14:02:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBF4FF80322
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
 by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
 id 1iKhzy-0006Vx-5I; Wed, 16 Oct 2019 13:01:50 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
 (envelope-from <ben@rainbowdash.codethink.co.uk>)
 id 1iKhzx-0001XM-KS; Wed, 16 Oct 2019 13:01:49 +0100
From: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk
Date: Wed, 16 Oct 2019 13:01:49 +0100
Message-Id: <20191016120149.5860-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 "Ben Dooks \(Codethink\)" <ben.dooks@codethink.co.uk>
Subject: [alsa-devel] [PATCH] ASoC: wm8958: use <asm/unaligned.h> to
	simplify code
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Simplify the memcpy/be32_to_cpu() code by simply using
get_unaligned_be32() throughout and makes the code nicer
to look at.

This fixes the following warnings from sparse:

sound/soc/codecs/wm8958-dsp2.c:62:26: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:62:26: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:62:26: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:62:26: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:62:26: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:62:26: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:69:15: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:69:15: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:69:15: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:69:15: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:69:15: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:69:15: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:72:18: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:72:18: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:72:18: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:72:18: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:72:18: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:72:18: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:91:17: warning: cast to restricted __be64
sound/soc/codecs/wm8958-dsp2.c:91:17: warning: cast to restricted __be64
sound/soc/codecs/wm8958-dsp2.c:91:17: warning: cast to restricted __be64
sound/soc/codecs/wm8958-dsp2.c:91:17: warning: cast to restricted __be64
sound/soc/codecs/wm8958-dsp2.c:91:17: warning: cast to restricted __be64
sound/soc/codecs/wm8958-dsp2.c:91:17: warning: cast to restricted __be64
sound/soc/codecs/wm8958-dsp2.c:91:17: warning: cast to restricted __be64
sound/soc/codecs/wm8958-dsp2.c:91:17: warning: cast to restricted __be64
sound/soc/codecs/wm8958-dsp2.c:91:17: warning: cast to restricted __be64
sound/soc/codecs/wm8958-dsp2.c:91:17: warning: cast to restricted __be64
sound/soc/codecs/wm8958-dsp2.c:108:29: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:108:29: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:108:29: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:108:29: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:108:29: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:108:29: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:120:26: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:120:26: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:120:26: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:120:26: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:120:26: warning: cast to restricted __be32
sound/soc/codecs/wm8958-dsp2.c:120:26: warning: cast to restricted __be32

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: patches@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/wm8958-dsp2.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 18535b326680..ca42445b649d 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -25,6 +25,8 @@
 #include <linux/mfd/wm8994/pdata.h>
 #include <linux/mfd/wm8994/gpio.h>
 
+#include <asm/unaligned.h>
+
 #include "wm8994.h"
 
 #define WM_FW_BLOCK_INFO 0xff
@@ -58,18 +60,15 @@ static int wm8958_dsp2_fw(struct snd_soc_component *component, const char *name,
 	}
 
 	if (memcmp(fw->data, "WMFW", 4) != 0) {
-		memcpy(&data32, fw->data, sizeof(data32));
-		data32 = be32_to_cpu(data32);
+		data32 = get_unaligned_be32(fw->data);
 		dev_err(component->dev, "%s: firmware has bad file magic %08x\n",
 			name, data32);
 		goto err;
 	}
 
-	memcpy(&data32, fw->data + 4, sizeof(data32));
-	len = be32_to_cpu(data32);
+	len = get_unaligned_be32(fw->data + 4);
+	data32 = get_unaligned_be32(fw->data + 8);
 
-	memcpy(&data32, fw->data + 8, sizeof(data32));
-	data32 = be32_to_cpu(data32);
 	if ((data32 >> 24) & 0xff) {
 		dev_err(component->dev, "%s: unsupported firmware version %d\n",
 			name, (data32 >> 24) & 0xff);
@@ -87,9 +86,8 @@ static int wm8958_dsp2_fw(struct snd_soc_component *component, const char *name,
 	}
 
 	if (check) {
-		memcpy(&data64, fw->data + 24, sizeof(u64));
-		dev_info(component->dev, "%s timestamp %llx\n",
-			 name, be64_to_cpu(data64));
+		data64 = get_unaligned_be64(fw->data + 24);
+		dev_info(component->dev, "%s timestamp %llx\n",  name, data64);
 	} else {
 		snd_soc_component_write(component, 0x102, 0x2);
 		snd_soc_component_write(component, 0x900, 0x2);
@@ -104,8 +102,7 @@ static int wm8958_dsp2_fw(struct snd_soc_component *component, const char *name,
 			goto err;
 		}
 
-		memcpy(&data32, data + 4, sizeof(data32));
-		block_len = be32_to_cpu(data32);
+		block_len = get_unaligned_be32(data + 4);
 		if (block_len + 8 > len) {
 			dev_err(component->dev, "%zd byte block longer than file\n",
 				block_len);
@@ -116,8 +113,7 @@ static int wm8958_dsp2_fw(struct snd_soc_component *component, const char *name,
 			goto err;
 		}
 
-		memcpy(&data32, data, sizeof(data32));
-		data32 = be32_to_cpu(data32);
+		data32 = get_unaligned_be32(data);
 
 		switch ((data32 >> 24) & 0xff) {
 		case WM_FW_BLOCK_INFO:
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
