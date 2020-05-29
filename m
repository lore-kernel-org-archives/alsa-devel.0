Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8000EC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 19:37:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F8F208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 19:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vWtQip21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F8F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 556891768;
	Fri, 29 May 2020 21:36:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 556891768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590781018;
	bh=CbxaKKS49OZ0Noa3PpjoBQwsZ09v9N+EUq4hV3dHJL8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vWtQip21agQ19+/4kTdJRrJBUTf0ksj+xyp4Ohq4YU+CyYJ4tdrBNAxSoJ3c/PiQ0
	 qaBWdIoLkyjx+I6m+BSC+Zk/HPVn9VPV61scUKFMwVnpp7IX0Lg7fboO7smzzvpUaH
	 R0mOtJm1WqZF4vPmZ+IONG4/cSUKEN8nncBrBCmw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8970AF8016F;
	Fri, 29 May 2020 21:36:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A238FF80227; Fri, 29 May 2020 21:36:05 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C72AF800FF
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 21:35:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C72AF800FF
IronPort-SDR: HqwQkFNH2MsKoRUPMPueHZ+CFdkxPj4s73N2jWztK3vKnuM4AmcTJuyr5ERYKhgRSgHbFvLGY4
 GrLit3taUJ7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 12:35:52 -0700
IronPort-SDR: eEbZtU0jM/vtrg4PR64MbPea654dgfygk6UhQRKGIETKVYV7klIEVGExncecSphE4CPH9oSwzU
 6qeLhnxbL2dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; d="scan'208";a="469605864"
Received: from jbrayton-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.97.254])
 by fmsmga006.fm.intel.com with ESMTP; 29 May 2020 12:35:51 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/3] Kconfig updates for DMIC and SOF HDMI support
Date: Fri, 29 May 2020 14:35:44 -0500
Message-Id: <20200529193547.6077-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

This series provides the following updates to the Intel machine driver
Kconfig:

1. The first patch adds the explicit dependency on GPIOLIB when
SND_SOC_DMIC is selected.

2. SND_SOC_SOF_HDA_AUDIO_CODEC is required for using the legacy
HDA codec driver for HDMI support in SOF. The last 3 three patches
make the required changes to account for this.

changes since v1:
first patch for DMIC was merged already
rebase for HDMI on top of Arnd's RT5682 changes.

Libin Yang (3):
  ASoC: intel: add depends on SND_SOC_SOF_HDA_AUDIO_CODEC for common
    hdmi
  ASoC: sof-sdw: remove CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC condition
  ASoC: sof_pcm512x: remove CONFIG_SND_HDA_CODEC_HDMI condition

 sound/soc/intel/boards/Kconfig        | 20 ++++++++++----------
 sound/soc/intel/boards/sof_pcm512x.c  |  9 ---------
 sound/soc/intel/boards/sof_sdw.c      |  8 --------
 sound/soc/intel/boards/sof_sdw_hdmi.c |  7 -------
 4 files changed, 10 insertions(+), 34 deletions(-)


base-commit: 89d73ccab20a684d8446cea4d8ac6a2608c8d390
-- 
2.20.1

