Return-Path: <SRS0=q721=53=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC3DC2BBC7
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Apr 2020 23:12:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE0521841
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Apr 2020 23:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OkaeChjG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORRR6+Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE0521841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABC3916D5;
	Sun, 12 Apr 2020 01:11:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABC3916D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586646765;
	bh=R2jZ2+8UiQo4UPZjj2tDin5/Lvsu8Ax4oUlcXeMn4YU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OkaeChjGoSjokG7xEZw7402ho7R5AbJgiM511fxtVC5fKNvRhYksQc+M4BrDOZNmc
	 glGhcfRLCi2OA/DOPidgo4y90kue1SJNlGbURAtar753iAQnCItP5UIyPGuBZF275k
	 w8JdQPQCPxYisIeIwBKCyxYP1cqiXmNTuEGenisg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA7D5F80216;
	Sun, 12 Apr 2020 01:11:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68F99F80218; Sun, 12 Apr 2020 01:11:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12B2DF801D8
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2020 01:11:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12B2DF801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ORRR6+Uy"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C2C9C20757;
 Sat, 11 Apr 2020 23:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586646690;
 bh=R2jZ2+8UiQo4UPZjj2tDin5/Lvsu8Ax4oUlcXeMn4YU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ORRR6+Uy4M4Ir+12Jvam+F9A+nvbucjJb7yYigwzrnt00kKIgWvzw2v12orZmYx08
 N3BOtsoXnb0uJp+rwv0l7FjjKiBTUJYpPYK5ejDqzS968T3wMOwIA8K2ThP+ERiqRZ
 6RmbQsRlEBaJUT6OdNMZ/gvXh4+TTfrASRx6isZE=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 085/108] ASoC: stm32: spdifrx: fix regmap status
 check
Date: Sat, 11 Apr 2020 19:09:20 -0400
Message-Id: <20200411230943.24951-85-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Olivier Moysan <olivier.moysan@st.com>, Mark Brown <broonie@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
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

From: Olivier Moysan <olivier.moysan@st.com>

[ Upstream commit a168dae5ea14283e8992d5282237bb0d6a3e1c06 ]

Release resources when exiting on error.

Fixes: 1a5c0b28fc56 ("ASoC: stm32: spdifrx: manage identification registers")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20200318144125.9163-2-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index e53fb4bd66b36..9fc2a1767eb1d 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -995,6 +995,8 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 
 	if (idr == SPDIFRX_IPIDR_NUMBER) {
 		ret = regmap_read(spdifrx->regmap, STM32_SPDIFRX_VERR, &ver);
+		if (ret)
+			goto error;
 
 		dev_dbg(&pdev->dev, "SPDIFRX version: %lu.%lu registered\n",
 			FIELD_GET(SPDIFRX_VERR_MAJ_MASK, ver),
-- 
2.20.1

