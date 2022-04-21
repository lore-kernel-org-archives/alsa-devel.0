Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECC2C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 08:09:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F335182F;
	Thu, 21 Apr 2022 10:08:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F335182F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650528574;
	bh=0Qy1E+ckCSZTxOd5dKAf8jeEiZcLs0dinlys6LuTM7c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FtSAalG/VBPE933Vr9floA5ed7Ni5CxeSZZvGpmiCQ7dsPA92ZUsgOpJLi2lm9Pe8
	 migrROiWg+bfc81z55CfovOPUAXeU4VAARzsiYPu+t8zzii3/d4X1E3CI92GL8yQ58
	 /kS1p1XI+tyu75XfhX7t2XpPkOxzzQlhgO2IoXlE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91F70F8052D;
	Thu, 21 Apr 2022 10:07:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B14F0F80526; Thu, 21 Apr 2022 10:07:32 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C15CF80279
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 10:07:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C15CF80279
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Md+XQA69"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650528447; x=1682064447;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0Qy1E+ckCSZTxOd5dKAf8jeEiZcLs0dinlys6LuTM7c=;
 b=Md+XQA69ZkCa+FWoSPmQ7YcyLnztBLiDo/tS8tjYyN6duotwCwdSLTSV
 kwwVn/lvt2MuG5K4zwQ0Gnwx2wQHwDCzO/F3UFrXHWf1NuvVITh/iF7HY
 FMVvVv86nWoxoEF6AoosBTaN9LAfZVkE3zbZchHbonwrUQ+9jkGHj6NCU
 ++FSrWNGNtrdkot4RMp+OIHsFpKF943tCKfy2H4Uf4uIEmAPp07nKyCHu
 vGBC9IsYhyT8Rr/iDPxRuCLoZilSsXRzOAJvDzvn34VFzByiDgxt+uFJB
 oKE8isLnozOCDc+3pSSABMe8apmL9n3uzpAXk3djFthE3lnXMM47bq8s/ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324718790"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="324718790"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 01:07:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; d="scan'208";a="577087089"
Received: from dchirca-mobl4.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.215.207])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 01:07:22 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, AjitKumar.Pandey@amd.com,
 daniel.baluta@nxp.com
Subject: [PATCH 4/6] ASoC: SOF: imx: Do not set fw_ready callback
Date: Thu, 21 Apr 2022 11:07:33 +0300
Message-Id: <20220421080735.31698-5-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220421080735.31698-1-peter.ujfalusi@linux.intel.com>
References: <20220421080735.31698-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

The fw_ready is handled internally to ipc3 and the callback no longer in
use.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Ajit Pandey <ajitkumar.pandey@amd.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/imx/imx8.c  | 2 --
 sound/soc/sof/imx/imx8m.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index d3a60c8e42cc..ba2fbed93f1d 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -504,7 +504,6 @@ static struct snd_sof_dsp_ops sof_imx8_ops = {
 
 	/* ipc */
 	.send_msg	= imx8_send_msg,
-	.fw_ready	= sof_fw_ready,
 	.get_mailbox_offset	= imx8_get_mailbox_offset,
 	.get_window_offset	= imx8_get_window_offset,
 
@@ -567,7 +566,6 @@ static struct snd_sof_dsp_ops sof_imx8x_ops = {
 
 	/* ipc */
 	.send_msg	= imx8_send_msg,
-	.fw_ready	= sof_fw_ready,
 	.get_mailbox_offset	= imx8_get_mailbox_offset,
 	.get_window_offset	= imx8_get_window_offset,
 
diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 8e9ae08dc7b0..1e95f91a7b22 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -430,7 +430,6 @@ static struct snd_sof_dsp_ops sof_imx8m_ops = {
 
 	/* ipc */
 	.send_msg	= imx8m_send_msg,
-	.fw_ready	= sof_fw_ready,
 	.get_mailbox_offset	= imx8m_get_mailbox_offset,
 	.get_window_offset	= imx8m_get_window_offset,
 
-- 
2.35.3

