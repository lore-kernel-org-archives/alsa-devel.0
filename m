Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C208BC433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 16:44:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD9EE86F;
	Mon,  7 Nov 2022 17:43:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD9EE86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667839455;
	bh=hyAzqw/4kYvSxZWk2lVHMTf66r5Af4kIFSGABFJYF2Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uIQ+HQjx8XbOxII/WbSBKq8WV8HCGFw1XJ2aaSeHCFUeoxP7AzZZkTDRDY/xvhAyZ
	 b/2SgCHQTz2XpzubA/oLciDYSmB7ZUOxeOycI/ddMr2bcw0R6V6W8dxfeJTYiiBc5e
	 KDJ3V8eCZNroqtjELoZPbZy/KpraMbZOvIHGpjK8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 575D4F80559;
	Mon,  7 Nov 2022 17:42:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7714F804D0; Mon,  7 Nov 2022 17:42:30 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24D9FF8025A
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 17:42:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24D9FF8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="aindOkK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667839345; x=1699375345;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hyAzqw/4kYvSxZWk2lVHMTf66r5Af4kIFSGABFJYF2Q=;
 b=aindOkK0YrH1FdPvvBynqI6R1XHyJmsUI7mf16URuIYMNujoZta5ECUF
 kLJS+SOu3j0FEAH2vjdQtt98CZBYhGFsQM8if2JFTkB/c0ZUYNMXZx9Hr
 4eit07rsfDAIMVPkKXsRXdKCiYwe4iMLTh1rHtoAGYiBvkJPOu0+DVSBH
 lOk3AdGoA/LlFcXsTD38Aqxa9CP9K8vp6KXJbmADW6TawiLht4Hjzuhkj
 bGJ/j/iOfVaM7FQs+Q/0bak4Nk7UJR8LUHlizW6w8Rkhh8CWPCLBYMlLm
 TTKSpckDJaK9CxU9RMwgTaHarz8jMz5dYCNadWkgUC26hdMtzXMl4LC58 A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="308081271"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; d="scan'208";a="308081271"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2022 08:42:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="778554113"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; d="scan'208";a="778554113"
Received: from seanabue-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.82.80])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2022 08:42:17 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: SOF: Intel: update D0i3 registers for MTL
Date: Mon,  7 Nov 2022 10:41:51 -0600
Message-Id: <20221107164154.21925-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

MeteorLake relies on a different register for D0i3 configuration, add
a platform-specific callback to abstract the differences.

Rander Wang (3):
  ASoC: SOF: Intel: add d0i3 definition for MTL
  ASoC: SOF: Intel: add d0i3_offset in chip_info
  ASoC: SOF: Intel: set d0i3 register with d0i3_offset

 sound/soc/sof/intel/apl.c     |  1 +
 sound/soc/sof/intel/cnl.c     |  2 ++
 sound/soc/sof/intel/hda-dsp.c | 21 ++++++++++++++-------
 sound/soc/sof/intel/icl.c     |  1 +
 sound/soc/sof/intel/mtl.c     |  1 +
 sound/soc/sof/intel/mtl.h     |  2 ++
 sound/soc/sof/intel/shim.h    |  1 +
 sound/soc/sof/intel/tgl.c     |  4 ++++
 8 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.34.1

