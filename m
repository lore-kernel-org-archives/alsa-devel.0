Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F648C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Nov 2021 14:57:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96FCE21D4;
	Tue, 30 Nov 2021 15:56:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96FCE21D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638284233;
	bh=askHQZC0W79e5jCS/bMEBre5DvmcTh/+I9+Rqtlm5cE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e1i1DK/LF2Q/D1WJNqnyB2jYiICSrA/FR3gBYs2GgJHg3Eo4xx/CU7QMr2U3uHsSI
	 u1rAwpR6xGqrInqqariRafyzDcByeOBaTm1gxYTiAzFntYb0mmoK9LINZhQHC7NCPi
	 kqHefLqnpuQYM8cfQcsiZUscU3g3CBFgQaWd3Qdk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FF8BF80587;
	Tue, 30 Nov 2021 15:51:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBEE6F8057A; Tue, 30 Nov 2021 15:51:04 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80062F80578
 for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2021 15:51:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80062F80578
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="W4n+KqVT"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 7FF4BCE1A58;
 Tue, 30 Nov 2021 14:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3866C53FCD;
 Tue, 30 Nov 2021 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283854;
 bh=askHQZC0W79e5jCS/bMEBre5DvmcTh/+I9+Rqtlm5cE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W4n+KqVTN0RiWzi/xpNyg1adME/Y2nMfTV9UNwfH+XtI2pkYzf3TXXlwB33vxxWZB
 zRosqzRX116Ea7GLMIZwlxxYgSW2DAWwebs1Cin+Txt6bD46LGKpxIUo9NQaX8zaPK
 xm76QFEjv94NKacoxnPigaziI6GY0zVEbZYd+EqBQXOm8iLXWb0Btjz8FxJwwZoQVz
 +HrFFUBFu0UmqzbgT0q5SBK8SD860k20JNCbyEZzG5YFvy4VQ577+PfWr4z1JMblTj
 2uiKvFs5z9Wo6bIFGDpXXak0dKAquYn759/r9vIKnAXZbsw9fqtk8T3Mo96q6edZBu
 JsiTNpiLQsrxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 10/43] ASoC: qdsp6: q6routing: validate port id
 before setting up route
Date: Tue, 30 Nov 2021 09:49:47 -0500
Message-Id: <20211130145022.945517-10-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145022.945517-1-sashal@kernel.org>
References: <20211130145022.945517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, stephan@gerhold.net, tiwai@suse.com,
 lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, ultracoolguy@disroot.org
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 6712c2e18c06b0976559fd4bd47774b243038e9c ]

Validate port id before it starts sending commands to dsp this would
make error handling simpler.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20211116114721.12517-6-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 0a6b9433f6acf..81fd2c7bdd1b1 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -368,6 +368,12 @@ int q6routing_stream_open(int fedai_id, int perf_mode,
 	}
 
 	session = &routing_data->sessions[stream_id - 1];
+	if (session->port_id < 0) {
+		dev_err(routing_data->dev, "Routing not setup for MultiMedia%d Session\n",
+			session->fedai_id);
+		return -EINVAL;
+	}
+
 	pdata = &routing_data->port_data[session->port_id];
 
 	mutex_lock(&routing_data->lock);
-- 
2.33.0

