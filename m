Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28E2C433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 17:11:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187A8610CC
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 17:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187A8610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF434169B;
	Fri,  9 Apr 2021 19:10:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF434169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617988284;
	bh=jPdMwpRkedzgbRr/AeEA7ZDat7TOns3JUbz24zL5ozw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NGWnOWk32LY5U6worqNX7AIBVZsaTR/HTbgyS1d3YnRRtGVHL0hXVp/B/ucpQwO9T
	 XkZKaE6fCaiyhgcOc9n33JtCKjjFNcUcGqsdA5nNh39TfPa/zHurNUpwxF7iaczEmX
	 H7Y29yREpABoL6n4Ltwm2z4jt2kW+1RZHhvNtqKs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93C5EF80260;
	Fri,  9 Apr 2021 19:09:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23050F80168; Fri,  9 Apr 2021 04:00:36 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51F94F80113
 for <alsa-devel@alsa-project.org>; Fri,  9 Apr 2021 04:00:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51F94F80113
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGh8v3TwRzPpMK;
 Fri,  9 Apr 2021 09:57:35 +0800 (CST)
Received: from huawei.com (10.67.174.78) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 10:00:14 +0800
From: Chen Lifu <chenlifu@huawei.com>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH -next] ASoC: sti: sti_uniperif: add missing MODULE_DEVICE_TABLE
Date: Fri, 9 Apr 2021 09:59:53 +0800
Message-ID: <20210409015953.259688-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.174.78]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 09 Apr 2021 19:09:35 +0200
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chen Lifu <chenlifu@huawei.com>
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

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 sound/soc/sti/sti_uniperif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 67315d9b352d..e3561f00ed40 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -97,6 +97,7 @@ static const struct of_device_id snd_soc_sti_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, snd_soc_sti_match);
 
 int  sti_uniperiph_reset(struct uniperif *uni)
 {

