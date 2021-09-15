Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7FFC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 06:56:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB54608FB
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 06:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFB54608FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9D1617D1;
	Wed, 15 Sep 2021 08:55:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9D1617D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631689006;
	bh=zFCwJj2gDM9H36Xz7KJZTGjJ2kqDdnnjkzReUy5csf0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aJOP7pB8hFpR+GFd+F/+xGKx382z/dzwmggFfKBxHX4TBwc7Zl32jmcl9lsf5oGD/
	 5uHGh6SIoGsgkMNlyqN4bP7mMRMJbjWs9lzLwtYfIiEO/wX9SoUxPsrSZxgs4wH5k7
	 hQaT/bKMQ4XDG6qM+rIKppq9N+66AKX9de/CnRG0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4711F802E8;
	Wed, 15 Sep 2021 08:55:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9CF5AF80132; Wed, 15 Sep 2021 08:55:53 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AFA56F800EF
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 08:55:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFA56F800EF
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="221901769"
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; d="scan'208";a="221901769"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2021 23:55:45 -0700
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; d="scan'208";a="544604181"
Received: from msavu-mobl1.ti.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.216.36])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2021 23:55:43 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 0/2] ASoC: SOF: Remove unused members from struct sof_dev_desc
Date: Wed, 15 Sep 2021 09:55:39 +0300
Message-Id: <20210915065541.1178-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 daniel.baluta@nxp.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

Hi,

dma_engine, dma_size and resindex_dma_base is unused from sof_dev_desc, drop
them.

resindex_dma_base is initialized to -1 for Intel platforms, but it is not used.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: SOF: intel: Do no initialize resindex_dma_base
  ASoC: SOF: Drop resindex_dma_base, dma_engine, dma_size from
    sof_dev_desc

 include/sound/sof.h           | 5 -----
 sound/soc/sof/intel/pci-apl.c | 2 --
 sound/soc/sof/intel/pci-cnl.c | 3 ---
 sound/soc/sof/intel/pci-icl.c | 2 --
 sound/soc/sof/intel/pci-tgl.c | 5 -----
 sound/soc/sof/intel/pci-tng.c | 1 -
 6 files changed, 18 deletions(-)

-- 
2.33.0

