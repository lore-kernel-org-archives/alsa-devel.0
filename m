Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD93C4727E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:37:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FBB2054F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ItsHHrWy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JzJBA1Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FBB2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68F3619FD;
	Thu,  1 Oct 2020 19:36:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68F3619FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601573864;
	bh=CApja9/3i4SSZxCyu1S8rCuEjQ9eENWhYSW5FFnSQuQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ItsHHrWy7rf1VIUUG+glv9DPN71/XaW01pPvI3cd5AswtTUJ1TREZMcGCNyVvsnR/
	 nu8sVyLLBU4RYAey3IzeaLAhDONOhCoTscP2uJJZctL0cJdHfouT9r/kJeRbzPhvl3
	 homnx3zF4GHRwZgWGYxuXH5JCDbDvPQJ8a2ZdVDs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82B07F802F8;
	Thu,  1 Oct 2020 19:34:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4266F802FB; Thu,  1 Oct 2020 19:34:25 +0200 (CEST)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF811F802F8
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 19:34:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF811F802F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="JzJBA1Ru"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f7612e60000>; Thu, 01 Oct 2020 10:33:26 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 17:34:14 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 1 Oct 2020 17:34:09 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
 <kuninori.morimoto.gx@renesas.com>, <pierre-louis.bossart@linux.intel.com>,
 <perex@perex.cz>, <tiwai@suse.com>, <thierry.reding@gmail.com>,
 <jonathanh@nvidia.com>
Subject: [PATCH v3 05/13] ASoC: audio-graph: Support empty Codec endpoint
Date: Thu, 1 Oct 2020 23:02:59 +0530
Message-ID: <1601573587-15288-6-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
References: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601573606; bh=xesz+C4t0YPTEFk/rqoe+zcMPgDi6HPptJd7hjC0VQQ=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=JzJBA1RuXOHgUu2eDrsEpKVQqr8gQFQAInbH/EUxhlR8CkQ1yzLjM2yrPrZhEPndl
 AOkHtCLO80qIyrijDr5Fi0TEuHZ1eM11//KRjNqEEWlhWr9mat+cf1u3nOL8cxwC52
 qKyl0J1l1ZQTzWp2NNQnso2GKnq3GgT0RV91A0HdmU3LN38tK21rqZXaJ4mLRu3pUT
 m+tcvkxhoYHmOokmmS8V4/ACrpT7Md9P5AscHlTqtCgrQY7oOk1prpDvcdzlveIFUB
 5umfj2aXsP8yWkndb0dX+5U8RvqI2E4os/ODUNLpSL7o31CLukbHKFO1u2g8y/Vv60
 2pn/AeUdhZmDg==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 nicoleotsuka@gmail.com, swarren@nvidia.com, Sameer Pujar <spujar@nvidia.com>,
 linux-kernel@vger.kernel.org, atalambedu@nvidia.com, viswanathl@nvidia.com,
 sharadg@nvidia.com, nwartikar@nvidia.com, linux-tegra@vger.kernel.org,
 rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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

For open platforms, which can support pluggable audio cards, Codec
endpoint is not fixed always. It actually depends on the compatible
HW module that is going to be connected. From SoC side the given I/O
interface is always available. Hence such links have fixed CPU endpoint
but no Codec endpoint. This patch helps to support such links where
user can populate Codec endpoint only and its fields in Platform DT
depending on the plugged HW.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/audio-graph-card.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 9b06841..0ba50be9 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -229,6 +229,14 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	int ret;
 
+	/*
+	 * Codec endpoint can be NULL for pluggable audio HW.
+	 * Platform DT can populate the Codec endpoint depending on the
+	 * plugged HW.
+	 */
+	if (!li->cpu && !codec_ep)
+		return 0;
+
 	/* Do it all CPU endpoint, and 1st Codec endpoint */
 	if (!li->cpu && dup_codec)
 		return 0;
@@ -565,7 +573,7 @@ static int graph_count_dpcm(struct asoc_simple_priv *priv,
 	li->link++; /* 1xCPU-dummy */
 	li->dais++; /* 1xCPU */
 
-	if (!dup_codec) {
+	if (!dup_codec && codec_ep) {
 		li->link++; /* 1xdummy-Codec */
 		li->conf++; /* 1xdummy-Codec */
 		li->dais++; /* 1xCodec */
-- 
2.7.4

