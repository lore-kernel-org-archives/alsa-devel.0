Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FF8C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:51:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E71620719
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IhV1PM6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E71620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 37F6216A3;
	Mon, 27 Jul 2020 18:50:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 37F6216A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595868686;
	bh=TUOODG6VuraKd1zxeLCxFaoy6Wba2YAVqbKzAWAK0gY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IhV1PM6zsJ5YCI7PTnNZ7gzJ/VUYWL57F4R64l1vwf/fxYNmGaUfJlJ66ODk8sSmY
	 uINCIzXaJkEBz0k9/pnXPg1WXk6QF9h3a85Ix3PmC+lcBhYjsGou/zElKmMEcPplez
	 jPnaoT5Mse7VYlIVA7ptxjnlgKeq5WX/O1RmkSxc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59471F801F7;
	Mon, 27 Jul 2020 18:49:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5E93F800DE; Mon, 27 Jul 2020 04:52:23 +0200 (CEST)
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
 by alsa1.perex.cz (Postfix) with ESMTP id C14DFF800DE
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 04:52:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C14DFF800DE
Received: from localhost (unknown [159.226.5.99])
 by APP-03 (Coremail) with SMTP id rQCowAAnL8NZQR5fRJpnAw--.64264S2;
 Mon, 27 Jul 2020 10:52:09 +0800 (CST)
From: Xu Wang <vulab@iscas.ac.cn>
To: perex@perex.cz, tiwai@suse.com, alexander@tsoy.me, e.burema@gmail.com,
 vulab@iscas.ac.cn, henryl@nvidia.com, alsa-devel@alsa-project.org
Subject: [PATCH] usb: endpoint : remove needless check before
 usb_free_coherent()
Date: Mon, 27 Jul 2020 02:52:08 +0000
Message-Id: <20200727025208.8739-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowAAnL8NZQR5fRJpnAw--.64264S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWrZw4UGr47GFWDWF4UJwb_yoW3WFX_ua
 y8Gr1DWrWqg3y7K3srCr4FyFW2g39aqF1kWF1SyFZrJF98J3yYy34xJrs8GF1fuanYgFnx
 Xwn2krZxGryxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb2kYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4UJV
 WxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8JwCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0-dbUUUUUU==
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiAgYKA1JhbmICzgACs8
X-Mailman-Approved-At: Mon, 27 Jul 2020 18:49:41 +0200
Cc: linux-kernel@vger.kernel.org
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

usb_free_coherent() is safe with NULL addr and this check is
not required.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 sound/usb/endpoint.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 88760268fb55..3a2b2a309a71 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -615,9 +615,8 @@ static void release_urbs(struct snd_usb_endpoint *ep, int force)
 	for (i = 0; i < ep->nurbs; i++)
 		release_urb_ctx(&ep->urb[i]);
 
-	if (ep->syncbuf)
-		usb_free_coherent(ep->chip->dev, SYNC_URBS * 4,
-				  ep->syncbuf, ep->sync_dma);
+	usb_free_coherent(ep->chip->dev, SYNC_URBS * 4,
+			  ep->syncbuf, ep->sync_dma);
 
 	ep->syncbuf = NULL;
 	ep->nurbs = 0;
-- 
2.17.1

