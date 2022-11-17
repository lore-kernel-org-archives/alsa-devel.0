Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1439C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Nov 2022 03:29:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B52F16AD;
	Thu, 17 Nov 2022 04:28:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B52F16AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668655744;
	bh=tZ7LwGFCziS6uyAkDJPPWYp3E1r7xWzb6xvOr82h2/o=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TepXR1B9whLg5PmDJiy3YG7os9SDKzXG9U3TBes2ps78VWfUyy4LaIjHzNFgOHGJs
	 PB/nSKlIit/ntXrZDsE68MMe/9W2WXH6Q8Xgl3ZdJyr2FQ2/6yPEkcspERnsSKwfKV
	 kIs/zUEDaMrCQ5/gQUSFpRqKBLaxrHClZsq3SV1o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3B27F8015B;
	Thu, 17 Nov 2022 04:28:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A05FAF8025A; Thu, 17 Nov 2022 04:28:10 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBABEF800B8
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2022 04:28:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBABEF800B8
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCQNF4vFcz8RTZR;
 Thu, 17 Nov 2022 11:27:57 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
 by mse-fl2.zte.com.cn with SMTP id 2AH3RSOc053408;
 Thu, 17 Nov 2022 11:27:46 +0800 (+08)
 (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid31;
 Thu, 17 Nov 2022 11:27:47 +0800 (CST)
Date: Thu, 17 Nov 2022 11:27:47 +0800 (CST)
X-Zmail-TransId: 2af96375aa3352d13a9c
X-Mailer: Zmail v1.0
Message-ID: <202211171127475450476@zte.com.cn>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <srinivas.kandagatla@linaro.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNsaW1idXM6IGNvcmU6IFVzZSBkZXZpY2VfbWF0Y2hfb2Zfbm9kZSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH3RSOc053408
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID
 6375AA3D.002 by FangMail milter!
X-FangMail-Envelope: 1668655677/4NCQNF4vFcz8RTZR/6375AA3D.002/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6375AA3D.002/4NCQNF4vFcz8RTZR
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with device_match_of_node().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/slimbus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 219483b79c09..9cafd33e7ddb 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -389,7 +389,7 @@ static int of_slim_match_dev(struct device *dev, void *data)
 	struct device_node *np = data;
 	struct slim_device *sbdev = to_slim_device(dev);

-	return (sbdev->dev.of_node == np);
+	return device_match_of_node(&sbdev->dev, np);
 }

 static struct slim_device *of_find_slim_device(struct slim_controller *ctrl,
-- 
2.25.1
