Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1354C282DD
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 22:26:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58DC20673
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 22:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nE9aM6gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58DC20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFF52169F;
	Fri, 10 Jan 2020 23:25:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFF52169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578695192;
	bh=iE4shZ0C1Hbdel/mM9Lit59dcVKL0BdRVujW5B/NJAE=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nE9aM6gxl62NOtQCdW04bxm6A7dFqkjXLnxuPEYqvTuvljKEFACyD7SVyzMhnENcK
	 HQwp7sSdVpe+8oFPV5SKSQEEUKKJ1kl3FZNIxRQyjiEaMrs9afb78mDZFfkiO41+6x
	 LMsGaxv0WVfyXzs8kcy1f0nNbdBedtlKSKCDcgNM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39C6AF801EB;
	Fri, 10 Jan 2020 23:25:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 966B3F8011C; Fri, 10 Jan 2020 23:25:40 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2045DF800E4
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 23:25:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2045DF800E4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 14:25:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; d="scan'208";a="216813222"
Received: from ewronsha-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.66.226])
 by orsmga008.jf.intel.com with ESMTP; 10 Jan 2020 14:25:32 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 10 Jan 2020 16:25:24 -0600
Message-Id: <20200110222530.30303-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/6] ASoC: soc-acpi: add support for
	SoundWire-based machines
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

SoundWire support on Intel platforms relies on ACPI _ADR fields
exposed in DSDT tables, with a 64-bit value defining which link a
Slave device is connected to and its partId/manufacturerID/uniqueID.

The existing definitions based on a globally-visible _HID used for
I2C/I2S are no longer sufficient and need to be extended to detect
during the probe steps which machine driver should be selected.

This patchset adds the structure changes, and a set of static tables
already used by Intel developers and customers. These tables are
provided ahead of time, but they will only be used once all
SoundWire-related parts are merged upstream and SoundWire is enabled
in the builds.

For reference, the complete set of 100+ patches required for SoundWire
on Intel platforms is available here:

https://github.com/thesofproject/linux/pull/1692

Bard Liao (1):
  ASoC: Intel: common: add match tables for ICL w/ SoundWire

Pierre-Louis Bossart (4):
  ASoC: soc-acpi: add _ADR-based link descriptors
  ASoC: Intel: common: soc-acpi: declare new tables for SoundWire
  ASoC: Intel: common: add match tables for TGL w/ SoundWire
  ASoC: SOF: Intel: reference SoundWire machine lists

Rander Wang (1):
  ASoC: Intel: common: add match tables for CNL/CFL/CML w/ SoundWire

 include/sound/soc-acpi-intel-match.h          |  6 ++
 include/sound/soc-acpi.h                      | 21 ++++
 .../intel/common/soc-acpi-intel-cfl-match.c   |  5 +
 .../intel/common/soc-acpi-intel-cml-match.c   | 89 +++++++++++++++++
 .../intel/common/soc-acpi-intel-cnl-match.c   |  5 +
 .../intel/common/soc-acpi-intel-icl-match.c   | 98 +++++++++++++++++++
 .../intel/common/soc-acpi-intel-tgl-match.c   | 51 +++++++++-
 sound/soc/sof/sof-pci-dev.c                   |  5 +
 8 files changed, 278 insertions(+), 2 deletions(-)


base-commit: b2e2a13796889e10ba0390ab338949ba63d89462
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
