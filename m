Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9857AC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 17:19:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC5DB18D9;
	Tue, 26 Apr 2022 19:18:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC5DB18D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650993545;
	bh=Q3kg/pshuWm+fFLsjsLqMIwXblyvNF9ILM8djl27JpM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T6YnzQfzumzEVs2dlKTFBe7+mckSG9p6E8xtw0U/ZK5504TFLsoRdshbXVuGoxXKm
	 dCYiAJLrNJo/CddqMV/HA91+jIOXq8N5klJ5qQdvfRftsBwN5K2BSwtMFDb/qEMTqE
	 lLYWnX2Szqv2XWY+Rq9k0HIsMhJ8p8viPfJXGk64=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 744DCF8055B;
	Tue, 26 Apr 2022 19:15:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE7B8F80571; Tue, 26 Apr 2022 19:15:48 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A4B6F8055B
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 19:15:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A4B6F8055B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Nf+G66Sf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650993341; x=1682529341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q3kg/pshuWm+fFLsjsLqMIwXblyvNF9ILM8djl27JpM=;
 b=Nf+G66Sfb4cvqNnVKKhsu6WRmUXu2z0npFfRSXz4TjhXXwq6F4craYg/
 NyOIFA8wH5HqbGQn2MQH1jUONPDX839WiMRu7mCIDd86/KLJB4HOVWmm7
 DtXXG0zK8PRBG0vFAQclftTQdh+z1huhcZ89SbAIFYVUKFyOMcXjokTqZ
 sRG7GYPNoLaFi7obMrjRNgCYpRpCIord9dvhWozGeVVf0FWD436x4fJvg
 x3dYTN00vX/e8xYHNK8h7uLUIGwCdDlMLxXL1U+PbLwAnmtGU+JvSXKja
 LV5nO2GaUSlSVN/AN9jlCtguYOL5HKHHNRviF8Y+5OwoDDyd1kTpk7D7N w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="264508104"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; d="scan'208";a="264508104"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 10:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; d="scan'208";a="650305692"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by FMSMGA003.fm.intel.com with ESMTP; 26 Apr 2022 10:15:19 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 12/14] ASoC: Intel: avs: Power management
Date: Tue, 26 Apr 2022 19:23:44 +0200
Message-Id: <20220426172346.3508411-13-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426172346.3508411-1-cezary.rojewski@intel.com>
References: <20220426172346.3508411-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, upstream@semihalf.com,
 harshapriya.n@intel.com, rad@semihalf.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 lma@semihalf.com
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

To preserve power during sleep operations, handle suspend (S3),
hibernation (S4) and runtime (RTD3) transitions. As flow for all of
is shared, define common handlers to reduce code size.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/avs/core.c | 125 +++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index 93180c22032d..c2f8fb87cfc2 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -536,6 +536,128 @@ static void avs_pci_remove(struct pci_dev *pci)
 	pm_runtime_get_noresume(&pci->dev);
 }
 
