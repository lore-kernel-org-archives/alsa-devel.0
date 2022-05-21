Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B39C433FE
	for <alsa-devel@archiver.kernel.org>; Sat, 21 May 2022 11:13:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF1861711;
	Sat, 21 May 2022 13:13:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF1861711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653131631;
	bh=3uqo+o2H12LkmXuPMeEja7vjDs5FXXDemotXlUS4H5U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a0br0fsARRXn8vt/pSWgrPKxrFwvgy8qdDsEbUiRWNqkZotGkjE2HMKZjzH2CQmBu
	 OwMVsYRdrnB2kaoNfrE8/nPdEOQEA3SsiQDec05NMPh255qfoq5u0cBm9V/fMQ+xQk
	 b6uiBXX53rhtBx3MT/Xdo/NfVH3Op1rqY+6jkF54=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B32E9F8051F;
	Sat, 21 May 2022 13:12:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8AB14F8051C; Sat, 21 May 2022 13:12:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 600C4F804CB
 for <alsa-devel@alsa-project.org>; Sat, 21 May 2022 13:12:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 600C4F804CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr
 header.b="D1DYV78f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=D055PQLkjddNqPyjiz+oZSg3+qohn0RJAVU0RfJ3zO8=;
 b=D1DYV78fCgx2bJAjVsccQuSTWgCm1Tp8hYqxlyeysjBjvuNrzOWBrRQN
 vfB/DGNaSQR3mf9pRqHzwrxdD4JSEJs6a8nukC7d/5Xjdw452Zh5dHgXa
 h2+Y9sax3ICIC38MbzjcBsD9edg9KKz1Rnop57kU1Fn+/BZnGCHvZ5JuP U=;
Authentication-Results: mail3-relais-sop.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; d="scan'208";a="14727987"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:06 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: amd: acp: fix typo in comment
Date: Sat, 21 May 2022 13:11:29 +0200
Message-Id: <20220521111145.81697-79-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>
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

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/soc/amd/acp/acp-pdm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
index 424c6e0bb9d6..7a0b26a30051 100644
--- a/sound/soc/amd/acp/acp-pdm.c
+++ b/sound/soc/amd/acp/acp-pdm.c
@@ -174,7 +174,7 @@ static void acp_dmic_dai_shutdown(struct snd_pcm_substream *substream,
 	struct acp_dev_data *adata = dev_get_drvdata(dev);
 	u32 ext_int_ctrl;
 
-	/* Disable DMIC interrrupts */
+	/* Disable DMIC interrupts */
 	ext_int_ctrl = readl(adata->acp_base + ACP_EXTERNAL_INTR_CNTL);
 	ext_int_ctrl |= ~PDM_DMA_INTR_MASK;
 	writel(ext_int_ctrl, adata->acp_base + ACP_EXTERNAL_INTR_CNTL);

