Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A658C2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:58:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A492054F
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UlVbgMKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A492054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 013CB1681;
	Wed, 15 Apr 2020 16:57:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 013CB1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586962716;
	bh=E0nVkVBgG4NkDOlg92j2TPx9+dA5ukCqLawOmZB2P9c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UlVbgMKe50RMqN48LgxQv6aXvjMQyHm8BvRfzmCoGT5Xqh3Kw20vDIvRYARR5wCwo
	 I0XB5xmckxn7hEZz02aTpJAtio+3TnJTW/tYpx+zgp15FCyAv7STUe03K1ieSjBH7t
	 OQpV6nXXUmr68ZxCdXfBvHnBVkzHCNJa6OamcIoA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EAD01F80291;
	Wed, 15 Apr 2020 16:56:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB1B6F8028D; Wed, 15 Apr 2020 16:56:00 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BAB2F8027D
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 16:55:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BAB2F8027D
IronPort-SDR: 6JlBNXR+WW8Kro9XPZyMVMxogBYyZoTcGTpzuHl1vrnbcL7IZRRmswcZI+f1vQjwJ8OThX/mcq
 YhLmvtDaoYZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 07:55:47 -0700
IronPort-SDR: yEOXzaHhUTFYm+2FDM0LVqSe9NvObg389jT6RuMAZydLfPsSi/DtcMQ++cRV6uBpNoCoYMkOL4
 0cueKAZrPg3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; d="scan'208";a="253545801"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 07:55:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 75709E2F; Wed, 15 Apr 2020 17:55:40 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] ASoC: Intel: Switch DMI table match to a test of
 variable
Date: Wed, 15 Apr 2020 17:55:24 +0300
Message-Id: <20200415145524.31745-10-andriy.shevchenko@linux.intel.com>
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

Since we have a common x86 quirk that provides an exported variable,
use it instead of local DMI table match.

Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 .../intel/common/soc-acpi-intel-cht-match.c   | 28 ++-----------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 2752dc955733..1ee93d35a1b8 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -5,31 +5,11 @@
  * Copyright (c) 2017, Intel Corporation.
  */
 
-#include <linux/dmi.h>
+#include <linux/platform_data/x86/machine.h>
+
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 
-static unsigned long cht_machine_id;
-
-#define CHT_SURFACE_MACH 1
-
-static int cht_surface_quirk_cb(const struct dmi_system_id *id)
-{
-	cht_machine_id = CHT_SURFACE_MACH;
-	return 1;
-}
-
-static const struct dmi_system_id cht_table[] = {
-	{
-		.callback = cht_surface_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
-		},
-	},
-	{ }
-};
-
 static struct snd_soc_acpi_mach cht_surface_mach = {
 	.id = "10EC5640",
 	.drv_name = "cht-bsw-rt5645",
@@ -43,9 +23,7 @@ static struct snd_soc_acpi_mach *cht_quirk(void *arg)
 {
 	struct snd_soc_acpi_mach *mach = arg;
 
-	dmi_check_system(cht_table);
-
-	if (cht_machine_id == CHT_SURFACE_MACH)
+	if (x86_microsoft_surface_3_machine)
 		return &cht_surface_mach;
 	else
 		return mach;
-- 
2.25.1