+static int __maybe_unused avs_suspend_common(struct avs_dev *adev, bool low_power)
+{
+	struct hdac_bus *bus = &adev->base.core;
+	int ret;
+
+	flush_work(&adev->probe_work);
+
+	snd_hdac_ext_bus_link_power_down_all(bus);
+
+	ret = avs_ipc_set_dx(adev, AVS_MAIN_CORE_MASK, false);
+	/*
+	 * pm_runtime is blocked on DSP failure but system-wide suspend is not.
+	 * Do not block entire system from suspending if that's the case.
+	 */
+	if (ret && ret != -EPERM) {
+		dev_err(adev->dev, "set dx failed: %d\n", ret);
+		return AVS_IPC_RET(ret);
+	}
+
+	avs_dsp_op(adev, int_control, false);
+	snd_hdac_ext_bus_ppcap_int_enable(bus, false);
+
+	ret = avs_dsp_core_disable(adev, AVS_MAIN_CORE_MASK);
+	if (ret < 0) {
+		dev_err(adev->dev, "core_mask %ld disable failed: %d\n", AVS_MAIN_CORE_MASK, ret);
+		return ret;
+	}
+
+	snd_hdac_ext_bus_ppcap_enable(bus, false);
+	/* disable LP SRAM retention */
+	avs_hda_power_gating_enable(adev, false);
+	snd_hdac_bus_stop_chip(bus);
+	/* disable CG when putting controller to reset */
+	avs_hdac_clock_gating_enable(bus, false);
+	snd_hdac_bus_enter_link_reset(bus);
+	avs_hdac_clock_gating_enable(bus, true);
+
+	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
+
+	return 0;
+}
+
+static int __maybe_unused avs_resume_common(struct avs_dev *adev, bool low_power, bool purge)
+{
+	struct hdac_bus *bus = &adev->base.core;
+	struct hdac_ext_link *hlink;
+	int ret;
+
+	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
+	avs_hdac_bus_init_chip(bus, true);
+
+	snd_hdac_ext_bus_ppcap_enable(bus, true);
+	snd_hdac_ext_bus_ppcap_int_enable(bus, true);
+
+	ret = avs_dsp_boot_firmware(adev, purge);
+	if (ret < 0) {
+		dev_err(adev->dev, "firmware boot failed: %d\n", ret);
+		return ret;
+	}
+
+	/* turn off the links that were off before suspend */
+	list_for_each_entry(hlink, &bus->hlink_list, list) {
+		if (!hlink->ref_count)
+			snd_hdac_ext_bus_link_power_down(hlink);
+	}
+
+	/* check dma status and clean up CORB/RIRB buffers */
+	if (!bus->cmd_dma_state)
+		snd_hdac_bus_stop_cmd_io(bus);
+
+	return 0;
+}
+
+static int __maybe_unused avs_suspend(struct device *dev)
+{
+	return avs_suspend_common(to_avs_dev(dev), true);
+}
+
+static int __maybe_unused avs_resume(struct device *dev)
+{
+	return avs_resume_common(to_avs_dev(dev), true, true);
+}
+
+static int __maybe_unused avs_runtime_suspend(struct device *dev)
+{
+	return avs_suspend_common(to_avs_dev(dev), true);
+}
+
+static int __maybe_unused avs_runtime_resume(struct device *dev)
+{
+	return avs_resume_common(to_avs_dev(dev), true, false);
+}
+
+static int __maybe_unused avs_freeze(struct device *dev)
+{
+	return avs_suspend_common(to_avs_dev(dev), false);
+}
+static int __maybe_unused avs_thaw(struct device *dev)
+{
+	return avs_resume_common(to_avs_dev(dev), false, true);
+}
+
+static int __maybe_unused avs_poweroff(struct device *dev)
+{
+	return avs_suspend_common(to_avs_dev(dev), false);
+}
+
+static int __maybe_unused avs_restore(struct device *dev)
+{
+	return avs_resume_common(to_avs_dev(dev), false, true);
+}
+
+static const struct dev_pm_ops avs_dev_pm = {
+	.suspend = avs_suspend,
+	.resume = avs_resume,
+	.freeze = avs_freeze,
+	.thaw = avs_thaw,
+	.poweroff = avs_poweroff,
+	.restore = avs_restore,
+	SET_RUNTIME_PM_OPS(avs_runtime_suspend, avs_runtime_resume, NULL)
+};
+
 static const struct pci_device_id avs_ids[] = {
 	{ 0 }
 };
@@ -546,6 +668,9 @@ static struct pci_driver avs_pci_driver = {
 	.id_table = avs_ids,
 	.probe = avs_pci_probe,
 	.remove = avs_pci_remove,
+	.driver = {
+		.pm = &avs_dev_pm,
+	},
 };
 module_pci_driver(avs_pci_driver);
 
-- 
2.25.1

