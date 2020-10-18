Return-Path: <SRS0=oKMh=DZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1873BC433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 19:22:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B802225F
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 19:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NN8hVVOx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYj/CkR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B802225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C20F1728;
	Sun, 18 Oct 2020 21:21:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C20F1728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603048951;
	bh=P53ED4BShvDlilS5vert2xbkgwQD01dU3Jv7kDeWyIM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NN8hVVOxN4OulhUzAXch+ouv0xvTAF/CUQ5uUHIMPk6BKmGfohJfvu8SIwViDr9GN
	 lC7uzz+2MLzD5waJzUSIy/rb2frSP1aNzXadkohaQ7zLKfbSHgvbMsbi0ub47wEL3U
	 0TPA9jKMqoMc2PS3Vw9OS8AF0TNemDNTFhpY5iVE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D8DEF801F2;
	Sun, 18 Oct 2020 21:20:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D533F80289; Sun, 18 Oct 2020 21:20:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44DB9F801F2
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2020 21:20:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44DB9F801F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BYj/CkR8"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 72895222EA;
 Sun, 18 Oct 2020 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603048806;
 bh=P53ED4BShvDlilS5vert2xbkgwQD01dU3Jv7kDeWyIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BYj/CkR8SFq+CotAr0s5NXxJUL8ckcnH86RQMlc9MW9XItCGn7WFWEawOModknS7K
 Uz12cxGEC8Tz7XniWYCsL0bBtW/udEM7kQulgOCw2gdxBoYzwL9IomL1YdR2k8Zom7
 XTwthdW6RF/xdZRK+MFGA+9/nF2ZgkCpPxPlAwUM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 098/111] ASoC: SOF: Add topology filename override
 based on dmi data match
Date: Sun, 18 Oct 2020 15:17:54 -0400
Message-Id: <20201018191807.4052726-98-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018191807.4052726-1-sashal@kernel.org>
References: <20201018191807.4052726-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
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

From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

[ Upstream commit 5253a73d567dcd75e62834ff5f502ea9470e5722 ]

Add topology filename override based on system DMI data matching,
typically to account for a different hardware layout.

In ACPI based systems, the tplg_filename is pre-defined in an ACPI
machine table. When a DMI quirk is detected, the
sof_pdata->tplg_filename is not set with the hard-coded ACPI value,
and instead is set with the DMI-specific filename.

Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200821195603.215535-14-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda.c   |  8 +++++++-
 sound/soc/sof/sof-pci-dev.c | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 63ca920c8e6e0..7152e6d1cf673 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1179,7 +1179,13 @@ void hda_machine_select(struct snd_sof_dev *sdev)
 
 	mach = snd_soc_acpi_find_machine(desc->machines);
 	if (mach) {
-		sof_pdata->tplg_filename = mach->sof_tplg_filename;
+		/*
+		 * If tplg file name is overridden, use it instead of
+		 * the one set in mach table
+		 */
+		if (!sof_pdata->tplg_filename)
+			sof_pdata->tplg_filename = mach->sof_tplg_filename;
+
 		sof_pdata->machine = mach;
 
 		if (mach->link_mask) {
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index aa3532ba14349..f3a8140773db5 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -35,8 +35,28 @@ static int sof_pci_debug;
 module_param_named(sof_pci_debug, sof_pci_debug, int, 0444);
 MODULE_PARM_DESC(sof_pci_debug, "SOF PCI debug options (0x0 all off)");
 
+static const char *sof_override_tplg_name;
+
 #define SOF_PCI_DISABLE_PM_RUNTIME BIT(0)
 
+static int sof_tplg_cb(const struct dmi_system_id *id)
+{
+	sof_override_tplg_name = id->driver_data;
+	return 1;
+}
+
+static const struct dmi_system_id sof_tplg_table[] = {
+	{
+		.callback = sof_tplg_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Volteer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Terrador"),
+		},
+		.driver_data = "sof-tgl-rt5682-ssp0-max98373-ssp2.tplg",
+	},
+	{}
+};
+
 static const struct dmi_system_id community_key_platforms[] = {
 	{
 		.ident = "Up Squared",
@@ -347,6 +367,10 @@ static int sof_pci_probe(struct pci_dev *pci,
 		sof_pdata->tplg_filename_prefix =
 			sof_pdata->desc->default_tplg_path;
 
+	dmi_check_system(sof_tplg_table);
+	if (sof_override_tplg_name)
+		sof_pdata->tplg_filename = sof_override_tplg_name;
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)
 	/* set callback to enable runtime_pm */
 	sof_pdata->sof_probe_complete = sof_pci_probe_complete;
-- 
2.25.1

