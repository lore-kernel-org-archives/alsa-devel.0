Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113F8C43334
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jul 2022 01:16:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5ADBB1727;
	Wed, 20 Jul 2022 03:15:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5ADBB1727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658279767;
	bh=H6+CHYRVq143W7sez+eI90XwcYLzJ7SJBwXBuJodYv8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ll1MV5pc9th4r/s4ARj4cXJQrSO695iC5jjSXYVv24Zg0DN/KnLiFmOXBeJBGf1Ey
	 Pu2UbWqYYZyBPH7HXndeRnFVGx8Zt/BUOgRBALUZuqf4ZHvfsXtPJo28jF1O3Di20F
	 9Br0XVq3na2zPt2fTgsdjEm+/vp7juIwJMiKtgOc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18D68F80570;
	Wed, 20 Jul 2022 03:13:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D416BF80570; Wed, 20 Jul 2022 03:13:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7241F80570
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2022 03:13:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7241F80570
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IMm+7z0x"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D8BEF6176A;
 Wed, 20 Jul 2022 01:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18AFC341CA;
 Wed, 20 Jul 2022 01:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658279604;
 bh=H6+CHYRVq143W7sez+eI90XwcYLzJ7SJBwXBuJodYv8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IMm+7z0xAi+zQevlsNVKelfiNNlNvxn8tFHKIa/pHKvZx0JluXN032fUurVxGCDGH
 vVa6eYlOmMrP/LuDlwvtwCE+S/JHdbvjzPWttyg9dhaHiO7/qqLPedYhCBIvG/j+tI
 YGsPePG+frqYksCha6grmnrbaoEQWYDziaj6NksNnwYEcUeI1NwBN64bA6wM84F04x
 t7T3T0aGH+VJrmJRw/QiBFfZn1me/j0bGhotDMHaQnhf2XAbdMwHRsVnhXrto5XYk5
 4mPKc35dfFq8JYN8iZAchcG3FTxvBOxq+wbuvcUXEjJLSl4ussyhgBJQ8jsGgl8Bb4
 h7auRsB4rwabw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 43/54] ASoC: qdsp6: fix potential memory leak in
 q6apm_get_audioreach_graph()
Date: Tue, 19 Jul 2022 21:10:20 -0400
Message-Id: <20220720011031.1023305-43-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720011031.1023305-1-sashal@kernel.org>
References: <20220720011031.1023305-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, pierre-louis.bossart@linux.intel.com,
 linmq006@gmail.com, Jianglei Nie <niejianglei2021@163.com>,
 alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com,
 Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, bgoswami@quicinc.com,
 dan.carpenter@oracle.com
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

From: Jianglei Nie <niejianglei2021@163.com>

[ Upstream commit df5b4aca7248dc5a5cae93f162eae0decf972e48 ]

q6apm_get_audioreach_graph() allocates a memory chunk for graph->graph
with audioreach_alloc_graph_pkt(). When idr_alloc() fails, graph->graph
is not released, which will lead to a memory leak.

We can release the graph->graph with kfree() when idr_alloc() fails to
fix the memory leak.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20220629182520.2164409-1-niejianglei2021@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index f424d7aa389a..794019286c70 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -75,6 +75,7 @@ static struct audioreach_graph *q6apm_get_audioreach_graph(struct q6apm *apm, ui
 	id = idr_alloc(&apm->graph_idr, graph, graph_id, graph_id + 1, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(apm->dev, "Unable to allocate graph id (%d)\n", graph_id);
+		kfree(graph->graph);
 		kfree(graph);
 		mutex_unlock(&apm->lock);
 		return ERR_PTR(id);
-- 
2.35.1

