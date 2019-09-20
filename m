Return-Path: <SRS0=YPxo=XP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC95C49ED7
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:51:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4219207E0
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aJ2piY5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4219207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B7FE166D;
	Fri, 20 Sep 2019 09:51:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B7FE166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568965913;
	bh=mmLUKcWJBA5daQSCwnDGeFIHpjXvuK+XPDmEgidzKak=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aJ2piY5gwgdwkS5zDah9OuDHP7eaURGQ3qdgqaOgh5XRKoaBb84G5Rj8PHUcPktqN
	 nTI92+3lHDfHfLNi+lEAFzNx6HKkjanphNQsviXoh9r0razELlP1hvL9pgw48bHLsC
	 N5cWess3ER1ObIIK0dSxhQh87Qjp452cGnjkjKqQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14BFEF804FF;
	Fri, 20 Sep 2019 09:51:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9E5EF80506; Fri, 20 Sep 2019 09:51:00 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56781F80096
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2019 09:50:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56781F80096
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M4K2r-1iBUnx2Whd-000HEj; Fri, 20 Sep 2019 09:50:48 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Mark Brown <broonie@kernel.org>
Date: Fri, 20 Sep 2019 09:50:18 +0200
Message-Id: <20190920075046.3210393-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:EAKPTZ+itukL2iznqTUk5rPIMXBlBv9PWcQDjxKpT9O//vnk5gh
 rAOyC8URZPiUfTgkKlxvXoVXPAwpUOUyBc0xu0jumnINBPwIcw5VCV1whnDmt15T78vaj+V
 KZBJvmieL310Wovz0k/cDx/thz7NXU/w31Vz4vpXtYosVVoU55dDg6Sm1k/LOvm4G84/dYT
 tJTF76m7Jh3v+6ff4FffA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pklhRZ2wyO4=:XKxLr9F1esW2k/1CYBwAZ1
 p6hU9OeU8jh6CmeIfSMgqs3GHdq17Y9JtBjCI54ia/904VPOE/xlrlfqufyoXbA2kdrJgmzxH
 sUOpcfn86X0zl1zGbd4rWbzgZ8sAaDA+bCVQsVKPn4jTwvkf54irU3EYvaHr7O5DPlYcn1jPE
 sqTlgeoGzmwIAsMiNYAHDhnd2HsogtybRZwkL307fcfIktlVFnDX/lWSsUQ1ivP6swjA2mzB+
 8LXTwspTBe5slOJELG1qo0uHoluy6sQFZcEp/AEKLwfwevC+dCfijD87ElENqhBFDbZG9E7np
 Sm5u845gRCukKCEiv9MoavuuTZLjLyqNuLWUBkH2WdaJd6bb4zdHZ1i9A5zWoeBtMlPzzkPTJ
 U3SDT0f9r0a0Wlb+DS8d7Z+QD3wSyUBOYzyJdtut/kOPdPMwRCOqremPdwCIs3T8BdO/4N1Ik
 9U525jwIbditIYdpvm+LfxVqNPfIqKpu8Yh2DYVvvap9NLDkORv0Sm21lrD5Y90cOV7UK71F+
 3DMvCH9YwvE50r6K1BvcuQLG0zJ8GFzxVSVCE2foMyOQU/dUk9u+5D2mIxhPJ3/6FsUZI93J4
 pttyejLqRP6Up5O/Vjv50dSljBxAwXkOyFHsvruHsHp9Vwx+SoAjhuBebch0iHZc0ZltlABEf
 nGoHWubqzFGasR1GTGiBMuiyo4nlaL/bq8l942kUgP3nFH+bLKC5lFtmH7EyNhvEaN+V35URq
 GSSNJbJK+6VgT3M32QcNabqLLHbtjkjf6R7n7bWJud2XwngeE9BWsfxv5lYgtX8sAEhwGkvPr
 94/qfrrwSsPKRE3wXXnGYXgyoRHPCBtZrSQ5CuXzEFR4osEHZGUGJaYtE0yrZAql+ifRz3zsQ
 eWcZ83+5KHTe4qoG+ouQ==
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [alsa-devel] [PATCH] ASoC: ti: fix SND_SOC_DM365_VOICE_CODEC
	dependencies
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

SND_SOC_DM365_VOICE_CODEC is a 'bool' option in a choice statement,
meaning it cannot be set to =m, but it selects two other drivers
that we may want to be loadable modules after all:

WARNING: unmet direct dependencies detected for SND_SOC_CQ0093VC
  Depends on [m]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
  Selected by [y]:
  - SND_SOC_DM365_VOICE_CODEC [=y] && <choice>
  Selected by [m]:
  - SND_SOC_ALL_CODECS [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMPILE_TEST [=y]

Add an intermediate symbol that sets SND_SOC_CQ0093VC and
MFD_DAVINCI_VOICECODEC to =m if SND_SOC=m.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/ti/Kconfig | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 87a9b9dd4e98..29f61053ab62 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -200,11 +200,18 @@ config SND_SOC_DM365_AIC3X_CODEC
 
 config SND_SOC_DM365_VOICE_CODEC
 	bool "Voice Codec - CQ93VC"
-	select MFD_DAVINCI_VOICECODEC
-	select SND_SOC_CQ0093VC
 	help
 	  Say Y if you want to add support for SoC On-chip voice codec
 endchoice
 
+config SND_SOC_DM365_VOICE_CODEC_MODULE
+	def_tristate y
+	depends on SND_SOC_DM365_VOICE_CODEC && SND_SOC
+	select MFD_DAVINCI_VOICECODEC
+	select SND_SOC_CQ0093VC
+	help
+	  The is an internal symbol needed to ensure that the codec
+	  and MFD driver can be built as loadable modules if necessary.
+
 endmenu
 
-- 
2.20.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
