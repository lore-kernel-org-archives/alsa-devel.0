Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94458C54FCB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:53:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB4A2087E
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dAjT5a2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB4A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62F35167F;
	Mon, 27 Apr 2020 18:52:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62F35167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588006390;
	bh=QVtzjeEH+FjT1Xk5fMn1gE179l6cVVtmm9zG/y3+24U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dAjT5a2GytsQD5F5aHX/tsIid7gkMt6JyPeAays82RBjU8S0JJj+lhXDemdpkaUMh
	 BnIniVg2nEAsLDkZJuG3eIY5hj/eG4PRZLnE/ht9jruzDlqFI1brfQW1vInip4I8Ec
	 ImI+62CbJ7okGnGC+XgKMCWea+2whctKGXGcBGCE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9F25F8022B;
	Mon, 27 Apr 2020 18:52:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5BCB0F80112; Mon, 27 Apr 2020 18:52:18 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D7C8F80112
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 18:52:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D7C8F80112
IronPort-SDR: I4/mTYb7pDBiB+qCXBWBx3DWab5cynprtXY5uqxKfD1BCEq/zy8B//vzMXMtmAcekFb5JVLDaF
 UuCCtWMeZD+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 09:52:11 -0700
IronPort-SDR: 7mbiFekdJ30bCfO51BZL+5GIDFB0uZWY8dEF+njlG13GxNPqFGg2Rfnt7Xs2aNZNb1lQt0oB2D
 9snN7FlYbolQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; d="scan'208";a="248925565"
Received: from dbombien-mobl.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.254.51.189])
 by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2020 09:52:11 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] Kconfig updates for DMIC and SOF HDMI support
Date: Mon, 27 Apr 2020 09:52:07 -0700
Message-Id: <20200427165211.23463-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
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

This series provides the following updtes to the Intel machine driver
Kconfig:

1. The first patch adds the explicit dependency on GPIOLIB when
SND_SOC_DMIC is selected.

2. SND_SOC_SOF_HDA_AUDIO_CODEC is required for using the legacy
HDA codec driver for HDMI support in SOF. The last 3 three patches
make the required changes to account for this.

Libin Yang (3):
  ASoC: intel: add depends on SND_SOC_SOF_HDA_AUDIO_CODEC for common
    hdmi
  ASoC: sof-sdw: remove CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC condition
  ASoC: sof_pcm512x: remove CONFIG_SND_HDA_CODEC_HDMI condition

Pierre-Louis Bossart (1):
  ASoC: Intel: boards: add explicit dependency on GPIOLIB when DMIC is
    used

 sound/soc/intel/boards/Kconfig        | 51 ++++++++++++++-------------
 sound/soc/intel/boards/sof_pcm512x.c  |  9 -----
 sound/soc/intel/boards/sof_sdw.c      |  8 -----
 sound/soc/intel/boards/sof_sdw_hdmi.c |  7 ----
 4 files changed, 26 insertions(+), 49 deletions(-)

-- 
2.17.1

