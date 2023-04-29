Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D07CC7618E
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Apr 2023 06:04:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0B9E161D;
	Sat, 29 Apr 2023 08:03:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0B9E161D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682748288;
	bh=ipaAx4AKLN5/HcvQPkVO7w6Jurv45LfDmbHt9D5nJME=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=MjwJxOm6YhQGrvCscF8AiHbO3ik3samupK3/FfjC66EPBsMWUyZ/gAGA4e6FrE2Ll
	 FBykIDQxsbVrEYdqOD9r5ugxWba0dSE6MpvYR+ZoMsL8BJl8Y58tRY16OIpOOOIlPG
	 EFqY1WaaaSP6ET835A5JLjpteaoOaOtnXjKzW4wc=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DD409F80104;
	Sat, 29 Apr 2023 08:03:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63CC5F8025E; Sat, 29 Apr 2023 08:02:36 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 30628F80104
	for <alsa-devel@alsa-project.org>; Sat, 29 Apr 2023 08:02:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30628F80104
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T485eIWO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6A8KygD+nWhp85vzQWwODAMm9Ud9p1UZ/7RQ/xwUgJg=; b=T485eIWOUc/qq6c3NgSPOTDFef
	+XtTwdUo7V0foOxGsU++Wken+a+pdPd8eHzK32zyao2DR17WWm21sYLu69akOtTypmuF0G4633nA2
	47amNnQSVSFvgBX3iO4xQHweBnsRBxWwa4sOS92jcu7m48581xt0Q//KkRtWOtxfWFHWuAkye2aAi
	aK+ri2lUN0yuCaa6r1ApPB3SsfWD4xHA2cZp94REUXB12ypjg6cGXaLdV42WRJbqsiVmjPreOEtuU
	WJapkQcy8twKHG9HOT1UqPWdx8Gk9rDZjeJhOdECS8LYtFWlask+Ix7zRdXbki1QuvQqmsbD8WDQb
	3aTGNQ+A==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1psdf0-00CIJ8-2J;
	Sat, 29 Apr 2023 06:02:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl MPC52xx drivers require PPC_BESTCOMM
Date: Fri, 28 Apr 2023 23:02:17 -0700
Message-Id: <20230429060217.2950-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XRLLL4PC653U34JXD4NTGK5D5XIE6TPE
X-Message-ID-Hash: XRLLL4PC653U34JXD4NTGK5D5XIE6TPE
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Randy Dunlap <rdunlap@infradead.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XRLLL4PC653U34JXD4NTGK5D5XIE6TPE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Both SND_MPC52xx_SOC_PCM030 and SND_MPC52xx_SOC_EFIKA select
SND_SOC_MPC5200_AC97. The latter symbol depends on PPC_BESTCOMM,
so the 2 former symbols should also depend on PPC_BESTCOMM since
"select" does not follow any dependency chains.

This prevents a kconfig warning and build errors:

WARNING: unmet direct dependencies detected for SND_SOC_MPC5200_AC97
  Depends on [n]: SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_MPC52xx [=y] && PPC_BESTCOMM [=n]
  Selected by [m]:
  - SND_MPC52xx_SOC_PCM030 [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_MPC5200_SIMPLE [=y]
  - SND_MPC52xx_SOC_EFIKA [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_EFIKA [=y]

ERROR: modpost: "mpc5200_audio_dma_destroy" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!
ERROR: modpost: "mpc5200_audio_dma_create" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!

Fixes: 40d9ec14e7e1 ("ASoC: remove BROKEN from Efika and pcm030 fabric drivers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
---
 sound/soc/fsl/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -243,7 +243,7 @@ config SND_SOC_MPC5200_AC97
 
 config SND_MPC52xx_SOC_PCM030
 	tristate "SoC AC97 Audio support for Phytec pcm030 and WM9712"
-	depends on PPC_MPC5200_SIMPLE
+	depends on PPC_MPC5200_SIMPLE && PPC_BESTCOMM
 	select SND_SOC_MPC5200_AC97
 	select SND_SOC_WM9712
 	help
@@ -252,7 +252,7 @@ config SND_MPC52xx_SOC_PCM030
 
 config SND_MPC52xx_SOC_EFIKA
 	tristate "SoC AC97 Audio support for bbplan Efika and STAC9766"
-	depends on PPC_EFIKA
+	depends on PPC_EFIKA && PPC_BESTCOMM
 	select SND_SOC_MPC5200_AC97
 	select SND_SOC_STAC9766
 	help
