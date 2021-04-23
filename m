Return-Path: <SRS0=7xvc=JU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C0CC433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 18:28:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD71613C8
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 18:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD71613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 642A41710;
	Fri, 23 Apr 2021 20:27:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 642A41710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619202505;
	bh=3Dn5x6qFhBwPQt/PjR52fl9Z0+OFcwVAroezu4VJSig=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mSU2cDwg9TlyOaDjhh2hkwW7uQ1QROg9mU+B5SHlB3wcZIw2/6lltEfzC/74Ujx9P
	 14lnWxGQNIH3tTdTGsvEEMxDCRr3TTqZKOk//3pcQV9dGLLFH9wu6zOqELB5QnKZg5
	 1DMpdd09Erc996Jig1N40DTN7KvJ0WViOklxjSCo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C4E1F80482;
	Fri, 23 Apr 2021 20:25:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 983FAF804CF; Fri, 23 Apr 2021 20:24:51 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E73DF802D2
 for <alsa-devel@alsa-project.org>; Fri, 23 Apr 2021 20:24:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E73DF802D2
IronPort-SDR: wYV6/0Md+czD32PHAwtS+0Zjnzl10a+3qK0069hjGKlXCo8Bc9a2n2Lp9WegQuDo6IJpJtEhG/
 SeGorGDoh+Mw==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="281441753"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; d="scan'208";a="281441753"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2021 11:24:33 -0700
IronPort-SDR: HC5IPe3j2wW07tiGepa8xn+6GlXaXpeNWoMtGbCnrH2A2pI8g4t2R1Xn6MWk02Y+gGOeKWY7aw
 3k7DuL1xvoKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; d="scan'208";a="535619432"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga004.jf.intel.com with ESMTP; 23 Apr 2021 11:24:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 2ABE641F; Fri, 23 Apr 2021 21:24:45 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 06/14] spi: pxa2xx: Group Intel Quark specific definitions
Date: Fri, 23 Apr 2021 21:24:33 +0300
Message-Id: <20210423182441.50272-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
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

DDS_RATE is Intel Quark specific definition. Move it to the rest
Intel Quark related.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pxa2xx_ssp.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 14b049840faf..1b6c1a0922bd 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -38,7 +38,6 @@ struct device_node;
 #define SSDR		(0x10)  /* SSP Data Write/Data Read Register */
 
 #define SSTO		(0x28)  /* SSP Time Out Register */
-#define DDS_RATE	(0x28)  /* SSP DDS Clock Rate Register (Intel Quark) */
 #define SSPSP		(0x2C)  /* SSP Programmable Serial Protocol */
 #define SSTSA		(0x30)  /* SSP Tx Timeslot Active */
 #define SSRSA		(0x34)  /* SSP Rx Timeslot Active */
@@ -105,6 +104,9 @@ struct device_node;
 #define CE4100_SSCR1_RFT	GENMASK(11, 10)	/* Receive FIFO Threshold (mask) */
 #define CE4100_SSCR1_RxTresh(x) (((x) - 1) << 10)	/* level [1..4] */
 
+/* Intel Quark X1000 */
+#define DDS_RATE		0x28		 /* SSP DDS Clock Rate Register */
+
 /* QUARK_X1000 SSCR0 bit definition */
 #define QUARK_X1000_SSCR0_DSS		GENMASK(4, 0)	/* Data Size Select (mask) */
 #define QUARK_X1000_SSCR0_DataSize(x)	((x) - 1)	/* Data Size Select [4..32] */
-- 
2.30.2

