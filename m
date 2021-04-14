Return-Path: <SRS0=Xywd=JL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13074C433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Apr 2021 17:00:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89D061155
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Apr 2021 17:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89D061155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DB411658;
	Wed, 14 Apr 2021 18:59:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DB411658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618419637;
	bh=uO6NzYU/QQD2+zF7k3ne5kGBYsvDU8tYetCjYp5RwbA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=amQf3JNQ3+b9j2Rmyw/pj7FXIDhPFL4RWqHNBVjaC8innAX+kXa80pQZAdOu4xOO5
	 //+5Iza+aY90rAdzn7a4WlixX8oUqzHPb+9iELa4m0YPLjie4qi3qD0QGI1hne0mDY
	 AuytV0lT6MjBQLfiVx/4VQDOQuDasFygP/qu5oSs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE35AF8025B;
	Wed, 14 Apr 2021 18:59:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B503F80269; Wed, 14 Apr 2021 18:59:46 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 201A1F80128
 for <alsa-devel@alsa-project.org>; Wed, 14 Apr 2021 18:59:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 201A1F80128
IronPort-SDR: A8DZBOo9b9UMhSIaLtJyO4js7fS8zQ7HTLbccbESLmNPqWUqB6oVs4V5H56hBGvwMQXIy0cKCv
 4hMWT+EamUhA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="182188978"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; d="scan'208";a="182188978"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 09:59:32 -0700
IronPort-SDR: pf41y/obrCa+Ke63j9HhhnLN6DAR2NqQ/X2kg9gsJCkxIy6im7LG9DXwE+x0gVjk532Q6VGF1u
 Y0267uexcmQg==
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; d="scan'208";a="615358208"
Received: from kjodonn-mobl.amr.corp.intel.com (HELO rsridh-mobl1.localdomain)
 ([10.212.99.40])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 09:59:31 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: use current DAI config during resume
Date: Wed, 14 Apr 2021 09:59:26 -0700
Message-Id: <20210414165926.1875465-1-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Recently, the sof_pcm_dai_link_fixup() function was
updated to match SSP config with the PCM hw_params
and set the current_config for the DAI widget.

But the sof_restore_pipelines() function still chooses the
default config for the DAI widget upon resuming. Fix this
to use the last used config when setting up the DAI widget
during resume.

Fixes: a1e1f10a6ed6 ("ASoC: SOF: match SSP config with pcm hw params")
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/sof-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 0d0d47dc0246..510883cd9107 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -267,7 +267,7 @@ int sof_restore_pipelines(struct device *dev)
 	/* restore dai links */
 	list_for_each_entry_reverse(dai, &sdev->dai_list, list) {
 		struct sof_ipc_reply reply;
-		struct sof_ipc_dai_config *config = dai->dai_config;
+		struct sof_ipc_dai_config *config = &dai->dai_config[dai->current_config];
 
 		if (!config) {
 			dev_err(dev, "error: no config for DAI %s\n",
-- 
2.25.1

