Return-Path: <SRS0=HX6w=5I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B2C4332B
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:57:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB9E20735
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MsPtt+rN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsLAT8+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB9E20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8093D1664;
	Mon, 23 Mar 2020 14:56:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8093D1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584971863;
	bh=x9N45CHzpUAUbANIthTeDN1wj3zIAuO24FE24TgsBWA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MsPtt+rNy379Y4YloUmseCJ4vOa74hV4WtObXWEl4fqQ4h48ccWy2zMkP2K2lShnW
	 2T4MzejW2b5LeHt4RqoibViRA0IUSSJ40+/d1s0wA9J6B3s+MxESXHscLJinGv7xl7
	 uDKT+g7K00opf27dEWDf2htT3moTwGRCGY5BxVxQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3EF3F80317;
	Mon, 23 Mar 2020 14:47:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38A90F8022B; Sat, 21 Mar 2020 12:40:39 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E887F801DB
 for <alsa-devel@alsa-project.org>; Sat, 21 Mar 2020 12:40:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E887F801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="LsLAT8+u"
Received: by mail-wr1-x442.google.com with SMTP id 31so4566208wrs.3
 for <alsa-devel@alsa-project.org>; Sat, 21 Mar 2020 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=7jR/DJniamHEDhpAAfPOcbN20Xg7ftVEruh/hyhO0PE=;
 b=LsLAT8+uDmGSdQQJntAF8vnUqUnpGplRkCu3wIrpjOm72QwxiPSyucWszlZYxKozpk
 qp1vUdTtSmAetmlLU6jTQsYrGZZvda/aPVoulZxELtCJkR0Tsk815tDkL+3HK/YXbxmF
 jtLdYdPDUeiOXDU/BXFfAiZiw+i+o+K8v/k6ReFNHkMNTlclmAibR2TVRvpJfZhdkJjf
 PO6EcEnhKLmfdn1TCVDGkM0VDNM4QsMMh+da0N9WrkDmlYc+Nei1FaumMXpQqwIkgw4S
 CSLK6Su/ZLNqr4Y5WZVY9LyUUDLzSlUN8nngsIj++Gs1w7nQoRTiQsF98zCyGaGin7Oz
 uAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7jR/DJniamHEDhpAAfPOcbN20Xg7ftVEruh/hyhO0PE=;
 b=bTd+O7vpv22jhKWc/Y8KBCBWzHwy2wAxa1P9tKkyvsOyeqoQSLu6cPqh+xVFbgUYX4
 Sbn2wt+tu2jnzg1Iyuv6seOKsa55LWUxfhH0jJpzwzt4F9ljRwWjaSMOKTJZAeTsXx53
 ITgtab94Yl6A6LXR89ZvCN832LKF8rJMNqkwDp7vgXeemrHIc98iLLij4luCH0m3CNqu
 H2dSK43Zq8eizZhH/8fhRA7tAvVeFvKaFvw7bzqKpf3sSaDGt2Hnqn/XcTWtTgZZMzrh
 nFjV/vVv4bC84Tpk1/SZy/EEjm23R7feRs3IZWmgc/VRJG5XWNSr2YEH3h2ppBQCWYxQ
 4BZQ==
X-Gm-Message-State: ANhLgQ28GevxqSxGIPcor6OOHAWuT+9Z2nn3Zu1UgT102B6ba/SQ4u/P
 mQFGE0spWXzHxBC+3MfLG2I=
X-Google-Smtp-Source: ADFU+vvxfx5Oi42isr8/wePrVDB2XPv0PjWByfMkPVW34u6Ng9Fb9YvXxU3xXUegrdwEReYm41u9Cg==
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr17009174wrw.52.1584790834729; 
 Sat, 21 Mar 2020 04:40:34 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d49:b100:e503:a7c7:f4c6:1aab])
 by smtp.gmail.com with ESMTPSA id t16sm9533091wra.17.2020.03.21.04.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 04:40:34 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jeff Chang <jeff_chang@richtek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: MT6660: make spdxcheck.py happy
Date: Sat, 21 Mar 2020 12:40:22 +0100
Message-Id: <20200321114022.8545-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 23 Mar 2020 14:47:38 +0100
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 linux-spdx@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

The SPDX-License-Identifier shall not be suffixed with anything further.
This makes ./scripts/spdxcheck.py complain:

  sound/soc/codecs/mt6660.c: 1:36 Invalid token: //

Clean up SPDX-License-Identifier line to make spdxcheck.py happy.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 sound/soc/codecs/mt6660.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/mt6660.c b/sound/soc/codecs/mt6660.c
index a36c416caad4..06ab1d39d2c1 100644
--- a/sound/soc/codecs/mt6660.c
+++ b/sound/soc/codecs/mt6660.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 //
+// SPDX-License-Identifier: GPL-2.0
 
 // Copyright (c) 2019 MediaTek Inc.
 
-- 
2.17.1

