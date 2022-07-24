Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EE6C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jul 2022 06:27:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51E713E7;
	Mon, 25 Jul 2022 08:26:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51E713E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658730430;
	bh=HQRWPlzHVQpWO50PW9Sop3YkJ5cLkBxWiSTwl/nUXZY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rtcRxJHb1EM3ph0cMMq/0iOAhzpwsaIybABSv31dWwyStDwG5aON+1qKvN3+MB8In
	 KFYcmFHfuN6o2k6S0X4z8PNKCPhj5wgTgO7uOneZV9MTV9fP3R37rEmrkudHRUXZ4S
	 s3jlq6RrQN1kOIpwYW8QRQcucTQsP/t8scDV6Xq4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95BE8F80212;
	Mon, 25 Jul 2022 08:25:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93493F8016A; Sun, 24 Jul 2022 09:10:30 +0200 (CEST)
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A51CBF80128
 for <alsa-devel@alsa-project.org>; Sun, 24 Jul 2022 09:10:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A51CBF80128
X-QQ-mid: bizesmtp83t1658646617tjaeqp23
Received: from localhost.localdomain ( [125.70.163.183])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 24 Jul 2022 15:10:16 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: 7jw2iSiCazpDLTDr4HOaN8SJ7zetT2RY2zS9DJNDlFgShqayluQZkuTk9rVYG
 eF1lNTbG9EbW4E48abZnaPlsnX3zTUBHLau+d8Z55dx54fMOBMTamppm83BchDEwGqNkm87
 oDjAzdZ90VkFTuXuTGooGQTjd/RR71fp/9OAvDKpKKIf2VHnNE8NPwXcpp/gQkzQJzCi0YO
 iCwALCPvCnOA+mRDhjAZTNFBKIu41VmXf0zkI1WwVCYTzQ1kSR63LgesCIISD9c8+gJcLLP
 5W2yAtIOxaZxuw9pb92j79nWQ/MRwzJ5SukUVe0bA6dK/diZKAEbKtQPAhPpskulI3viNLi
 t5H7Bk+tgONF4RzB/oUTGfQfhv3BHgwPEVR/bpf71LSCcUTE4s=
X-QQ-GoodBg: 0
From: wangjianli <wangjianli@cdjrlc.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] pci/asihpi: fix repeated words in comments
Date: Sun, 24 Jul 2022 15:10:09 +0800
Message-Id: <20220724071009.9274-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Mailman-Approved-At: Mon, 25 Jul 2022 08:25:50 +0200
Cc: wangjianli <wangjianli@cdjrlc.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 sound/pci/asihpi/hpi6205.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 3d6914c64c4a..27e11b5f70b9 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -445,7 +445,7 @@ void HPI_6205(struct hpi_message *phm, struct hpi_response *phr)
 /* SUBSYSTEM */
 
 /** Create an adapter object and initialise it based on resource information
- * passed in in the message
+ * passed in the message
  * *** NOTE - you cannot use this function AND the FindAdapters function at the
  * same time, the application must use only one of them to get the adapters ***
  */
-- 
2.36.1

