Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370ADC433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:46:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16DF2078A
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jgv8dQJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16DF2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A7CF1762;
	Wed, 26 Aug 2020 20:45:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A7CF1762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598467601;
	bh=EJzvZi9Tib+4BBvmAWvZNL6vX6Cmhm2lOpgoeDwYNrQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jgv8dQJyM6hGGx4Pmr6G6RTAF9O1l+wH7lErEOtmqMDtdwZ1Peq5uKBYEX9agftZL
	 fidrFsLJDCK2iSzMoRZXwV4b8bplqZLx31hWtOG7sWkCMACy3rzGXRvHO6MNPRqoTi
	 mTe/2B8K3TQbdyzPy3YoMiNJs/CiFZWLxpLxAeVg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 693E9F80257;
	Wed, 26 Aug 2020 20:45:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1715AF8020C; Wed, 26 Aug 2020 20:45:49 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C6E7F80105
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 20:45:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C6E7F80105
IronPort-SDR: hX22tD1W3S7hOFrvGI9e1mDqcmXpwmXmZNAiRaAFZ8N0rFz+0Eikb8Qe3X21G8uRr3OVMMZ4IY
 UxYjkuobtXSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="174418606"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="174418606"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 11:45:41 -0700
IronPort-SDR: mtOjzStZGBHF3EUILItc9Wp8+w5NTTx4679DMkjVmVvHzAxBbhrdYS0C5LO+SypxqA8oJpmT2Y
 zQtL+ea46Ueg==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="500347320"
Received: from sghoshal-mobl.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.209.145.101])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 11:45:41 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/8] SOF fixes and updates for FW boot
Date: Wed, 26 Aug 2020 11:45:24 -0700
Message-Id: <20200826184532.1612070-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

This series includes fixes and updates for the FW boot sequence for
Intel platforms.

Ranjani Sridharan (7):
  ALSA: hda: fix VS_LTRC register name
  ASoC: SOF: Intel: hda: Add helper function to program ICCMAX stream
  ASoC: SOF: Intel: hda: modify the signature of get_stream_with_tag()
  ASoC: SOF: Intel: hda: define macro for code loader stream format
  ASoC: SOF: Intel: hda: Define FW boot sequence with ICCMAX
  ASoC: SOF: Intel: hda: Add sof_tgl_ops for TGL platforms
  ASoC: SOF: Intel: hda: Simplify error handling during FW boot

Yong Zhi (1):
  ASoC: SOF: Intel: hda: Remove unused parameters in cl_dsp_init()

 include/sound/hda_register.h     |   2 +-
 sound/soc/sof/intel/Makefile     |   2 +-
 sound/soc/sof/intel/cnl.c        |  23 +----
 sound/soc/sof/intel/hda-ipc.h    |   4 +
 sound/soc/sof/intel/hda-loader.c | 145 ++++++++++++++++++-------------
 sound/soc/sof/intel/hda-stream.c |  69 +++++++++++++++
 sound/soc/sof/intel/hda.h        |   6 ++
 sound/soc/sof/intel/tgl.c        | 137 +++++++++++++++++++++++++++++
 sound/soc/sof/sof-pci-dev.c      |   2 +-
 9 files changed, 306 insertions(+), 84 deletions(-)
 create mode 100644 sound/soc/sof/intel/tgl.c

-- 
2.25.1

