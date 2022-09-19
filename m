Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685AEECAAD3
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 11:55:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70364163E;
	Mon, 19 Sep 2022 13:54:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70364163E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663588532;
	bh=DY7KE4pNa+r6Merv9tT57wV+RayHUzyfqAO+TiLd6wc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o6mXiziFe8C9wP5HpmbHuDyJ//q53CdPi+fE8p/65Rqnxys9b5uCcaL3wnkZ4IPCH
	 MX6GDdk5tho0QOBVSx0VxqQBXJJilBkkXbaFUmMiubqErURKNp82PTScmIgfrxDT+Z
	 kBcUYmnlv2I79ggZuWjlLIf+7xZzDb1rFwZ8t/2w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FDD0F804AE;
	Mon, 19 Sep 2022 13:54:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91AB0F804B4; Mon, 19 Sep 2022 13:54:22 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F813F8023A
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2022 13:54:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F813F8023A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="eVxq1YWV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663588457; x=1695124457;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DY7KE4pNa+r6Merv9tT57wV+RayHUzyfqAO+TiLd6wc=;
 b=eVxq1YWVqUX3pW9g4ve/qc0hyiLl/BHpzV/mTzCGcUJvZVkH9rvl9Lzq
 4Sitmn2l71L2iOvTzoLJu9FPtwDmxZKA6PTjtufDvRWvvw617UBu8up3y
 HvsPoYiu+DAvfJLv+jY0g8CTpsmf+p2Wckce0PsoKpwiKx2+Jxh77JR8Q
 kKwTu7T/ONle/cVRAbvv28Br5thmD4bJ5MBcA9ysUZgCX8/4gm1jUyL4Q
 f3UtqIHuk6Xn35D/vhishM63U+IC+TqdrI/NbpY9NwtmyWvYCTsRec+5F
 8cBGuUaO5EBzHFkX66sqGFC4H0OpFX+zGwtKgLs9VsCcZ6O5CDhD4i7i+ Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="300752717"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; d="scan'208";a="300752717"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 04:54:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; d="scan'208";a="744086832"
Received: from amagnus-mobl2.ger.corp.intel.com (HELO pbossart-mobl3.home)
 ([10.249.46.168])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 04:54:07 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 1/4] ASoC: SOF: Intel: hda: refine SSP count support
Date: Mon, 19 Sep 2022 13:53:47 +0200
Message-Id: <20220919115350.43104-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919115350.43104-1-pierre-louis.bossart@linux.intel.com>
References: <20220919115350.43104-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

The SSP count is incorrect for TGL and MTL devices, the SSP count is
limited to 3 (I2SPC parameter in the Integration HAS).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/hda.h | 2 ++
 sound/soc/sof/intel/mtl.c | 2 +-
 sound/soc/sof/intel/tgl.c | 8 ++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index ba6feb1b0d3b4..bb9d2af06530e 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -435,6 +435,8 @@
 #define APL_SSP_COUNT		6
 #define CNL_SSP_COUNT		3
 #define ICL_SSP_COUNT		6
+#define TGL_SSP_COUNT		3
+#define MTL_SSP_COUNT		3
 
 /* SSP Registers */
 #define SSP_SSC1_OFFSET		0x4
diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index 1cc1398336e1f..efc91feb83e9e 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -784,7 +784,7 @@ const struct sof_intel_dsp_desc mtl_chip_info = {
 	.ipc_ctl = MTL_DSP_REG_HFIPCXCTL,
 	.rom_status_reg = MTL_DSP_ROM_STS,
 	.rom_init_timeout	= 300,
-	.ssp_count = ICL_SSP_COUNT,
+	.ssp_count = MTL_SSP_COUNT,
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE_ACE,
 	.sdw_alh_base = SDW_ALH_BASE_ACE,
diff --git a/sound/soc/sof/intel/tgl.c b/sound/soc/sof/intel/tgl.c
index 017bf331ed5a6..5135e1c7e6cf4 100644
--- a/sound/soc/sof/intel/tgl.c
+++ b/sound/soc/sof/intel/tgl.c
@@ -123,7 +123,7 @@ const struct sof_intel_dsp_desc tgl_chip_info = {
 	.ipc_ctl = CNL_DSP_REG_HIPCCTL,
 	.rom_status_reg = HDA_DSP_SRAM_REG_ROM_STATUS,
 	.rom_init_timeout	= 300,
-	.ssp_count = ICL_SSP_COUNT,
+	.ssp_count = TGL_SSP_COUNT,
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
@@ -146,7 +146,7 @@ const struct sof_intel_dsp_desc tglh_chip_info = {
 	.ipc_ctl = CNL_DSP_REG_HIPCCTL,
 	.rom_status_reg = HDA_DSP_SRAM_REG_ROM_STATUS,
 	.rom_init_timeout	= 300,
-	.ssp_count = ICL_SSP_COUNT,
+	.ssp_count = TGL_SSP_COUNT,
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
@@ -169,7 +169,7 @@ const struct sof_intel_dsp_desc ehl_chip_info = {
 	.ipc_ctl = CNL_DSP_REG_HIPCCTL,
 	.rom_status_reg = HDA_DSP_SRAM_REG_ROM_STATUS,
 	.rom_init_timeout	= 300,
-	.ssp_count = ICL_SSP_COUNT,
+	.ssp_count = TGL_SSP_COUNT,
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
@@ -192,7 +192,7 @@ const struct sof_intel_dsp_desc adls_chip_info = {
 	.ipc_ctl = CNL_DSP_REG_HIPCCTL,
 	.rom_status_reg = HDA_DSP_SRAM_REG_ROM_STATUS,
 	.rom_init_timeout	= 300,
-	.ssp_count = ICL_SSP_COUNT,
+	.ssp_count = TGL_SSP_COUNT,
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
 	.sdw_shim_base = SDW_SHIM_BASE,
 	.sdw_alh_base = SDW_ALH_BASE,
-- 
2.34.1

