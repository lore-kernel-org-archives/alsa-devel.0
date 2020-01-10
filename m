Return-Path: <SRS0=QJW1=27=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A850FC282DD
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 22:30:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2221A2072E
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jan 2020 22:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="owhgbOCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2221A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74BEF16D2;
	Fri, 10 Jan 2020 23:29:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74BEF16D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578695420;
	bh=QawqTZEVULsf8udCb1pOAcRMuR95FFCme/xZbrZFdY8=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=owhgbOCoz9hDWJSvGqPCpUQjKtZ2fAa9fYda9QqAdYHmN8oGzBuKGRZkgu9HjT9Sb
	 9zqTI2Pcb3jOS7ijIukYTMVLOvpKfXD6Aukx2Y4RQSLM1qsVf9KIrzwrTBJZSdGsdG
	 TEdbk+KvkzG1ZGDonma14685X49Sm+Uo0cVAt1pc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0885BF80292;
	Fri, 10 Jan 2020 23:25:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F42AF801DA; Fri, 10 Jan 2020 23:25:47 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1042EF80161
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2020 23:25:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1042EF80161
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 14:25:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; d="scan'208";a="216813297"
Received: from ewronsha-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.66.226])
 by orsmga008.jf.intel.com with ESMTP; 10 Jan 2020 14:25:37 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 10 Jan 2020 16:25:29 -0600
Message-Id: <20200110222530.30303-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110222530.30303-1-pierre-louis.bossart@linux.intel.com>
References: <20200110222530.30303-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>
Subject: [alsa-devel] [PATCH 5/6] ASoC: Intel: common: add match tables for
	TGL w/ SoundWire
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

RT711 is in SoundWire mode on link0.
RT1308 is either on SSP2 or on SoundWire link1 (depending on hardware
reworks).

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-tgl-match.c   | 51 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index b4687a5d1962..5984dd151f3e 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -14,12 +14,46 @@ static struct snd_soc_acpi_codecs tgl_codecs = {
 	.codecs = {"MX98357A"}
 };
 
+static const u64 rt711_0_adr[] = {
+	0x000010025D071100
+};
+
+static const u64 rt1308_1_adr[] = {
+	0x000120025D130800,
+	0x000122025D130800
+};
+
+static const struct snd_soc_acpi_link_adr tgl_i2s_rt1308[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt711_0_adr),
+		.adr = rt711_0_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr tgl_rvp[] = {
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
+	{}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 	{
 		.id = "10EC1308",
-		.drv_name = "tgl_rt1308",
+		.drv_name = "rt711_rt1308",
+		.link_mask = 0x1, /* RT711 on SoundWire link0 */
+		.links = tgl_i2s_rt1308,
 		.sof_fw_filename = "sof-tgl.ri",
-		.sof_tplg_filename = "sof-tgl-rt1308.tplg",
+		.sof_tplg_filename = "sof-tgl-rt711-rt1308.tplg",
 	},
 	{
 		.id = "10EC5682",
@@ -33,5 +67,18 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_machines[] = {
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_tgl_machines);
 
+/* this table is used when there is no I2S codec present */
+struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_sdw_machines[] = {
+	{
+		.link_mask = 0x3, /* rt711 on link 0 and 2 rt1308s on link 1 */
+		.links = tgl_rvp,
+		.drv_name = "sdw_rt711_rt1308_rt715",
+		.sof_fw_filename = "sof-tgl.ri",
+		.sof_tplg_filename = "sof-tgl-rt711-rt1308.tplg",
+	},
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_tgl_sdw_machines);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel Common ACPI Match module");
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
