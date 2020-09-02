Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD6AC433E7
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:27:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C7620767
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bTXm0DO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C7620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8FD0189F;
	Wed,  2 Sep 2020 23:26:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8FD0189F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599082043;
	bh=DJnp++F4/FUL3looa3sB9EiGiG4RTck0lgsFbHayKPA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bTXm0DO/d7+2BoNCiH7k2Y76ynZPDIC8koyDR8E4PIcVUEHkd6y89QuB4aXteVbWm
	 fC3iAlR1HbOYE1eHq4DBAksLVpTIcb+kR29+GdX+pbNXb+Fhsy5kYQFO+CheQa0kKP
	 UmgZF+zmU6w4RjheujsyaV2UjrWNGvKR5b9ETNbA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88F91F802E1;
	Wed,  2 Sep 2020 23:22:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B37A4F80305; Wed,  2 Sep 2020 23:22:28 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECB04F8026F
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 23:22:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECB04F8026F
IronPort-SDR: qU2YCTJqJRIRQqUjWdnIDCPIcyUOPGTwTg+EZ2L72ecvklx9R9TFI9dLQxdNiVWE40AL+EBOzz
 rW2q729mPlag==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="157482867"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="157482867"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:04 -0700
IronPort-SDR: QOKeDLrkaii+YP1XS9ojvCow0A2eZLTywf8PhBlGEEefJdm39PuhTTB0QUNcaxWl9lI+8OH80G
 6As0YfvmaD3w==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="477798278"
Received: from rnagarat-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.56.27])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:22:03 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 07/18] ALSA: compress_offload: remove redundant initialization
Date: Wed,  2 Sep 2020 16:21:22 -0500
Message-Id: <20200902212133.30964-8-pierre-louis.bossart@linux.intel.com>
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

sound/core/compress_offload.c:1044:6: style: Redundant initialization
for 'ret'. The initialized value is overwritten before it is
read. [redundantInitialization]

 ret = snd_register_device(SNDRV_DEVICE_TYPE_COMPRESS,
     ^
sound/core/compress_offload.c:1034:10: note: ret is initialized
 int ret = -EINVAL;
         ^
sound/core/compress_offload.c:1044:6: note: ret is overwritten
 ret = snd_register_device(SNDRV_DEVICE_TYPE_COMPRESS,
     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/compress_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index e3eb314acb10..c1fec932c49d 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1032,7 +1032,7 @@ static const struct file_operations snd_compr_file_ops = {
 
 static int snd_compress_dev_register(struct snd_device *device)
 {
-	int ret = -EINVAL;
+	int ret;
 	struct snd_compr *compr;
 
 	if (snd_BUG_ON(!device || !device->device_data))
-- 
2.25.1

