Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690DAC54E94
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Jan 2023 11:47:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABFB21E2;
	Wed, 25 Jan 2023 12:46:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABFB21E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674647224;
	bh=Y4MDaIFdAkxlz4T8TGmshBV4wjCywYa2pIfPeVA1rUE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=WzxTsLgI2LU5g2k0W9SC1JVAo4RP9JKpScFqWFDW4QPhfJabur6B5vuE4uMp+XLyi
	 Yyp1N+kQcN+K8ouzRDbFkqGgrS1cL2rSJOBYirsnCj8liYQ0yOe/G4Qyd8/2z73jxE
	 p4LfmjRBbDNslnTC7g+EoqMBzl/0iyO2136WZypM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 116B5F800FB;
	Wed, 25 Jan 2023 12:46:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06ED6F804FD; Wed, 25 Jan 2023 12:46:11 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 872DBF80163
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2023 12:46:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 872DBF80163
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YxTrFSX8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674647164; x=1706183164;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Y4MDaIFdAkxlz4T8TGmshBV4wjCywYa2pIfPeVA1rUE=;
 b=YxTrFSX8NsWBvQl60bqi02t8GzW7wFITbCyJkEJw3cm3tZItA6lunv0L
 7c1stSBIXwQ0VWpcg6RuBsh49pCu4Ifx0sQoIog8HBX+hiIEGEj04F2fe
 eQK4JQt9Lfqo1LAuyJDIq/VwWn68YMeU9g7pGz+3R8PQ3LQy4VI8cLzFO
 j7a3FFVZRmqxNqTKPC+7iDuE27cy6XDheOtmXVj11+GkIT2ixSKE90a0J
 zG1HSfD8w7dFJKnaadBOymyd+79/YLJQS9TV3D3XVouBD0Dg3mkhdb6+w
 z3Ao2FbI3MT8uu+2RGGc8Ee0AAxIskKO3nquchD0SBHd5xhnriSufkEIU Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="324234142"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; d="scan'208";a="324234142"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2023 03:45:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="612393916"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; d="scan'208";a="612393916"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
 by orsmga003.jf.intel.com with ESMTP; 25 Jan 2023 03:45:56 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 00/11] ASoC: topology: Fixes and cleanups
Date: Wed, 25 Jan 2023 20:46:38 +0100
Message-Id: <20230125194649.3485731-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Following is series of fixes and cleanups for core topology code. Few
patches fixing various problems all around and few fixing function
names.

Amadeusz Sławiński (11):
  ASoC: topology: Properly access value coming from topology file
  ASoC: topology: Remove unused SOC_TPLG_PASS_PINS constant
  ASoC: topology: Fix typo in functions name
  ASoC: topology: Fix function name
  ASoC: topology: Rename remove_ handlers
  ASoC: topology: Remove unnecessary forward declarations
  ASoC: topology: Pass correct pointer instead of casting
  ASoC: topology: Return an error on complete() failure
  ASoC: Topology: Remove unnecessary check for EOF
  ASoC: topology: Use unload() op directly
  ASoC: topology: Unify kcontrol removal code

 include/sound/soc-topology.h |   2 +-
 sound/soc/soc-topology.c     | 183 ++++++++++++++---------------------
 2 files changed, 74 insertions(+), 111 deletions(-)

-- 
2.25.1

