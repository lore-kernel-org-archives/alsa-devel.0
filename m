Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5D7C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 07:50:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43D611893;
	Tue, 26 Apr 2022 09:50:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43D611893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650959451;
	bh=R1XAnQT8qMS6TBH04xhnpbmYjdmM6pvxXwAg/V5ztbg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AYXPeg1alD+mP2dEt0RzQqGbVqRUHwAQQdMknFzgovZXsiqtlCyt6AssoSG82n/pb
	 +n8wuS7WrKQydSAwSPpcHIXLZ/fyqAIuIg6M9Lk8vwfGEzxgvt5u+7/XYAPbhsMnwC
	 ANFEMYAHkRU/tmiic9p9pZqkXBhIjPaJMbGzR9PI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB49AF80171;
	Tue, 26 Apr 2022 09:50:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8DE7F80171; Tue, 26 Apr 2022 09:49:58 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 0DBFFF80105
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 09:49:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DBFFF80105
X-IronPort-AV: E=Sophos;i="5.90,290,1643641200"; d="scan'208";a="119189518"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 26 Apr 2022 16:49:48 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id DB0624248B14;
 Tue, 26 Apr 2022 16:49:44 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH v2 0/3] ASoC: sh: rz-ssi: Trivial fixes
Date: Tue, 26 Apr 2022 08:49:19 +0100
Message-Id: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@denx.de>,
 linux-kernel@vger.kernel.org,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
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

This patch series aims to fix trivial issues found in rz-ssi driver.

Cheers,
Prabhakar

v1->v2:
* Updated patch description for patch 1/3
* Patch 2/3 unchanged
* For patch 3/3 dropped devers action and instead called
  rz_ssi_release_dma_channels() in the error path.

v1:
https://patchwork.kernel.org/project/linux-renesas-soc/cover/
20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Lad Prabhakar (3):
  ASoC: sh: rz-ssi: Drop SSIFSR_TDC and SSIFSR_RDC macros
  ASoC: sh: rz-ssi: Propagate error codes returned from
    platform_get_irq_byname()
  ASoC: sh: rz-ssi: Release the DMA channels in rz_ssi_probe() error
    path

 sound/soc/sh/rz-ssi.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
2.25.1

