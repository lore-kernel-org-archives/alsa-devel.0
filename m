Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAE6C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jan 2022 13:27:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AEDC1AE8;
	Tue, 25 Jan 2022 14:26:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AEDC1AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643117242;
	bh=uZ8eS2l3cOo1RFtRekulJSBnSzGVAdHcEp1eHwVKFvQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MBnzzPbd7IdI7DZBE5Xz7MzDynhqJI9nCgnmBfgKzTYER4GX9CmLVOpNlyAm2OJr1
	 KpIurL00tcXIHITFIabI0bZpYoyayIK+JrQENiRHJvyhmFpaT7Quye/YvO7QLbykc/
	 D/seuGgRqv0fnABzvPInOKfVs7+uvA/+7+a9XrxE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3FBAF80511;
	Tue, 25 Jan 2022 14:25:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69468F804FE; Tue, 25 Jan 2022 14:25:30 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by alsa1.perex.cz (Postfix) with ESMTP id 1352DF80169
 for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2022 14:25:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1352DF80169
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; d="scan'208";a="107606153"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 25 Jan 2022 22:25:19 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6E0784295950;
 Tue, 25 Jan 2022 22:25:17 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, Pavel Machek <pavel@denx.de>
Subject: [PATCH 3/3] ASoC: sh: rz-ssi: Remove duplicate macros
Date: Tue, 25 Jan 2022 13:24:57 +0000
Message-Id: <20220125132457.14984-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125132457.14984-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220125132457.14984-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Prabhakar <prabhakar.csengg@gmail.com>, linux-kernel@vger.kernel.org,
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

Remove SSICR_MST and SSICR_CKDV macros which are defined more than once.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 1a46c9f3c4e5..e8edaed05d4c 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -28,8 +28,6 @@
 /* SSI REGISTER BITS */
 #define SSICR_DWL(x)		(((x) & 0x7) << 19)
 #define SSICR_SWL(x)		(((x) & 0x7) << 16)
-#define SSICR_MST		BIT(14)
-#define SSICR_CKDV(x)		(((x) & 0xf) << 4)
 
 #define SSICR_CKS		BIT(30)
 #define SSICR_TUIEN		BIT(29)
-- 
2.17.1

