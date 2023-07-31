Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726D1C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:35:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6632A850;
	Mon, 31 Jul 2023 23:34:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6632A850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690839303;
	bh=FDZRZkJ3kkPD7nBK9NTcqGaUTO2jLnOwv91xpzD6rTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Fl+DIOw23UH04UOg1qrEM783Bd6PB1WuPwyuX5e77Wzv8hd5R4ksSt8+ogHLDxXeR
	 lRHk8PnVDwnSrjXRKsh29xuMP2OSriyBoIPleijglcwtsxmeIZrZ1U03Yny3gAn8Eu
	 jQ+SPXdyvJWWrxdaIrwKKJ/5z4dfEmOzO7vA8Tzw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 171E7F8055C; Mon, 31 Jul 2023 23:33:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B689F80578;
	Mon, 31 Jul 2023 23:33:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09A98F80520; Mon, 31 Jul 2023 23:33:14 +0200 (CEST)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F204BF801D5
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:33:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F204BF801D5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cMQkZ6MM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839189; x=1722375189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FDZRZkJ3kkPD7nBK9NTcqGaUTO2jLnOwv91xpzD6rTU=;
  b=cMQkZ6MMzjpTnuYtWHGHBCa5lyqnEahSNFSQLKmip1oOwwfMrBaiwZm/
   /exn5xzKzeutyQNoJi4cwFBR6U96eq3dKvTg+V46nfzl2OCv/rTWiONTa
   tFh1u4YcGFXQwcqzAIrouoeUT3CceBQNEIUBOYLJsoPCVeY+Tzo42pNQG
   a1VcjjuseBpo+wRK57T1bUMGhb+zqCoVTLeH0t/VtlYON1V1BpgctXcp3
   4hQe5u35ZtsXLjlxEE1RGul5Vq+KvwmtgC9X5oJdQ1ywG0rQrvunKsX80
   6oUWOzdAUGpaSm0l+YXLZgJ4IVeMHUnwTbwL5o61B0WxRtx9VfXPPE38e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435447525"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="435447525"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="731708908"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="731708908"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:33:05 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Trevor Wu <trevor.wu@mediatek.com>,
	Yaochun Hung <yc.hung@mediatek.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/6] ASoC: SOF: ipc3: update dai_link_fixup for
 SOF_DAI_MEDIATEK_AFE
Date: Mon, 31 Jul 2023 16:32:40 -0500
Message-Id: <20230731213242.434594-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731213242.434594-1-pierre-louis.bossart@linux.intel.com>
References: <20230731213242.434594-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XOSVFADHZMC2JJOJDNJS7OAJ5VNKWDGC
X-Message-ID-Hash: XOSVFADHZMC2JJOJDNJS7OAJ5VNKWDGC
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XOSVFADHZMC2JJOJDNJS7OAJ5VNKWDGC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Trevor Wu <trevor.wu@mediatek.com>

For MediaTek AFE, DAI DMA can support different bitwidths compared to
the BE DAI. Therefore, it is preferable to obtain the BE frame format
from the DAI_CONFIG.

Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc3-pcm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/sof/ipc3-pcm.c b/sound/soc/sof/ipc3-pcm.c
index 304faf6425ab..cb58ee8c158a 100644
--- a/sound/soc/sof/ipc3-pcm.c
+++ b/sound/soc/sof/ipc3-pcm.c
@@ -309,6 +309,23 @@ static int sof_ipc3_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 		channels->min = private->dai_config->afe.channels;
 		channels->max = private->dai_config->afe.channels;
 
+		snd_mask_none(fmt);
+
+		switch (private->dai_config->afe.format) {
+		case SOF_IPC_FRAME_S16_LE:
+			snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
+			break;
+		case SOF_IPC_FRAME_S24_4LE:
+			snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
+			break;
+		case SOF_IPC_FRAME_S32_LE:
+			snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S32_LE);
+			break;
+		default:
+			dev_err(component->dev, "Not available format!\n");
+			return -EINVAL;
+		}
+
 		dev_dbg(component->dev, "rate_min: %d rate_max: %d\n", rate->min, rate->max);
 		dev_dbg(component->dev, "channels_min: %d channels_max: %d\n",
 			channels->min, channels->max);
-- 
2.39.2

