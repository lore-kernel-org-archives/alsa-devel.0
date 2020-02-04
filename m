Return-Path: <SRS0=uPGH=3Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D79CC2D0B1
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:19:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A442087E
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Aog1AWq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A442087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71597166D;
	Tue,  4 Feb 2020 14:19:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71597166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580822396;
	bh=Nyjt6eRcHZmRW0OC/4X+EWYoqPvt3dSHFgtpENCUkCQ=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Aog1AWq19zCrTgTR3nCKTJfAXWu4nd5Naq0zNEz2Pp3NIXo3J4rvtfGTM3/z7az9M
	 piiIqRbjMYbo9hUtyA2v7X1CcLN0WFXzNQeHI8QFWHPT8b/q2HNWCfiGTYa+A94mcC
	 WT/d+mE4J03aCzDoH63xwpvHMDbYd78qRN2xpsws=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3799F8015B;
	Tue,  4 Feb 2020 14:19:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44441F80162; Tue,  4 Feb 2020 14:19:04 +0100 (CET)
Received: from albert.telenet-ops.be (albert.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:1a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F26EEF800AB
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2020 14:19:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F26EEF800AB
Received: from ramsan ([84.195.182.253]) by albert.telenet-ops.be with bizsmtp
 id ydJy210175USYZQ06dJzbo; Tue, 04 Feb 2020 14:18:59 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iyy6U-0005H5-SS; Tue, 04 Feb 2020 14:18:58 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iyy6U-0001zr-P5; Tue, 04 Feb 2020 14:18:58 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date: Tue,  4 Feb 2020 14:18:57 +0100
Message-Id: <20200204131857.7634-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ASoC: wcd934x: Add missing COMMON_CLK
	dependency to SND_SOC_ALL_CODECS
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

Just adding a dependency on COMMON_CLK to SND_SOC_WCD934X is not
sufficient, as enabling SND_SOC_ALL_CODECS will still select it,
breaking the build later:

    WARNING: unmet direct dependencies detected for SND_SOC_WCD934X
      Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMMON_CLK [=n] && MFD_WCD934X [=m]
      Selected by [m]:
      - SND_SOC_ALL_CODECS [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMPILE_TEST [=y] && MFD_WCD934X [=m]
    ...
    ERROR: "of_clk_add_provider" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
    ERROR: "of_clk_src_simple_get" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
    ERROR: "clk_hw_register" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
    ERROR: "__clk_get_name" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!

Fix this by adding the missing dependency to SND_SOC_ALL_CODECS

Fixes: 42b716359beca106 ("ASoC: wcd934x: Add missing COMMON_CLK dependency")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Seen with e.g. m68k/allmodconfig.
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2865148659600346..7e90f5d830971309 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -214,7 +214,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WCD9335 if SLIMBUS
-	select SND_SOC_WCD934X if MFD_WCD934X
+	select SND_SOC_WCD934X if MFD_WCD934X && COMMON_CLK
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
 	select SND_SOC_WM0010 if SPI_MASTER
 	select SND_SOC_WM1250_EV1 if I2C
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
