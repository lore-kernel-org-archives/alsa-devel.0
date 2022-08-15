Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14440C00140
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Aug 2022 16:50:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C24D163D;
	Mon, 15 Aug 2022 18:49:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C24D163D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660582236;
	bh=I/aUJe+QFHA3J8Sxk1MWzGqbQpKhywkKPbOgnVtPawU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E1u3MVjZjrb2pgF6Xr8r8pXhsrH9D2x7fraGKVztRRXDz0djaWkqw7eNIWBmHKUsu
	 CzdAVbfxoeK38vrWizsR6r00j/F9wE9c28TLcsD9gPTSnOjqNIzWl3Cka403ApunBl
	 wYoF3z93UHDn4c0pEb8Z7mkAK1eglxt1y3WG/dfE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CCB9F8055A;
	Mon, 15 Aug 2022 18:48:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35C33F80553; Mon, 15 Aug 2022 18:48:35 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B05CF80125
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2022 18:48:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B05CF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="KMl7bpoR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660582109; x=1692118109;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I/aUJe+QFHA3J8Sxk1MWzGqbQpKhywkKPbOgnVtPawU=;
 b=KMl7bpoR3okVzabNjruVQqhFXT+Q58ZNNc1EBF8/zq3TN+ygsc0gfk2w
 upfMu81GauEptpsH0rzePnu+I6fiaMhn/4oeBIt8E6i8XNsIuXADge+BK
 O5hB289/Oqj/Sec58fChCscKGE+Xq3sPvRJH3hZjwkagWXKBdJFTyXkeG
 4n4/mEd0grR/jgIpHEdd9Joc+7kcxN7lTmshTS71MWzVMmkGizp+c/hLU
 59PBgZr3od/BokJ/9n6Ldrrg0vjwpQjyxdjJqjXM3x28DA+Ck0AEiXY1J
 d0TNb0+w98NtdsJSQGwd5k7z6EYGLWzBFLqOG47xa5qYdECf4pEkRFx7T g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="289570727"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; d="scan'208";a="289570727"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 09:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; d="scan'208";a="582946892"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga006.jf.intel.com with ESMTP; 15 Aug 2022 09:48:24 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 4/4] ASoC: Intel: Drop legacy HSW/BDW board-match information
Date: Mon, 15 Aug 2022 18:58:18 +0200
Message-Id: <20220815165818.3050649-5-cezary.rojewski@intel.com>
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

With board-matching information for legacy solution moved to local
directory, there is no need to expose it globally.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/sound/soc-acpi-intel-match.h              |  1 -
 .../intel/common/soc-acpi-intel-hsw-bdw-match.c   | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
index bc7fd46ec2bc..14d783952548 100644
--- a/include/sound/soc-acpi-intel-match.h
+++ b/include/sound/soc-acpi-intel-match.h
@@ -14,7 +14,6 @@
  * these tables are not constants, some fields can be used for
  * pdata or machine ops
  */
-extern struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cherrytrail_machines[];
diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index cbcb649604e5..6daf60b1edf1 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -9,40 +9,25 @@
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 
-struct snd_soc_acpi_mach snd_soc_acpi_intel_haswell_machines[] = {
-	{
-		.id = "INT33CA",
-		.drv_name = "hsw_rt5640",
-		.fw_filename = "intel/IntcSST1.bin",
-		.sof_tplg_filename = "sof-hsw.tplg",
-	},
-	{}
-};
-EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_haswell_machines);
-
 struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 	{
 		.id = "INT343A",
 		.drv_name = "bdw_rt286",
-		.fw_filename =  "intel/IntcSST2.bin",
 		.sof_tplg_filename = "sof-bdw-rt286.tplg",
 	},
 	{
 		.id = "10EC5650",
 		.drv_name = "bdw-rt5650",
-		.fw_filename = "intel/IntcSST2.bin",
 		.sof_tplg_filename = "sof-bdw-rt5650.tplg",
 	},
 	{
 		.id = "RT5677CE",
 		.drv_name = "bdw-rt5677",
-		.fw_filename =  "intel/IntcSST2.bin",
 		.sof_tplg_filename = "sof-bdw-rt5677.tplg",
 	},
 	{
 		.id = "INT33CA",
 		.drv_name = "hsw_rt5640",
-		.fw_filename = "intel/IntcSST2.bin",
 		.sof_tplg_filename = "sof-bdw-rt5640.tplg",
 	},
 	{}
-- 
2.25.1

