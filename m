Return-Path: <SRS0=MK90=ML=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B6FC07E9B
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 23:34:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D94D610D2
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 23:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D94D610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DB6E1614;
	Tue, 20 Jul 2021 01:33:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DB6E1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626737652;
	bh=n5XDRSeMWGkxISI7+WFdB/+BbeLx1GhqboUFpzgefnI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F5KLInnfuPuNFBhmoCRW96h1jBIxqgatnyIzrshwGm2OcTp8n9GVTaJ3vdZ/W9Q1N
	 fqNPZEJadRoylyZACKXapga/OPGICjvII7E7T170QMeJS6Oh2pJZV3b6eNAODFDhJI
	 q4qo/Szr6m2Oio/42A/pHYaf+/7bOFtKFVx19IVk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B624FF80256;
	Tue, 20 Jul 2021 01:33:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5168F80256; Tue, 20 Jul 2021 01:33:19 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 779B1F800C5
 for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2021 01:33:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 779B1F800C5
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="198350321"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="198350321"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 16:33:08 -0700
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="494333667"
Received: from mjduranm-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.21])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 16:33:07 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ASoC/soundwire: add quirks for Intel 'Bishop County' NUC
 M15
Date: Mon, 19 Jul 2021 18:32:46 -0500
Message-Id: <20210719233248.557923-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, gregkh@linuxfoundation.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>
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

The 'Bishop County' NUC Laptops designed by Intel rely on SoundWire
peripherals. Quirks are required on the soundwire/ side to work-around
ACPI issues (bad _ADR) and sound/soc/ side for jack detection.

The two patches are independent and can be merged in the two subsystem
independently if desired. Both patches are however required in any
backport.

Thanks to Gilles van Eeden for reporting this issue and testing these
patches.

Pierre-Louis Bossart (2):
  soundwire: dmi-quirks: add quirk for Intel 'Bishop County' NUC M15
  ASOC: Intel: sof_sdw: add quirk for Intel 'Bishop County' NUC M15

 drivers/soundwire/dmi-quirks.c   | 16 ++++++++++++----
 sound/soc/intel/boards/sof_sdw.c | 11 +++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.25.1

