Return-Path: <SRS0=Gs4n=N5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDB7C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 18:48:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13A461100
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 18:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C13A461100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5298F171F;
	Tue,  7 Sep 2021 20:47:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5298F171F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631040481;
	bh=hKmWbHvzuiMu1DAz+5jZTHxJrLLwEnBNddVa8N4DZqU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FjEAh08PhBo3dWABVORrzO7BYznoCX/K3SUCS7GE9QVdaPKu79Ka77va//VKde+Kh
	 5u0AV9sCT98oD1TIsaCxX8xri4VR3EvOwz7SQwFwT5PC7s4WcAqBfxmPkCdHHhWKY5
	 +lpsvAebsCBkNQAD7jeqcAIRjjh2bbgXYtglKn0c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E40A6F80253;
	Tue,  7 Sep 2021 20:47:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45D75F802DF; Tue,  7 Sep 2021 20:47:10 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7FC6CF80217
 for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2021 20:47:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7FC6CF80217
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="220314450"
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; d="scan'208";a="220314450"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2021 11:47:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; d="scan'208";a="503192381"
Received: from fdiasmor-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.186.104])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2021 11:46:59 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: core: allow module parameter to override dma trace
 Kconfig
Date: Tue,  7 Sep 2021 13:46:47 -0500
Message-Id: <20210907184648.33306-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org
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

Most distributions do not enable the SOF developer options and
specifically the DMA trace. This is problematic for end-user/community
support since the sof-logger tool cannot extract valuable information.

Conversely in rare cases the DMA trace can lead to Heisenbugs by
creating more traffic to system memory and more interrupts.

This patch changes the logic so that the Kconfig value is used as a
default value for a module parameter, but this value can be changed as
needed. Users can override the distro DMA trace selection.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 3e4dd4a86363..6be4f159ee35 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -19,7 +19,7 @@
 #endif
 
 /* see SOF_DBG_ flags */
-int sof_core_debug;
+int sof_core_debug =  IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_FIRMWARE_TRACE);
 module_param_named(sof_debug, sof_core_debug, int, 0444);
 MODULE_PARM_DESC(sof_debug, "SOF core debug options (0x0 all off)");
 
@@ -202,8 +202,7 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 		goto fw_run_err;
 	}
 
-	if (IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_FIRMWARE_TRACE) ||
-	    (sof_core_debug & SOF_DBG_ENABLE_TRACE)) {
+	if (sof_core_debug & SOF_DBG_ENABLE_TRACE) {
 		sdev->dtrace_is_supported = true;
 
 		/* init DMA trace */
-- 
2.25.1

