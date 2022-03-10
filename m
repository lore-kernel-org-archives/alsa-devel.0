Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB73C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Mar 2022 04:29:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE14C173B;
	Thu, 10 Mar 2022 05:28:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE14C173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646886551;
	bh=0diQQ9gkswuCJ+kcMI+Tzgu6ZpIe60c5jyJoLPE9nDw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IfhaS2HGKTK0YhW/48QKDjE3R4/oTgM4RuPXxnoD5kbCFpbP8EFNoSfKwwKCJuiDx
	 6V3oixTSGvavP+GUSofryzLpsX5Y0pUyrN/WCALoNAsPWfIxDa7ERP8+Mb5RUZcETU
	 yjEvRSor65nFF/r+quNPLhX/ON6RTTV6268jANJw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BC2CF804CA;
	Thu, 10 Mar 2022 05:27:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DAA6F80517; Thu, 10 Mar 2022 05:27:48 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17CD2F800FD
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2022 05:27:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17CD2F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="hFFYf++q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646886463; x=1678422463;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0diQQ9gkswuCJ+kcMI+Tzgu6ZpIe60c5jyJoLPE9nDw=;
 b=hFFYf++qdVjSLZ7k9e9/pLELkj/48f3bVN4ksYsNbzhqyhPvXYxw8vYT
 6cbhePLzy/3q0rEl/ZimXFNj1QKV0m/qFCcN8s0laQfvgtzflEXc1GhUT
 hAbEar2WfcSy2iJRBHKrILedCryzm0Xxm81qLqQmdJFkSl9oyNTqKhyjB
 bxjOIiyGt/CeoWqges2uLfaHzMo/gG8+TlEaXXjSc0zHhDPo9TY9yohMQ
 IjN4SRSuS+0sF/XcY10lScWlbNdvgmvYRr9SYB+IMN+/T5t2DJ6SyUCOV
 rOeNztoXWeoK5Eh0e69vV2MhthgI2ClqIrcf5fhMKHiqIFtr2X3xAAe34 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318380881"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; d="scan'208";a="318380881"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 20:27:31 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; d="scan'208";a="547884667"
Received: from ttahmed-mobl2.amr.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.254.50.225])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 20:27:31 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 01/10] ASoC: SOF: sof-priv: Remove stale
 snd_sof_ipc_stream_pcm_params() declaration
Date: Wed,  9 Mar 2022 20:27:11 -0800
Message-Id: <20220310042720.976809-2-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310042720.976809-1-ranjani.sridharan@linux.intel.com>
References: <20220310042720.976809-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

The implementation for snd_sof_ipc_stream_pcm_params() does not exist,
remove it from the header file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/sof-priv.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 2e19ac619ad5..2cff62e75f1e 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -520,8 +520,6 @@ void snd_sof_ipc_free(struct snd_sof_dev *sdev);
 void snd_sof_ipc_get_reply(struct snd_sof_dev *sdev);
 void snd_sof_ipc_reply(struct snd_sof_dev *sdev, u32 msg_id);
 void snd_sof_ipc_msgs_rx(struct snd_sof_dev *sdev);
-int snd_sof_ipc_stream_pcm_params(struct snd_sof_dev *sdev,
-				  struct sof_ipc_pcm_params *params);
 int snd_sof_ipc_valid(struct snd_sof_dev *sdev);
 int sof_ipc_tx_message(struct snd_sof_ipc *ipc, u32 header,
 		       void *msg_data, size_t msg_bytes, void *reply_data,
-- 
2.25.1

