Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C143FC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jul 2022 19:54:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0783F83D;
	Mon, 25 Jul 2022 21:53:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0783F83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658778889;
	bh=nGLPlhpxO2YiFzGBdPz1op4nh9eiw+0hHGNdCjMiHZU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iaaeT+IJzSzJJqK61ese47TEBhApJgiQWAhSi5uzGnQjA49BH05kZF+TbCVtGsjDf
	 zcyascR8agO/4ro4/kTaCBSCfon3MM1Iw+3JfeFSvtvBlsqcRjbzoTejE4PnIcQ3e6
	 J1fdN/K0HpBXzWngvnkkKFr9ouBgMw7zrMtLXwWc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95A8DF80088;
	Mon, 25 Jul 2022 21:53:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF9B6F80163; Mon, 25 Jul 2022 21:53:56 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13E4CF80088
 for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2022 21:53:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13E4CF80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="N8cF5xMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658778835; x=1690314835;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nGLPlhpxO2YiFzGBdPz1op4nh9eiw+0hHGNdCjMiHZU=;
 b=N8cF5xMwKeH18RioFU5yS3MwIJ6X7ezBrbyGPIaO9k1pd05erIysUUHV
 14QBnS9373dOLCEajZ15+FGHLLGhFgjdzz2R4ho5cv6JAwAq49BPQpB6B
 tF/+QfMXKTUkRaDxNozMYSmzs/SKNJxcTym4gikNbQch7Q8hxT4JSILFG
 NK7YIhK/pauDBhkeiC/yr0s2BrI8ojkrsVHjEmzMVH8vmbDTlMgsfj/1P
 f1Hx7jXDcWRAOArw/3N58oScbMdAVnvTCRYvi34Rlq/5k7crd22NeX9S8
 84rLCfee78XbhvLjdUZpPr2vUqHn3XpT/io74PDhMyKpU1RrQcZBDtWtx A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="270820356"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; d="scan'208";a="270820356"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2022 12:53:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; d="scan'208";a="627593482"
Received: from mbianco-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.71.159])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2022 12:53:50 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: SOF: minor updates for 5.20
Date: Mon, 25 Jul 2022 14:53:40 -0500
Message-Id: <20220725195343.145603-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

One sanity check for SSP index reported by NHLT/BIOS and two updates for
Mediatek and Intel Chromebooks related to already-merged firmware
changes.

Ideally this should go in 5.20, time-permitting.

Brent Lu (1):
  ASoC: SOF: dai-intel: add SOF_DAI_INTEL_SSP_CLKCTRL_MCLK_AON bit

Pierre-Louis Bossart (1):
  ASoC: SOF: Intel: hda: add sanity check on SSP index reported by NHLT

YC Hung (1):
  ASoC: SOF: Add cont_update_posn to platform parameters

 include/sound/sof/dai-intel.h | 2 ++
 include/uapi/sound/sof/abi.h  | 2 +-
 sound/soc/sof/intel/hda.c     | 7 +++++++
 sound/soc/sof/ipc3-pcm.c      | 3 +++
 sound/soc/sof/sof-priv.h      | 1 +
 5 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.34.1

