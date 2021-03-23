Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4D6C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 13:34:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9406197F
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 13:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9406197F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0990167F;
	Tue, 23 Mar 2021 14:33:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0990167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616506473;
	bh=TF5UXY/Ix+B1d3eL0dXOo5Us589tHbqG9GQ1ovjUlLc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=udhyAz0EwMPZMU0mksHMVdbdwaHYs9uyhElZCOB7bR55FLLf3o2xQa1RklrIasUsW
	 2+NiTeYy6aXOHSD/VUVCqd8q05xGnJtZPQXd/tksClvFomjRK4gwkbXcqhp6vgKlcA
	 1kfhVGBCRx/bw4fYteraL4b/4oUa5BZA+3ApWEt0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62409F80290;
	Tue, 23 Mar 2021 14:32:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C13AF8025F; Tue, 23 Mar 2021 13:15:44 +0100 (CET)
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 987D5F80104
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 13:15:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 987D5F80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.b="aBnCPsqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6QZd+
 Qu0fIzv6FrkmEmhT2O1Vr/D3wWNz5LeNfDEykY=; b=aBnCPsqePEj/C83PjqBP4
 lLp7tKrL+h25sOzKlI9vawdHaaSe5xHJRvycFVYKIde7OsqNm1dH0p6QzgWOQ9tb
 x5xNou15pbRQudkkzQ9JYml388xmgTdMhre7C83AlErKXljpt3fzXlIHPqmrir8t
 03TDL2Or/iet0EPSPDUCN4=
Received: from caizhichao.ccdomain.com (unknown [218.94.48.178])
 by smtp8 (Coremail) with SMTP id DMCowAAXHrLH21lgfoN2WA--.9610S2;
 Tue, 23 Mar 2021 20:15:26 +0800 (CST)
From: caizhichao <tomstomsczc@163.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] sound/i2c: Simplify the return expression of
 snd_i2c_bit_sendbyte()
Date: Tue, 23 Mar 2021 20:14:43 +0800
Message-Id: <20210323121443.1276-1-tomstomsczc@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAXHrLH21lgfoN2WA--.9610S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1xWryxAw1kXF1rKr17Jrb_yoWxZwc_Gr
 ykWw48WrW5XayYv3yfZrW5Zw47GF1DCrn2kF18Kw43Gay5Ww42qr18Gr929rykXr4F9Fy3
 Wr95Wr9xC39FvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnUl1DUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pwrp23prpvu6rf6rljoofrz/xtbBzR5eil0CPryz5AAAsN
X-Mailman-Approved-At: Tue, 23 Mar 2021 14:32:46 +0100
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Zhichao Cai <caizhichao@yulong.com>
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

From: Zhichao Cai <caizhichao@yulong.com>

Simplify the return expression.

Signed-off-by: Zhichao Cai <caizhichao@yulong.com>
---
 sound/i2c/i2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/i2c/i2c.c b/sound/i2c/i2c.c
index 847e3b6..dfcc87e 100644
--- a/sound/i2c/i2c.c
+++ b/sound/i2c/i2c.c
@@ -235,9 +235,7 @@ static int snd_i2c_bit_sendbyte(struct snd_i2c_bus *bus, unsigned char data)
 	for (i = 7; i >= 0; i--)
 		snd_i2c_bit_send(bus, !!(data & (1 << i)));
 	err = snd_i2c_bit_ack(bus);
-	if (err < 0)
-		return err;
-	return 0;
+	return err < 0 ? err : 0;
 }
 
 static int snd_i2c_bit_readbyte(struct snd_i2c_bus *bus, int last)
-- 
1.9.1


