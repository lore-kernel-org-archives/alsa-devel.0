Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B43C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 07:59:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6663060ED5
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 07:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6663060ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 077A91681;
	Wed, 18 Aug 2021 09:58:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 077A91681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629273589;
	bh=dn29flncw23v5S1lvEnH2rHeW+198k4gg8gos2dwDVE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n69LR6rc0NOGDGsnD1SSD48exfeZOCuNTY0sVcdImomOvAWjmdaXTvtozUZKNbXU2
	 R6yDz9C0NfbBYM/nfrrd4HLs4Ln3x92TfIOjgOaoP18m5dJ/dtCaIiQ8hx8K3hb5sD
	 8T6iSy00Ay68cWUQH9Xiy49fLPSRDSbM4bNBlNz8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EB25F804E1;
	Wed, 18 Aug 2021 09:56:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3431EF8052E; Wed, 18 Aug 2021 09:56:10 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33CE0F80425
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 09:55:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33CE0F80425
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="195855514"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="195855514"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 00:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="676974798"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2021 00:55:05 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/11] ASoC: Intel: Skylake: Fix module resource and format
 selection
Date: Wed, 18 Aug 2021 09:57:35 +0200
Message-Id: <20210818075742.1515155-5-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818075742.1515155-1-cezary.rojewski@intel.com>
References: <20210818075742.1515155-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, jairaj.arava@intel.com,
 upstream@semihalf.com, harshapriya.n@intel.com, cujomalainey@google.com,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
 broonie@kernel.org, jenny.tc@intel.com, lma@semihalf.com,
 vamshi.krishna.gopal@intel.com
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

Module configuration may differ between its instances depending on
resources required and input and output audio format. Available
parameters to select from are stored in module resource and interface
(format) lists. These come from topology, together with description of
each of pipe's modules.

Ignoring index value provided by topology and relying always on 0th
entry leads to unexpected module behavior due to under/overbudged
resources assigned or impropper format selection. Fix by taking entry at
index specified by topology.

Fixes: f6fa56e22559 ("ASoC: Intel: Skylake: Parse and update module config structure")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 054c080b7289..a35ee9d47d6d 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -113,7 +113,7 @@ static int is_skl_dsp_widget_type(struct snd_soc_dapm_widget *w,
 
 static void skl_dump_mconfig(struct skl_dev *skl, struct skl_module_cfg *mcfg)
 {
-	struct skl_module_iface *iface = &mcfg->module->formats[0];
+	struct skl_module_iface *iface = &mcfg->module->formats[mcfg->fmt_idx];
 
 	dev_dbg(skl->dev, "Dumping config\n");
 	dev_dbg(skl->dev, "Input Format:\n");
@@ -195,8 +195,8 @@ static void skl_tplg_update_params_fixup(struct skl_module_cfg *m_cfg,
 	struct skl_module_fmt *in_fmt, *out_fmt;
 
 	/* Fixups will be applied to pin 0 only */
-	in_fmt = &m_cfg->module->formats[0].inputs[0].fmt;
-	out_fmt = &m_cfg->module->formats[0].outputs[0].fmt;
+	in_fmt = &m_cfg->module->formats[m_cfg->fmt_idx].inputs[0].fmt;
+	out_fmt = &m_cfg->module->formats[m_cfg->fmt_idx].outputs[0].fmt;
 
 	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (is_fe) {
@@ -239,9 +239,9 @@ static void skl_tplg_update_buffer_size(struct skl_dev *skl,
 	/* Since fixups is applied to pin 0 only, ibs, obs needs
 	 * change for pin 0 only
 	 */
-	res = &mcfg->module->resources[0];
-	in_fmt = &mcfg->module->formats[0].inputs[0].fmt;
-	out_fmt = &mcfg->module->formats[0].outputs[0].fmt;
+	res = &mcfg->module->resources[mcfg->res_idx];
+	in_fmt = &mcfg->module->formats[mcfg->fmt_idx].inputs[0].fmt;
+	out_fmt = &mcfg->module->formats[mcfg->fmt_idx].outputs[0].fmt;
 
 	if (mcfg->m_type == SKL_MODULE_TYPE_SRCINT)
 		multiplier = 5;
@@ -1631,11 +1631,12 @@ int skl_tplg_update_pipe_params(struct device *dev,
 			struct skl_module_cfg *mconfig,
 			struct skl_pipe_params *params)
 {
-	struct skl_module_res *res = &mconfig->module->resources[0];
+	struct skl_module_res *res;
 	struct skl_dev *skl = get_skl_ctx(dev);
 	struct skl_module_fmt *format = NULL;
 	u8 cfg_idx = mconfig->pipe->cur_config_idx;
 
+	res = &mconfig->module->resources[mconfig->res_idx];
 	skl_tplg_fill_dma_id(mconfig, params);
 	mconfig->fmt_idx = mconfig->mod_cfg[cfg_idx].fmt_idx;
 	mconfig->res_idx = mconfig->mod_cfg[cfg_idx].res_idx;
@@ -1644,9 +1645,9 @@ int skl_tplg_update_pipe_params(struct device *dev,
 		return 0;
 
 	if (params->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		format = &mconfig->module->formats[0].inputs[0].fmt;
+		format = &mconfig->module->formats[mconfig->fmt_idx].inputs[0].fmt;
 	else
-		format = &mconfig->module->formats[0].outputs[0].fmt;
+		format = &mconfig->module->formats[mconfig->fmt_idx].outputs[0].fmt;
 
 	/* set the hw_params */
 	format->s_freq = params->s_freq;
-- 
2.25.1

