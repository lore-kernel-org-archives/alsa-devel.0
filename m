Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8E9C433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:27:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216B320C56
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Qvth9ufm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKq0lwzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216B320C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 766D91850;
	Fri, 28 Aug 2020 09:26:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 766D91850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598599633;
	bh=mIH9CJyT3jQugMuMwVAcWRNlbGKYjs5RfVX3XHXZL1o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qvth9ufmawMh4sTLrZUqgtUHTLDo5tlAw1mOHYc8DViG4z9+5xryFCzmSU6Ep7nm4
	 Zyurm6RLAD4sozitsbVNZyImnjiJ55/2U8lowovF4tQ7UZf/hDntk8cPMfLrT4xFWg
	 QQj+pM0WKSx2eha+2qlajoh54m3HXr3MhWdSeLy4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 999D0F802FD;
	Fri, 28 Aug 2020 09:22:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED4B1F802D2; Fri, 28 Aug 2020 09:21:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E270F802D2
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 09:21:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E270F802D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hKq0lwzv"
Received: from localhost.localdomain (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7F52A20DD4;
 Fri, 28 Aug 2020 07:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598599297;
 bh=mIH9CJyT3jQugMuMwVAcWRNlbGKYjs5RfVX3XHXZL1o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hKq0lwzvBVKFwV4Px2JmOFFCTK9u4lSFB2VDERAnWMecd5Fvso0964pz8mi6LJxah
 su/DejTjbyGqRQRx4uloug1Ljmig5RUmj9SaHrkZPOwSDyEEZJ1OZOfwynojD/lk5v
 uLEHxe8zOqOQZxb/MlTDl+s0iHkW1IbX8ddi2b0c=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH 8/9] soundwire: intel_init: use FIELD_{GET|PREP}
Date: Fri, 28 Aug 2020 12:51:00 +0530
Message-Id: <20200828072101.3781956-9-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828072101.3781956-1-vkoul@kernel.org>
References: <20200828072101.3781956-1-vkoul@kernel.org>
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

use FIELD_{GET|PREP} in intel_init driver to get/set field values
instead of open coding masks and shift operations.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/intel_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index add46d8fc85c..66411bdf1832 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -382,7 +382,7 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 	 * Name(_ADR, 0x40000000), with bits 31..28 representing the
 	 * SoundWire link so filter accordingly
 	 */
-	if ((adr & GENMASK(31, 28)) >> 28 != SDW_LINK_TYPE)
+	if (FIELD_GET(GENMASK(31, 28), adr) != SDW_LINK_TYPE)
 		return AE_OK; /* keep going */
 
 	/* device found, stop namespace walk */
-- 
2.26.2

