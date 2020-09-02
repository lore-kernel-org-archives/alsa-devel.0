Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F690C433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:26:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCE120767
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PKtf+A+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCE120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13B6E189B;
	Wed,  2 Sep 2020 23:25:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13B6E189B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599081999;
	bh=i6nb6+VvlANo3l7uN/RfGvY54QieHhFbA/V669vhMYo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PKtf+A+7B0jAwWZ179Dlwcwbv6nETLmy+1rwRuvYHTY+U5pl8kVkayYwbDBO5HERd
	 ktEPkO24OAofWncCYCJMKiqBNLjRMGzGW4RZxAngvgkZWH+4OPDJfnUr3sOUB5yNtb
	 vVeSzOGmM5xzgoP4n+lFYkaWlX5fbX32YANK0VdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E15CBF80304;
	Wed,  2 Sep 2020 23:22:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BDA3BF802E9; Wed,  2 Sep 2020 23:22:23 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECE9CF802A1
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 23:22:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECE9CF802A1
IronPort-SDR: FkKqZubbhwxw3PhfOhAs4T+rIf1gl8iT8I0bfQy0pGiuxQ2P+p0Yugz93DZzpGY1emlpCOrYmo
 XuB3q16sgHAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="157482864"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="157482864"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:03 -0700
IronPort-SDR: P3epRokmuU92bMwRNgzI0qF+cjykb5zb1C14b33fa7KNmUfkr5HBauHiSEV/WBSuRex5ipF8Dg
 0krUeJ+2TAxw==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="477798275"
Received: from rnagarat-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.56.27])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:02 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 06/18] ALSA: compress_offload: dereference after checking for
 NULL pointer
Date: Wed,  2 Sep 2020 16:21:21 -0500
Message-Id: <20200902212133.30964-7-pierre-louis.bossart@linux.intel.com>
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

Fix cppcheck warning and only dereference once the initial checks are
done:

sound/core/compress_offload.c:516:38: warning: Either the condition
'!stream' is redundant or there is possible null pointer dereference:
stream. [nullPointerRedundantCheck]
 struct snd_compr_runtime *runtime = stream->runtime;
                                     ^
sound/core/compress_offload.c:518:17: note: Assuming that condition
'!stream' is not redundant
if (snd_BUG_ON(!(stream) || !(stream)->runtime))
                ^
sound/core/compress_offload.c:516:38: note: Null pointer dereference
 struct snd_compr_runtime *runtime = stream->runtime;
                                     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/compress_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 0e53f6f31916..e3eb314acb10 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -513,10 +513,11 @@ EXPORT_SYMBOL(snd_compr_malloc_pages);
 
 int snd_compr_free_pages(struct snd_compr_stream *stream)
 {
-	struct snd_compr_runtime *runtime = stream->runtime;
+	struct snd_compr_runtime *runtime;
 
 	if (snd_BUG_ON(!(stream) || !(stream)->runtime))
 		return -EINVAL;
+	runtime = stream->runtime;
 	if (runtime->dma_area == NULL)
 		return 0;
 	if (runtime->dma_buffer_p != &stream->dma_buffer) {
-- 
2.25.1

