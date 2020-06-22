Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E42C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:59:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F2E25439
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dMmWcuml";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l04caq2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F2E25439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2935116BC;
	Mon, 22 Jun 2020 08:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2935116BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592809164;
	bh=M+IMJCWsfaGwRdIZxma3LL04/JdsXZ7jXdbDu2zWSs8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dMmWcumlY18dOw1vuftA0ahaRLu0KgicLyEzy2Ilgn5OpR/7xbkazj02VkxefBhPL
	 3Vx4gPmCdStSMgkFxL8Mt3LbN+sPaFQOkvVxlPxrfVz5HrVHulHR4bLCZs68zOtIfN
	 MVo/cEcf0KFXaYXNlc7N1EuJ/Eb7TPmBMrwVuFIc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A493DF8015A;
	Mon, 22 Jun 2020 08:58:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A7F8F8015B; Mon, 22 Jun 2020 08:58:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAB3FF8010E
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 08:58:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AAB3FF8010E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="l04caq2+"
Received: from localhost.localdomain (unknown [171.61.66.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E5C7625360;
 Mon, 22 Jun 2020 06:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592809106;
 bh=M+IMJCWsfaGwRdIZxma3LL04/JdsXZ7jXdbDu2zWSs8=;
 h=From:To:Cc:Subject:Date:From;
 b=l04caq2+VwFrt5m0dYJc5LRs8iiTn1o+HMA8ghi+N8f3XqMi+7KwU1sNFKobHP9MM
 iUyz9jgrPTtoEqEAIRHtG9NQSac3bCTS3tyoTFytA1zfZAW3hiWG8WUKB/UB0iysDd
 XH8dFCbQ0y629dk9gI/qSqH0DEj36sUjeJjsC4YM=
From: Vinod Koul <vkoul@kernel.org>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v2 0/3] ALSA: compress: Document stream states and fix gapless
 SM
Date: Mon, 22 Jun 2020 12:28:08 +0530
Message-Id: <20200622065811.221485-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 linux-arm-msm@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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

Srini found issue with gapless implementation which prompted to look deeper
into SM for compressed stream.

So documenting SM was first step, so first two patches add that. Last patch
fixes the issue by keeping track on partial_drain and then moving state to
'running' in snd_compr_drain_notify() for partial_drain case on success.
While at it, noticed snd_compr_drain_notify() is lockless state change, so
fixed that as well.

I have tested this on Dragon board RB3, compressed audio works out of the
box on that platform and Srini will send driver and fcplay patches for
gapless soon.

Changes in v2:
 - Added tested tag by Srini
 - Update compress SM with Free state and compr_stop() transitions

Vinod Koul (3):
  ALSA: compress: document the compress audio state machine
  ALSA: compress: document the compress gapless audio state machine
  ALSA: compress: fix partial_drain completion state

 .../sound/designs/compress-offload.rst        | 84 +++++++++++++++++++
 include/sound/compress_driver.h               | 12 ++-
 sound/core/compress_offload.c                 |  4 +
 3 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.26.2

