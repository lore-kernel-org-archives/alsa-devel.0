Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5200EC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Jan 2022 11:06:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 814C418E8;
	Tue, 11 Jan 2022 12:06:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 814C418E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641899215;
	bh=UZTEJwqrWznAXGdvsV/ZHOp1lI6B4x07xoOVy5ZfMec=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fFv7T5BnkQsQFscbTDeau0d+a+THvFjkvLaHiCm/7OgFtuF1y1Rpp7Hi+fDjfBpef
	 +cpCfuEkNdwS47bHGfpfwtOJIKEh3bpy+DTS012uhjsCujk/dGeHxVLRQxoJkgkVDo
	 SLYDSGjXFloOqf6WlC/PjgJYH2bk3A76hqPRPnJI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14744F80118;
	Tue, 11 Jan 2022 12:06:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62905F80118; Tue, 11 Jan 2022 12:06:03 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1715FF80118
 for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2022 12:05:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1715FF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="TZ3tZntm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641899161; x=1673435161;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UZTEJwqrWznAXGdvsV/ZHOp1lI6B4x07xoOVy5ZfMec=;
 b=TZ3tZntmLiqmQw8MUDz2Q9/M6jPOdwdxSuSIHFqHFmm6+9PcsP8a8Idb
 bc74Ht9bFK62Pd/fDPJgYNzhREP2iBKWRjQxVS/1xj5SpNxKrBsWkhN78
 /4tn4/lpHzxYswqnd6HSurpmDdsW+gQRYiwz8gGxz9P/f+WwN6ulhYC4a
 Rw7FOK6DkNub/ab5ZV0TNoKhYMgeBBBJR833LUDqI2fe0Ewx5RoKsupCV
 eCBzdgPdMHYI6ADWuLh3RTTzszqNu0mfcz+Oh3GvISiFv7VGze92W98ei
 1kcz2cKSylh7ac8HVi3G6k90dGNPRoe6TljAaVR1Yf66c9Uyk01FCOqbR Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="241012607"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; d="scan'208";a="241012607"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2022 03:05:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; d="scan'208";a="528700927"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
 by orsmga008.jf.intel.com with ESMTP; 11 Jan 2022 03:05:52 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/3] ASoC: topology: Fixes
Date: Tue, 11 Jan 2022 20:05:25 +0100
Message-Id: <20220111190528.445248-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
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

Following series performs few cleanups in topology code.

First patch reduces number of prints we get from failure.
Second allos TLV controls to be either read or write which should be
possible as evidenced by further code in function.
Last one cleanups after refactoring of memory handling.

Amadeusz Sławiński (3):
  ASoC: topology: Remove superfluous error prints
  ASoC: topology: Allow TLV control to be either read or write
  ASoC: topology: Optimize soc_tplg_dapm_graph_elems_load behavior

 sound/soc/soc-topology.c | 103 ++++++++++-----------------------------
 1 file changed, 27 insertions(+), 76 deletions(-)

-- 
2.25.1

