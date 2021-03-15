Return-Path: <SRS0=ty8W=IN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54855C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 19:40:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D4B64DFD
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 19:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D4B64DFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9001E1934;
	Mon, 15 Mar 2021 20:39:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9001E1934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615837200;
	bh=EOTs2+EwjNAl/e5xkdGx+XyHQ3EVZCv1Gq8HWeEefb0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DQG61gtfZ7zAxB8+XTOX101qeR/QSo+PL5jS4nXPnX9n/acWi9zWvnJARUiHTbfMO
	 4Plap4+XeH7Sq38W8JTw1ZEGHNOXSobqYWnODJLjrGp3liIy+vtypAKtletf4SwazC
	 BGt1SazQaWGQ7fVpwn6PWwASoyYEj5uXjSAdQIEU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE8F5F80100;
	Mon, 15 Mar 2021 20:39:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E284F80171; Mon, 15 Mar 2021 20:39:07 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A405BF80100
 for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2021 20:38:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A405BF80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="LTrstFFh"
Received: by mail-qv1-xf32.google.com with SMTP id t16so8378604qvr.12
 for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2021 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j5iwX/IFSMt3h2ZEDu4oRP553pThlR+vqENZsQ96C8c=;
 b=LTrstFFh5NIGqfXGH7GH4QvaACZkDCRcBENi9HWtVtrX4ZrvKEAnkr6qXfjc00JaHd
 ijfiSHH6dPra7KeWkMc8P55GuJN9TTJPymeXg+kzTV+7FC/sRhQkW3CKX82tysawq40x
 AD6sDWMKz2IM+Zhr6f8k83tNOs2DTiBVuFsffSzLeuBdj4akWZDbuaqXjbEdAUrTJVry
 +34Wmx6mg1obcMOsunrejivsZ/LdWGbtpPJzC6IhO+VSUUyMS4Hia2iN5zQ1ublbWZW+
 EFwGIWtwcUHrd6f6jDwbAvZmfLI27eOV1pPQnSrE4S4TtqMFF07h5cRsMs8CS//KOF9/
 ytiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j5iwX/IFSMt3h2ZEDu4oRP553pThlR+vqENZsQ96C8c=;
 b=To7ZxSqDogWrh5Wa+EtjUT71FK93e47Jy++XkUR3Hv6zZOckx1DGcHEqISAzdIZRsg
 fboCUIg0K27xfmVH5k+Hd2WXWsaXvRshmbLLuZjlp7VtoG9NlPH6GW2c3J3E7Q903jG+
 Z7Qj0CUrbE0Up1D9Igbhv+EwXF6dqKsElDaGBI69zeWkjzgGq6N8SCxhI/ElP/b6qLvy
 gH0E91FU6Du1BPYSS6AHcoOq1sxstJFBIeeoJNdJIOqqpeWCY0cXnCiWxYl8MQJAyuq1
 xhgf0DziWj8uPVSbLAwqvIqBoa6WTIw6YK3FZlzoCGA3qCpopOyuQVqNRFg5p2frKz+z
 tfqA==
X-Gm-Message-State: AOAM533+k6V3kqk3F1hwHrUyhPuyTcfhSgx83F8S63jREO0HUUIsjTox
 IUh6Cf7ljiOREqy8WrPHMrE=
X-Google-Smtp-Source: ABdhPJzRPVkvmoA9L/ehmepAqGf5XS1OFry+k3CPaL1e1xrH5sWcJ2gZgRj2oB+Fedfa3RaNGVFgeA==
X-Received: by 2002:a0c:f349:: with SMTP id e9mr12439515qvm.59.1615837133190; 
 Mon, 15 Mar 2021 12:38:53 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:919::1000])
 by smtp.gmail.com with ESMTPSA id f186sm13493450qkj.106.2021.03.15.12.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 12:38:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Subject: [PATCH] ASoC: mx27vis: Remove unused file
Date: Mon, 15 Mar 2021 16:38:42 -0300
Message-Id: <20210315193842.183042-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
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

i.MX has been converted to a devicetree-only platform and
asoc-mx27vis.h is no longer used.

Get rid of this unused file.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 include/linux/platform_data/asoc-mx27vis.h | 12 ------------
 1 file changed, 12 deletions(-)
 delete mode 100644 include/linux/platform_data/asoc-mx27vis.h

diff --git a/include/linux/platform_data/asoc-mx27vis.h b/include/linux/platform_data/asoc-mx27vis.h
deleted file mode 100644
index 2107d0d992dd..000000000000
--- a/include/linux/platform_data/asoc-mx27vis.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PLATFORM_DATA_ASOC_MX27VIS_H
-#define __PLATFORM_DATA_ASOC_MX27VIS_H
-
-struct snd_mx27vis_platform_data {
-	int amp_gain0_gpio;
-	int amp_gain1_gpio;
-	int amp_mutel_gpio;
-	int amp_muter_gpio;
-};
-
-#endif /* __PLATFORM_DATA_ASOC_MX27VIS_H */
-- 
2.25.1

