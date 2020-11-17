Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CECC2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 15:04:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4D724199
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="L0ZybRkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4D724199
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B44BC1732;
	Tue, 17 Nov 2020 16:03:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B44BC1732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605625453;
	bh=oaYZ3SqstJuYFKmG4jh/Bk107+ZqJJ843vvVYjU9vgw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L0ZybRkAzT2ItZNr0z7ER9RfK6sMTcrBTRRUXTIPYnx9XS71+bBa0iyyW1Ips4x0X
	 cWURua2ysJN3tQNJ+XYcC3dqNJKihlpp9CsKhOiXTmJFSbPOgoWbJ/h+H2zqaUAJW7
	 CVoYLe8SD3uAgtDCgSU0Pef7F+iIsamtDoKdQg0o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83975F800FE;
	Tue, 17 Nov 2020 16:03:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 695EBF801F5; Tue, 17 Nov 2020 16:03:05 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32151F800FE;
 Tue, 17 Nov 2020 16:02:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32151F800FE
IronPort-SDR: VXu2yAp4lz+A3X1PQeh3SwbkFEUW7hmPRzRfDOlxKGpZaBPALQGPTtEhCL3MghIZknfCRCm8qV
 ty9O6aQzk+nA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150206688"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; d="scan'208";a="150206688"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 07:02:32 -0800
IronPort-SDR: rRnEpKTXnMvuULl90wbdLFtQX3BcyC/GaJbP9D+CgG1niRNVEVaFgjuQTBbtH1o7AeaA7n7Qck
 g03xR/bqyg8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; d="scan'208";a="340919682"
Received: from glewandosky.igk.intel.com ([10.237.149.85])
 by orsmga002.jf.intel.com with ESMTP; 17 Nov 2020 07:02:29 -0800
From: Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: Intel: catpt: select WANT_DEV_COREDUMP
Date: Tue, 17 Nov 2020 15:52:23 +0100
Message-Id: <20201117145223.21222-1-gustaw.lewandowski@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: cezary.rojewski@intel.com, patch@alsa-project.org, tiwai@suse.de,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>, broonie@kernel.org,
 Piotr Maziarz <piotrx.maziarz@linux.intel.com>
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

From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>

Select WANT_DEV_COREDUMP for catpt driver.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Signed-off-by: Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>

--
Changes in v2:
 - change should be added to catpt only
---
 sound/soc/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a5b446d5af19..52ae7c981f56 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -24,6 +24,7 @@ config SND_SOC_INTEL_CATPT
 	depends on DMADEVICES && SND_DMA_SGBUF
 	select DW_DMAC_CORE
 	select SND_SOC_ACPI_INTEL_MATCH
+	select WANT_DEV_COREDUMP
 	help
 	  Enable support for Intel(R) Haswell and Broadwell platforms
 	  with I2S codec present. This is a recommended option.
-- 
2.29.0

