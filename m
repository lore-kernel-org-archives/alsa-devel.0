Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319C5C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 06:52:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D003D6196F
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 06:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D003D6196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1C3A9F6;
	Mon, 22 Mar 2021 07:51:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1C3A9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616395926;
	bh=Rqjp4+fegCR0DTLKfiJ+9RdeCyUVc9IWtGVBTWMbRno=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eImAuZrmoz4o/eUQQJCSDt84vWxpd/h92ZQb5YR0urYP89ZBYq1h8yDAw+B2wjHfT
	 rZZChNkrqSnnRiJL5M7chchLrStVGFNt7BrHJYM8VMncOxokTNCocAmEpYVausqKsV
	 5EpTxDFMzKFjVN+jmOn/shoYz/EuBtmtHLfFK9Wg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC0F6F80156;
	Mon, 22 Mar 2021 07:51:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F628F8016B; Mon, 22 Mar 2021 07:51:14 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44697F80107
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 07:51:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44697F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Q1J7T3rG"
Received: by mail-qk1-x72f.google.com with SMTP id q3so9544187qkq.12
 for <alsa-devel@alsa-project.org>; Sun, 21 Mar 2021 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ng4QK2W9WiNBsUJfqoNFrl5fepUbDbeAq/WthmkCVkQ=;
 b=Q1J7T3rGk9TL04wcFRX95DZH+Z4yA8x0wfxg69rFs+BPiDSKGbISiZJQatr41YZc/q
 fV7psnj5dX8PtgIunvGYDHnLeEUEdX4T4jQSGfU1W79VhrN2eGmEkXrzeOaTDR1kXT1X
 AOwHuB+CKr8Uqj9HmWcqYN514mDT3tgNq2ca8ofSnyZ4Jh/YFKMIkIlH2F3lc5Bsk2XK
 Ex7d/HD2zsrXSNvBFGc4U2MKeR2nfRGgCgjYYQZIW/tcMICe+KvmCz9yXtXiFh3EfOT1
 uGsyUHKD+fSBIEvCRwsy0+0FBmACKT/aIEJylD1prv5sOfpi/LfAevHV/n/IDSLUdiTw
 dD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ng4QK2W9WiNBsUJfqoNFrl5fepUbDbeAq/WthmkCVkQ=;
 b=UavNNwG8fnTdPjwepJtA6sKF8KpBxv/5bnEhFTU91q02iG58+qvnhWLkjOjYZXdNPI
 dUYjo0doKBOhzbq5oyL5iMBQJu2ybaXwxhOaz9drQBiQ4XYF+v+Fi7J/zuACa75kSF91
 cIUqQMQyGaQX8wwv72Y0Pmt6siLJ90lssWYmaH9CKvHlYz4NhCTmw9vRNu7qczs1Xcm2
 b8ow7SWX4WsUEJ8xGUNFy6U0fgbYn68dCuttU0l6z6O/C4bluP11hF1WNB2OSyfZotKS
 ZqvDiQS91UaH1sJKsBraPHlX2dfm2Sf9tX6Am8k4fjnWH8eMUB4GB+b24rV8QEu3pcau
 oF4w==
X-Gm-Message-State: AOAM532nBRWyezqhIoZ8SmknPv1bU6gg5HJlKdNSkiTd43/JvCW3UWbq
 ctUY1eKTommnqvBCfm2dQ0k=
X-Google-Smtp-Source: ABdhPJw0ScfH0xpTyAvRN6k4dC0WByFlK23impzGOK8akmGEwIgcP4P+RfTlkXJ4KIPOoHiRMwRZyA==
X-Received: by 2002:a05:620a:2108:: with SMTP id
 l8mr9496087qkl.474.1616395867679; 
 Sun, 21 Mar 2021 23:51:07 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.40])
 by smtp.gmail.com with ESMTPSA id e3sm8547210qtj.28.2021.03.21.23.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Mar 2021 23:51:07 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 andriy.shevchenko@linux.intel.com, unixbhaskar@gmail.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: Fix a typo
Date: Mon, 22 Mar 2021 12:20:53 +0530
Message-Id: <20210322065053.74022-1-unixbhaskar@gmail.com>
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

s/struture/structure/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 sound/soc/intel/atom/sst/sst.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 4d37d39fd8f4..978bf4255888 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -344,7 +344,7 @@ struct sst_fw_save {
  * @block_lock : spin lock to add block to block_list and assign pvt_id
  * @rx_msg_lock : spin lock to handle the rx messages from the DSP
  * @scard_ops : sst card ops
- * @pci : sst pci device struture
+ * @pci : sst pci device structure
  * @dev : pointer to current device struct
  * @sst_lock : sst device lock
  * @pvt_id : sst private id
--
2.31.0

