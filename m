Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2291FC2BB1D
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 18:24:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871FB20716
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 18:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KcxySR14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871FB20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF2E2172B;
	Thu, 12 Mar 2020 19:23:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF2E2172B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584037442;
	bh=okE1NMmkK9Mm87y6NeZ+CJL7TOd9IZMJrNhEXZiMdwE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KcxySR14ZF4gdET8dVI5t1bLcmXMm1RLYVBdpn/41jOJtub8zzLEvAH3ouIKwJF26
	 m3mbGV+LdapQFWSowQVFOV9HX5u1WdL0ENBZqCpwF349g46f2Y18//HFoP2iMj4UqA
	 3i30cj7B2Tl5xPrD/tJuwteX5ouGTNQPog7C1A1k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31E20F801D9;
	Thu, 12 Mar 2020 19:23:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7657F8020C; Thu, 12 Mar 2020 19:23:10 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E856F800BE
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 19:23:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E856F800BE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 11:23:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; d="scan'208";a="322555535"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga001.jf.intel.com with ESMTP; 12 Mar 2020 11:23:01 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] acpi: Add NHLT table signature
Date: Thu, 12 Mar 2020 19:22:16 +0100
Message-Id: <20200312182216.7818-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 alsa-devel@alsa-project.org, Erik Kaneda <erik.kaneda@intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Robert Moore <robert.moore@intel.com>
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

NHLT (Non-HDAudio Link Table) provides configuration of audio
endpoints for Intel SST (Smart Sound Technology) DSP products. Similarly
to other ACPI tables, data provided by BIOS may not describe it
correctly, thus overriding is required.

ACPI override mechanism checks for unknown signature before proceeding.
Update known signatures array to support NHLT.

CC: Erik Kaneda <erik.kaneda@intel.com>
CC: Robert Moore <robert.moore@intel.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 drivers/acpi/tables.c | 2 +-
 include/acpi/actbl2.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 180ac4329763..0e905c3d1645 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -501,7 +501,7 @@ static const char * const table_sigs[] = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	NULL };
+	ACPI_SIG_NHLT, NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index e45ced27f4c3..876ccf50ec36 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -43,6 +43,7 @@
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
+#define ACPI_SIG_NHLT           "NHLT"	/* Non-HDAudio Link Table */
 
 /*
  * All tables must be byte-packed to match the ACPI specification, since
-- 
2.17.1

