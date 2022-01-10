Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F72C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jan 2022 09:50:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 221B317B3;
	Mon, 10 Jan 2022 10:49:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 221B317B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641808207;
	bh=u0/QazhwAru1ZOtWn7gUMMCW3D667oKJgPNfXlFHklE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ugmntAdpItbdruX7jxyaz9xB6eJOVpUQSy4RGoPWUyyeZJ12iwq70dkxICpvpjh+d
	 ifwKsaQ/SfftfdjWvumhuIN5ksuajRJbwhL8EOfvPcqF240zyXQ/f88RDhSSudU1A7
	 5pmwCVl+UQl7JFYWmSy4KznEuW8fZKICWG40aizU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1CDBF80248;
	Mon, 10 Jan 2022 10:48:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35925F80518; Mon, 10 Jan 2022 10:48:47 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by alsa1.perex.cz (Postfix) with ESMTP id E881CF80134
 for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2022 10:48:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E881CF80134
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000"; d="scan'208";a="106003032"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 18:48:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 160774238CA4;
 Mon, 10 Jan 2022 18:47:57 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 4/5] ASoC: sh: rz-ssi: Make return type of
 rz_ssi_stream_is_valid() to bool
Date: Mon, 10 Jan 2022 09:47:10 +0000
Message-Id: <20220110094711.8574-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: alsa-devel@alsa-project.org, Pavel Machek <pavel@denx.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>
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

rz_ssi_stream_is_valid() never returns an int, it returns the result of
a condition which is either true or false.

While at it, drop "!!" as the expression is boolean.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index fa68d3a0bd62..aabd15e9d515 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -188,14 +188,14 @@ static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
 	return (ssi->playback.dma_ch && (ssi->dma_rt || ssi->capture.dma_ch));
 }
 
-static int rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
-				  struct rz_ssi_stream *strm)
+static bool rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
+				   struct rz_ssi_stream *strm)
 {
 	unsigned long flags;
-	int ret;
+	bool ret;
 
 	spin_lock_irqsave(&ssi->lock, flags);
-	ret = !!(strm->substream && strm->substream->runtime);
+	ret = strm->substream && strm->substream->runtime;
 	spin_unlock_irqrestore(&ssi->lock, flags);
 
 	return ret;
-- 
2.17.1

