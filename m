Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ECAC001DF
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Aug 2023 03:01:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48B04DE;
	Thu,  3 Aug 2023 05:00:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48B04DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691031703;
	bh=mp4/SnB2HGxNNmLofSpDfCRV10WQj8BqBB1augGOWc8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=a284l9MMLk8wZiyHigIDKipz0fNqm+EA/12HVfggRm5XdNQU2jVIiZoltjKEW2wZl
	 EXCCcYxWheSAUD9Q7MHs3oBZhLx9e7bvPaSVCmsl/7pglEfrPMJ0/1cgPMnSVvwcyN
	 htAADpPbA+Z8dEGe2tPjnduJI1ejitdTuey9Ye5s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA951F80535; Thu,  3 Aug 2023 05:00:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A7060F8025A;
	Thu,  3 Aug 2023 05:00:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD644F8025A; Thu,  3 Aug 2023 05:00:08 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 36F1DF80087
	for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2023 04:59:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36F1DF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dv1aBM6w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=V34U8x+xt3cNOs6Hq3uSEoa9SGtAD0arB4vReWdva5o=; b=dv1aBM6wBmGZQ7hPRqWmxgrOQB
	dy+FQT81UfT7eaeA7UyeRmzxBzRfo8x27SdpCBn3zFfXgYZvuohELngmC3zTk57Nfhdm93vDWMty7
	lNn2rxu1wYKvLhjEPsgPwtiTfz7HeZZM15eNYIEOXLe5f58jfb99cJmduUdq0htWWnA/ZXBo+6ZTZ
	4zdBA6M1upafxG+rKFlDETJgCv4LWBW369cleIp8sGx1ed/0uo3teEOdc7x1Lh0+iAPpsSKmqsrDO
	5tJYaIFpNuzPJGT7D3VhITvnqCm26O9R969JuFNS3vGBkUkfTVjE/XRwzLq5GLBPKD8mcn7uwuWNL
	Yuj0BP9Q==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qROZ0-006Ve1-0D;
	Thu, 03 Aug 2023 02:59:46 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 RESEND*3] ASoC: fsl MPC52xx drivers require PPC_BESTCOMM
Date: Wed,  2 Aug 2023 19:59:41 -0700
Message-ID: <20230803025941.24157-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: E2IE7CY52MADCYHLGYVO7DG7ULPYNRO3
X-Message-ID-Hash: E2IE7CY52MADCYHLGYVO7DG7ULPYNRO3
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E2IE7CY52MADCYHLGYVO7DG7ULPYNRO3/>
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
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
---
v2: use correct email address for Mark Brown.

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
