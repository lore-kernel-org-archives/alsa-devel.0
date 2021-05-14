Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2026EC43461
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 21:33:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631F46145A
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 21:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631F46145A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 359D9172E;
	Fri, 14 May 2021 23:32:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 359D9172E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621027991;
	bh=4L4mcKVn3lkbqXEEkhEsQV92HBC1CPOXzYICTb92p2Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U3H0lU3e2K094MeldUnyol5Ih7LQBG2kVp16iLQfFA66F6sYADpBKOE2VEeCnq4Dn
	 ENBSlGTv7IOQFb9ItifIAM24TqspotvDupuGtMWJJAjzx1mdESZ1MjeYPvA+IAfQ7s
	 xkpdtiQ+DFjoVfFGfMIjyw8xVAlkIdvgFOL+VY8g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BED65F8020C;
	Fri, 14 May 2021 23:32:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A075F80240; Fri, 14 May 2021 23:32:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3260DF800BF
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 23:32:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3260DF800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JpuFugNG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 905B66143F;
 Fri, 14 May 2021 21:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621027929;
 bh=4L4mcKVn3lkbqXEEkhEsQV92HBC1CPOXzYICTb92p2Y=;
 h=From:To:Cc:Subject:Date:From;
 b=JpuFugNGtCnfLnbuSbD6CYvS9tqG7bcN2jo/Rzbn/NVrHpOOWL7eV0QAY28Wxe03K
 12BtzI6hEX+yVdfs7SDSFprIQ4WsWbty/nHjnLJP5jrSWHWeIux++zfG4EC1yV+XO1
 q+xp/qqE1d/sp622ccn1qu/941nWsAIaPjp8itRWGUOkr9WAuah0cIRllwQTbQCnZp
 ozBSoCKp+ZVx6e+ASRN7jsYuZL1I5N18jsrQ4RdzRvfnpJ27qo0639AKPl76HuOT3q
 ZiA1LF4H3iOkY3dPOCd7TmEXgnMfiyvnXk9a7pBFkUEJxRU34qT05AfFNeDm556Bph
 kD+ZQlgrBsncQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: fsl: fix SND_SOC_IMX_RPMSG dependency
Date: Fri, 14 May 2021 23:31:14 +0200
Message-Id: <20210514213118.630427-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Arnd Bergmann <arnd@arndb.de>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
 Viorel Suman <viorel.suman@nxp.com>, Fabio Estevam <festevam@gmail.com>
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

Kconfig produces a warning with SND_SOC_FSL_RPMSG=y and SND_IMX_SOC=m:

WARNING: unmet direct dependencies detected for SND_SOC_IMX_RPMSG
  Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_IMX_SOC [=m] && RPMSG [=y]
  Selected by [y]:
  - SND_SOC_FSL_RPMSG [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && COMMON_CLK [=y] && RPMSG [=y] && SND_IMX_SOC [=m]!=n

Add a dependency to prevent this configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 0917d65d6921..556c284f49dd 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -119,6 +119,7 @@ config SND_SOC_FSL_RPMSG
 	tristate "NXP Audio Base On RPMSG support"
 	depends on COMMON_CLK
 	depends on RPMSG
+	depends on SND_IMX_SOC || SND_IMX_SOC = n
 	select SND_SOC_IMX_RPMSG if SND_IMX_SOC != n
 	help
 	  Say Y if you want to add rpmsg audio support for the Freescale CPUs.
-- 
2.29.2

