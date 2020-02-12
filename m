Return-Path: <SRS0=nhcg=4A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C3C2BA83
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:59:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527D12082F
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ma9fvjLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527D12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1FD91686;
	Wed, 12 Feb 2020 15:58:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1FD91686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581519571;
	bh=MU+sg0AouHEolomRkjgnl0sR+yQ0IAPJ4BQ4oONDc5I=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ma9fvjLcuunAxzPDa6lBoRMHEzCau5j7YeiyJ2OTPl/2FUP47GnH1K29ZBnnZFWXW
	 jZRFpezuTQrIBAEcJRpevE9W2RS4o7g7wsaIs2rkiHA1z00lIcpWiqPpm6J9k7giE5
	 GDO9AU/80UeO7oXx5JGYyEFXo1Yu1NS4o8hKjuQg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4754F8025E;
	Wed, 12 Feb 2020 15:57:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B44EEF80276; Wed, 12 Feb 2020 15:57:06 +0100 (CET)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AA6DF80125
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 15:57:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AA6DF80125
Received: from ramsan ([84.195.182.253])
 by baptiste.telenet-ops.be with bizsmtp
 id 1qwu2200V5USYZQ01qwuij; Wed, 12 Feb 2020 15:57:02 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1j1tRe-0004yt-OW; Wed, 12 Feb 2020 15:56:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1j1tRe-0001Dk-NQ; Wed, 12 Feb 2020 15:56:54 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 12 Feb 2020 15:56:50 +0100
Message-Id: <20200212145650.4602-4-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212145650.4602-1-geert@linux-m68k.org>
References: <20200212145650.4602-1-geert@linux-m68k.org>
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH 3/3] ASoC: Fix SND_SOC_ALL_CODECS imply misc
	fallout
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Fixes for missing miscellaneous support:

    ERROR: "abx500_get_register_interruptible" [...] undefined!
    ERROR: "abx500_set_register_interruptible" [...] undefined!
    ERROR: "arizona_free_irq" [...] undefined!
    ERROR: "arizona_request_irq" [...] undefined!
    ERROR: "arizona_set_irq_wake" [...] undefined!
    ERROR: "mc13xxx_reg_rmw" [...] undefined!
    ERROR: "mc13xxx_reg_write" [...] undefined!
    ERROR: "snd_soc_free_ac97_component" [...] undefined!
    ERROR: "snd_soc_new_ac97_component" [...] undefined!

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: ea00d95200d02ece ("ASoC: Use imply for SND_SOC_ALL_CODECS")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/codecs/Kconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3ef804d07deea41d..d957fd6980b10a92 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -319,6 +319,7 @@ config SND_SOC_WM_ADSP
 
 config SND_SOC_AB8500_CODEC
 	tristate
+	depends on ABX500_CORE
 
 config SND_SOC_AC97_CODEC
 	tristate "Build generic ASoC AC97 CODEC driver"
@@ -343,8 +344,9 @@ config SND_SOC_AD193X_I2C
 	select SND_SOC_AD193X
 
 config SND_SOC_AD1980
-	select REGMAP_AC97
 	tristate
+	depends on SND_SOC_AC97_BUS
+	select REGMAP_AC97
 
 config SND_SOC_AD73311
 	tristate
@@ -646,6 +648,7 @@ config SND_SOC_CS47L15
 
 config SND_SOC_CS47L24
 	tristate
+	depends on MFD_CS47L24
 
 config SND_SOC_CS47L35
 	tristate
@@ -1234,6 +1237,7 @@ config SND_SOC_STA529
 
 config SND_SOC_STAC9766
 	tristate
+	depends on SND_SOC_AC97_BUS
 
 config SND_SOC_STI_SAS
 	tristate "codec Audio support for STI SAS codec"
@@ -1415,9 +1419,11 @@ config SND_SOC_WM5100
 
 config SND_SOC_WM5102
 	tristate
+	depends on MFD_WM5102
 
 config SND_SOC_WM5110
 	tristate
+	depends on MFD_WM5110
 
 config SND_SOC_WM8350
 	tristate
@@ -1579,9 +1585,11 @@ config SND_SOC_WM8996
 
 config SND_SOC_WM8997
 	tristate
+	depends on MFD_WM8997
 
 config SND_SOC_WM8998
 	tristate
+	depends on MFD_WM8998
 
 config SND_SOC_WM9081
 	tristate
@@ -1639,6 +1647,7 @@ config SND_SOC_MAX9877
 
 config SND_SOC_MC13783
 	tristate
+	depends on MFD_MC13XXX
 
 config SND_SOC_ML26124
 	tristate
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
