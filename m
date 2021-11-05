Return-Path: <SRS0=XtK2=PY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEFBC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 02:28:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82B36112E
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 02:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B82B36112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D97531670;
	Fri,  5 Nov 2021 03:27:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D97531670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636079289;
	bh=y/tjKcCl+375I3kbsCbkntnPD54jvAwBCWMl77vn9Rs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=drfPKkW67ea6BgMOAvtqHCjcFTOoB4TT6WbjMAE1bFh+wVmOI3JJWlM6w5FjDiIXE
	 WFnioMlo33qAzWESyvOR9t8TSEBQ5/sDTWBFDeSNpx/nrLubBAlFXoS5Nh1iI4Orpv
	 pqSQRS66O+PdXIyT/E4gt6NuQEhO6lsb2hhqlz+U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F4A3F804B1;
	Fri,  5 Nov 2021 03:27:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8BB9F802BE; Fri,  5 Nov 2021 03:27:13 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28871F8012A
 for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2021 03:27:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28871F8012A
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="231678120"
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; d="scan'208";a="231678120"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2021 19:27:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; d="scan'208";a="501786419"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2021 19:27:01 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH 0/9] ASoC: Ietel: Add Dell ADL products support
Date: Fri,  5 Nov 2021 10:26:37 +0800
Message-Id: <20211105022646.26305-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com
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

This series adds configurations for Dell ADL products.

Gongjun Song (9):
  ASoC: Intel: sof_sdw: Add support for SKU 0AF3 product
  ASoC: Intel: soc-acpi: add SKU 0AF3 SoundWire configuration
  ASoC: Intel: sof_sdw: Add support for SKU 0B00 and 0B01 products
  ASoC: Intel: sof_sdw: Add support for SKU 0B11 product
  ASoC: Intel: sof_sdw: Add support for SKU 0B13 product
  ASoC: Intel: soc-acpi: add SKU 0B13 SoundWire configuration
  ASoC: Intel: sof_sdw: Add support for SKU 0B29 product
  ASoC: Intel: soc-acpi: add SKU 0B29 SoundWire configuration
  ASoC: Intel: sof_sdw: Add support for SKU 0B12 product

 sound/soc/intel/boards/sof_sdw.c              |  69 ++++++++++++
 .../intel/common/soc-acpi-intel-adl-match.c   | 105 ++++++++++++++++++
 2 files changed, 174 insertions(+)

-- 
2.17.1

