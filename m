Return-Path: <SRS0=sDoq=M5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D2C4338F
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 10:31:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE156023B
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Aug 2021 10:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FE156023B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E574216E5;
	Fri,  6 Aug 2021 12:30:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E574216E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628245905;
	bh=XQiQpGxfZ93Zx3aI21XxuH9pF30ZuUS927jUAisQzmc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ADJK2Jxzf+h4bNlrk7XowTFsz4Jj24ozWPJAt2PhMUtAaIHZvWcovZaSYXDBxZe3N
	 P74mGnngyGw4kEEj0QxErrQJnQgBm9lXZeEnI0Mwz5ToDdN6PGcIHJIKwov608o5ul
	 /5C2uUix8GVDXsp2K5cdNcROJjOxohcxeARnHP0M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 056DFF80279;
	Fri,  6 Aug 2021 12:30:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D674AF80279; Fri,  6 Aug 2021 12:29:56 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 034E3F8010A
 for <alsa-devel@alsa-project.org>; Fri,  6 Aug 2021 12:29:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 034E3F8010A
X-IronPort-AV: E=Sophos;i="5.84,300,1620658800"; d="scan'208";a="90017332"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 06 Aug 2021 19:29:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.62])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9A09F42208EF;
 Fri,  6 Aug 2021 19:29:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 0/3] Add RZ/G2L Sound support
Date: Fri,  6 Aug 2021 11:29:27 +0100
Message-Id: <20210806102930.3024-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Biju Das <biju.das@bp.renesas.com>,
 Chris Brandt <chris.brandt@renesas.com>
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

This patch series aims to add ASoC support on RZ/G2L SoC's.

It is based on the work done by Chris Brandt for RZ/A ASoC driver.

v3->v4:
 * Updated the subject line as per style for the subsystem.
 * Removed select SND_SIMPLE_CARD from Kconfig
 * Added C++ comments for copyright and driver description.
 * Moved validation of channels in hw_params
 * removed asm issue reported by bot as well as Mark
 * replaced master/slave macros with provider/consumer macros
 * Improved locking and added more null pointer checks.
v2->v3:
 * Fixed the dependency on KCONFIG
 * Merged the binding patch with dma feature added
 * Updated dt binding example with encoded #dma-cells value.
 * Improved Error handling in probe function
 * Removed the passing legacy channel configuration parameters from
   dmaengine_slave_config function
 * started using dma_request_chan instead of deprecated
   dma_request_slave_channel
 * Removed SoC dtsi and config patches from this series. Will send it later.
v1->v2:
 * Rebased to latest rc kernel

Biju Das (3):
  ASoC: sh: Add RZ/G2L SSIF-2 driver
  ASoC: dt-bindings: sound: renesas,rz-ssi: Update slave dma channel
    configuration parameters
  ASoC: sh: rz-ssi: Add SSI DMAC support

 .../bindings/sound/renesas,rz-ssi.yaml        |    4 +-
 sound/soc/sh/Kconfig                          |    6 +
 sound/soc/sh/Makefile                         |    4 +
 sound/soc/sh/rz-ssi.c                         | 1069 +++++++++++++++++
 4 files changed, 1081 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/sh/rz-ssi.c

-- 
2.17.1

