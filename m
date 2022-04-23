Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF91C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Apr 2022 16:45:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2111B16FA;
	Sat, 23 Apr 2022 18:45:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2111B16FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650732357;
	bh=s5+O362q0LmfZoNHw6C94dA5Qf3vkbC/AJsySBS/pAM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C9DaKIxVxII6La02RZvoAC0T2J/q4VFw+6jFbs+QVcdVNeeQObLJbpyUjHbYyRD2Q
	 E8z7DofySj5OiycilWTNmnyTG+90KRTCrRmFAzWhqweRcjTQm8+AX7hGvLzScm9kME
	 jAgG93UYPJirAmSBcdsmdWCXrqvQGl59IklGAmVc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AB5FF80109;
	Sat, 23 Apr 2022 18:45:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 992F1F80248; Sat, 23 Apr 2022 18:45:03 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id B0EDFF80109
 for <alsa-devel@alsa-project.org>; Sat, 23 Apr 2022 18:44:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0EDFF80109
X-IronPort-AV: E=Sophos;i="5.90,284,1643641200"; d="scan'208";a="118915064"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2022 01:44:49 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 96AAE40071E4;
 Sun, 24 Apr 2022 01:44:46 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: sh: Make SND_SOC_RZ depend on ARCH_RZG2L
Date: Sat, 23 Apr 2022 17:44:43 +0100
Message-Id: <20220423164443.146299-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Biju Das <biju.das@bp.renesas.com>
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

The SSI block is identical on Renesas RZ/G2L, RZ/G2UL and RZ/V2L SoC's, so
instead of adding dependency for each SoC's add dependency on ARCH_RZG2L.
The ARCH_RZG2L config option is already selected by ARCH_R9A07G043,
ARCH_R9A07G044 and ARCH_R9A07G054.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index ae46f187cc2a..97916e3ca9dd 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -47,7 +47,7 @@ config SND_SOC_RCAR
 
 config SND_SOC_RZ
 	tristate "RZ/G2L series SSIF-2 support"
-	depends on ARCH_R9A07G044 || COMPILE_TEST
+	depends on ARCH_RZG2L || COMPILE_TEST
 	help
 	  This option enables RZ/G2L SSIF-2 sound support.
 
-- 
2.25.1

