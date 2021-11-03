Return-Path: <SRS0=wMeK=PW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4A6C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Nov 2021 08:28:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735B86117A
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Nov 2021 08:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 735B86117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2321167E;
	Wed,  3 Nov 2021 09:27:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2321167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635928083;
	bh=C+kzOrtyt4kl6WzOrHR/TdOJcy8tBYH2+FLAyykT8dI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L7hVDwWa/msK7e/1VfphPVCFKi+ojFrqDuPFB5J9ZD3M3yLyBxhm0S8hOW0ttk0yX
	 XMkFlZyielIUxmVrsPoZUKpkxZ9k6vi8GZTw1VlhNLVrSxm94VGzZaiFJvpl4pcia8
	 tVk0iBQ4sCyTTSB8azNMBrTqradMDP+71ojFjAYE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 629F8F80269;
	Wed,  3 Nov 2021 09:27:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10635F8026A; Wed,  3 Nov 2021 09:27:10 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF684F80224
 for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2021 09:27:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF684F80224
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="228904998"
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; d="scan'208";a="228904998"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2021 01:26:58 -0700
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; d="scan'208";a="500946362"
Received: from mdmytryc-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.213.198])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2021 01:26:56 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF:control: Fix variable type in
 snd_sof_refresh_control()
Date: Wed,  3 Nov 2021 10:27:10 +0200
Message-Id: <20211103082710.17165-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com
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

From: Peter Ujfalusi <peter.ujfalusi@gmail.com>

The second parameter for snd_sof_ipc_set_get_comp_data() is ipc_cmd, not
ipc_ctrl_type and the type is u32.

Fixes: 756bbe4205bc6 ("ASoC: SOF: Handle control change notification from firmware")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 sound/soc/sof/control.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index 58bb89af4de1..bb1dfe4f6d40 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -69,7 +69,7 @@ static void snd_sof_refresh_control(struct snd_sof_control *scontrol)
 {
 	struct sof_ipc_ctrl_data *cdata = scontrol->control_data;
 	struct snd_soc_component *scomp = scontrol->scomp;
-	enum sof_ipc_ctrl_type ctrl_type;
+	u32 ipc_cmd;
 	int ret;
 
 	if (!scontrol->comp_data_dirty)
@@ -79,9 +79,9 @@ static void snd_sof_refresh_control(struct snd_sof_control *scontrol)
 		return;
 
 	if (scontrol->cmd == SOF_CTRL_CMD_BINARY)
-		ctrl_type = SOF_IPC_COMP_GET_DATA;
+		ipc_cmd = SOF_IPC_COMP_GET_DATA;
 	else
-		ctrl_type = SOF_IPC_COMP_GET_VALUE;
+		ipc_cmd = SOF_IPC_COMP_GET_VALUE;
 
 	/* set the ABI header values */
 	cdata->data->magic = SOF_ABI_MAGIC;
@@ -89,7 +89,7 @@ static void snd_sof_refresh_control(struct snd_sof_control *scontrol)
 
 	/* refresh the component data from DSP */
 	scontrol->comp_data_dirty = false;
-	ret = snd_sof_ipc_set_get_comp_data(scontrol, ctrl_type,
+	ret = snd_sof_ipc_set_get_comp_data(scontrol, ipc_cmd,
 					    SOF_CTRL_TYPE_VALUE_CHAN_GET,
 					    scontrol->cmd, false);
 	if (ret < 0) {
-- 
2.33.1

