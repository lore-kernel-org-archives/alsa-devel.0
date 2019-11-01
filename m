Return-Path: <SRS0=I1aD=YZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAA8CA9ED1
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:33:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C47A217F9
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Nov 2019 17:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MRq9FZrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C47A217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7989236B;
	Fri,  1 Nov 2019 18:32:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7989236B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572629624;
	bh=jrxGMff/t9HpCMUyM8818GeexJWbY0ZZXQx9Djp0VD8=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MRq9FZrPeMlPagi46mTxGZCUOsUV/mpHiJxcUQeCrmE3mReBJ1eoivWlG+L4iNsl5
	 h+WOJT8FEZ4wmp3aMEg+zOMcI9DtkBuCiJPxDfOfQO2VCixARvl07ZQ9hzimIwPr2O
	 IgN1vaydr4CsaIc/sLT3Uk+DN/g9smy7pcx2zPFc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC2E7F8060F;
	Fri,  1 Nov 2019 18:31:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFF24F803D6; Fri,  1 Nov 2019 18:31:16 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9FC8CF8048F
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2019 18:31:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9FC8CF8048F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Nov 2019 10:30:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; d="scan'208";a="206457421"
Received: from ggarreto-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.92.243])
 by FMSMGA003.fm.intel.com with ESMTP; 01 Nov 2019 10:30:56 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri,  1 Nov 2019 12:30:39 -0500
Message-Id: <20191101173045.27099-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101173045.27099-1-pierre-louis.bossart@linux.intel.com>
References: <20191101173045.27099-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 05/11] ASoC: SOF: imx: fix reverse
	CONFIG_SND_SOC_SOF_OF dependency
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

updated solution to the problem reported with randconfig:

CONFIG_SND_SOC_SOF_IMX depends on CONFIG_SND_SOC_SOF, but is in
turn referenced by the sof-of-dev driver. This creates a reverse
dependency that manifests in a link error when CONFIG_SND_SOC_SOF_OF
is built-in but CONFIG_SND_SOC_SOF_IMX=m:

sound/soc/sof/sof-of-dev.o:(.data+0x118): undefined reference to `sof_imx8_ops'

use def_trisate to propagate the right settings without select.

Fixes: f4df4e4042b0 ("ASoC: SOF: imx8: Fix COMPILE_TEST error")
Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/imx/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
index 6315fba8ce71..bae4f7bf5f75 100644
--- a/sound/soc/sof/imx/Kconfig
+++ b/sound/soc/sof/imx/Kconfig
@@ -11,8 +11,8 @@ config SND_SOC_SOF_IMX_TOPLEVEL
 
 if SND_SOC_SOF_IMX_TOPLEVEL
 
-config SND_SOC_SOF_IMX8
-	tristate "SOF support for i.MX8"
+config SND_SOC_SOF_IMX8_SUPPORT
+	bool "SOF support for i.MX8"
 	depends on IMX_SCU
 	depends on IMX_DSP
 	help
@@ -20,4 +20,8 @@ config SND_SOC_SOF_IMX8
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
+config SND_SOC_SOF_IMX8
+	def_tristate SND_SOC_SOF_OF
+	depends on SND_SOC_SOF_IMX8_SUPPORT
+
 endif ## SND_SOC_SOF_IMX_IMX_TOPLEVEL
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
