Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51C3CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:48:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3132A218AE
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KZMhOddr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3132A218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F5F915E0;
	Tue, 22 Oct 2019 21:47:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F5F915E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571773685;
	bh=tVdqisEXH7LvYEn7FXW9R6EpuNNv7DcbVdpwAHZzqLQ=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KZMhOddrs9Jf4BFf5uTggvksgTJeaDk8juEGipSlCydjMCaWo3IO6Sp78RPpJ7dU6
	 xH56atHsUXm/SYt1UTxFERe40zrUa4mgZJIa7/jt6CYTFrz0dw7aVUOauxdX//jnSv
	 Hb1P0gz9z0fdgvRoewrsS0VImXEh86pdS0aqFp6E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97C15F802FB;
	Tue, 22 Oct 2019 21:47:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEF3DF80322; Tue, 22 Oct 2019 21:47:13 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91330F802FB
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 21:47:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91330F802FB
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2019 12:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,217,1569308400"; d="scan'208";a="201780642"
Received: from mssikder-mobl.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.68.44])
 by orsmga006.jf.intel.com with ESMTP; 22 Oct 2019 12:47:07 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 22 Oct 2019 14:47:04 -0500
Message-Id: <20191022194705.23347-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022194705.23347-1-pierre-louis.bossart@linux.intel.com>
References: <20191022194705.23347-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Pan Xiuli <xiuli.pan@linux.intel.com>
Subject: [alsa-devel] [PATCH 1/2] ASoC: Intel: common: add ACPI matching
	tables for JSL
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

From: Pan Xiuli <xiuli.pan@linux.intel.com>

There are no upstream machine drivers just yet so just add dummy table
for compilation in nocodec-mode.

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
---
 include/sound/soc-acpi-intel-match.h           |  1 +
 sound/soc/intel/common/Makefile                |  1 +
 .../intel/common/soc-acpi-intel-jsl-match.c    | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-jsl-match.c

diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
index 6c9929abd90b..4e44782862df 100644
--- a/include/sound/soc-acpi-intel-match.h
+++ b/include/sound/soc-acpi-intel-match.h
@@ -27,6 +27,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_ehl_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[];
 
 /*
  * generic table used for HDA codec-based platforms, possibly with
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 18d9630ae9a2..eafe95ead49b 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -9,6 +9,7 @@ snd-soc-acpi-intel-match-objs := soc-acpi-intel-byt-match.o soc-acpi-intel-cht-m
 	soc-acpi-intel-bxt-match.o soc-acpi-intel-glk-match.o \
 	soc-acpi-intel-cnl-match.o soc-acpi-intel-icl-match.o \
 	soc-acpi-intel-tgl-match.o soc-acpi-intel-ehl-match.o \
+	soc-acpi-intel-jsl-match.o \
 	soc-acpi-intel-hda-match.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o snd-soc-sst-ipc.o
diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
new file mode 100644
index 000000000000..1c68a04f0c6e
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * soc-apci-intel-jsl-match.c - tables and support for JSL ACPI enumeration.
+ *
+ * Copyright (c) 2019, Intel Corporation.
+ *
+ */
+
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_jsl_machines);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Common ACPI Match module");
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
