Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF49C678D6
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Jan 2023 09:28:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B778E7FF0;
	Fri, 13 Jan 2023 10:27:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B778E7FF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673602122;
	bh=C9eEbKq5usd6ckHzGy5EN+JxgZQpOybLQsyYvmgo4Hg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=RQZsYycdT0hUANcg7ePV8gewZfS+hSmtil+MEEBJ8ySBl+ZrH6Xx2USUDP2HrOhZU
	 Bvc8g0NEI2W3ag+ZPIaZHD5Gl0arm1cU6DS//XbUVUDFpt0X1pcFkYGjDwE/sktaRY
	 KhJ14TN1ZVAQ15z66DLqz8G9XdkppHJ8rtk+XBHE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CFADF803DC;
	Fri, 13 Jan 2023 10:27:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4CA50F8026D; Fri, 13 Jan 2023 10:27:26 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 617F7F8026D
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2023 10:27:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 617F7F8026D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VBZjNHSU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673602045; x=1705138045;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C9eEbKq5usd6ckHzGy5EN+JxgZQpOybLQsyYvmgo4Hg=;
 b=VBZjNHSUWwSMhafvNslCYgew63C6YLtw+FOzCk5p6XMIKSNcJ0yrygbs
 FSfjXxBvi8hFCaqNnsBxBx0qMivm/XPjpj+09gupoQjJMu+7Dz0Xx9Eg1
 ORGRKtu/XsoFfOShrKqFl+GVM8Hr9YvgfpwkiiuObL4Cf77eTg8+oFNHl
 dFdrDypuMofa4PP3Vd4g1AJ60S+SDzqZhJyy67fREUgLCpkEBWJzNIH+J
 dZaQwsxcig+wF8/Zq7ZjSRmPs8SebH42TctOXr2G/UloJYmnZGQUzg0yX
 xtPWywQxzELo6NMKacHW1/9a4I78+BTAXvKhq6toXJufMd5byWzCaCPLf w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="351189440"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; d="scan'208";a="351189440"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2023 01:27:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="608116093"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; d="scan'208";a="608116093"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2023 01:27:22 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 2/5] soundwire: stream: use consistent pattern for freeing
 buffers
Date: Fri, 13 Jan 2023 17:35:29 +0800
Message-Id: <20230113093532.3872113-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113093532.3872113-1-yung-chuan.liao@linux.intel.com>
References: <20230113093532.3872113-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 bard.liao@intel.com, linux-kernel@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The code should free the message buffer used for data, the message
structure used for control and assign the latter to NULL. The last
part is missing for multi-link cases, and the order is inconsistent
for single-link cases.

Link: https://github.com/thesofproject/linux/issues/4056
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index e0eae0b98267..f27bd37b154d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -723,8 +723,8 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
 	}
 
 	if (!multi_link) {
-		kfree(wr_msg);
 		kfree(wbuf);
+		kfree(wr_msg);
 		bus->defer_msg.msg = NULL;
 		bus->params.curr_bank = !bus->params.curr_bank;
 		bus->params.next_bank = !bus->params.next_bank;
@@ -769,6 +769,7 @@ static int sdw_ml_sync_bank_switch(struct sdw_bus *bus)
 	if (bus->defer_msg.msg) {
 		kfree(bus->defer_msg.msg->buf);
 		kfree(bus->defer_msg.msg);
+		bus->defer_msg.msg = NULL;
 	}
 
 	return 0;
@@ -867,6 +868,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 		if (bus->defer_msg.msg) {
 			kfree(bus->defer_msg.msg->buf);
 			kfree(bus->defer_msg.msg);
+			bus->defer_msg.msg = NULL;
 		}
 	}
 
-- 
2.25.1

