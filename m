Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966B2C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 07:09:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E5B6185C;
	Tue, 14 Jun 2022 09:08:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E5B6185C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655190578;
	bh=ru5nmFShOcTN2+hVrh9On0A7ykPXQdTK5V3NU52pvgs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=snJMP0FSwM6VPVmHMIzqeTxSFvv30RSv+Mcqwc7KMqJ2ri/nwonHNBp4uI+F12DMr
	 JGFL4GRHAzgyhmN1Qhc+F3jgQUGpE3QA0Z3zRpiVUmeS29zNG3XpZ/f1ZzA/e/ZRGs
	 Z/i51C9KxEROEe+lCdp6t4Y1l3nmh9rKZ+QkOOrk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF3B3F80139;
	Tue, 14 Jun 2022 09:08:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28F6FF80165; Tue, 14 Jun 2022 09:08:46 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3487F8012B
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2022 09:08:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3487F8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="JZpwkV6v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655190523; x=1686726523;
 h=from:to:cc:subject:date:message-id;
 bh=ru5nmFShOcTN2+hVrh9On0A7ykPXQdTK5V3NU52pvgs=;
 b=JZpwkV6vJR1kAE9wdbs/MM4NBYP/IqLbXOik3G2N3QOOxufPX99i2Z3K
 5CCAPYc6FLYt3tEIoB4KsIHC52zqCN8Z8qNaumUi0ft3t3IyaKJ2R587i
 zsumLkv77QiAMMGjJTNh9n1WIkSRhliZdpEVFwl+o4iBFKuos8k1G96J9
 ZrLQVJMPv/0vGSw/0jouIAT17OyT+DbLlWi3wZty0n4ruVf5qGcGg0QEr
 MG/A06s9X3RWXoft/vQXf24cv2O7inzftc6rDS2uL68Y8GPApyvmQJ1Qb
 4nqaXcHeAbnhxlwYmVXhPjEZNsO29eYFya85kAhLnmSPn7crZzaNVuSDb g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279250035"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="279250035"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:08:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="640185928"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:08:27 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 0/2] ASoC/SoundWire: Intel: add sdw BE dai trigger
Date: Tue, 14 Jun 2022 15:08:15 +0800
Message-Id: <20220614070817.2508-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com,
 bard.liao@intel.com
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
@Vinod, Could you ack if the soundwire patch looks good to you?
And we can go through the ASoC tree since the change is mainly on ASoC.

Bard Liao (2):
  soundwire: Intel: add trigger callback
  ASoC: SOF: Intel: add trigger callback into sdw_callback

 drivers/soundwire/intel.c           |  8 ++++++++
 include/linux/soundwire/sdw_intel.h |  1 +
 sound/soc/sof/intel/hda-dai.c       | 15 ++++++++++++---
 sound/soc/sof/intel/hda.c           |  2 +-
 sound/soc/sof/intel/hda.h           |  1 +
 5 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.17.1

