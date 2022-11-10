Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138A2C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Nov 2022 13:57:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D43C1666;
	Thu, 10 Nov 2022 14:56:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D43C1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668088645;
	bh=QsIiRuCew5ZO1BNvlS86zYl8Nr+uoxGXdCjkU7F6oog=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lyt+4RmSIaCF30KlQoa2nKyfn319+wlWEEhfiau66W8C2NvZoAPEc5Mmv75v4Y5mI
	 vNHsL3zrWhxnXgbr2Xu44dDRuRxKfpxtYHvKz7ymtDO0utPsRHJNepvKg4lpZpVbQY
	 2LiKXi2uxnE3yhaoWvXSFpEnbfdIfUwWfeuJy+zQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A23B5F80163;
	Thu, 10 Nov 2022 14:56:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 959DAF8032B; Thu, 10 Nov 2022 14:56:33 +0100 (CET)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66E71F80162
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2022 14:56:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66E71F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="M6R1TdI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668088587; x=1699624587;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QsIiRuCew5ZO1BNvlS86zYl8Nr+uoxGXdCjkU7F6oog=;
 b=M6R1TdI8SDP4lCmRsLl3AdHwOiDHq+6PLYOejerVaPci6kr+OWSFb+Vw
 jL/dJTGk5cUnssFri2saasn/StP6zJ5a5CL5YRM1rvHpc007lBotpLxPb
 p+fcKqphhabhSsmcvzD1ZYUm8LfQUke3N19Enru5+4MqGewxMq/AnlHDf
 kOGdvRy7R/vGKjJF/NmJnUKAs9j9VSqIDDarA6WTA97ah8xJZ71Bv/wC0
 6d+4ohG474/EQsKucYH5pFqwtRM6K+C/1vVQkxh0V+X9a0+uv1eky3WhB
 9TKh5mWyC9MvyoYVc0csM3mmyzLjkieUT/FF3FfZGfsfAASzcBc4ImB/1 Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373431541"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; d="scan'208";a="373431541"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 05:56:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="966414992"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; d="scan'208";a="966414992"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga005.fm.intel.com with ESMTP; 10 Nov 2022 05:56:20 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 0/2] ASoC: Intel: avs: DSP recovery and resume fixes
Date: Thu, 10 Nov 2022 15:13:28 +0100
Message-Id: <20221110141330.740916-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com
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

Two fixes that are result of the recent discussions [1][2].

First adds missing locking around snd_pcm_stop() while the second fix
sets substream state to DISCONNECTED if any suspend/resume related
operation fails so that userspace has means to be aware that something
went wrong during said operation.

[1]: https://lore.kernel.org/alsa-devel/73e6425f-8e51-e26f-ad83-ccc5df517a43@intel.com/
[2]: https://lore.kernel.org/alsa-devel/20221104131244.3920179-1-cezary.rojewski@intel.com/

Cezary Rojewski (2):
  ASoC: Intel: avs: Lock substream before snd_pcm_stop()
  ASoC: Intel: avs: Disconnect substream if suspend or resume fails

 sound/soc/intel/avs/ipc.c |  2 ++
 sound/soc/intel/avs/pcm.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.25.1

