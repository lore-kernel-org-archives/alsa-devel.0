Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FE2C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 00:58:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009CA22CAE
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 00:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009CA22CAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 255E5193C;
	Fri, 22 Jan 2021 01:57:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 255E5193C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611277125;
	bh=5P19+XXKmfShBEW+kQmZI15VnC3OnvrMCLBdepBpdfU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b2Eh3AABO1o++v5Ny/knjDLMkSuwwmAkGDjof1n+Fb7i9PtnyJ3Ga/PJ5G+CZFaVk
	 VOmKoh6xx4GfQbBjMiEreYHv9CBltxbzRr1TZvES4PW81XQi9udbjh6Gt4aWWp1YDC
	 oae+mp/TCy2D9nnWtOViI6i3FiJvfpJGygqM3wxI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55F91F8026A;
	Fri, 22 Jan 2021 01:57:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0A2BF80272; Fri, 22 Jan 2021 01:57:52 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61E90F80125
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 01:57:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61E90F80125
IronPort-SDR: GUhSO+gHapkK4N6BpzqrP2EyxQbj2ocwYK7NOKkIxuqxZKE8dbcf5dK3DypWmzbho5y3rI/k/9
 AWoua5Y80TsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264190801"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; d="scan'208";a="264190801"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 16:57:40 -0800
IronPort-SDR: dRLHQEeyrpgXDDuxKwokQMgNzDJiPNsmz0lx+9cKz/XOp2BFzVu9R4Tdhl/we8/RtuP87JJwwt
 1Nz5/CyE6ppg==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; d="scan'208";a="367126945"
Received: from seleedom-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.133.150])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 16:57:39 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ASoC: SOF: partial fix to Kconfig issues
Date: Thu, 21 Jan 2021 18:57:23 -0600
Message-Id: <20210122005725.94163-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Arnd Bergmann <arnd@kernel.org>, vkoul@kernel.org,
 broonie@kernel.org,
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

We've had several reports of broken dependencies. The 'right' fix is
to revisit the module dependencies as suggested by Arnd Bergmann. This
is WIP at https://github.com/thesofproject/linux/pull/2683. Since this
is taking longer than expected, I am only sharing quick fixes for now.

Pierre-Louis Bossart (2):
  ASoC: SOF: Intel: soundwire: fix select/depend unmet dependencies
  ASoC: SOF: SND_INTEL_DSP_CONFIG dependency

 sound/soc/sof/intel/Kconfig  |  3 ++-
 sound/soc/sof/sof-acpi-dev.c | 11 ++++++-----
 sound/soc/sof/sof-pci-dev.c  | 10 ++++++----
 3 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.25.1

