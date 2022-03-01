Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA74C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Mar 2022 06:50:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D77981AE9;
	Tue,  1 Mar 2022 07:49:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D77981AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646117425;
	bh=d1pZHjlViL7neu6tjrespr0BqT7OScfDs2hWTkYKAWY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rTeccA8dpSc/Yu/Za+Tsqd2SRKtPlIh3sjt70M3ldU+Avr5mSeHLn3XXeJv81rRwQ
	 F3KyKKyeoanpP0xuh5F/Kqw354DyTcYq9qWzn+04QShkpHr+3ZQRNnjeDiI9l7pwu/
	 tbM8WYl+y68KJWXjRAGZ/8KkdBopLjhMLiqkQYNg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 700CDF80054;
	Tue,  1 Mar 2022 07:49:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F201F80227; Tue,  1 Mar 2022 07:49:33 +0100 (CET)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC884F80054
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2022 07:49:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC884F80054
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=yang.lee@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0V5t7p1Q_1646117362; 
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0V5t7p1Q_1646117362) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 01 Mar 2022 14:49:22 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: broonie@kernel.org
Subject: [PATCH -next] ASoC: amd: Fix an ignored error return from
 platform_get_irq_byname()
Date: Tue,  1 Mar 2022 14:49:20 +0800
Message-Id: <20220301064920.37788-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, tangmeng@uniontech.com,
 Abaci Robot <abaci@linux.alibaba.com>, tiwai@suse.com, lgirdwood@gmail.com,
 Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org
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

The return from the call to platform_get_irq_byname() is int, it can be
a negative error code, however this is being assigned to an unsigned
int variable 'adata->i2s_irq', so assign the value to 'ret' concurrently
to solve this problem without affecting other functions.

Eliminate the following coccicheck warning:
./sound/soc/amd/acp/acp-renoir.c:286:5-19: WARNING: Unsigned expression
compared with zero: adata -> i2s_irq < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 3304a242f45a ("ASoC: amd: Use platform_get_irq_byname() to get the interrupt")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/amd/acp/acp-renoir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 738cf2e2b973..64e824161091 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -282,8 +282,8 @@ static int renoir_audio_probe(struct platform_device *pdev)
 	if (!adata->acp_base)
 		return -ENOMEM;
 
-	adata->i2s_irq = platform_get_irq_byname(pdev, "acp_dai_irq");
-	if (adata->i2s_irq < 0)
+	adata->i2s_irq = ret = platform_get_irq_byname(pdev, "acp_dai_irq");
+	if (ret < 0)
 		return -ENODEV;
 
 	adata->dev = dev;
-- 
2.20.1.7.g153144c

