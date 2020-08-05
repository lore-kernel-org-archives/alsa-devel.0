Return-Path: <SRS0=cqJl=BP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7281C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:56:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53BA220792
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CDROa7ij";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ue6pmgES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BA220792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D50F41668;
	Wed,  5 Aug 2020 11:55:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D50F41668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596621376;
	bh=iEfDjZSWYicHuAC0JQbWEM3wyxjAk8YOwPrCH0sSzBY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CDROa7ijCNgHCUxR22E9jpXtTIOm1tAJN4uAjN8qiDcYPLmiHTUszWaAnQ4FZAcHd
	 GOllOklghx52dGI3XUtdky4AWjYZcFWnTcrVhLntH1a6T+uVo2HQn79yW26KS0xBjL
	 ZTAQ+SgcTM0lEeYeuWoPpUTprrHKdLDBAH4vUzVQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D243F802E0;
	Wed,  5 Aug 2020 11:53:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBD5DF802DC; Wed,  5 Aug 2020 11:53:01 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1F30F80234
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2020 11:52:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1F30F80234
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Ue6pmgES"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f2a81670000>; Wed, 05 Aug 2020 02:52:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 05 Aug 2020 02:52:52 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 05 Aug 2020 02:52:52 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug
 2020 09:52:52 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 5 Aug 2020 09:52:52 +0000
Received: from mkumard.nvidia.com (Not Verified[10.24.34.162]) by
 hqnvemgw03.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5f2a81720000>; Wed, 05 Aug 2020 02:52:51 -0700
From: Mohan Kumar <mkumard@nvidia.com>
To: <tiwai@suse.com>, <perex@perex.cz>
Subject: [PATCH v2 3/3] ALSA: hda/tegra: Add 100us dma stop delay
Date: Wed, 5 Aug 2020 15:22:21 +0530
Message-ID: <20200805095221.5476-4-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805095221.5476-1-mkumard@nvidia.com>
References: <20200805095221.5476-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1596621159; bh=uZF+fL32kiXr/FFhU7XFb0VNeNdMUglasynYmIpWkSs=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Type;
 b=Ue6pmgESI0KEd18bPXWXznCxRraZq044VlQbBMpliDuMu2N0F1h1v/pFid4D6688d
 Nb0JkeAN+Ekydp+UEcHyDK5J1a3QRptFSNm0CtRD43qNDdjL7RyycPdnx8/ZUQoYXq
 Iqz9RMTwdt6zxxPVl9nT8BdMEvZ+pFIJZGk51nrXkfo7g5jE7GzM3BFxik5pM7HM1x
 nJIO1r2w8Sg4SVspz9dAS/4CCPcZ4K9XrvUVyo396ErdgLbgjlnm1VtkTx170sBgp4
 EwcAs/QtNAtVOq0ZytBV+HlDnqEzAdqcEhXpldtXniMFfC/2jNNv2V+kkHr2fdqV6T
 Pe0sz3F0iK+Cg==
Cc: alsa-devel@alsa-project.org, spujar@nvidia.com, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org, treding@nvidia.com,
 Mohan Kumar <mkumard@nvidia.com>
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

Tegra HDA has audio data buffer for upto tens of frames, this buffer
can help to avoid underflow. HW will keep issuing new data fetch
request when buffers are not full and current BDL is not done. When SW
disable DMA RUN bit for a stream, HW can't cancel the already issued data
fetch request and hence it can't stop DMA. HW has to wait for all issued
data fetch request get data returned before it stops DMA.

This HW behavior is not in sync with HDA spec which says DMA RUN bit
should be cleared within 1 audio frame. For Tegra, DMA RUN bit was
active for more than one audio frame, due to this the timeout in
snd_hdac_stream_sync function is not helping. When Stream reset set
and clear happens during DMA RUN bit active state it results in Memory
Decode error.

Unfortunately, there is no way to detect when these data accesses have
completed, but testing has shown that a 100us delay between Stream reset
set and clear operation for Tegra avoids the memory decode error.
Therefore, adding a 100us dma stop delay.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index ecf98eb9df36..c94553bcca88 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -308,6 +308,7 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 		return err;
 	}
 	bus->irq = irq_id;
+	bus->dma_stop_delay = 100;
 	card->sync_irq = bus->irq;
 
 	/*
-- 
2.17.1

