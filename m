Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3359C35671
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:26:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8A220732
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aIKDb9uJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8A220732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CBE51676;
	Mon, 24 Feb 2020 12:25:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CBE51676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582543603;
	bh=uXRohhCqEQhH3/lW1orzDPOEnApLWiFxqmKG5kRD+ec=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aIKDb9uJiiIVQCFIJV3sOmSlb0P6nnJyoCaLk6Sj+kQ95XjEUU0loZOtZF0ZuT2pR
	 TWR2GKwx/bOBy+Q4saz+L4UiFwp08PN9UH/bAxvyEN3rfhUaz2stNZyH0lTuQ4EWTW
	 kUXBuyatpNHMoE8RSUUO/lMZV5DpDEbtpMLSn2Bs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D66EAF8014D;
	Mon, 24 Feb 2020 12:25:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51938F8014E; Mon, 24 Feb 2020 12:25:51 +0100 (CET)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9844AF80090
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 12:25:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9844AF80090
Received: from ramsan ([84.195.182.253])
 by baptiste.telenet-ops.be with bizsmtp
 id 6bRe2200c5USYZQ01bReUi; Mon, 24 Feb 2020 12:25:45 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1j6Brm-0003AP-QG; Mon, 24 Feb 2020 12:25:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1j6Brm-0003mM-NM; Mon, 24 Feb 2020 12:25:38 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout
Date: Mon, 24 Feb 2020 12:25:37 +0100
Message-Id: <20200224112537.14483-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
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

On i386 randconfig:

    sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
    wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
    sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
    wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
    sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
    wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'

Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Before commit ea00d95200d02ece ("ASoC: Use imply for
SND_SOC_ALL_CODECS"), SND_SOC_ALL_CODECS used:

    select SND_SOC_WM9705 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
    select SND_SOC_WM9712 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)
    select SND_SOC_WM9713 if (SND_SOC_AC97_BUS || SND_SOC_AC97_BUS_NEW)

but SND_SOC_AC97_BUS_NEW never existed in upstream.
Should there be another dependency>

See also "non-existent SND_SOC_AC97_BUS_NEW (was: Re: [PATCH v9] ASoC:
pxa: switch to new ac97 bus support)"
http://lore.kernel.org/r/CAMuHMdU3uxfBwKd8SkOtZSDV5Ai3CKc3CWRhDy0Cz94T1Hn0iA@mail.gmail.com
---
 sound/soc/codecs/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e9d54e4576ce5ba..a7e89567edbe8b47 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1610,16 +1610,19 @@ config SND_SOC_WM9090
 
 config SND_SOC_WM9705
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9712
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9713
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
-- 
2.17.1

