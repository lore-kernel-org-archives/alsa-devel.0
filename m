Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087FBC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jul 2022 19:51:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13C4983B;
	Mon, 25 Jul 2022 21:50:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13C4983B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658778681;
	bh=Dn+ASodmQ2OjCt8f/XrHlqmWJ/eN5Is/eRnn+N0laiQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lx8g7sb0jlrjl+nK7kKzmb0pfIja/mRbWtqX9AO3zknsawL4nm39Cg62ZQOtWh94Z
	 5b1zwAwVWAjvXxT8Fo+wz0+MDaS2KPndvlN+U7Nm9rZnBElymhRvvs7zkC3ObXwfeN
	 dyKl1BpQBL0wt+YS/LmwW1iYywmxkEoGrh4jbGqQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18D69F80549;
	Mon, 25 Jul 2022 21:49:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 013E6F8054A; Mon, 25 Jul 2022 21:49:40 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 507E7F80163
 for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2022 21:49:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 507E7F80163
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="FWAMVqNU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658778571; x=1690314571;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Dn+ASodmQ2OjCt8f/XrHlqmWJ/eN5Is/eRnn+N0laiQ=;
 b=FWAMVqNUuZErwWeeBrJ1n50e/8XDAZqyRaIVNCG1w0TWMemmG6DSZo/L
 dDkAyfEs0qc+S1td1YqdJtirwfkxyzUP03b9BupxHgS9qfg9a38thYfCP
 heNzJZQwwjTlp8NH/4HX5rRdwD3BfcFplMl42pZUQz4ehNWJ2tqS27Vzq
 UPAIMsz+0/kjR+ftBwM+lBUnrqAlveMFbFgEHzlvCk9mUsMbl0hI6Qoc2
 dMoluhXetpbTFEf7ruFHkykJ3D+5kaIdJwHMfnUjsOrIz2hgAig8BiAb+
 vuPK2IroSnxLoBl+5N1wbL/Kk5IWx8O+gIZooNUEVrT8mtvhRg+3PE0fG A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="267553894"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; d="scan'208";a="267553894"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2022 12:49:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; d="scan'208";a="632479427"
Received: from mbianco-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.71.159])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2022 12:49:20 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/10] ASoC: Intel: machine driver updates for 5.20
Date: Mon, 25 Jul 2022 14:48:59 -0500
Message-Id: <20220725194909.145418-1-pierre-louis.bossart@linux.intel.com>
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

A couple of minor updates contributed and tested by Intel teams or end-users.
Ideally these should be applied for 5.20, time-permitting.

Andrey Turkin (2):
  ASoC: Intel: sof_es8336: Fix GPIO quirks set via module option
  ASoC: Intel: sof_es8336: ignore GpioInt when looking for
    speaker/headset GPIO lines

Muralidhar Reddy (3):
  ASoC: Intel: soc-acpi: Add entry for sof_es8336 in ADL match table
  ASoC: Intel: sof_es8336: add support for HDMI_In capture
  ASoC: Intel: sof_es8336: reset the num_links during probe

Pierre-Louis Bossart (2):
  ASoC: Intel: sof_sdw: add support for Dell SKU 0AF0
  ASoC: Intel: sof_es8336: remove hard-coded SSP selection

Yong Zhi (3):
  ASoC: Intel: sof_rt5682: Add support for mtl_mx98357_rt5682
  ASoC: Intel: sof_rt5682: Perform quirk check first in card late probe
  ASoC: Intel: sof_nau8825: Move quirk check to the front in late probe

 sound/hda/intel-dsp-config.c                  |   5 +
 sound/soc/intel/boards/sof_es8336.c           | 160 +++++++++++++-----
 sound/soc/intel/boards/sof_nau8825.c          |  10 +-
 sound/soc/intel/boards/sof_rt5682.c           |  26 ++-
 sound/soc/intel/boards/sof_sdw.c              |  10 ++
 .../intel/common/soc-acpi-intel-adl-match.c   |  25 +++
 .../intel/common/soc-acpi-intel-mtl-match.c   |  17 ++
 7 files changed, 201 insertions(+), 52 deletions(-)

-- 
2.34.1

