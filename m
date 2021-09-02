Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD30C432BE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 11:48:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B6C610CD
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 11:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46B6C610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 145A8179D;
	Thu,  2 Sep 2021 13:47:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 145A8179D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630583315;
	bh=I9QhhUmMlaH83RcNScF4Ip23Ai+LmVaXbzktsJKkkTU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OBfjWZJGr/2wGrsbCjKUI5zpCIOujPt7OQIgWFzoyFmSCzBvxSfjTxd67fU0jaYfn
	 +iAz2/BjVB9j70w5blrRFVUS80Iyn+0C6Jh0ORHq/0k4cmECpXcNHf+Y6IWga759Ee
	 l0Ht+uqM6fnfaNls4dZfq0cHJFtf9QH9jMUfej2k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AEB1F8025B;
	Thu,  2 Sep 2021 13:47:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24349F80269; Thu,  2 Sep 2021 13:47:43 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2DCD2F8020D
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 13:47:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DCD2F8020D
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="217226433"
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; d="scan'208";a="217226433"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2021 04:47:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; d="scan'208";a="533049982"
Received: from leeyapha-desk2.amr.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.212.83])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2021 04:47:27 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	rander.wang@intel.com
Subject: [PATCH] ASoC: SOF: control: fix a typo in put operations for kcontrol
Date: Thu,  2 Sep 2021 14:47:44 +0300
Message-Id: <20210902114744.27237-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
 pierre-louis.bossart@linux.intel.com
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

From: Rander Wang <rander.wang@intel.com>

SOF_CTRL_TYPE_VALUE_CHAN_SET should be used for put operations
for consistency. The current use of _GET is obviously incorrect
but _GET and _SET result in the same action so there is no
functional change introduced by this patch.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/control.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index 456f3cd36678..58bb89af4de1 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -144,7 +144,7 @@ int snd_sof_volume_put(struct snd_kcontrol *kcontrol,
 	if (pm_runtime_active(scomp->dev))
 		snd_sof_ipc_set_get_comp_data(scontrol,
 					      SOF_IPC_COMP_SET_VALUE,
-					      SOF_CTRL_TYPE_VALUE_CHAN_GET,
+					      SOF_CTRL_TYPE_VALUE_CHAN_SET,
 					      SOF_CTRL_CMD_VOLUME,
 					      true);
 	return change;
@@ -217,7 +217,7 @@ int snd_sof_switch_put(struct snd_kcontrol *kcontrol,
 	if (pm_runtime_active(scomp->dev))
 		snd_sof_ipc_set_get_comp_data(scontrol,
 					      SOF_IPC_COMP_SET_VALUE,
-					      SOF_CTRL_TYPE_VALUE_CHAN_GET,
+					      SOF_CTRL_TYPE_VALUE_CHAN_SET,
 					      SOF_CTRL_CMD_SWITCH,
 					      true);
 
@@ -266,7 +266,7 @@ int snd_sof_enum_put(struct snd_kcontrol *kcontrol,
 	if (pm_runtime_active(scomp->dev))
 		snd_sof_ipc_set_get_comp_data(scontrol,
 					      SOF_IPC_COMP_SET_VALUE,
-					      SOF_CTRL_TYPE_VALUE_CHAN_GET,
+					      SOF_CTRL_TYPE_VALUE_CHAN_SET,
 					      SOF_CTRL_CMD_ENUM,
 					      true);
 
-- 
2.33.0

