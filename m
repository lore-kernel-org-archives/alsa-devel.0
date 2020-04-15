Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED0C2BB55
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:57:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61A7208E4
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DMcOOCT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61A7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 065271612;
	Wed, 15 Apr 2020 16:56:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 065271612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586962661;
	bh=0drUO4MWi5bzHH5NrIQvcCMBtOkFxhVVX2YhLk9Z0w4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DMcOOCT6zU5LKYT0zwO+yvybAj2Qp72XJtFAcm3mIVCm6//3pNfYCUKGeT12qptb3
	 sFDlqNPLmGhQMhEc/jaXHwMXng2vgcthrqPWIhgQEbopVty2vKo8HtRXw9hkl/aeEQ
	 WXa0Kkn+NX4+vGPp9e+42cBtqtY9IwjejkiOHomw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8271F8025F;
	Wed, 15 Apr 2020 16:56:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D034F8028B; Wed, 15 Apr 2020 16:55:57 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87895F80266
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 16:55:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87895F80266
IronPort-SDR: nwjWupH6AqN3o6V50gwu4iATufmDkdYBGq3PauR/bNKHWVSQzoxZ+7HL/YszG/+gXGyjcr19SK
 CxQG5D7aS98Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 07:55:47 -0700
IronPort-SDR: YMknequTHuJ5gH68ECaixFGpOMMezScX1cOg6clpO32nbcExs4hTQ4Xg3yuSJmGIjUAvkSYi3S
 ouYhENvLTylA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; d="scan'208";a="454934621"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga006.fm.intel.com with ESMTP; 15 Apr 2020 07:55:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 58DB8C4E; Wed, 15 Apr 2020 17:55:40 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/9] x86/quirks: Add a DMI quirk for Microsoft Surface 3
Date: Wed, 15 Apr 2020 17:55:21 +0300
Message-Id: <20200415145524.31745-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
References: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Add a DMI quirk for Microsoft Surface 3 which will be utilized by few drivers.

Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c                  | 10 ++++++++++
 include/linux/platform_data/x86/machine.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index a97055599bb7..b4a3aa9c3f48 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -658,6 +658,9 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083, quirk_intel_purley_xeon_ras
 bool x86_apple_machine;
 EXPORT_SYMBOL(x86_apple_machine);
 
+bool x86_microsoft_surface_3_machine;
+EXPORT_SYMBOL(x86_microsoft_surface_3_machine);
+
 static const struct dmi_system_id x86_machine_table[] __initconst = {
 	{
 		.ident = "x86 Apple Macintosh",
@@ -673,6 +676,13 @@ static const struct dmi_system_id x86_machine_table[] __initconst = {
 		},
 		.driver_data = &x86_apple_machine,
 	},
+	{
+		.ident = "Microsoft Surface 3",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
+		},
+		.driver_data = &x86_microsoft_surface_3_machine,
+	},
 	{}
 };
 
diff --git a/include/linux/platform_data/x86/machine.h b/include/linux/platform_data/x86/machine.h
index b1e7a560a046..9bdf5a06b490 100644
--- a/include/linux/platform_data/x86/machine.h
+++ b/include/linux/platform_data/x86/machine.h
@@ -8,8 +8,13 @@
  * x86_apple_machine - whether the machine is an x86 Apple Macintosh
  */
 extern bool x86_apple_machine;
+/**
+ * x86_microsoft_surface_3_machine - whether the machine is Microsoft Surface 3
+ */
+extern bool x86_microsoft_surface_3_machine;
 #else
 #define x86_apple_machine			false
+#define x86_microsoft_surface_3_machine		false
 #endif
 
 #endif	/* PLATFORM_DATA_X86_MACHINE_H */
-- 
2.25.1

