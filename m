Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4EEC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 20:37:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D2B7172E;
	Thu, 21 Apr 2022 22:36:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D2B7172E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650573452;
	bh=We/qwK8hWYBV0kdEkXOl6CGsfzRXf4NR7FSlS6p1tk8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Wwm/xItAQ+bsDaYw7m/XqV62BUImcrOKEx1wOjcgmKs50HLoMRj+jQgzeB9le/jsY
	 fr6E7gepdwKIsWhicF8aFQ0Jicf092L2TmKYGYcfTrPM6lir5Su0gA2sABlOtV0qXa
	 Zm1nKx8VWp1N3GyTyAeApJ2oMzCLxxtWKhXZxgzg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC856F804FD;
	Thu, 21 Apr 2022 22:36:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF773F804FB; Thu, 21 Apr 2022 22:36:33 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by alsa1.perex.cz (Postfix) with ESMTP id CF7CFF80125
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 22:36:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF7CFF80125
X-IronPort-AV: E=Sophos;i="5.90,279,1643641200"; d="scan'208";a="117601856"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 22 Apr 2022 05:36:23 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9AC5A40197A6;
 Fri, 22 Apr 2022 05:36:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: sh: rz-ssi: Trivial fixes
Date: Thu, 21 Apr 2022 21:35:52 +0100
Message-Id: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Cc: Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
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

Lad Prabhakar (3):
  ASoC: sh: rz-ssi: Drop unused macros
  ASoC: sh: rz-ssi: Propagate error codes returned from
    platform_get_irq_byname()
  ASoC: sh: rz-ssi: Add a devres action to release the DMA channels

 sound/soc/sh/rz-ssi.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.17.1

