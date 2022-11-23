Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C6AC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 12:44:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EB40164F;
	Wed, 23 Nov 2022 13:43:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EB40164F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669207448;
	bh=BRBt2o9DrYJstjhh/7mpbXXBWvSI6VS9AIrcb9ecNZs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jHhLTWJx6nt4PcLY7AxdShMOkTx2WyEKyO+kVYV/RGFxZwuv1YgjvvhANY+m1FMTc
	 1TyZaJbY7RCrD+A2MxtvYPm/fnJUYk93dMsNfmZWC6+zQTyLc+NC2LZS7U3dL8oJ0I
	 py4WQOhUAczrSvTcqTsKi5d9sZ9IuH5/o36T4A54=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38426F800BB;
	Wed, 23 Nov 2022 13:42:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0617DF80425; Wed, 23 Nov 2022 13:42:50 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4ADBF80149
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 13:42:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4ADBF80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MmCQEBoJ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5572261C67;
 Wed, 23 Nov 2022 12:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B562BC433C1;
 Wed, 23 Nov 2022 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669207366;
 bh=BRBt2o9DrYJstjhh/7mpbXXBWvSI6VS9AIrcb9ecNZs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MmCQEBoJoIYz9jLh1uTqLcyGTS5g4a2U3FfGnCIZAJmubMZXvEnc9dbU7w958CRW2
 bG6SuYFlPhCt3q2dHtMrioBp2UMylKb0uZ8ruMurUU3Fx6dDjw5UO9IiB3wP/azkw9
 XBfGwn+o2qRGinwfqv6E1h3h5nAB4nKzICP9SBqLRT/TvJ1lc8GILidIrLUTJghN7r
 ctH4n86DSAF1B3/f9WFAe41tLXfr0TVjgN6lGxtWhfOmEuqgAMQwRmEXp8OkIynyEG
 N1AXXd/JrC9Dhk6TCIvyJns5LMoK16Y4vsYhKyW28iE+E/B+xvRHDSK4NlVqrmQAZf
 y7QQZC6sAT9gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/31] ASoC: Intel: soc-acpi: add ES83x6 support
 to IceLake
Date: Wed, 23 Nov 2022 07:42:05 -0500
Message-Id: <20221123124234.265396-4-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221123124234.265396-1-sashal@kernel.org>
References: <20221123124234.265396-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, cezary.rojewski@intel.com,
 kai.vehmanen@linux.intel.com, rander.wang@intel.com,
 peter.ujfalusi@linux.intel.com, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 ranjani.sridharan@linux.intel.com, liam.r.girdwood@linux.intel.com,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 9a1d248bb4beaf1b43d17ba12481ee0629fa29b9 ]

Missing entry to find a machine driver for ES83x6-based platforms.

Link: https://github.com/thesofproject/linux/issues/3873
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20221031195836.250193-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-icl-match.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-icl-match.c b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
index 768ed538c4ea..bc49295bcfe2 100644
--- a/sound/soc/intel/common/soc-acpi-intel-icl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
@@ -10,6 +10,11 @@
 #include <sound/soc-acpi-intel-match.h>
 #include "../skylake/skl.h"
 
+static const struct snd_soc_acpi_codecs essx_83x6 = {
+	.num_codecs = 3,
+	.codecs = { "ESSX8316", "ESSX8326", "ESSX8336"},
+};
+
 static struct skl_machine_pdata icl_pdata = {
 	.use_tplg_pcm = true,
 };
@@ -29,6 +34,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_machines[] = {
 		.sof_fw_filename = "sof-icl.ri",
 		.sof_tplg_filename = "sof-icl-rt5682.tplg",
 	},
+	{
+		.comp_ids = &essx_83x6,
+		.drv_name = "sof-essx8336",
+		.sof_tplg_filename = "sof-icl-es8336", /* the tplg suffix is added at run time */
+		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_SSP_NUMBER |
+					SND_SOC_ACPI_TPLG_INTEL_SSP_MSB |
+					SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER,
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_icl_machines);
-- 
2.35.1

