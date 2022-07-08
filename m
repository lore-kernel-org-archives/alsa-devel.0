Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B7EC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jul 2022 06:14:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AE5D857;
	Fri,  8 Jul 2022 08:13:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AE5D857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657260862;
	bh=QDlKDUOAMJO2R3ZV+IEYWZ6C3HL1d2Ix8qtgXh3ipk8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KfXNxJJoV4OAf7KVRprjWyoX2rkSLRauThAloCrxD/imq6rPEdtNdBmISNXvFFFAj
	 tDQCWiwjlvY0fqmjjbfiRS6e8OicV+DlLF91J+SYITOhK5c3eqUOpNG/wGwPz09WL6
	 bYn0ZA27IN8051KRWojBoWzKTYVtwp9nAYOx4Yk8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C24B7F80166;
	Fri,  8 Jul 2022 08:13:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25998F80084; Fri,  8 Jul 2022 08:13:30 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2DDBF80084
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2022 08:13:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2DDBF80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="kcSKMPJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657260808; x=1688796808;
 h=from:to:cc:subject:date:message-id;
 bh=QDlKDUOAMJO2R3ZV+IEYWZ6C3HL1d2Ix8qtgXh3ipk8=;
 b=kcSKMPJI1EnooRMKJYNGuHe0Ns54n69w3ncshp+ZU3vAS2/y4Jmo2spK
 KntELQjVPAWrXr/TjQHuk5TdP8MbVp7KfyJHDCfTpJ/b/5V8XUDpuJ+k2
 2nKzNOzchGsWJpCFLx1oF12I8TqqbJ9wS8AALYQ03JGlK5G1ftJ65qD4N
 mROeDXvkJrMumx7kLfo9oo8SqDGP+5stJql5u6AV/eZPFnf/PqkfoMuvL
 H+BXhLmv1dLKHlTmbYGzgyfRrkMA24ksN0R+kxrvasFWzg7Yu2ZMqY1mv
 2sCw0KboEi2X002JlCvCEojoQhHlKskhOQhUN+ezgncGdIf+JQWzG6mkI A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="281750575"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; d="scan'208";a="281750575"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2022 23:13:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; d="scan'208";a="651440339"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2022 23:13:20 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	vkoul@kernel.org
Subject: [RESEND PATCH v3 0/2] ASoC/SoundWire: Intel: add sdw BE dai trigger
Date: Fri,  8 Jul 2022 14:13:10 +0800
Message-Id: <20220708061312.25878-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com, bard.liao@intel.com
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

For SOF IPC4, we need to set pipeline state in BE DAI trigger.
@Mark, resending this series in case it is lost in your mailbox.

v2:
 - Change "#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)" to
   "if (IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE))"

v3:
 - Change the multi-line comment style in "soundwire: Intel: add trigger
   callback" patch and take Vinod's Ack.

Bard Liao (2):
  soundwire: Intel: add trigger callback
  ASoC: SOF: Intel: add trigger callback into sdw_callback

 drivers/soundwire/intel.c           |  9 +++++++++
 include/linux/soundwire/sdw_intel.h |  1 +
 sound/soc/sof/intel/hda-dai.c       | 14 +++++++++++---
 sound/soc/sof/intel/hda.c           |  2 +-
 sound/soc/sof/intel/hda.h           |  1 +
 5 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.17.1

