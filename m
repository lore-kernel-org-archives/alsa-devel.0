Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A83C6FA82
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Sep 2022 08:44:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 945EBAEA;
	Fri, 23 Sep 2022 10:43:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 945EBAEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663922680;
	bh=3658Tjx4a9jrff+BkNE3sIENj2CyeDzZPJ1jLD3ybpg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZkpxukK6Zp9Oi5a+83z8DLh815kDBiwUTU853RIGOkrJG0vmNZg2Nq8XjET4jrSNY
	 t7af26uIJMR0c0yVYDQ6109l8QnUTxyZL36hiebrJPbnSDvZfbkf/kc9KY3c13pSeH
	 ehs3IM5+8Fn4MwXmr/v1pTZy9mypMAndC1JpZ9BM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 463BAF80552;
	Fri, 23 Sep 2022 10:42:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C92FF80169; Wed, 21 Sep 2022 05:31:43 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C8FBF80107
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2022 05:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C8FBF80107
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MXP6B1MqSzHpfS;
 Wed, 21 Sep 2022 11:29:22 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 11:31:30 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <fengzheng923@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.com>, <wens@csie.org>,
 <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
 <alsa-devel@alsa-project.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>
Subject: [PATCH -next] sound: sunxi: fix declaration compile error
Date: Wed, 21 Sep 2022 11:38:19 +0800
Message-ID: <20220921033819.2188233-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 23 Sep 2022 10:42:24 +0200
Cc: liwei391@huawei.com, zengheng4@huawei.com
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

Just fix compile error without any logic changes.

sound/soc/sunxi/sun50i-dmic.c:62:1: error: ‘static’ is not at beginning of declaration [-Werror=old-style-declaration]
   62 | const static struct dmic_rate dmic_rate_s[] = {
      | ^~~~~

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 sound/soc/sunxi/sun50i-dmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
index cd3c07f2070f..86cff5a5b1bd 100644
--- a/sound/soc/sunxi/sun50i-dmic.c
+++ b/sound/soc/sunxi/sun50i-dmic.c
@@ -59,7 +59,7 @@ struct dmic_rate {
 	unsigned int rate_bit;
 };
 
-const static struct dmic_rate dmic_rate_s[] = {
+static const struct dmic_rate dmic_rate_s[] = {
 	{48000, 0x0},
 	{44100, 0x0},
 	{32000, 0x1},
-- 
2.25.1

