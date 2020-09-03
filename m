Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9581C433E9
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:51:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6F7206EB
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="um500wDi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ybIoXID5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6F7206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C69F1717;
	Thu,  3 Sep 2020 13:50:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C69F1717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599133878;
	bh=6MIasn/UbIMheiL07BO4dQ2F1IUsNXnQh8tvJ+7HVYA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=um500wDimHn9n9y0Win66ZX8BShHuDvsu+bri7fbSJBiu/IVoaK4w+MtQYHVGNmn6
	 /T/ayAVsxbeGUt5+4WBZ4F7uE6ndV01ZYTym85iJtqBHf/rAJkVg4YDMk5byMKkECz
	 3czHqdYxR0NhQWQKbpPEhSWlB28ZbtjHlWVoFv9E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02D80F80322;
	Thu,  3 Sep 2020 13:45:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4AD4DF80328; Thu,  3 Sep 2020 13:45:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A8CBF80321
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 13:45:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A8CBF80321
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ybIoXID5"
Received: from localhost.localdomain (unknown [122.171.179.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 13EAF20709;
 Thu,  3 Sep 2020 11:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599133546;
 bh=6MIasn/UbIMheiL07BO4dQ2F1IUsNXnQh8tvJ+7HVYA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ybIoXID5qHy1ZGhv1I6BqR4Dsn/KvH74w5jQlE+9YVizNZnv5KSkIo1Crl4ViZho6
 TlMsf2sjHi4HTiLolwwdz/BxsDRZbJlBkl8JPGiS0HhpQJNm7lZXLQSm6HM0gI5zlc
 jrKySq2BVsxuSY6FR5O8y2C07Ms81u3ddZoUOfAU=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 9/9] soundwire: remove SDW_REG_SHIFT()
Date: Thu,  3 Sep 2020 17:15:04 +0530
Message-Id: <20200903114504.1202143-10-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903114504.1202143-1-vkoul@kernel.org>
References: <20200903114504.1202143-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>
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

soundwire had defined SDW_REG_SHIFT to calculate shift values for
bitmasks, but now that we have better things in bitfield.h, remove this.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/soundwire/sdw_registers.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index 5d3c271af7d1..f420e8059779 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -4,13 +4,6 @@
 #ifndef __SDW_REGISTERS_H
 #define __SDW_REGISTERS_H
 
-/*
- * typically we define register and shifts but if one observes carefully,
- * the shift can be generated from MASKS using few bit primitaives like ffs
- * etc, so we use that and avoid defining shifts
- */
-#define SDW_REG_SHIFT(n)			(ffs(n) - 1)
-
 /*
  * SDW registers as defined by MIPI 1.2 Spec
  */
-- 
2.26.2

