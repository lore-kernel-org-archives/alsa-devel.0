Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F0FC433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 16:38:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E1E61983
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 16:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E1E61983
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 916CE86F;
	Mon, 22 Mar 2021 17:37:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 916CE86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616431125;
	bh=mSDEFlBXi9qZ5J94KgtYEglgkXSAj6n4Ivi81wSbWvo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tue3BX/RQmX02sW3zO2Wnz9N3w82IjBm1gB4nF/S0VCN0TjAgiPaIj5w6Vxd5GUMO
	 jpUdG3gotxt+T7PfYzb3b8nTq18Pt1SEw+UQSoPyZOdUlTkfbZvwVCOoIdH6BzZ4LJ
	 IZAEWyCYs5tos/X9VWgygYTE+K1p2MuH5TgLWRy8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4851F801D5;
	Mon, 22 Mar 2021 17:37:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5B64F80246; Mon, 22 Mar 2021 17:37:52 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EEBAFF8016B
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 17:37:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEBAFF8016B
IronPort-SDR: WX7ZwLb7bmZZ3pMv3itDWUowXYazTXQWnsXgP7jQi8gSZjzKPX9WLr0y9SQzba1Fc6nhRS0K23
 IAmLEhkqEzUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210376598"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="210376598"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 09:37:41 -0700
IronPort-SDR: rgBlWBtor1JFDXxW7/ktfykUuVWlIuLxp44EfyusEy+Nb38BDx22SFZpK7/erpj6duidj5Il2S
 /n5gewsHonog==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="407899052"
Received: from josemari-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.40.21])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 09:37:39 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/8] ASoC: SOF: Intel: shutdown and core handling corrections
Date: Mon, 22 Mar 2021 11:37:20 -0500
Message-Id: <20210322163728.16616-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

This patchset fixes a logical flow in the core status, improves
shutdown support on Intel SOF platforms with an HDaudio controller and
cleans-up ElkhartLake support.

Guennadi Liakhovetski (1):
  ASoC: SOF: Intel: HDA: fix core status verification

Libin Yang (5):
  ASoC: SOF: Intel: TGL: fix EHL ops
  ASoC: SOF: Intel: TGL: set shutdown callback to hda_dsp_shutdown
  ASoC: SOF: Intel: ICL: set shutdown callback to hda_dsp_shutdown
  ASoC: SOF: Intel: CNL: set shutdown callback to hda_dsp_shutdown
  ASoC: SOF: Intel: APL: set shutdown callback to hda_dsp_shutdown

Pierre-Louis Bossart (2):
  ASoC: SOF: core: harden shutdown helper
  ASoC: SOF: Intel: move ELH chip info

 sound/soc/sof/core.c          |  8 +++++++-
 sound/soc/sof/intel/apl.c     |  3 ++-
 sound/soc/sof/intel/cnl.c     | 19 ++-----------------
 sound/soc/sof/intel/hda-dsp.c | 21 +++++++++++++++++----
 sound/soc/sof/intel/hda.h     |  1 +
 sound/soc/sof/intel/icl.c     |  3 ++-
 sound/soc/sof/intel/pci-tgl.c |  2 +-
 sound/soc/sof/intel/tgl.c     | 18 +++++++++++++++++-
 8 files changed, 49 insertions(+), 26 deletions(-)

-- 
2.25.1

