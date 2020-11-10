Return-Path: <SRS0=3oRA=EQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C228DC388F7
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 14:52:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79C2206B2
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 14:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ouzQrb0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79C2206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C2901724;
	Tue, 10 Nov 2020 15:51:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C2901724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605019946;
	bh=cusRnK0uqu/AecyixywBeWegSpoEhpKEw0kjxV8e5Gs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ouzQrb0WXNrqAvsd8pYtrM6xxepps8XW1yivvKymKo4FZg1TVzIpawk2WJqArEzYn
	 nI4JPs8EaOONqa7cruMHIs7RzAkMetD3aONDt7hlF2LM+nnChx3cjiH66lSWry/9s/
	 TPDTMejmTOIP+3f0nE30EBTNKZeHXXM1ZGO+T5QM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE776F801EB;
	Tue, 10 Nov 2020 15:51:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6A57F80059; Tue, 10 Nov 2020 15:51:33 +0100 (CET)
Received: from albert.telenet-ops.be (albert.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:1a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53CD7F80059
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 15:51:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53CD7F80059
Received: from ramsan.of.borg ([84.195.186.194])
 by albert.telenet-ops.be with bizsmtp
 id qerN2300Q4C55Sk06erNwy; Tue, 10 Nov 2020 15:51:22 +0100
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1kcUzS-001CZj-9Z; Tue, 10 Nov 2020 15:51:22 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1kcUzR-00DlSc-TP; Tue, 10 Nov 2020 15:51:21 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH] ASoC: fsl: SND_SOC_FSL_AUD2HTX should depend on ARCH_MXC
Date: Tue, 10 Nov 2020 15:51:20 +0100
Message-Id: <20201110145120.3280658-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

The Freescale/NXP AUDIO TO HDMI TX module is only present on NXP i.MX 8
Series SoCs.  Hence add a dependency on ARCH_MXC, to prevent asking the
user about this driver when configuring a kernel without i.MX 8 platform
support.

Fixes: 8a24c834c053ef1b ("ASoC: fsl_aud2htx: Add aud2htx module driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 52a5622150088b49..ad9f90d314b7a033 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -107,6 +107,7 @@ config SND_SOC_FSL_XCVR
 
 config SND_SOC_FSL_AUD2HTX
 	tristate "AUDIO TO HDMI TX module support"
+	depends on CONFIG_ARCH_MXC || COMPILE_TEST
 	help
 	  Say Y if you want to add AUDIO TO HDMI TX support for NXP.
 
-- 
2.25.1

