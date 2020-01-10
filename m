Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2773CC282DD
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 22:29:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D5920673
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 22:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mR3u6jsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D5920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03E9116D9;
	Fri, 10 Jan 2020 23:28:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03E9116D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578695348;
	bh=qOnrmx/9Pbar6kuuLJ/cA8/sEi7vP/wkAGi/Jk5dcxw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mR3u6jsZHH/zOpWrFP524Y6in9Uf03wLYqOncjVrb5gvBPjBSUXDZ2asMBGwcXjgx
	 8IGXKfeUMI8Xn3KunUm2mmgy6uuH67pg1lkkDsUdQ9W3p0qz8TnADEf7t8AmlTo12N
	 OOh8UywLuturuWBy3t4BADoPo0MB2TBvIy0yU/ds=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CEA79F8028B;
	Fri, 10 Jan 2020 23:25:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 309AFF80273; Fri, 10 Jan 2020 23:25:46 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3ECD9F800E4
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 23:25:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3ECD9F800E4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 14:25:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; d="scan'208";a="216813258"
Received: from ewronsha-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.66.226])
 by orsmga008.jf.intel.com with ESMTP; 10 Jan 2020 14:25:35 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 10 Jan 2020 16:25:27 -0600
Message-Id: <20200110222530.30303-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110222530.30303-1-pierre-louis.bossart@linux.intel.com>
References: <20200110222530.30303-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 3/6] ASoC: Intel: common: add match tables for
	ICL w/ SoundWire
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Bard Liao <yung-chuan.liao@linux.intel.com>

The two configurations are with the Realtek 3-in-1 board requiring all
4 links to be enabled, or basic configuration with the on-board RT700
using link0.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-icl-match.c   | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-icl-match.c b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
index 38977669b576..67e9da4635f2 100644
--- a/sound/soc/intel/common/soc-acpi-intel-icl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
@@ -33,5 +33,103 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_machines[] = {
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_icl_machines);
 
+static const u64 rt700_0_adr[] = {
+	0x000010025D070000
+};
+
+static const struct snd_soc_acpi_link_adr icl_rvp[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt700_0_adr),
+		.adr = rt700_0_adr,
+	},
+	{}
+};
+
+static const u64 rt711_0_adr[] = {
+	0x000010025D071100
+};
+
+static const u64 rt1308_1_adr[] = {
+	0x000110025D130800
+};
+
+static const u64 rt1308_2_adr[] = {
+	0x000210025D130800
+};
+
+static const u64 rt715_3_adr[] = {
+	0x000310025D715000
+};
+
+static const struct snd_soc_acpi_link_adr icl_3_in_1_default[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt711_0_adr),
+		.adr = rt711_0_adr,
+	},
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(rt1308_1_adr),
+		.adr = rt1308_1_adr,
+	},
+	{
+		.mask = BIT(2),
+		.num_adr = ARRAY_SIZE(rt1308_2_adr),
+		.adr = rt1308_2_adr,
+	},
+	{
+		.mask = BIT(3),
+		.num_adr = ARRAY_SIZE(rt715_3_adr),
+		.adr = rt715_3_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr icl_3_in_1_mono_amp[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt711_0_adr),
+		.adr = rt711_0_adr,
+	},
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(rt1308_1_adr),
+		.adr = rt1308_1_adr,
+	},
+	{
+		.mask = BIT(3),
+		.num_adr = ARRAY_SIZE(rt715_3_adr),
+		.adr = rt715_3_adr,
+	},
+	{}
+};
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_icl_sdw_machines[] = {
+	{
+		.link_mask = 0xF, /* 4 active links required */
+		.links = icl_3_in_1_default,
+		.drv_name = "sdw_rt711_rt1308_rt715",
+		.sof_fw_filename = "sof-icl.ri",
+		.sof_tplg_filename = "sof-icl-rt711-rt1308-rt715.tplg",
+	},
+	{
+		.link_mask = 0xB, /* 3 active links required */
+		.links = icl_3_in_1_mono_amp,
+		.drv_name = "sdw_rt711_rt1308_rt715",
+		.sof_fw_filename = "sof-icl.ri",
+		.sof_tplg_filename = "sof-icl-rt711-rt1308-rt715-mono.tplg",
+	},
+	{
+		.link_mask = 0x1, /* rt700 connected on link0 */
+		.links = icl_rvp,
+		.drv_name = "sdw_rt700",
+		.sof_fw_filename = "sof-icl.ri",
+		.sof_tplg_filename = "sof-icl-rt700.tplg",
+	},
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_icl_sdw_machines);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel Common ACPI Match module");
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
