Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730CFC678D5
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Mar 2023 14:07:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20B0E1470;
	Tue,  7 Mar 2023 15:07:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20B0E1470
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678198072;
	bh=Cf0iP2dZTnj59k7896YYxCBDpqMmaLz3NZ4TgDnq6Mg=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SD+bLV004wMlIcWLDlpSA/st4U4ACGNod9vVBDJ1lXdK8W5Zm170wlGscikc4asUp
	 KYIUHMnzjT5vTfj01Icz5BVoUExZGQP7lm8gvZzspqJhxSIDOskfdL7suQNrjjNabY
	 2hMKbqwNpXJFZ1Pi65EidQa3l4iXKQWE7z9bELR0=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 87F64F80571;
	Tue,  7 Mar 2023 15:04:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45173F80431; Tue,  7 Mar 2023 15:04:36 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4DBCBF800C9
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2023 15:04:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DBCBF800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VBy/l8Uh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678197874; x=1709733874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cf0iP2dZTnj59k7896YYxCBDpqMmaLz3NZ4TgDnq6Mg=;
  b=VBy/l8UheLVzBtgqLjNsK0bQOEhjvJ41YSgLd55nXlasu6hvejhHoZQ/
   afFktcPHJirbJUi5u2kw+L6RUZ0axqMvxHru33U3RW3ImgYwd4fnd0SBp
   Jv9ACtlINXkALj+eJPuHcqG1QfQtcu04i9UPNgh0KaAzNzpTlasngXujl
   cHbFT+VOMMeU9/w0j1iLFFBwPGcKoYEmd2sc7yrTNZE09sIzBWh/iqjHA
   0XzrZXfb0Cmi+QDaqFEFOdz6FzLw/Yj2rdsC6UkyUZd7WDw/lXHlcIaiP
   OvSPEUJll2jbsvx4cJh94QomFjZ9MG0qsB9v6DFRUl+xuBn2pQflEwL8t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="316255250"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400";
   d="scan'208";a="316255250"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2023 06:04:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="786706963"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400";
   d="scan'208";a="786706963"
Received: from rganesh-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.47.75])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2023 06:04:30 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 07/14] ASoC: SOF: Intel: hda-dai: Introduce DAI widget ops
Date: Tue,  7 Mar 2023 16:04:28 +0200
Message-Id: <20230307140435.2808-8-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140435.2808-1-peter.ujfalusi@linux.intel.com>
References: <20230307140435.2808-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DQ63V6K25VXREVA5LUNXLNPNQQSAY4GK
X-Message-ID-Hash: DQ63V6K25VXREVA5LUNXLNPNQQSAY4GK
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 rander.wang@intel.com, yung-chuan.liao@linux.intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DQ63V6K25VXREVA5LUNXLNPNQQSAY4GK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Introduce a new ops structure for HDA DAI widget DMA ops and add a new
field to struct snd_sof_dai that will be used to set the ops pointer for
DAI widgets.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/hda.h | 31 +++++++++++++++++++++++++++++++
 sound/soc/sof/sof-audio.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 0679bebe4ad7..c6243827f8d0 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -928,4 +928,35 @@ extern struct sdw_intel_ops sdw_callback;
 struct sof_ipc4_fw_library;
 int hda_dsp_ipc4_load_library(struct snd_sof_dev *sdev,
 			      struct sof_ipc4_fw_library *fw_lib, bool reload);
+
+/**
+ * struct hda_dai_widget_dma_ops - DAI DMA ops optional by default unless specified otherwise
+ * @get_hext_stream: Mandatory function pointer to get the saved pointer to struct hdac_ext_stream
+ * @assign_hext_stream: Function pointer to assign a hdac_ext_stream
+ * @release_hext_stream: Function pointer to release the hdac_ext_stream
+ * @setup_hext_stream: Function pointer for hdac_ext_stream setup
+ * @reset_hext_stream: Function pointer for hdac_ext_stream reset
+ * @pre_trigger: Function pointer for DAI DMA pre-trigger actions
+ * @trigger: Function pointer for DAI DMA trigger actions
+ * @post_trigger: Function pointer for DAI DMA post-trigger actions
+ */
+struct hda_dai_widget_dma_ops {
+	struct hdac_ext_stream *(*get_hext_stream)(struct snd_sof_dev *sdev,
+						   struct snd_soc_dai *cpu_dai,
+						   struct snd_pcm_substream *substream);
+	struct hdac_ext_stream *(*assign_hext_stream)(struct snd_sof_dev *sdev,
+						      struct snd_soc_dai *cpu_dai,
+						      struct snd_pcm_substream *substream);
+	void (*release_hext_stream)(struct snd_sof_dev *sdev, struct snd_soc_dai *cpu_dai,
+				    struct snd_pcm_substream *substream);
+	void (*setup_hext_stream)(struct snd_sof_dev *sdev, struct hdac_ext_stream *hext_stream,
+				  unsigned int format_val);
+	void (*reset_hext_stream)(struct snd_sof_dev *sdev, struct hdac_ext_stream *hext_sream);
+	int (*pre_trigger)(struct snd_sof_dev *sdev, struct snd_soc_dai *cpu_dai,
+			   struct snd_pcm_substream *substream, int cmd);
+	int (*trigger)(struct snd_sof_dev *sdev, struct snd_soc_dai *cpu_dai,
+		       struct snd_pcm_substream *substream, int cmd);
+	int (*post_trigger)(struct snd_sof_dev *sdev, struct snd_soc_dai *cpu_dai,
+			    struct snd_pcm_substream *substream, int cmd);
+};
 #endif
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index e0579af9d281..239b82f37976 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -502,6 +502,8 @@ struct snd_sof_dai {
 	int number_configs;
 	int current_config;
 	struct list_head list;	/* list in sdev dai list */
+	/* core should not touch this */
+	const void *platform_private;
 	void *private;
 };
 
-- 
2.39.2

