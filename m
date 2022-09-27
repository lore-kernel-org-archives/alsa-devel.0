Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F02DC07E9D
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Sep 2022 11:36:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EBDA84C;
	Tue, 27 Sep 2022 13:35:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EBDA84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664278585;
	bh=6ZLd7SiG0U7egjWJYJ+G3LfpGkZQIbA/6DsNXQhV9IA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r+WB/i5rQoGhUV+ZeBDWwHLLcG+XuEtlpLKOXvTq9cFOvcrfxfJuv8XcwllYYuv/V
	 MCfO1fNrl/LvKll+KQkXtYsS+qXT7QmRV0cp6//bJNfsucds2b0+HjQoxbJcZbpIiK
	 H/X1LOuggUvMrBr0zSUiY7eetf31IhVv+uFwn65M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07B24F804D0;
	Tue, 27 Sep 2022 13:35:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32920F80496; Tue, 27 Sep 2022 13:35:07 +0200 (CEST)
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B591F8025E
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 13:35:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B591F8025E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="TdnRyzkT"
From: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1664278499; bh=E6uzsBYVZvDKj1HzGMPEUTFj/LsUV+qoai7hTKUpGS8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TdnRyzkTL3T68jSbosljBlber57jYv7P01BI8UvAXOC/timh4FZIMdsfcRwDjUkoW
 uiLpHwrOe5hrIhtZD0QT2MtkDQl0eSgop2twqhkwRi1Chq3aYOcwpmY2Jp1BQ26N08
 aeHZf/OjIVEdY9CBrfyJX2ZSatY6bPwumdHRtAX8=
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: apple: mca: Remove stale release of DMA channels
Date: Tue, 27 Sep 2022 13:34:25 +0200
Message-Id: <20220927113426.49724-2-povik+lin@cutebit.org>
In-Reply-To: <20220927113426.49724-1-povik+lin@cutebit.org>
References: <20220927113426.49724-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
 alsa-devel@alsa-project.org, asahi@lists.linux.dev,
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

The commit 4ec8179c212f ("ASoC: apple: mca: Postpone requesting of DMA
channels") shuffled around with the requesting and releasing of DMA
channels. It left behind stale release calls from within
apple_mca_release, remove those now.

Fixes: 4ec8179c212f ("ASoC: apple: mca: Postpone requesting of DMA channels")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/apple/mca.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index 75925bfcf754..7ca653987b78 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -970,18 +970,11 @@ static const struct snd_soc_component_driver mca_component = {
 
 static void apple_mca_release(struct mca_data *mca)
 {
-	int i, stream;
+	int i;
 
 	for (i = 0; i < mca->nclusters; i++) {
 		struct mca_cluster *cl = &mca->clusters[i];
 
-		for_each_pcm_streams(stream) {
-			if (IS_ERR_OR_NULL(cl->dma_chans[stream]))
-				continue;
-
-			dma_release_channel(cl->dma_chans[stream]);
-		}
-
 		if (!IS_ERR_OR_NULL(cl->clk_parent))
 			clk_put(cl->clk_parent);
 
-- 
2.33.0

