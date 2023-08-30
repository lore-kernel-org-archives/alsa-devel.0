Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FFFC83F2E
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Aug 2023 08:27:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E98A8AE9;
	Thu, 31 Aug 2023 10:26:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E98A8AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693470461;
	bh=12hUQdDdXq5HXe98g3pHDG0C0rh0VWOV3z4d9FLqn6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=maT76bcQ5l1vvwNHyFU0VyR7yII3XZ+c//ty/6PdKSDqkV6BaAhXpgpHLoQwbOsDS
	 yPnYCBFOUziEPs0FwuvwdrBjnFJBQvI6wQta+a+hfSEsfujTAzL75WYowZg+vq/Ei7
	 xSAmqiOonV32bbQakvZiyfXAwyVDJh1YsxXtGBfA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10BFDF805EF; Thu, 31 Aug 2023 10:24:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E17DF805E9;
	Thu, 31 Aug 2023 10:24:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67B90F80558; Wed, 30 Aug 2023 17:37:16 +0200 (CEST)
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E939BF80158;
	Wed, 30 Aug 2023 17:37:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E939BF80158
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: [PATCH v4 10/11] ASoC: SOF: Intel: Move binding to display driver
 outside of deferred probe
Date: Wed, 30 Aug 2023 17:36:51 +0200
Message-Id: <20230830153652.217855-11-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com>
References: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: mlankhorst@mblankhorst.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: YEG2TJOALLRSQYYDPT7HYZON2OQ5ZBB4
X-Message-ID-Hash: YEG2TJOALLRSQYYDPT7HYZON2OQ5ZBB4
X-Mailman-Approved-At: Thu, 31 Aug 2023 08:22:59 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YEG2TJOALLRSQYYDPT7HYZON2OQ5ZBB4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Now that we can use -EPROBE_DEFER, it's no longer required to spin off
the snd_hdac_i915_init into a workqueue.

Use the -EPROBE_DEFER mechanism instead, which must be returned in the
probe function.

The previously added probe_no_wq can be used for this,
and we also use the newly added remove_no_wq for unbinding afterwards.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-common-ops.c |  1 +
 sound/soc/sof/intel/hda.c            | 15 ++++++---------
 sound/soc/sof/intel/hda.h            |  1 +
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/intel/hda-common-ops.c b/sound/soc/sof/intel/hda-common-ops.c
index 803b5e9087782..1e2e9b6a5c1c2 100644
--- a/sound/soc/sof/intel/hda-common-ops.c
+++ b/sound/soc/sof/intel/hda-common-ops.c
@@ -17,6 +17,7 @@
 struct snd_sof_dsp_ops sof_hda_common_ops = {
 	/* probe/remove/shutdown */
 	.probe_no_wq	= hda_dsp_probe_no_wq,
+	.remove_no_wq	= hda_dsp_remove_no_wq,
 	.probe		= hda_dsp_probe,
 	.remove		= hda_dsp_remove,
 
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index e918b5dadfa02..886073598e40f 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1160,6 +1160,7 @@ int hda_dsp_probe_no_wq(struct snd_sof_dev *sdev)
 		return -ENOMEM;
 	sdev->pdata->hw_pdata = hdev;
 	hdev->desc = chip;
+	ret = hda_init(sdev);
 
 err:
 	return ret;
@@ -1195,9 +1196,6 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 
 	/* set up HDA base */
 	bus = sof_to_bus(sdev);
-	ret = hda_init(sdev);
-	if (ret < 0)
-		goto hdac_bus_unmap;
 
 	if (sdev->dspless_mode_selected)
 		goto skip_dsp_setup;
@@ -1307,8 +1305,6 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 		iounmap(sdev->bar[HDA_DSP_BAR]);
 hdac_bus_unmap:
 	platform_device_unregister(hdev->dmic_dev);
-	iounmap(bus->remap_addr);
-	hda_codec_i915_exit(sdev);
 
 	return ret;
 }
@@ -1317,7 +1313,6 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	const struct sof_intel_dsp_desc *chip = hda->desc;
-	struct hdac_bus *bus = sof_to_bus(sdev);
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
 	struct nhlt_acpi_table *nhlt = hda->nhlt;
 
@@ -1368,10 +1363,12 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 	if (!sdev->dspless_mode_selected)
 		iounmap(sdev->bar[HDA_DSP_BAR]);
 
-	iounmap(bus->remap_addr);
-
-	sof_hda_bus_exit(sdev);
+	return 0;
+}
 
+int hda_dsp_remove_no_wq(struct snd_sof_dev *sdev)
+{
+	iounmap(sof_to_bus(sdev)->remap_addr);
 	hda_codec_i915_exit(sdev);
 
 	return 0;
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 89b8c239e9a5e..26ae11e4e1240 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -574,6 +574,7 @@ struct sof_intel_hda_stream {
  * DSP Core services.
  */
 int hda_dsp_probe_no_wq(struct snd_sof_dev *sdev);
+int hda_dsp_remove_no_wq(struct snd_sof_dev *sdev);
 int hda_dsp_probe(struct snd_sof_dev *sdev);
 int hda_dsp_remove(struct snd_sof_dev *sdev);
 int hda_dsp_core_power_up(struct snd_sof_dev *sdev, unsigned int core_mask);
-- 
2.39.2

