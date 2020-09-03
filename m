Return-Path: <SRS0=A1sP=CN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC15C433E2
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:45:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 883F720791
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MY5HDopG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883F720791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18F951A9F;
	Fri,  4 Sep 2020 10:44:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18F951A9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599209110;
	bh=o+Pk+IcBuP5STCQqzqQHO/C2MriCb5QauFlJHUJo6pw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MY5HDopG8CIpNFeX56Jbl1DKceNtropiJplx1J6dqbQKpXj1SkYYUuAfAgEy8vz6D
	 TV30PoASZD8RvvuYKh2TLBtzgVAsdLexsSpCo6REEhj6SL3oZ4h9Y2pxM9dwNuRb8P
	 ulUnmsqAsjgeQDGapuo66FjBD0H8zu9CNE4/EYb8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75486F802EC;
	Fri,  4 Sep 2020 10:41:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EFBAF802F7; Fri,  4 Sep 2020 10:41:37 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83821F802E0
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2020 10:41:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83821F802E0
IronPort-SDR: RzNEEJn5IyuhcOabZq2ektCf1LKzX16uE1qO2trC89SkkvRyHQQxA3nEsEejdyutpGR97Lh3pB
 YF2UVSdF/AYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="175765417"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="175765417"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 01:41:30 -0700
IronPort-SDR: gOWvG2y6N5bUwa5hD67rPHc1zS22y1HocsBCPWd4WAmwYEUMOLgQ4zoPVhOL/6da7g+QRQWBRp
 T4MUWWVFHEKw==
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="284358906"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 01:41:26 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 2/4] soundwire: intel: fix NULL/ERR_PTR confusion
Date: Fri,  4 Sep 2020 04:47:37 +0800
Message-Id: <20200903204739.31206-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903204739.31206-1-yung-chuan.liao@linux.intel.com>
References: <20200903204739.31206-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

snd_soc_dai_get_sdw_stream() can only return the pointer to stream or
an ERR_PTR value, NULL is not a possible value.

Fixes: 09553140c8d7b ('soundwire: intel: implement get_sdw_stream() operations')
Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 710f5eba936b..7c20b7daf1c8 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1142,7 +1142,7 @@ static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
 		dma = dai->capture_dma_data;
 
 	if (!dma)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	return dma->stream;
 }
-- 
2.17.1

