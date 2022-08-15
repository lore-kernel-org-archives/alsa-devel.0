Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DA2C00140
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Aug 2022 16:49:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61571163F;
	Mon, 15 Aug 2022 18:48:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61571163F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660582183;
	bh=47CpAx0EqZ6hdeD88U1C47Dhgxy6l2811gaEG2zZjfo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=osM68cofyjgnffIS6QY1xBKdPJXDjGEcC6cFawJDFVMDypa13NOmAmy7ayer2roZS
	 kUJzMptXmrltX99Dkl5gvZbWq+GykvL44DtAmzSaAgBo6c2HnI/2ENVyG8NgSnYiaF
	 IuAQR3NywdOFxinEUCofgBALsGKbALatmqX5c8Ao=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5DA5F80506;
	Mon, 15 Aug 2022 18:48:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A934EF80506; Mon, 15 Aug 2022 18:48:28 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18B1AF80125
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2022 18:48:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18B1AF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="fS9reQ/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660582103; x=1692118103;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=47CpAx0EqZ6hdeD88U1C47Dhgxy6l2811gaEG2zZjfo=;
 b=fS9reQ/Xl2o6V2RrLPqK5iqi21LPwi1/P0vWFbe9qkP1f2nECG+3bvqf
 Q7y7OE14p8bUQICBdlh0pRvTkKrR/EaWDh7UjcLc+Z3e7stZjFGyO5WIj
 Hhe2kH8lx2W55g9F9JyVqtFcipKRfY//NY08MipsqXR5pRLUjz6WzizHv
 uL8nbEUFbz+I5LpvEEggM14OSyb3fXsdxWLZ/foUmmTjWYtAfI17tDeH2
 y3BKDFo7CNJ9sX1pYErOfOPNOdXOCIkYgTf55N5qgvnoWhUJfKEtBuiso
 +ViWF9PtLcgXkY8xomi8hFuFoxb8wFpbaDkOO+JfqBtOYZ8YzM0ag8IwC A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="289570697"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; d="scan'208";a="289570697"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 09:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; d="scan'208";a="582946848"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga006.jf.intel.com with ESMTP; 15 Aug 2022 09:48:16 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 1/4] ASoC: Intel: hsw_rt5640: Rename module
Date: Mon, 15 Aug 2022 18:58:15 +0200
Message-Id: <20220815165818.3050649-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815165818.3050649-1-cezary.rojewski@intel.com>
References: <20220815165818.3050649-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, kai.vehmanen@linux.intel.co,
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

Change kernel module name from snd_soc_sst_haswell to snd_soc_hsw_rt5640
to better reflect its purpose.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/boards/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index eea1e26acfda..c1e532c47e5c 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-snd-soc-sst-haswell-objs := hsw_rt5640.o
+snd-soc-hsw-rt5640-objs := hsw_rt5640.o
 snd-soc-sst-bdw-rt5650-mach-objs := bdw-rt5650.o
 snd-soc-sst-bdw-rt5677-mach-objs := bdw-rt5677.o
 snd-soc-sst-broadwell-objs := bdw_rt286.o
@@ -47,7 +47,7 @@ obj-$(CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH) += snd-soc-sof_rt5682.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH) += snd-soc-sof_cs42l42.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_ES8336_MACH) += snd-soc-sof_es8336.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_NAU8825_MACH) += snd-soc-sof_nau8825.o
-obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
+obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-hsw-rt5640.o
 obj-$(CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON) += snd-soc-sst-bxt-da7219_max98357a.o
 obj-$(CONFIG_SND_SOC_INTEL_BXT_RT298_MACH) += snd-soc-sst-bxt-rt298.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_PCM512x_MACH) += snd-soc-sst-sof-pcm512x.o
-- 
2.25.1

