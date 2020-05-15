Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9A6C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 14:05:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464D020657
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fFxZZbVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464D020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1E6C1607;
	Fri, 15 May 2020 16:04:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1E6C1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589551523;
	bh=qp+HH6EIDLWyCxGKhKVf8xs9sk6YprAYb1+qYq4c8yU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fFxZZbVgip2lQjyZDLW7YF92SDDtnydxHm5fckusjymZJyTdernkvK/X85CmsetS+
	 0SUuF4oMPG6q74C5c/bas884x/yL1ZnCvu5S4a0byvurykFZOQOEVEukZlIOWNgqjY
	 WmFIpNeiT+hrcURX/QSZ+5KOGKBXXP3g9Wm4MJ0g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E70FF802DD;
	Fri, 15 May 2020 16:00:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41763F802A8; Fri, 15 May 2020 16:00:54 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FD48F8028E
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 16:00:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FD48F8028E
IronPort-SDR: jfdLmFQep+rTmP6NS5C4kMy+hCwksrNi7vgLBTLdxQQFhk+9NuZFUr7nL3DnXr1CMYZoR86Shd
 57ZAfk9jik4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 07:00:43 -0700
IronPort-SDR: aBVbqTVtdPye2SbkdBTbkP0WPBLsXrrNpcWGlfTcvdegrqR4rmInFWw1s3N9uZpHSO/FBvE6Yn
 Dmn+JAY5IoMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; d="scan'208";a="266611138"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga006.jf.intel.com with ESMTP; 15 May 2020 07:00:42 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 6/8] ASoC: SOF: define INFO_ flags in dsp_ops
Date: Fri, 15 May 2020 16:59:56 +0300
Message-Id: <20200515135958.17511-7-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200515135958.17511-1-kai.vehmanen@linux.intel.com>
References: <20200515135958.17511-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com
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

From: Daniel Baluta <daniel.baluta@nxp.com>

In the past, the INFO_ flags such as PAUSE/NO_PERIOD_WAKEUP were
defined in the SOF PCM core, but that was changed since
commit 27e322fabd508b ("ASoC: SOF: define INFO_ flags in dsp_ops")

Now these flags must be set in DSP ops.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/imx/imx8m.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 3ac0444dca93..f83581041cf3 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -273,6 +273,12 @@ struct snd_sof_dsp_ops sof_imx8m_ops = {
 	/* DAI drivers */
 	.drv = imx8m_dai,
 	.num_drv = 1, /* we have only 1 SAI interface on i.MX8M */
+
+	.hw_info = SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
 };
 EXPORT_SYMBOL(sof_imx8m_ops);
 
-- 
2.26.0

