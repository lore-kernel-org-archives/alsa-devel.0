Return-Path: <SRS0=/b47=CC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68418C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:11:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC50C2067C
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vJgc5R+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC50C2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1698B1688;
	Mon, 24 Aug 2020 22:10:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1698B1688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598299884;
	bh=PEN7cES05W8866Kg9g8b4FRUJU9eoEmn9vQGTMbyQrU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vJgc5R+Qx5qGTvgsc6A6vjf4yIUILpT4yxJ/54bgiorRKDfCix70AVOyquF/wySSO
	 CMqnb3ViF5C4njrFlb3baLWd5cKWKu3l+Gxw+erdcC7EQblm/1eB/RV58+rntQbkSb
	 cdKQyhCUZKL3hoVra4bgbRND+BITzYhFUHc0gKuk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 386E7F801D9;
	Mon, 24 Aug 2020 22:09:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CF47F802C4; Mon, 24 Aug 2020 22:09:35 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 498B2F8016F
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 22:09:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 498B2F8016F
IronPort-SDR: SYcVfqDNF9zpMPy9JxaecdX4/I+u2BecxbdAbu/uPbyXbm9pqpmLJ5jUhlEtbnzh7dpPoM8CK2
 TVxYprTwwSUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="157033725"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; d="scan'208";a="157033725"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2020 13:09:22 -0700
IronPort-SDR: cyyT8i3AqgWc6CdqC+yniUIS4di59amVfzLIatQ/gmBk/szkheYyCIlXNBuYDGlnjO4+uAbmns
 IYku7CB0W4Ig==
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; d="scan'208";a="443351182"
Received: from dentoneb-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.223.13])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2020 13:09:21 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/8] ASoC: SOF: topology: (cosmetic) remove redundant variable
 initialisations
Date: Mon, 24 Aug 2020 15:09:05 -0500
Message-Id: <20200824200912.46852-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824200912.46852-1-pierre-louis.bossart@linux.intel.com>
References: <20200824200912.46852-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Remove two cases of redundant variable initialisation.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 13e10a0c0b05..3b4e09089643 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2083,12 +2083,12 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	struct snd_soc_dapm_widget *widget = swidget->widget;
 	struct snd_soc_tplg_private *private = &tw->priv;
-	struct sof_ipc_comp_process *process = NULL;
+	struct sof_ipc_comp_process *process;
 	struct sof_widget_data *wdata = NULL;
 	size_t ipc_data_size = 0;
 	size_t ipc_size;
 	int offset = 0;
-	int ret = 0;
+	int ret;
 	int i;
 
 	if (type == SOF_COMP_NONE) {
-- 
2.25.1

