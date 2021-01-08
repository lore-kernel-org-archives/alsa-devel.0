Return-Path: <SRS0=g0zL=GL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7E5C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 03:21:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BA9236F9
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 03:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BA9236F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3463E1672;
	Fri,  8 Jan 2021 04:20:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3463E1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610076073;
	bh=CTlKH8xcfGYPOLc4su4wmhkD5iap7mHkUs8MDpJWphk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JbxZtlK8C50BTaGqXL+UaDNmcVuDSVKbTOeRSaYS/rTvnKy68zhSszGuo+GM765oP
	 TerfzY5CiMI/QeJ6oPty8QgYryYnoAd0PKJYsioeSVz+WIw6OSMyOY3O+1BvYJC6QN
	 P5cjEMNqkPBgYX7e8wHInqqPFZxN7zCXG/Exsz7Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32EFFF80165;
	Fri,  8 Jan 2021 04:20:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C4D2F80166; Fri,  8 Jan 2021 04:20:19 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 528ADF800EE
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2021 04:20:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 528ADF800EE
IronPort-SDR: 5d6SJ5o0MTlKXrFT+S7eofe43J4vMuqrYwjRDx+7k3JRmyd3oex1Sn5yXgcHAA6Il74g47UBxF
 TmGfnhfR5Vqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="174955180"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; d="scan'208";a="174955180"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2021 19:20:10 -0800
IronPort-SDR: DBpkYoX+1rsZh7iSNEehwxVbtd5B+LBaSEWpIsllSKOPij+KiVsyUeTTSFLz3pFuLS3YQ4jpeO
 MT/eLTH673Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; d="scan'208";a="362197160"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by orsmga002.jf.intel.com with ESMTP; 07 Jan 2021 19:20:07 -0800
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/2] Enable DMA mode on Intel Keem Bay platform
Date: Fri,  8 Jan 2021 11:12:46 +0800
Message-Id: <20210108031248.20520-4-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: cezary.rojewski@intel.com, lars@metafoo.de, tiwai@suse.com,
 jee.heng.sia@intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, broonie@kernel.org
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

v2: Update patch to align with latest kernel release.
v1: Initial patch version, to enable DMA mode on Intel Keembay platform.

Michael Sit Wei Hong (2):
  dt-bindings: sound: intel, keembay-i2s: Add info for device to use DMA
  ASoC: Intel: KMB: Enable DMA transfer mode

 .../bindings/sound/intel,keembay-i2s.yaml     |  14 ++
 sound/soc/intel/Kconfig                       |   2 +
 sound/soc/intel/keembay/kmb_platform.c        | 157 ++++++++++++++++--
 sound/soc/intel/keembay/kmb_platform.h        |   9 +
 4 files changed, 167 insertions(+), 15 deletions(-)

-- 
2.17.1

