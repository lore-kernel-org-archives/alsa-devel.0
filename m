Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ADCC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:48:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7159C2070A
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="obAXCKnT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndn8eVjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7159C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02FEA170C;
	Thu, 18 Jun 2020 03:48:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02FEA170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592444937;
	bh=B3HdxUBiJCU32sbuk444sodIJkPGhv+mpEKr9pRgcY4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=obAXCKnTQm9Vt+z8+A7UaqlGDevVF07cw4mzU8LOnLXm4gIdidtwQW7SR39V3eWVM
	 GYIcGmkqe8YJ/SkFu7vX8tgRp22uQRAM8luBkyFIboy/djqLZX+yEfKx1jwlnsuNkk
	 zHp1OByVz30qK4qZERsIqmg9+hlm0cGfJSiHPuHA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B39B3F804E4;
	Thu, 18 Jun 2020 03:22:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0AF08F804E7; Thu, 18 Jun 2020 03:22:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7412EF804E4
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 03:22:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7412EF804E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ndn8eVjJ"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1FA7320663;
 Thu, 18 Jun 2020 01:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592443353;
 bh=B3HdxUBiJCU32sbuk444sodIJkPGhv+mpEKr9pRgcY4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ndn8eVjJ8XEacRN2xWTQLlc4DWG/NWJDk13VJpng/qg+dVipzXeQTaKLF5pICUwiN
 tlCO0O+KuoYUIZJa4d/0wykn4R/Kg0RdM6EZEhNte26o6DV8M9+Fe4bnX/2cC200WA
 mDPhHH4IZH5c+mnLq9ILG1X4Z31BE3WS5/Y2/K+I=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 011/172] ASoC: davinci-mcasp: Fix dma_chan refcnt
 leak when getting dma type
Date: Wed, 17 Jun 2020 21:19:37 -0400
Message-Id: <20200618012218.607130-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Xin Tan <tanxin.ctf@gmail.com>,
 Xiyu Yang <xiyuyang19@fudan.edu.cn>, alsa-devel@alsa-project.org,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
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

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit a697ae6ea56e23397341b027098c1b11d9ab13da ]

davinci_mcasp_get_dma_type() invokes dma_request_chan(), which returns a
reference of the specified dma_chan object to "chan" with increased
refcnt.

When davinci_mcasp_get_dma_type() returns, local variable "chan" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one exception handling path of
davinci_mcasp_get_dma_type(). When chan device is NULL, the function
forgets to decrease the refcnt increased by dma_request_chan(), causing
a refcnt leak.

Fix this issue by calling dma_release_channel() when chan device is
NULL.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/1587818916-38730-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 14ab16e1369f..1203de8aab99 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1758,8 +1758,10 @@ static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
 				PTR_ERR(chan));
 		return PTR_ERR(chan);
 	}
-	if (WARN_ON(!chan->device || !chan->device->dev))
+	if (WARN_ON(!chan->device || !chan->device->dev)) {
+		dma_release_channel(chan);
 		return -EINVAL;
+	}
 
 	if (chan->device->dev->of_node)
 		ret = of_property_read_string(chan->device->dev->of_node,
-- 
2.25.1

