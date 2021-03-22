Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE4EC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 21:02:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0E7619A2
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 21:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0E7619A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38F3885D;
	Mon, 22 Mar 2021 22:01:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38F3885D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616446943;
	bh=oe27PQJUMhkEiIPZpMyOr5f89DFCGebHuUuCMuzkWuU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h+VIURwx1mmK7HOcYQbeezrXV2f1aaVbPhwkYUA/M57g7LcB0fLq/pa/qgT6sEe8z
	 YAvNBfxRqkD3IJuef2tOhmr8pb7Z87NYp+1eFrU39ABYnSUS6hu1wJqkJYpucfsSPs
	 CXK1VF7ymDAqBrc+M3YcxtnIm+a5a7AVunL7PQHg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA3E8F80156;
	Mon, 22 Mar 2021 22:01:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A8C4F8016B; Mon, 22 Mar 2021 22:01:31 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98688F8012F
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 22:01:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98688F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="OL19KNMZ"
Received: by mail-qt1-x82f.google.com with SMTP id h7so13436254qtx.3
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Cyat6zOR7/GgwGxSsJlE3YlCqVzoIHPgkclZ/M3Ujsc=;
 b=OL19KNMZOqZBDibR4JT79gwPRZ3wmr4w9iTZ6STjVyvB5+ZB6ClPd9/z7apeiIO5oh
 H9M62yS/k9jf8NGlfeNYvv38FZc6Zz0rgD2eVPX5mBF3mx55v1gmJG8aOykbgPrKEIJw
 kuuE/2mNM2R/mggFcdMmORN96c6V6xDFOAo6BQ+QPz4ADDIFBJSB+ju7E61D5AeZFiIG
 +lHWC1AfkaZgbjQPlGWArc0OsOTN0Yz/OoLnpiFUu87XPceHiCp497C+XV+RO4tp+W0H
 IwbSAkrKGL5+qiEsj67RGsSAvlLMGYPbTzE5lGsAiy6hWhBwX9D9m1CesUM4HM37eHQB
 Fjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Cyat6zOR7/GgwGxSsJlE3YlCqVzoIHPgkclZ/M3Ujsc=;
 b=LQUav3FGkRyVwBOV/jIzlfQtkMKIu5WN96WHt4GEYbEYgLy+9ECFox+GZQCub21RKo
 syXc8IrVAdUnoDA/DhmPv9J77N+QvSb2T9i98rD4t3ZMZAGFMaeJIUWLVEYr+xSU7QWn
 +TGq15fSXixF5cmCIgTEtjAJYVTWWvGS+GPWEPwMfs/GgsNi6aMMONmgn7Iq/1LT1nfI
 7k2rFe/Hk4Q8PhWwIil9NWlINhLfJeSEcqJY9aJoFd3RDB9/FiPhKSmDLihmZdX2hbsI
 HQ/PsmIJqBg10jYVf+3isoce5dk23yYnq3I0d1w1jFfhLOrbuNfPE6dNG3nkLkAfnsAr
 kJPQ==
X-Gm-Message-State: AOAM5303N0kQoBr766hk2V9VdUsvlvmqM1W4lPpoClHeSLGDKb0cFiim
 nselvIHr3IBcBH1pKl6iIZk=
X-Google-Smtp-Source: ABdhPJxrahGekLcDm3v9AKtNSRgQl4XgZUwL2ZLmS3/WFkgzkQXCsF4mAcTneGyB9nAo1AMw5SSBAg==
X-Received: by 2002:ac8:688c:: with SMTP id m12mr1775174qtq.74.1616446880803; 
 Mon, 22 Mar 2021 14:01:20 -0700 (PDT)
Received: from localhost.localdomain ([138.199.10.68])
 by smtp.gmail.com with ESMTPSA id b21sm11599027qkl.14.2021.03.22.14.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 14:01:20 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, unixbhaskar@gmail.com,
 gustavoars@kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: Fix a typo
Date: Tue, 23 Mar 2021 02:31:05 +0530
Message-Id: <20210322210105.1575758-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: rdunlap@infradead.org
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


s/defintions/definitions/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 sound/soc/intel/skylake/skl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 857ea17e3c9f..33ed274fc0cb 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  skl.h - HD Audio skylake defintions.
+ *  skl.h - HD Audio skylake definitions.
  *
  *  Copyright (C) 2015 Intel Corp
  *  Author: Jeeja KP <jeeja.kp@intel.com>
--
2.31.0

