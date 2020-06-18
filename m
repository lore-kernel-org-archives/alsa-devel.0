Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4DCC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:50:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8930421D80
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hzJ+5diZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIPs+fEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8930421D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D6DE16F3;
	Thu, 18 Jun 2020 03:49:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D6DE16F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592445037;
	bh=VkcaWixqyjfhWDL/yIdtd0ZiSNKdKgFdcGsVMEWCN3w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hzJ+5diZBniE9x2BFMiPhosjjw48rAFqYIHARZx9r2oSN+MNYZF3PV9jF5oaNHbGg
	 NOpwYQvZ00+79sO2FTtI0LPMBcbdjL6LXZQLELxD+na6q7TPfWhxWz90BRG64Qu9SA
	 eKgFyDOuKzrNaCCG7HjJDIN2Rdl3Xd6FscxQyfmc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC4C5F80369;
	Thu, 18 Jun 2020 03:23:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CD7AF8036E; Thu, 18 Jun 2020 03:23:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCBEFF80369
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 03:23:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCBEFF80369
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hIPs+fEC"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6EA92221EF;
 Thu, 18 Jun 2020 01:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592443402;
 bh=VkcaWixqyjfhWDL/yIdtd0ZiSNKdKgFdcGsVMEWCN3w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hIPs+fECPxnk1YVrE3nP6YwAoRI5u/Xx6B5cnDQIB9nKYHxq6tmLWb1AuwhqGU6Cw
 SRCwb+GFVvR/RErFRKok4rhSTUoNWwRx8Ukg5E6MsgQ1uENdIQb3FLstt8iazOESPO
 HilclS2hyC2HTIME75ULnI//IJouIymFzaspqVbU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 047/172] ASoC: meson: add missing free_irq() in
 error path
Date: Wed, 17 Jun 2020 21:20:13 -0400
Message-Id: <20200618012218.607130-47-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 "Pavel Machek \(CIP\)" <pavel@denx.de>, Mark Brown <broonie@kernel.org>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
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

From: "Pavel Machek (CIP)" <pavel@denx.de>

[ Upstream commit 3b8a299a58b2afce464ae11324b59dcf0f1d10a7 ]

free_irq() is missing in case of error, fix that.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

Link: https://lore.kernel.org/r/20200606153103.GA17905@amd
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-fifo.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 0e4f65e654c4..b229c182b7c3 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -209,7 +209,7 @@ static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
 	/* Enable pclk to access registers and clock the fifo ip */
 	ret = clk_prepare_enable(fifo->pclk);
 	if (ret)
-		return ret;
+		goto free_irq;
 
 	/* Setup status2 so it reports the memory pointer */
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
@@ -229,8 +229,14 @@ static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
 	/* Take memory arbitror out of reset */
 	ret = reset_control_deassert(fifo->arb);
 	if (ret)
-		clk_disable_unprepare(fifo->pclk);
+		goto free_clk;
+
+	return 0;
 
+free_clk:
+	clk_disable_unprepare(fifo->pclk);
+free_irq:
+	free_irq(fifo->irq, ss);
 	return ret;
 }
 
-- 
2.25.1

