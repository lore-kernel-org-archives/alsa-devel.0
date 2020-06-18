Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6B7C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:11:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196BC20EDD
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LQibdAA4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5Zl3YYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196BC20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF7411689;
	Thu, 18 Jun 2020 03:11:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF7411689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592442716;
	bh=mmt5ndiFij10gOStOvriPpqYvAFtLsVIaRIzJBlMHF8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LQibdAA47Fq7a0WK5abuweEIupSQBv1bdnqhySJjgL/yHBXRIvFWR5SlZ9lnRj8Yp
	 QCTDGTO2D9/GFUS0REkSWGQgR73nOZ5aEJ/IaY1WnV2A+l/3pDXNkr80ksfeQpKFYY
	 WM9gj0jnxiVrQ6YYzE+Sd3/mjMfp4hPL3bonzU1A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A63C9F802E1;
	Thu, 18 Jun 2020 03:08:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B6750F802E2; Thu, 18 Jun 2020 03:08:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B604F802C4
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 03:08:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B604F802C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="t5Zl3YYt"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E22221D7E;
 Thu, 18 Jun 2020 01:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592442513;
 bh=mmt5ndiFij10gOStOvriPpqYvAFtLsVIaRIzJBlMHF8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t5Zl3YYtDAtqIg5Bp60iwr1hbdnPKb+bwg7S7LOuaR0s+WbQxhoCWosEX+xeQFcYq
 qAKg1OsG5zG/FicEoZFaVUjFGNC+CWMb9gpII5TtCnW/YyDe8Cv80eHRSx9rY64FIO
 jI/jBwyO6+PsPdcgAfuiwI62Ua2FMlE0lAB8a+qo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 020/388] ASoC: codecs: wm97xx: fix ac97 dependency
Date: Wed, 17 Jun 2020 21:01:57 -0400
Message-Id: <20200618010805.600873-20-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, Arnd Bergmann <arnd@arndb.de>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit ee2cbe06935bfa58f1fe07dc2a2283945f4b97dc ]

A recent build fix got the dependency slightly wrong, breaking
builds with CONFIG_AC97_BUS_NEW:

WARNING: unmet direct dependencies detected for SND_SOC_WM9713
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AC97_BUS [=n]
  Selected by [m]:
  - SND_SOC_ZYLONITE [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_PXA2XX_SOC [=m] && MACH_ZYLONITE [=y] && AC97_BUS [=n]=n

WARNING: unmet direct dependencies detected for SND_SOC_WM9712
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AC97_BUS [=n]
  Selected by [m]:
  - SND_PXA2XX_SOC_EM_X270 [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_PXA2XX_SOC [=m] && (MACH_EM_X270 [=n] || MACH_EXEDA [=n] || MACH_CM_X300 [=y]) && AC97_BUS [=n]=n

Change the dependency to allow either version of the AC97 library
code.

Fixes: 5a309875787d ("ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200428212721.2877627-1-arnd@arndb.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e60e0b6a689c..8cdc68c141dc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1620,19 +1620,19 @@ config SND_SOC_WM9090
 
 config SND_SOC_WM9705
 	tristate
-	depends on SND_SOC_AC97_BUS
+	depends on SND_SOC_AC97_BUS || AC97_BUS_NEW
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9712
 	tristate
-	depends on SND_SOC_AC97_BUS
+	depends on SND_SOC_AC97_BUS || AC97_BUS_NEW
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9713
 	tristate
-	depends on SND_SOC_AC97_BUS
+	depends on SND_SOC_AC97_BUS || AC97_BUS_NEW
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
-- 
2.25.1

