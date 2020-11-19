Return-Path: <SRS0=WcGQ=EZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476A1C2D0E4
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 12:54:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C062468B
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 12:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oHaAkBAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C062468B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33BEF16B1;
	Thu, 19 Nov 2020 13:53:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33BEF16B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605790475;
	bh=OLp90CLAnPMHQTe6NVHkWCeq6CeSvYQggnDjo9V4xwY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oHaAkBAM+VjKzKOquPAny5CbfoGextRbgCqcoTS7kXrgIEZk7MR4++jnnHwBcVFkw
	 Dwh5R+bJyPP44ikWXEo8Swvds8tLN5hyEW8XEVHDA1J3ffAJSPupeHaK1VbKNSwJ/3
	 OCdla8+VxAEok4Cc2P1Rx1VWYvdNS8s+qzxzmto4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B873AF80169;
	Thu, 19 Nov 2020 13:53:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1159DF801ED; Thu, 19 Nov 2020 13:53:34 +0100 (CET)
Received: from albert.telenet-ops.be (albert.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:1a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D18EDF800C5
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2020 13:53:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D18EDF800C5
Received: from ramsan.of.borg ([84.195.186.194])
 by albert.telenet-ops.be with bizsmtp
 id uCtL2300B4C55Sk06CtLs6; Thu, 19 Nov 2020 13:53:20 +0100
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1kfjRA-003pry-4m; Thu, 19 Nov 2020 13:53:20 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1kfjR9-00H3nI-FO; Thu, 19 Nov 2020 13:53:19 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: fsi: Stop using __raw_*() I/O accessors
Date: Thu, 19 Nov 2020 13:53:18 +0100
Message-Id: <20201119125318.4066097-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>
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

There is no reason to keep on using the __raw_{read,write}l() I/O
accessors in Renesas ARM or SuperH driver code.  Switch to using the
plain {read,write}l() I/O accessors, to have a chance that this works on
big-endian.

Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Assembler output difference on SuperH checked.
---
 sound/soc/sh/fsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 3c574792231bc5c3..518d4b0c4b8b99fa 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -313,12 +313,12 @@ static void __fsi_reg_write(u32 __iomem *reg, u32 data)
 	/* valid data area is 24bit */
 	data &= 0x00ffffff;
 
-	__raw_writel(data, reg);
+	writel(data, reg);
 }
 
 static u32 __fsi_reg_read(u32 __iomem *reg)
 {
-	return __raw_readl(reg);
+	return readl(reg);
 }
 
 static void __fsi_reg_mask_set(u32 __iomem *reg, u32 mask, u32 data)
-- 
2.25.1

