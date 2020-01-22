Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF405C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:26:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF1524680
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WlQldPJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF1524680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A154916B0;
	Wed, 22 Jan 2020 12:25:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A154916B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579692397;
	bh=aqhO27bwIpA6z3GWJ9+5xBSjyPGeyGjwsqj3ljKcE2o=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WlQldPJwoVbQfyqNor4lGy2MTJGh5CdKDRN4dF7FmEI3INjgPFmuxp2mHb1tfJGAM
	 etuc2hk1FDAZ2AnIHPcEpYfLO1iA+pjwz7+keOQDjBeS9oyg82ehD0eVkq1IZYVixb
	 zkm7MA3lauud4iy+eYcKN7ek0D1SDHqQexM5Z6Uk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F4EFF80278;
	Wed, 22 Jan 2020 12:23:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95170F8026F; Wed, 22 Jan 2020 12:23:23 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07644F80229
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 12:23:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07644F80229
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jan 2020 03:23:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,349,1574150400"; d="scan'208";a="227648038"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga003.jf.intel.com with ESMTP; 22 Jan 2020 03:23:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id AF11C4CA; Wed, 22 Jan 2020 13:23:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
Date: Wed, 22 Jan 2020 13:23:03 +0200
Message-Id: <20200122112306.64598-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [alsa-devel] [PATCH v3 6/9] x86/quirks: Add a DMI quirk for
	Microsoft Surface 3
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
index 3867f81baae7..88675844b1ab 100644
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
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
