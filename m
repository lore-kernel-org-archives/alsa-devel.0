Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B803AC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:24:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096B72220B
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096B72220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78CF116CE;
	Wed, 23 Dec 2020 18:23:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78CF116CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608744243;
	bh=h1DjeuziAPWAhXzrZWjO1w2pXJeCBxFyfJelL/xgEOU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YJGwD4aIjs1++rTIdi1pgOKkIY0tXIoGgenZo94CNVrN1KIZCeyh/0yTjkg06NkOG
	 UR4TfO7dIL7He00JqmuKMlpwPd33rZCgJ7CxylQGpysDiw0I7LEZUepxBzvH8C0u3m
	 rL9tQXMC84g3R7EnWEHGunXJG/P3STSCAuBMxgGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C81AAF804BD;
	Wed, 23 Dec 2020 18:23:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3069AF804C1; Wed, 23 Dec 2020 18:23:11 +0100 (CET)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD2F8F80212
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 18:23:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD2F8F80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de
 header.b="dihiTNNZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=pX1LgKhVCtV+QZok7N1fQH9W07X3ZG11IQtJVsDun5Q=; b=dihiTNNZhJ71/ZUhUTQ6OF9POX
 KWir5k3P9HzaqXxjG+3/gWz7nqyV0vGcBHxgKSD+W8Qav4Q5KJkeuPcnn6TZt9ZUwxpXwFTyck7Qb
 kO786mfXZLPe+QtciD6+fe1zHZJiKupwI3OwX3+Z4QDhWzZPkvjWHjGapWX+j0F05m1XSgAb96rZM
 B1YDa7EP6rf9Z8rP4/lRcqTQ7UZWaEPSuhu1LGgepaRCxljsuaa6YiR3FlEEizkKC5SpbJKRywzCI
 t9cCUoKRYOhmg+V+lYh5b84ppCAG9wAdfKy7Qq41kUBxnaOrwtDk19ocmBB37Vrz4SayAAPGjsoH/
 1o+3FsaQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <lars@metafoo.de>)
 id 1ks7qo-000Eu7-G8; Wed, 23 Dec 2020 18:23:02 +0100
Received: from [62.216.202.54] (helo=lars-desktop.fritz.box)
 by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1ks7qo-000Crk-Cl; Wed, 23 Dec 2020 18:23:02 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 07/18] ALSA: dummy: Use DIV_ROUND_UP() instead of open-coding
 it
Date: Wed, 23 Dec 2020 18:22:18 +0100
Message-Id: <20201223172229.781-7-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201223172229.781-1-lars@metafoo.de>
References: <20201223172229.781-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26026/Wed Dec 23 13:53:03 2020)
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
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

Use DIV_ROUND_UP() instead of open-coding it. This documents intent
and makes it more clear what is going on for the casual reviewer.

Generated using the following the Coccinelle semantic patch.

// <smpl>
@@
expression x, y;
@@
-(((x) + (y) - 1) / (y))
+DIV_ROUND_UP(x, y)
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/drivers/dummy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index b5486de08b97..316c9afadefe 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -236,7 +236,7 @@ struct dummy_systimer_pcm {
 static void dummy_systimer_rearm(struct dummy_systimer_pcm *dpcm)
 {
 	mod_timer(&dpcm->timer, jiffies +
-		(dpcm->frac_period_rest + dpcm->rate - 1) / dpcm->rate);
+		DIV_ROUND_UP(dpcm->frac_period_rest, dpcm->rate));
 }
 
 static void dummy_systimer_update(struct dummy_systimer_pcm *dpcm)
-- 
2.20.1

