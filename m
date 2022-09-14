Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59E2ECAAD8
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Sep 2022 09:03:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF014184E;
	Wed, 14 Sep 2022 11:02:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF014184E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663146212;
	bh=RUselDYlOcAsICvqJ0Jg87IqgKRD31uJXYIX0ZCS6UY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nw+KpAuUdr6npduQku0uZGFFbM39uMf0dxTsQ5VxEVUaMUjoVVP4g1khWiMdSBs8f
	 +5RUTUIk7m6qDqZeA+VDB24vGH2Tv/QjbKTBPCd4clbg8+OebUJiRlOt0yiGEs7TEo
	 Ly+KWG0fBxP6vZ5g3T/9tQkpEIZ4h/2xhWjh6yws=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40D8BF8053D;
	Wed, 14 Sep 2022 11:02:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA037F8053D; Wed, 14 Sep 2022 11:01:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E829AF8053B
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2022 11:01:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E829AF8053B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ofFq37MM"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9F8976198B;
 Wed, 14 Sep 2022 09:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60702C43140;
 Wed, 14 Sep 2022 09:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663146111;
 bh=RUselDYlOcAsICvqJ0Jg87IqgKRD31uJXYIX0ZCS6UY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ofFq37MMfbAwLMLRMlA7/KCRm3sycWVGj3qyvRzOprqX/jNWpOOh9aOTG4fJzBxW4
 jp6hUQ1sX3r9WGLZDMIAmaJ+Q3n7ksEFxMpvIpefzV8PAwygYSN2hw1EBBkBY1hUdo
 IFQjezoBUHbztvQ3F3YE3JVU7FazWFu7J05kqwBRCSes6NOHUiSBMxxjpR0gy3W2Pa
 j4VTEcglxL68l/UgZQH1Z2K9pRN7BbwjoMMErbTz78k3w43bsdugC1w/olPl0ntOp8
 n7QVQlWrU6VVtudTd4TLq1Op4je7JaFwAyiozftMq3Ayxl0w4zc2m4CmbY+kqlkore
 /uQhgfdp4Y9jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 13/22] ALSA: hda/tegra: Align BDL entry to 4KB
 boundary
Date: Wed, 14 Sep 2022 05:00:54 -0400
Message-Id: <20220914090103.470630-13-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220914090103.470630-1-sashal@kernel.org>
References: <20220914090103.470630-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>, spujar@nvidia.com, tiwai@suse.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, digetx@gmail.com,
 jonathanh@nvidia.com, Mohan Kumar <mkumard@nvidia.com>
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

From: Mohan Kumar <mkumard@nvidia.com>

[ Upstream commit 8d44e6044a0e885acdd01813768a0b27906d64fd ]

AZA HW may send a burst read/write request crossing 4K memory boundary.
The 4KB boundary is not guaranteed by Tegra HDA HW. Make SW change to
include the flag AZX_DCAPS_4K_BDLE_BOUNDARY to align BDLE to 4K
boundary.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
Link: https://lore.kernel.org/r/20220905172420.3801-1-mkumard@nvidia.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 7debb2c76aa62..976a112c7d006 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -474,7 +474,8 @@ MODULE_DEVICE_TABLE(of, hda_tegra_match);
 static int hda_tegra_probe(struct platform_device *pdev)
 {
 	const unsigned int driver_flags = AZX_DCAPS_CORBRP_SELF_CLEAR |
-					  AZX_DCAPS_PM_RUNTIME;
+					  AZX_DCAPS_PM_RUNTIME |
+					  AZX_DCAPS_4K_BDLE_BOUNDARY;
 	struct snd_card *card;
 	struct azx *chip;
 	struct hda_tegra *hda;
-- 
2.35.1

