Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DA8C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 22:39:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D837206D5
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 22:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UjiBA9yM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D837206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF14B168B;
	Wed, 29 Jan 2020 23:38:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF14B168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580337574;
	bh=iSN3gDJVlV9pp7I2nSwv82C0o1GfP2Iud8zK/bOCdAo=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UjiBA9yMlFalO0kb+comVLlVgA0zJLQKJVLWHY6y4U8RnNXyfIXvYXH+4juWln1oE
	 wRGsFcO4JXCczObBAKqjED0Q+k1Y+sMpkUiNyyDUEIHa1+UluzKjZVht7trDwpkNjA
	 kM6VbhVZNrAKKDTCA2wVTrvGb8eUwxkGly3QsPm4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EB1FF8027B;
	Wed, 29 Jan 2020 23:36:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B6D1BF80082; Wed, 29 Jan 2020 23:36:18 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA406F8021E
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 23:36:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA406F8021E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 14:36:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; d="scan'208";a="223176777"
Received: from kjhudson-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.70.93])
 by fmsmga007.fm.intel.com with ESMTP; 29 Jan 2020 14:36:04 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed, 29 Jan 2020 16:36:00 -0600
Message-Id: <20200129223603.2569-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/3] ASoC: Intel: add sof_pcm512x machine driver
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

This is an overdue upstream contribution for a platform used by nearly
all SOF developers at Intel as well as the SOF CI.

While I was the initial author in 2018, these patches were updated and
improved by Xiuli Pan, Ranjani Sridharan, Kai Vehmanen and Guennadi
Liakhovetski who worked on the last clean-ups. Thanks y'all.

Full disclosure on the Cherrytrail/Up support: the board will only be
detected with specific pin-configurations that are not handled by the
mainline kernel just yet.

Pierre-Louis Bossart (3):
  ASoC: Intel: sof_pcm512x: add support for SOF platforms with pcm512x
  ASoC: Intel: BXT: switch pcm512x based boards to sof_pcm512x
  ASoC: Intel: CHT: add support for pcm512x boards

 sound/soc/intel/boards/Kconfig                |  14 +
 sound/soc/intel/boards/Makefile               |   2 +
 sound/soc/intel/boards/sof_pcm512x.c          | 428 ++++++++++++++++++
 .../intel/common/soc-acpi-intel-bxt-match.c   |   2 +-
 .../intel/common/soc-acpi-intel-cht-match.c   |   7 +
 5 files changed, 452 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/boards/sof_pcm512x.c

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
