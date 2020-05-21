Return-Path: <SRS0=D4yB=7D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE0DC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 May 2020 18:55:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBD320872
	for <alsa-devel@archiver.kernel.org>; Thu, 21 May 2020 18:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QWbrDE4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBD320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4EB21864;
	Thu, 21 May 2020 20:54:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4EB21864
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590087314;
	bh=pJSlNJHUNqhJSgYnvDL6tC3+iYTvXJJEwyFIG7oqVLQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QWbrDE4CgQRotECpVAsOFq8Fbl7YiHEZTEHQA1nBr33Wpw2mjY/TELZORU8WYXsKu
	 uc8SrEI38AqnyLt+S/C9gHguzbe3OUz0i/91RmB0NxMHPvFzaoeWA0xjiMWNJ1/6gz
	 sDptX0tXGH8yqdPq7AJlJnvLRBfRdfr+I5fGa3zA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25649F80299;
	Thu, 21 May 2020 20:52:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DD1CF8029A; Thu, 21 May 2020 20:52:43 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr
 [80.12.242.127])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82598F801D8
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2020 20:52:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82598F801D8
Received: from belgarion.home ([86.210.245.36]) by mwinf5d28 with ME
 id hWsG220030nqnCN03WsXKi; Thu, 21 May 2020 20:52:32 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 21 May 2020 20:52:32 +0200
X-ME-IP: 86.210.245.36
From: Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: <soc.lore.kernel.org>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 soc@kernel.org
Subject: [PATCH v3 3/3] ASoC: pxa: remove Compulab pxa2xx boards
Date: Thu, 21 May 2020 20:51:39 +0200
Message-Id: <20200521185140.27276-3-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521185140.27276-1-robert.jarzmik@free.fr>
References: <20200521185140.27276-1-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
 Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
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

As these boards have been removed from the pxa tree, amend accordingly
the sound subsystem.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Mike Rapoport <rppt@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index d4c0f580a565..fb2d5ab02b0d 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -128,9 +128,8 @@ config SND_PXA2XX_SOC_E800
 	  Toshiba e800 PDA
 
 config SND_PXA2XX_SOC_EM_X270
-	tristate "SoC Audio support for CompuLab EM-x270, eXeda and CM-X300"
-	depends on SND_PXA2XX_SOC && (MACH_EM_X270 || MACH_EXEDA || \
-			MACH_CM_X300)
+	tristate "SoC Audio support for CompuLab CM-X300"
+	depends on SND_PXA2XX_SOC && MACH_CM_X300
 	depends on AC97_BUS=n
 	select REGMAP
 	select AC97_BUS_NEW
-- 
2.26.2

