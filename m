Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAABEC433E7
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:25:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6276F20767
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nxvcBdmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6276F20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4ADF61871;
	Wed,  2 Sep 2020 23:24:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4ADF61871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599081898;
	bh=BjeRGKB/Sf+aXhCr+ESND5WIYvh26RIZYG+0W7yMLgc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nxvcBdmIXtwQ0rfHB+tQe8fpr47h0mxxyqWxEiRP4myk6BcmhFVm6eJovTBeKVD0M
	 mVJajQpignU2jPr5jPAHZ2t668U6Y1ed43G0/4PCFR/E5OBFkacKFF+JBHizuJ/lOZ
	 VUSIlL+qsLcwGhnk+UjmtIEO/acqKAlgIaHgkaH4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C6E4F802EB;
	Wed,  2 Sep 2020 23:22:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2787CF802EA; Wed,  2 Sep 2020 23:22:22 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CCABF801DA
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 23:22:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CCABF801DA
IronPort-SDR: N1czUyei10ellIKTqH5l1fxnqiIk5Jv2XNa6vn6UDUEptdvmOVbJ/66QXXVc+Rq3D2xMeABXYA
 xbVD6PtKDJwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="157482850"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="157482850"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:21:59 -0700
IronPort-SDR: zF/GSz5YIFTtSOSRBGvP+Yluavb7BNSi+Y6QDIo1z1f2itA2kpKPbvAHVQ+8pIV2okKB98c/qa
 eWYPMcLX/wzw==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="477798266"
Received: from rnagarat-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.56.27])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:21:58 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 02/18] ALSA: core: memalloc: fix fallthrough position
Date: Wed,  2 Sep 2020 16:21:17 -0500
Message-Id: <20200902212133.30964-3-pierre-louis.bossart@linux.intel.com>
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

Fix cppcheck, the fallthrough only makes sense within the conditional
block

sound/core/memalloc.c:161:3: style:inconclusive: Statements following
return, break, continue, goto or throw will never be
executed. [unreachableCode]
  fallthrough;
  ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/memalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index ad74ea9cbff5..0aeeb6244ff6 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -157,8 +157,8 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 		 * so if we fail to malloc, try to fetch memory traditionally.
 		 */
 		dmab->dev.type = SNDRV_DMA_TYPE_DEV;
-#endif /* CONFIG_GENERIC_ALLOCATOR */
 		fallthrough;
+#endif /* CONFIG_GENERIC_ALLOCATOR */
 	case SNDRV_DMA_TYPE_DEV:
 	case SNDRV_DMA_TYPE_DEV_UC:
 		snd_malloc_dev_pages(dmab, size);
-- 
2.25.1

