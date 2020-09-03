Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4FCC433E9
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:48:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DB3206EB
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CgdSVPdS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LixsVFcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DB3206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49CBA18F7;
	Thu,  3 Sep 2020 13:47:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49CBA18F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599133698;
	bh=X+GUo7r2fem7RtX0ecIJdRl8g3BdBJ89wf8cZ/g/1pw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CgdSVPdStN5kvLeIlaEi+TVtX36T5daPY2o32ZzsBZz8iCTke9Q0BtEKm0eceMCzs
	 SYzl51CnHCGxu/iVXESWPD+JdbG04iaEz8YVViiAFY/YnFVER582t3sezJIMzjwMTe
	 0nmcNktXcBMesYgMcxhtRToX6mHp4T2h9SrIOen0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90DE2F802E0;
	Thu,  3 Sep 2020 13:45:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27BFFF800F0; Thu,  3 Sep 2020 13:45:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E117FF800F0
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 13:45:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E117FF800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LixsVFcm"
Received: from localhost.localdomain (unknown [122.171.179.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 293E9206EB;
 Thu,  3 Sep 2020 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599133524;
 bh=X+GUo7r2fem7RtX0ecIJdRl8g3BdBJ89wf8cZ/g/1pw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LixsVFcmoPjoamYhCHYMBdElYwDRNKqvMzsS2qp+1vLaaI17vfxXCI1p2Ao1NC4vd
 z1bmRkLBKHEFhibl3KH0MBzy5448GWOL35qQOADXStly71Rzv9iTZ01EGsI7wEEjr8
 O0zQMRChywhqhC3yhKzpfI4zewgW9SFgFUIwS+Z4=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 2/9] soundwire: bus: use FIELD_GET()
Date: Thu,  3 Sep 2020 17:14:57 +0530
Message-Id: <20200903114504.1202143-3-vkoul@kernel.org>
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

use FIELD_GET() in bus code to extract field values instead of open
coding masks and shift operations.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index e6e0fb9a81b4..d808f0256ba0 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -347,8 +347,8 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 		return -EINVAL;
 	}
 
-	msg->addr_page1 = (addr >> SDW_REG_SHIFT(SDW_SCP_ADDRPAGE1_MASK));
-	msg->addr_page2 = (addr >> SDW_REG_SHIFT(SDW_SCP_ADDRPAGE2_MASK));
+	msg->addr_page1 = FIELD_GET(SDW_SCP_ADDRPAGE1_MASK, addr);
+	msg->addr_page2 = FIELD_GET(SDW_SCP_ADDRPAGE2_MASK, addr);
 	msg->addr |= BIT(15);
 	msg->page = true;
 
@@ -1420,7 +1420,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		port = buf & SDW_SCP_INT1_PORT0_3;
 
 		/* To get port number corresponding to bits, shift it */
-		port = port >> SDW_REG_SHIFT(SDW_SCP_INT1_PORT0_3);
+		port = FIELD_GET(SDW_SCP_INT1_PORT0_3, port);
 		for_each_set_bit(bit, &port, 8) {
 			sdw_handle_port_interrupt(slave, bit,
 						  &port_status[bit]);
-- 
2.26.2

