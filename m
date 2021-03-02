Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1BFC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 08:30:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E7A600CC
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 08:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E7A600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0145D16B9;
	Tue,  2 Mar 2021 09:29:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0145D16B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614673797;
	bh=KiF38rdEb9uT4uOk0Xm4LFf1SvTi926DSSAegXlJa1M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sKLDjjuFdaK8tFL/g7P7W5wHrDscpSD374LDuU10Z54DLKMQH8pijW9Ad4CGtjkUG
	 OjIQjJXyoaxk2jFtrIYo0DPQsiuuBx0DoK0R94lgC8sUW8uadD27sRhq34MZJesLXy
	 mkHo6z8hegq5LaPJ+gEYVkw7GZvNI00iD2U85Zuk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BE88F8032C;
	Tue,  2 Mar 2021 09:27:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67155F8032D; Tue,  2 Mar 2021 09:27:43 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E796F802CA
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 09:27:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E796F802CA
IronPort-SDR: 0Q7SOdZTQUULIFMwQH1AalDCFMyFJtfnLd+ut5ytjvne+tZg0ym+8leubN+pA+Hp2cKX0Fi0RK
 8EOFgQhHzEow==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="184302415"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="184302415"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 00:27:35 -0800
IronPort-SDR: X48LF1vSvlfDH+mntuNDOUikuDyU5dXy1/6HejuRlt9XVne9Qfu/JD9DY3Yuz4GQG6/5tHZQv1
 wG+YzVJHRVCw==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="406613529"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 00:27:31 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 3/3] soundwire: intel: add master quirks for bus clash and
 parity
Date: Tue,  2 Mar 2021 16:27:20 +0800
Message-Id: <20210302082720.12322-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
References: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
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

Now that we have declarations and bus support, add quirks for Intel
platforms.

Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/soundwire/intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index a2d5cdaa9998..c1fdc85d0a74 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1286,6 +1286,9 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
 		prop->hw_disabled = true;
 
+	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
+		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
+
 	return 0;
 }
 
-- 
2.17.1

