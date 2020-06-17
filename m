Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31652C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 01:03:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF172080D
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 01:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VEgfY0+Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z++8msct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF172080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FF3A1615;
	Wed, 17 Jun 2020 03:02:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FF3A1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592355824;
	bh=Lz5y8+MW6hX3BjZcvjTZQ0qGuSOgmyYq045OqvY14Ak=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VEgfY0+ZNdysI2JU5uHXwv0H8LCWsW+wvZRG7SFd1fP2ZUponbrbFQbTbaHRoS1Ic
	 Gk5rgIHVcSKjeRqP9ikWPDjP5qEOTEgpuHBJkrnMBZV4A7eBFs6FxXUEpA5qZsmOMY
	 1H+tn8D26oNeO/LlMx2OsbFs+dGQ7fI2n9H4ZkH0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B54AAF80217;
	Wed, 17 Jun 2020 03:02:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07E3FF8022B; Wed, 17 Jun 2020 03:02:52 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05EC7F80114
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 03:02:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05EC7F80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Z++8msct"
Received: by mail-pl1-x641.google.com with SMTP id k1so163050pls.2
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g2a002H3vcNUYJWpyRwovtWUn/ajmAxDHx0MWs9PMJ4=;
 b=Z++8msctdPpkpmbBjfmvMohChPXDgzSD9AtwZnDQEe3e0Kt9EMr3qi9KIGZNslsyXr
 xLp79imR3/YKoOqFdVgGw7josD+eVR+1USuL/E7J/kUnmDwQEs9qVUwl8McnXnhPhSu1
 eOpyIkmmOGW+GZ/SHwOmMCJdiTYyoAexK9/VkcLFKnV/if1DUlM1UlCVsU0rQau8XguM
 xZeinGWLaDbq1+nxElAmljy04KGeOjSbHh4GZWX0EqeWCaJKlndXBWEsjkorOAEi8czE
 RlzdUDPo84mfw9lgQ26Bq+WM1MW8+N+N2PlQjhcOyktUhvV39w8y4dFNL6bcFDzbpF0V
 JvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g2a002H3vcNUYJWpyRwovtWUn/ajmAxDHx0MWs9PMJ4=;
 b=kjxlF93AGi7nRGk5zVAAUu3pALGelBZVcmrCpDRkOv5wpOkzjFmndxlYQ3x88REf0M
 rKBHiW6jg/53m1ltYX9NdXVd3jFb2iy8svWF0NiEmpCBB6rwbyWU8Ho0c3m+RDRvkWbV
 ZcyJ/+PcRHZIFy9nYYKie8PLjAuIYiwNROYDiSbnBzYxJpDMqf4kZUN6TIyvbCAkuxY5
 UgEF8VC3DlGA5on18EdRRYI1QGB3qamES/aguulHjrU5wiqN2etJDeq0Hoq9rvFh3GM4
 6sS230uILdNaqA8PB7qe510lU2KwOGcomzn8CRfroM9gpyDUgIJIZ3THJHuLI8HQfr8+
 P04g==
X-Gm-Message-State: AOAM531r+m6NQpUeh5o6a2ga+nTH/vfboTuTvmdeZnlEw5I6H7egogJp
 3A334opwSwPNt4jkKFjXEIo=
X-Google-Smtp-Source: ABdhPJywNMJ6KgTrIYao5oHl5pmyoYTV3NqSGTdY+bxKIgOQHt/ofYCsUFqaFWq+tUtpmk15FKde5Q==
X-Received: by 2002:a17:90a:8089:: with SMTP id
 c9mr5862338pjn.126.1592355765913; 
 Tue, 16 Jun 2020 18:02:45 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain ([89.46.114.134])
 by smtp.gmail.com with ESMTPSA id fv7sm3563299pjb.41.2020.06.16.18.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 18:02:45 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: Intel: KeemBay: Fix header guard
Date: Tue, 16 Jun 2020 18:02:32 -0700
Message-Id: <20200617010232.23222-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: Nathan Chancellor <natechancellor@gmail.com>,
 clang-built-linux@googlegroups.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Sia Jee Heng <jee.heng.sia@intel.com>
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

Clang warns:

 In file included from sound/soc/intel/keembay/kmb_platform.c:14:
 sound/soc/intel/keembay/kmb_platform.h:9:9: warning: 'KMB_PLATFORM_H_'
 is used as a header guard here, followed by #define of a different
 macro [-Wheader-guard]
 #ifndef KMB_PLATFORM_H_
         ^~~~~~~~~~~~~~~
 sound/soc/intel/keembay/kmb_platform.h:10:9: note: 'KMB_PLATFORMP_H_'
 is defined here; did you mean 'KMB_PLATFORM_H_'?
 #define KMB_PLATFORMP_H_
         ^~~~~~~~~~~~~~~~
         KMB_PLATFORM_H_
 1 warning generated.

Fix the typo so that the header guard works as intended.

Fixes: c5477e966728 ("ASoC: Intel: Add KeemBay platform driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1053
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/intel/keembay/kmb_platform.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/keembay/kmb_platform.h b/sound/soc/intel/keembay/kmb_platform.h
index 29600652d8f4..6bf221aa8fff 100644
--- a/sound/soc/intel/keembay/kmb_platform.h
+++ b/sound/soc/intel/keembay/kmb_platform.h
@@ -7,7 +7,7 @@
  */
 
 #ifndef KMB_PLATFORM_H_
-#define KMB_PLATFORMP_H_
+#define KMB_PLATFORM_H_
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>

base-commit: 27f70ec4fa0e0f419031f1b8d61b1a788244e313
-- 
2.27.0

