Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCE9C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 19:31:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02E831878;
	Tue,  8 Mar 2022 20:30:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02E831878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646767892;
	bh=95XKRGm6/kKmQe/wqP6iZkA3xkm1a2LczjRX2vk/TUU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sdTVJmCHGS6Eei6krtpPNuW+Rnj8tLnhg7rdRlSfcIjcdxpMqVx/r6Sa3AXJ+fEmC
	 DQeI5oaP7z9C+PDjNmVe40W3u1QlsZ5zrZEP45rP0T+dtyEDW0c5GNjT1tL6P2k1sP
	 xYqw8pXZBTTBfLdJI7qFpz1FFbVRsy2vfR2Z84fI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 279E9F80564;
	Tue,  8 Mar 2022 20:27:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 015FEF80552; Tue,  8 Mar 2022 20:27:01 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFD08F80517
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2022 20:26:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFD08F80517
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="QVCve4uA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646767609; x=1678303609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=95XKRGm6/kKmQe/wqP6iZkA3xkm1a2LczjRX2vk/TUU=;
 b=QVCve4uAbXKL8gI+7JCCA8Nu14CHZO1quPAvOoSe5DjqcK7ZRbcpqNou
 hECGMJv7B8OHRStnFi1o7JNIreQu3irGinvI/ueKqj5A7+g2I9xzsv02v
 w7WqcmbIzF5OmBgHcfERrjFxB6eH3H9H0VXN05PW120xRIYEDgTRmTNUb
 z0JMTSHuRdaW55WcPUrBWwHd6xpfvjIFkxiVbszbN44HsQEtcjOcQqjlj
 HiPagWq0+JVt5/GZwXbfRAdX5YWT48QvYGCWtw9NtRBOvGJPC6U6F0kbq
 SBDbn++6q8Zyeapg4q2MDSRD/rTRncZ/On32BvJmoPSZruIO6GB9bjkI+ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252363713"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="252363713"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 11:26:46 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="495573965"
Received: from jhaskins-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.209.53.149])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 11:26:45 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 10/20] ASoC: Intel: soc-acpi: add ESSX8336 support on Cannon
 Lake machines
Date: Tue,  8 Mar 2022 13:26:00 -0600
Message-Id: <20220308192610.392950-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308192610.392950-1-pierre-louis.bossart@linux.intel.com>
References: <20220308192610.392950-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Huajun Li <huajun.li@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Nikolai Kostrigin <nickel@altlinux.org>, broonie@kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

From: Nikolai Kostrigin <nickel@altlinux.org>

Add the support for all ES83x6 devices

Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
index 8d3e8c3b589b..3df89e4511da 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
@@ -11,6 +11,11 @@
 #include "../skylake/skl.h"
 #include "soc-acpi-intel-sdw-mockup-match.h"
 
+static const struct snd_soc_acpi_codecs essx_83x6 = {
+	.num_codecs = 3,
+	.codecs = { "ESSX8316", "ESSX8326", "ESSX8336"},
+};
+
 static struct skl_machine_pdata cnl_pdata = {
 	.use_tplg_pcm = true,
 };
@@ -23,6 +28,15 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[] = {
 		.pdata = &cnl_pdata,
 		.sof_tplg_filename = "sof-cnl-rt274.tplg",
 	},
+	{
+		.comp_ids = &essx_83x6,
+		.drv_name = "sof-essx8336",
+		/* cnl and cml are identical */
+		.sof_tplg_filename = "sof-cml-es8336", /* the tplg suffix is added at run time */
+		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_SSP_NUMBER |
+					SND_SOC_ACPI_TPLG_INTEL_SSP_MSB |
+					SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER,
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_cnl_machines);
-- 
2.30.2

