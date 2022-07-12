Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9107C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jul 2022 12:24:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A83131676;
	Tue, 12 Jul 2022 14:23:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A83131676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657628651;
	bh=eu/nklKCnJWpp4t7+fXQWIlL4aSaE4ZIud/ZdlWwaMY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Pf4vPvOcrzIsi2MjEGz8noaC0Pj+wKDcjmq6m6JoXMtXdI2bmNBqqtxtNOp0ALZUa
	 pOQRiuIl/42dxZ9oqyq9ju+Vg36bSRQblOD0FOJecJQ8EFJK5ZfOj99I+kCfAz1uLE
	 oQP9nZPzkJqqknvzM4nEVLG3wCN4iZIrJkzM7yN8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A0C4F802DB;
	Tue, 12 Jul 2022 14:23:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4512F8012B; Tue, 12 Jul 2022 14:23:19 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB4B8F8012B
 for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2022 14:23:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB4B8F8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="LRT25HXn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657628598; x=1689164598;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eu/nklKCnJWpp4t7+fXQWIlL4aSaE4ZIud/ZdlWwaMY=;
 b=LRT25HXnu0inPf/uBZ8Q6cvGDtbYapxYcFL82csJQB4I/qiAs+yzMkC3
 Z51Nb1JqouzuSGCrJ1ibTzkdeV69ypL/tXaOcIBf7om4UZJscSORwnxUv
 hTDHjOBJWo0tjScAbrwADQwmvT208eF8WGjKuAiQ7VmoLXiLScPqvvYGK
 OjDc4d8etSuGqg+7HuklNkZqgAgdyCHOBhjUWwHrpF2s1uAqc8IK2hc+e
 sG9XrTpy2w63K0VRiBMr/Rt5uKD4ZbzYgSL7epua+KrJNwMLdVhSpY2qF
 PlKn6e15NJmAwWBQWR3mFIPd9y1inHY33QdENQV59XQKmjYKJznDCmi16 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284945765"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; d="scan'208";a="284945765"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2022 05:23:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; d="scan'208";a="922178904"
Received: from ahedstro-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.254.175])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2022 05:23:09 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 0/3] ASoC: SOF: Intel: Do not process IPC reply before
 firmware boot
Date: Tue, 12 Jul 2022 15:23:54 +0300
Message-Id: <20220712122357.31282-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
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

Hi,

By mistake a developer managed to create a 'corrupted' IPC4 firmware image which
loaded fine to the DSP and after boot it sent an IPC reply before we would have
received the FW_READY message.
It turned out that the image was an IPC3 firmware and the IPC reply was the IPC3
FW_READY notification message which got understood as an IPC4 reply message due
to the difference between the two IPC mechanism.

This caused a NULL pointer dereference since the reply memory will be allocated
after the FW_READY message.

To make sure this will not bite again, skip any spurious reply messages before
the FW_READY.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: SOF: Intel: cnl: Do not process IPC reply before firmware boot
  ASoC: SOF: Intel: hda-ipc: Do not process IPC reply before firmware
    boot
  ASoC: SOF: Intel: mtl: Do not process IPC reply before firmware boot

 sound/soc/sof/intel/cnl.c     | 37 +++++++++++++++++++++------------
 sound/soc/sof/intel/hda-ipc.c | 39 ++++++++++++++++++++++-------------
 sound/soc/sof/intel/mtl.c     | 20 +++++++++++-------
 3 files changed, 62 insertions(+), 34 deletions(-)

-- 
2.37.0

