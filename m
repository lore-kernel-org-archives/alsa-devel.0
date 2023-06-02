Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C375C7EE24
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jun 2023 12:46:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F7C720C;
	Fri,  2 Jun 2023 14:45:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F7C720C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685709982;
	bh=McQIwyw8ISVxlP2qAhRRv+FXFr6OUy8H+OaWYCPsDmw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CCMwlAhWx5UKqzeLFV1ub+muCPWNLkj27Mw1xCR6pSPMHheRN2CHAFyO2V5oHe+EJ
	 hvgCHsQtCbWz5bOX3ydPBQSDenzHy2v26kr3ysbmyYzMI/6u7LQo2K1Hp4ZHfM6yfv
	 oefi2UXvnUzpXyvFFD27U8X67nrHEKu6DzW005yU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0EFCF804DA; Fri,  2 Jun 2023 14:45:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A5F8F80199;
	Fri,  2 Jun 2023 14:45:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 32D15F80149; Fri,  2 Jun 2023 14:45:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 221D3F800ED
	for <alsa-devel@alsa-project.org>; Fri,  2 Jun 2023 14:44:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 221D3F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=btkguOVO
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E6622616D1;
	Fri,  2 Jun 2023 12:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B06C433EF;
	Fri,  2 Jun 2023 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685709894;
	bh=McQIwyw8ISVxlP2qAhRRv+FXFr6OUy8H+OaWYCPsDmw=;
	h=From:To:Cc:Subject:Date:From;
	b=btkguOVOSVVPudv8jF3nxyiecgErSnv3Ek3cBd2OZRehnzwYHjkFDCnTr+w8sGyCz
	 H1xkmzQyBLIRldZ6KpcqCmPfjJflOMM8irt6dCHLu4fdPczqi0g7XoJOPk7ovRKMm/
	 ksEyW5zQbizKPTy29woFmDgYx8DAkhh6z+Nywo/ifUCv+0ljwKgtSWvUlUTGV+CqBL
	 GgEie5i2XMC4/CdwQK0Xa2OzPh4f+CvSqqPExN7o4+XHE3g7CaNOQILkVpeR8RJiNf
	 lo57kd/rOPMs2OWB69nx3oXT9PhX+mrLOgSkazGl8gwO9k+YsbEhIsaOGjaM+UnwVA
	 oqmVgrtx6hjLg==
From: Arnd Bergmann <arnd@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG
Date: Fri,  2 Jun 2023 14:44:39 +0200
Message-Id: <20230602124447.863476-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YCZLSMIO57V2SYT2XKRBQAX56QGLKHEN
X-Message-ID-Hash: YCZLSMIO57V2SYT2XKRBQAX56QGLKHEN
X-MailFrom: arnd@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YCZLSMIO57V2SYT2XKRBQAX56QGLKHEN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Arnd Bergmann <arnd@arndb.de>

The vangogh driver just gained a link time dependency that now causes
randconfig builds to fail:

x86_64-linux-ld: sound/soc/amd/vangogh/pci-acp5x.o: in function `snd_acp5x_probe':
pci-acp5x.c:(.text+0xbb): undefined reference to `snd_amd_acp_find_config'

Fixes: e89f45edb747e ("ASoC: amd: vangogh: Add check for acp config flags in vangogh platform")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 08e42082f5e96..e724cb3c70b74 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -81,6 +81,7 @@ config SND_SOC_AMD_VANGOGH_MACH
 	tristate "AMD Vangogh support for NAU8821 CS35L41"
 	select SND_SOC_NAU8821
 	select SND_SOC_CS35L41_SPI
+	select SND_AMD_ACP_CONFIG
 	depends on SND_SOC_AMD_ACP5x && I2C && SPI_MASTER
 	help
 	  This option enables machine driver for Vangogh platform
-- 
2.39.2

