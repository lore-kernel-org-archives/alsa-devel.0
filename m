Return-Path: <SRS0=YQ6z=GC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99722C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Dec 2020 15:45:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6A721D1B
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Dec 2020 15:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6A721D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 581971833;
	Wed, 30 Dec 2020 16:44:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 581971833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609343097;
	bh=Dr9mLOW7dfuWMVS7lwdbQQhz8bsyb9ZknSWmQdtAQ50=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HPUMDjHtpa0OEQvJCkgvRcbXHoLStaOp8u+R5VGEB5py+yVfveCSz260T0L4CMNXn
	 veDmQKX3nZRYHmfwyb8LS0PzXyFsnTY8OsRmwlEORMSxJQrOD2jZz02McJohIiznYI
	 1aNVL/9VASfZzl+Djr3XPO3so47WxULM5p0AgA0Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C171CF80132;
	Wed, 30 Dec 2020 16:44:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26A63F801F5; Wed, 30 Dec 2020 16:44:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48C72F80132
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2020 16:43:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48C72F80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pBY3tylF"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4871021D1B;
 Wed, 30 Dec 2020 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609343030;
 bh=Dr9mLOW7dfuWMVS7lwdbQQhz8bsyb9ZknSWmQdtAQ50=;
 h=From:To:Cc:Subject:Date:From;
 b=pBY3tylFQvxqVhAaPPVFQMbq7vsGkynLjJ2rQxOAB0mcU8ct4N5wvdsEVCAttFypy
 AGsSpDqAV1abFnbgf/XgfjTmDMsiJocZolFIeb7Pro1rrDYC+kbsDYeM/DdrwAGnIK
 2D6uD0J6nWDcWRKXoNsikkmhiHoq8/d8hGlsgerxei3aSMwH9oPNMVIiU3x4z/JcJa
 71rrsftnWPirApCsts7sp889RZg8H3VkWoSn3q727UQIqDeOkrnhQcEmUavGxM6eT6
 KATY5Cu2nnu03RLafpxYqiJPFbiiDe2sja1nLRpUSCK/k3hPHE3G1Mb8MLQBPqspjC
 R0SMwOgQppTdg==
From: Arnd Bergmann <arnd@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] ASoC: mediatek: add MTK_PMIC_WRAP dependency
Date: Wed, 30 Dec 2020 16:43:34 +0100
Message-Id: <20201230154345.639122-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, Tzung-Bi Shih <tzungbi@google.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

Randconfig builds often show harmless warnings like

WARNING: unmet direct dependencies detected for SND_SOC_MT6359
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && MTK_PMIC_WRAP [=n]
  Selected by [y]:
  - SND_SOC_MT8192_MT6359_RT1015_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8192 [=y]

Add a dependency to avoid that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 8d3dcfb6a580..effdb76369e4 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -172,7 +172,7 @@ config SND_SOC_MT8192
 config SND_SOC_MT8192_MT6359_RT1015_RT5682
 	tristate "ASoC Audio driver for MT8192 with MT6359 RT1015 RT5682 codec"
 	depends on I2C
-	depends on SND_SOC_MT8192
+	depends on SND_SOC_MT8192 && MTK_PMIC_WRAP
 	select SND_SOC_MT6359
 	select SND_SOC_RT1015
 	select SND_SOC_RT1015P
-- 
2.29.2

