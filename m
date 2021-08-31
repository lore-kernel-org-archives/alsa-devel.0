Return-Path: <SRS0=fy3w=NW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57291C432BE
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Aug 2021 13:20:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78886103D
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Aug 2021 13:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C78886103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB52E171E;
	Tue, 31 Aug 2021 15:19:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB52E171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630416001;
	bh=RQbaYzthx2QuRqkyHiPKLU4KmSR2/JHCyTvyLbnbpg8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Mj0bugZ9h7ramrncWjXZq8wmbBc68ngbzX7bUhGFEWBz5/u8e29+9TzGnTV/NzKD4
	 r48M1Y+5z/MglLC9xmNz0H8x6eZkA6hHP1rQjnUosZzqIFWMwf9xaVKrjP8bH+lz8U
	 ZOScfMhMgnmhBNeoHJ6VM6HwV+ddAHN04thwOrpk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41708F80254;
	Tue, 31 Aug 2021 15:19:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5BED0F8025B; Tue, 31 Aug 2021 15:19:09 +0200 (CEST)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38012F80127
 for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2021 15:19:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38012F80127
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:2193:279a:893d:20ae])
 by xavier.telenet-ops.be with bizsmtp
 id oDJx250061ZidPp01DJx8i; Tue, 31 Aug 2021 15:19:00 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1mL3fE-000rnQ-OW; Tue, 31 Aug 2021 15:18:56 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1mL3fE-000hSM-B9; Tue, 31 Aug 2021 15:18:56 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Trevor Wu <trevor.wu@mediatek.com>
Subject: [PATCH] ASoC: mediatek: SND_SOC_MT8195 should depend on ARCH_MEDIATEK
Date: Tue, 31 Aug 2021 15:18:54 +0200
Message-Id: <7e628e359bde04ceb9ddd74a45931059b4a4623c.1630415860.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

The Mediatek MT8195 sound hardware is only present on Mediatek MT8195
SoCs.  Hence add a dependency on ARCH_MEDIATEK, to prevent asking the
user about this driver when configuring a kernel without Mediatek SoC
support.

Fixes: 6746cc858259985a ("ASoC: mediatek: mt8195: add platform driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index cf567a89f421b4c0..c8c815f599da90bf 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -187,6 +187,7 @@ config SND_SOC_MT8192_MT6359_RT1015_RT5682
 
 config SND_SOC_MT8195
 	tristate "ASoC support for Mediatek MT8195 chip"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select SND_SOC_MEDIATEK
 	help
 	  This adds ASoC platform driver support for Mediatek MT8195 chip
-- 
2.25.1

