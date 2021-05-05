Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A0FC433ED
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:53:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F3BE613B4
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3BE613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DDA51713;
	Wed,  5 May 2021 18:52:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DDA51713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620233600;
	bh=HGFtvC083Ni1nBN15WSuKPbVwjoqOSHiN4Am6r8cCdM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SG+zR3QES5S4Ov8VaCR6OvL2/E2la/+/88YRz6j8vsXu6tbqroeNFFZao+yJg2eKT
	 9H8esG6AFR+ZvkPZ0IjPuX7dthmn6ctWpfj7h5jFl/6UsDNi1GPbnv2Qk8PMvkIqOU
	 JQF7CshmmzjI82fQVEmkl0oStmlkzIVXPeFzgWN0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D291F80508;
	Wed,  5 May 2021 18:38:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7B3AF8060D; Wed,  5 May 2021 18:38:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 038B0F80508
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:38:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 038B0F80508
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="G6rSkGGH"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77FC761447;
 Wed,  5 May 2021 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232691;
 bh=HGFtvC083Ni1nBN15WSuKPbVwjoqOSHiN4Am6r8cCdM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G6rSkGGHCNBfbvlhL5h8auL4j//ccbYqOHVYGDXSD4h72g4RTAYuxXsFdOPD+cCHx
 ffSoX4tRrNGou0PF5JuYSS3zZ401LjGTRVutJV9l/0ypEw0nT8yztcDqFsFl3iqb5l
 kCCH+yxIBs5ZZnGph8IV2JTtllCMUgRS3cszlsPXfi/XQN2B9TEp0A4hwggNxqv4/G
 YG/X71ORitRhpitQKxvMZC2fvQeA7+zdUuwH4QWAQMuGGGY/kP4DM3h+4dqNkZF5xI
 TjMF6ZXGWhFd7awgZCsy/vobytepgLZG5CgO0XV6gYde6DGZC3nulzyJDrrV3VsL0y
 elByEPPRiAGNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 56/85] ASoC: Intel: sof_sdw: add quirk for new
 ADL-P Rvp
Date: Wed,  5 May 2021 12:36:19 -0400
Message-Id: <20210505163648.3462507-56-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163648.3462507-1-sashal@kernel.org>
References: <20210505163648.3462507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
 Bard Liao <bard.liao@intel.com>
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

From: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>

[ Upstream commit d25bbe80485f8bcbbeb91a2a6cd8798c124b27b7 ]

Add quirks for jack detection, rt711 DAI and DMIC

Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210415175013.192862-6-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 1d7677376e74..9dc982c2c776 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -187,6 +187,17 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_FOUR_SPK),
 	},
+	/* AlderLake devices */
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alder Lake Client Platform"),
+		},
+		.driver_data = (void *)(SOF_RT711_JD_SRC_JD1 |
+					SOF_SDW_TGL_HDMI |
+					SOF_SDW_PCH_DMIC),
+	},
 	{}
 };
 
-- 
2.30.2

