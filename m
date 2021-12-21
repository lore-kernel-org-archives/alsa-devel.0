Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69723C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Dec 2021 17:02:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AADD2179C;
	Tue, 21 Dec 2021 18:01:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AADD2179C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640106130;
	bh=zmLAP7F4CSO9PZBd0Ay3IsVN4C3vHg86kNkHohOzmAg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ko1HO4f3hrAqhmQ310hVsS2SwPitNX1xlXwbBGHIsc0kTSw6BJzLUl/TlcUPZQUD/
	 vUZuCwfVdbduYeNuIHLVLl++a1tFMsHiGu4d9Q5PuKxSmBOD0Y5JBnUXnnMaUhkKsS
	 /3+gkZDGtfNy9852Z85AjenidJW/rNiQsl998nmE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4182CF80125;
	Tue, 21 Dec 2021 18:01:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85B58F8010B; Tue, 21 Dec 2021 18:01:18 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by alsa1.perex.cz (Postfix) with ESMTP id EF34AF8010B
 for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2021 18:01:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF34AF8010B
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; d="scan'208";a="104253500"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 02:01:08 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 26AB540083DD;
 Wed, 22 Dec 2021 02:01:05 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Michal Simek <michal.simek@xilinx.com>, alsa-devel@alsa-project.org
Subject: [PATCH v2 0/2] sound/soc: Use platform_get_irq() to fetch IRQ's
Date: Tue, 21 Dec 2021 17:00:58 +0000
Message-Id: <20211221170100.27423-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi All,

This patch series aims to drop using platform_get_resource() for IRQ types
in preparation for removal of static setup of IRQ resource from DT core
code.

Dropping usage of platform_get_resource() was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  ASoC: xlnx: Use platform_get_irq() to get the interrupt
  ASoC: bcm: Use platform_get_irq() to get the interrupt

 sound/soc/bcm/bcm63xx-i2s.h          |  1 -
 sound/soc/bcm/bcm63xx-pcm-whistler.c | 13 ++++++-------
 sound/soc/xilinx/xlnx_spdif.c        | 10 +++-------
 3 files changed, 9 insertions(+), 15 deletions(-)

-- 
2.17.1

