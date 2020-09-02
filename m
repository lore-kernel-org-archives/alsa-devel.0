Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715B4C43461
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:33:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F0E208C7
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FOS++/ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F0E208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B8B118BE;
	Wed,  2 Sep 2020 23:32:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B8B118BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599082400;
	bh=CqmrUMauM8rqKjaeK1Ejk026cacGMeRhQaSRa3/taok=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FOS++/haIaJ3tcY3SWL4HcVe5HDZ6/0QU1b4MT9mlS5b7MKZQ1KzGwXTy6kwLi/ds
	 o+B4ht7gxWdK9rB+xyF2uOERicsQqVi0/e4M6sbAkoQK4ueHq80qypFPhQ/cSSh48E
	 P4hJnyh4XxOIazoqMQAKup2ysWMz3cZkKgDpJU7M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7444EF8034F;
	Wed,  2 Sep 2020 23:22:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51ED4F80268; Wed,  2 Sep 2020 23:22:36 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEBE0F80268
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 23:22:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BEBE0F80268
IronPort-SDR: pP1s6Un7XVSXC4vpgoJN+Y1IRK4yTLpEQ70Iu4EVSVxWBP4tv+yFjAlcW+/Cn5y4ibZxFdQlPA
 Ly14LoOOBw+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="157482904"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="157482904"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:13 -0700
IronPort-SDR: 1IrBvyt2C9r/4xw8D04JqyY1B/SBCt8LjJReWECtMB5wFKgqBai56yJRR0hIUeCdp6yT0BabuZ
 JVzqOeu8x5fA==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="477798300"
Received: from rnagarat-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.56.27])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:12 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 18/18] ALSA: vx: vx_pcm: remove redundant assignment
Date: Wed,  2 Sep 2020 16:21:33 -0500
Message-Id: <20200902212133.30964-19-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902212133.30964-1-pierre-louis.bossart@linux.intel.com>
References: <20200902212133.30964-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
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

Fix cppcheck warning:

sound/drivers/vx/vx_pcm.c:63:7: style: Variable 'buf' is assigned a
value that is never used. [unreadVariable]
  buf = (unsigned char *)runtime->dma_area;
      ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/drivers/vx/vx_pcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index 47361e26be80..3d2e3bcafca8 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -60,7 +60,6 @@ static void vx_pcm_read_per_bytes(struct vx_core *chip, struct snd_pcm_runtime *
 	*buf++ = vx_inb(chip, RXL);
 	if (++offset >= pipe->buffer_bytes) {
 		offset = 0;
-		buf = (unsigned char *)runtime->dma_area;
 	}
 	pipe->hw_ptr = offset;
 }
-- 
2.25.1

