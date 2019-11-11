Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97250C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:30:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD2220659
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H0fHThNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD2220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 565F91670;
	Mon, 11 Nov 2019 23:29:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 565F91670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573511413;
	bh=O/vxRGi+f/fAc5cLA9iPUPwXop3ENsWjgMXpVadPkM4=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H0fHThNBeTXfjI+it+AyzLNqlrFxqgzf3UNfdL1ADC/GylieIA9y/5MqjyTwnYGiF
	 PpD+B3VBM17k9rgArnSevUeO5rNgKHzwrJtYSOZh35MPe3GKr49j84wtkq1daTLK6A
	 UXsk7xjdC6QdDHu5qZ773sUIgz7glrYdA1jcoYuc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD81FF8045D;
	Mon, 11 Nov 2019 23:29:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64DB6F8045D; Mon, 11 Nov 2019 23:29:19 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7726F8015C
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 23:29:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7726F8015C
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Nov 2019 14:29:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,294,1569308400"; d="scan'208";a="354902141"
Received: from kathyche-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.27.186])
 by orsmga004.jf.intel.com with ESMTP; 11 Nov 2019 14:29:07 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Mon, 11 Nov 2019 16:28:58 -0600
Message-Id: <20191111222901.19892-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/3] ASoC: Intel/SOF: split CFL, CNL,
	CML firmware names
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

The manifests used for the three machines can be different, so let's
move to use different firmware names. When the files can be shared
between platforms, we will use a symlink in /lib/firmware.

This change may break early platforms who relies on custom
kernels/firmware, but this will be the format supported moving
forward for all SOF firmware releases. One platform - one name.

Liam Girdwood (1):
  ASoC: SOF: Intel: Fix CFL and CML FW nocodec binary names.

Pierre-Louis Bossart (2):
  ASoC: Intel: acpi-match: split CNL tables in three
  ASoC: SOF: Intel: hda: use fallback for firmware name

 include/sound/soc-acpi-intel-match.h          |  2 +
 sound/soc/intel/common/Makefile               |  3 +-
 .../intel/common/soc-acpi-intel-cfl-match.c   | 18 ++++++
 .../intel/common/soc-acpi-intel-cml-match.c   | 56 +++++++++++++++++++
 .../intel/common/soc-acpi-intel-cnl-match.c   | 38 -------------
 sound/soc/sof/intel/hda.c                     | 11 +++-
 sound/soc/sof/sof-pci-dev.c                   |  8 +--
 7 files changed, 91 insertions(+), 45 deletions(-)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-cfl-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-cml-match.c

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
