Return-Path: <SRS0=n5wC=KQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016C5C433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 09:35:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14EB613C4
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 09:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14EB613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33B7716A3;
	Fri, 21 May 2021 11:34:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33B7716A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621589705;
	bh=pZlKkdVSLnTkmCaYvo2ujHhf17LMDLGnW4zgCRwi0n8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Wfl53zfNvcwb/W5asQHuX33+4bvvh+dOPzX4TzCDpVyhCNh5hgymSP/GxJkGoQjLl
	 EKOBqsh+mN+T9BVmjAuv4KMH1vjm1nOZHu2TYGTE/nhwp4Xqkc8XZggA9tRx1lQXCe
	 1A2zyurW4GSdPsP/Hm/0b0DpY/9jzxwCM1eGKE8s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18C7DF80259;
	Fri, 21 May 2021 11:33:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C851F80249; Fri, 21 May 2021 11:33:20 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF103F800E5
 for <alsa-devel@alsa-project.org>; Fri, 21 May 2021 11:33:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF103F800E5
IronPort-SDR: z5S9d9/72UYKmCaAmQrtTyxhvZiofnK31Wg9zJjIn3EbFBwdWZLM3P3BbQU1VWG3MvxRMQ+bu9
 P9NcXERs5/Dw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="262664175"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="262664175"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2021 02:33:09 -0700
IronPort-SDR: NiBaV0IG/6Q/pvZ4rXb68Hpo9tHbmOE0INE410CUsEbxXPJ8CMeZTd4/j1CJ97XTp8EzhSkxF1
 5vO8FPv68yOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="475640839"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga002.fm.intel.com with ESMTP; 21 May 2021 02:33:07 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 0/7] ASoC: SOF: code cleanups for 5.14
Date: Fri, 21 May 2021 12:27:57 +0300
Message-Id: <20210521092804.3721324-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

Set of code cleanups for issues found in code review.

Jaska Uimonen (1):
  ASoC: SOF: topology: fix assignment to use le32_to_cpu

Keyon Jie (1):
  ASoC: SOF: ops: print out the polling register

Peter Ujfalusi (4):
  ASoC: SOF: Check desc->ops directly in acpi/pci/of probe functions
  ASoC: SOF: pci: No need to cast second time to save the desc
  ASoC: SOF: loader: Use snd_sof_dsp_block_read() instead
    sof_block_read()
  ASoC: SOF: Intel: hda: Remove conditions against CONFIG_PCI

Pierre-Louis Bossart (1):
  ASoC: SOF: ops: don't return void value

 sound/soc/sof/intel/hda.c    |  8 +++-----
 sound/soc/sof/loader.c       |  2 +-
 sound/soc/sof/ops.h          | 10 ++++++----
 sound/soc/sof/sof-acpi-dev.c |  5 +----
 sound/soc/sof/sof-of-dev.c   |  5 +----
 sound/soc/sof/sof-pci-dev.c  |  7 ++-----
 sound/soc/sof/topology.c     |  2 +-
 7 files changed, 15 insertions(+), 24 deletions(-)


base-commit: aa736700f42fa0813e286ca2f9274ffaa25163b9
-- 
2.31.0

