Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71E2C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 06:44:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF4F64E56
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 06:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF4F64E56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 849C816C0;
	Wed, 10 Feb 2021 07:44:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 849C816C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612939493;
	bh=KFttDdzgAcqgF5KdUm1D3Yzn4wym9KXfkeuoVJPUdS0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vG033SJqy69KXHgUQalw12CTc89q0ZJXR3MGNq4jDYSrtQKlVrJtrRpft1O169h0q
	 ha/1XGBuTqDemZy4AiEUo9GuZgcvUlJ6Oz4/9Rv/Ou3JdYP6Fycoo00R5WumlJLxfC
	 NFmKumaXQbq3zJzxLgwFh6z9/4dP/h1PrnY2Zpyo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5D49F80169;
	Wed, 10 Feb 2021 07:44:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4038BF8022B; Wed, 10 Feb 2021 07:44:00 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07D4CF8010D
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 07:43:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07D4CF8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="KQA0fRsQ"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B602380aa0000>; Tue, 09 Feb 2021 22:43:54 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 06:43:54 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 10 Feb 2021 06:43:50 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <thierry.reding@gmail.com>
Subject: [PATCH 0/3] Use clocks property in a device node
Date: Wed, 10 Feb 2021 12:13:38 +0530
Message-ID: <1612939421-19900-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612939434; bh=c19W9Oh8pMdfVc6xnFBZ4UqL8XI7169ntNra7yJITRQ=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Type;
 b=KQA0fRsQR5FGeoZRbP0CMD9srE2MTT59P5vHyOH12W9OWxY46SqyhYO+703E49cFH
 PQZ+7Avc4joDpvTBGwsaln5yBuQXWXD3OxmUDSo3+k62AjU16b+lRN+WYnsW8tJ9Xq
 ThCMcCg3ppLDIhACt5bOs9/KaFH2baOljFM+YVoEe7iEHVPa/9wmz3ajddt5sDCPDw
 Wxk0zlmJUe+AB/TfEMxmVrptATN5c8VB69UNdFLKADFYjsW/qowLBWN0Hy7mFHt+St
 9usn+irw4KuJGrLARBTtd9gI2YI929YOLjUIBt0o3FYTB+8A9uyVa7NCVi7EZ4nBKM
 /UJLLLHpxQI3w==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, Sameer Pujar <spujar@nvidia.com>,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, sharadg@nvidia.com,
 linux-tegra@vger.kernel.org
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

It is recommended to not specifiy clocks property in an endpoint subnode.
This series moves clocks to device node.

However after moving the clocks to device node, the audio playback or
capture fails. The specified clock is not actually getting enabled and
hence the failure is seen. There seems to be a bug in simple-card-utils.c
where clock handle is not assigned when parsing clocks from device node.

Fix the same and revert original change which actually added clocks
property in endpoint subnode. Also update Jetson AGX Xavier DT where the
usage is found.


Sameer Pujar (3):
  ASoC: simple-card-utils: Fix device module clock
  Revert "ASoC: audio-graph-card: Add clocks property to endpoint node"
  arm64: tegra: Move clocks from RT5658 endpoint to device node

 .../devicetree/bindings/sound/audio-graph-port.yaml         |  3 ---
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts          |  2 +-
 sound/soc/generic/simple-card-utils.c                       | 13 ++++++-------
 3 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.7.4

