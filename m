Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37076C54FD0
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:04:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B874F20728
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XJ21jo+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B874F20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CF31168F;
	Thu, 23 Apr 2020 18:03:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CF31168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587657865;
	bh=vZZ1STVry+ZTVR5pXvOjLHRuE1PxH1tmqhxhA88Wt0w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XJ21jo+VPmZ7Y3V/WH2aeOkn/pdhIMcXQVTthH7m5mnmjfwgKfWpXc5K49UghIcbV
	 wsEnCWdqSNv8jc9DQpreKRmDizIEwXeVvYC/bg6uZjvsXyaEMu2qEpzWVnxcbnR4GE
	 rhxkQhY0oFhRzf8kjA/GN9w8vKdTCx0vUhvDCRyA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8922EF8014A;
	Thu, 23 Apr 2020 18:03:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A0CCF801EC; Thu, 23 Apr 2020 18:03:33 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39EC7F800FF
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 18:03:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39EC7F800FF
IronPort-SDR: 4yW4LxYxA+j0rDitaintXZU2sLcJUpYJjlIhOp/cWlwKci0JYDuSkj90R7twjEAYHld52yPgl4
 dIGFyJdUkmpA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 09:03:22 -0700
IronPort-SDR: Nu874FQZyX5LRVkdYw5ozdPJrHhjJ2LOgv9NqNVI3faFtjoEqfEr221iY1mXjyA7ZayYuwMUGF
 77fZ+mIu6WFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; d="scan'208";a="244913799"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga007.jf.intel.com with ESMTP; 23 Apr 2020 09:03:20 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ALSA: hda: Refactor Intel NHLT init
Date: Thu, 23 Apr 2020 18:03:10 +0200
Message-Id: <20200423160310.28019-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com
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

NHLT fetch based on _DSM prevents ACPI table override mechanism from
being utilized. Make use of acpi_get_table to enable it and get rid of
redundant code. In consequence, NHLT can be overridden just like any
other ACPI table, e.g.: DSDT or SSDT.

Change has been verified on all Intel AVS architecture platforms, RVP
and production laptops both.

Change possible due to addition of NHLT signature to the list of
standard ACPI tables:
https://patchwork.kernel.org/patch/11463235/

Override helps not only with debug purposes but also allows user for
table adjustment when one found on their production hardware is invalid.
Shared official NHLT spec is now available to community at:
https://01.org/blogs/intel-smart-sound-technology-audio-dsp

NHLT support for iASL is still ongoing subject but should be available
in nearest future.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---

Changes in v2:
- commit message update, no functional changes

 sound/hda/intel-nhlt.c | 49 +++++++-----------------------------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/sound/hda/intel-nhlt.c b/sound/hda/intel-nhlt.c
index 99a23fe7fab9..2f741d2792d8 100644
--- a/sound/hda/intel-nhlt.c
+++ b/sound/hda/intel-nhlt.c
@@ -4,58 +4,25 @@
 #include <linux/acpi.h>
 #include <sound/intel-nhlt.h>
 
-#define NHLT_ACPI_HEADER_SIG	"NHLT"
-
-/* Unique identification for getting NHLT blobs */
-static const guid_t osc_guid =
-	GUID_INIT(0xA69F886E, 0x6CEB, 0x4594,
-		  0xA4, 0x1F, 0x7B, 0x5D, 0xCE, 0x24, 0xC5, 0x53);
-
 struct nhlt_acpi_table *intel_nhlt_init(struct device *dev)
 {
-	acpi_handle handle;
-	union acpi_object *obj;
-	struct nhlt_resource_desc *nhlt_ptr;
-	struct nhlt_acpi_table *nhlt_table = NULL;
-
-	handle = ACPI_HANDLE(dev);
-	if (!handle) {
-		dev_err(dev, "Didn't find ACPI_HANDLE\n");
-		return NULL;
-	}
+	struct nhlt_acpi_table *nhlt;
+	acpi_status status;
 
-	obj = acpi_evaluate_dsm(handle, &osc_guid, 1, 1, NULL);
-
-	if (!obj)
-		return NULL;
-
-	if (obj->type != ACPI_TYPE_BUFFER) {
-		dev_dbg(dev, "No NHLT table found\n");
-		ACPI_FREE(obj);
+	status = acpi_get_table(ACPI_SIG_NHLT, 0,
+				(struct acpi_table_header **)&nhlt);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(dev, "NHLT table not found\n");
 		return NULL;
 	}
 
-	nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
-	if (nhlt_ptr->length)
-		nhlt_table = (struct nhlt_acpi_table *)
-			memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
-				 MEMREMAP_WB);
-	ACPI_FREE(obj);
-	if (nhlt_table &&
-	    (strncmp(nhlt_table->header.signature,
-		     NHLT_ACPI_HEADER_SIG,
-		     strlen(NHLT_ACPI_HEADER_SIG)) != 0)) {
-		memunmap(nhlt_table);
-		dev_err(dev, "NHLT ACPI header signature incorrect\n");
-		return NULL;
-	}
-	return nhlt_table;
+	return nhlt;
 }
 EXPORT_SYMBOL_GPL(intel_nhlt_init);
 
 void intel_nhlt_free(struct nhlt_acpi_table *nhlt)
 {
-	memunmap((void *)nhlt);
+	acpi_put_table((struct acpi_table_header *)nhlt);
 }
 EXPORT_SYMBOL_GPL(intel_nhlt_free);
 
-- 
2.17.1

