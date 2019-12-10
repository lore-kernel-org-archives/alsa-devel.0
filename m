Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A6C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:56:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3954D207FF
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JDtn/w4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3954D207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62A8116B4;
	Tue, 10 Dec 2019 15:56:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62A8116B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575989810;
	bh=UPynf69i3TwAFc6y7lxSo1+WPh2gkuDYo9Yind+uNyA=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JDtn/w4rehInHTKAtvx9L12vZnRIP6zJYi1K2syG/JzmX2kd2YtTyf4UnHUbnoLvG
	 dsArMVTFEKPiNc3fjvuAk+FrO47d9PGcRAcK+F0VuiLB2QOvS0J5pyt8SHXX+nNddt
	 XIbsh67TwwM/0QQ9X3gP+gfz3tc0rFSwFU4AzZiw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7BCBF80249;
	Tue, 10 Dec 2019 15:54:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34C45F80279; Tue, 10 Dec 2019 15:54:21 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25770F8020C
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:54:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25770F8020C
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 42765AD26;
 Tue, 10 Dec 2019 14:54:12 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Dec 2019 15:53:45 +0100
Message-Id: <20191210145406.21419-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210145406.21419-1-tiwai@suse.de>
References: <20191210145406.21419-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [alsa-devel] [PATCH for-5.6 02/23] ASoC: atmel: Drop superfluous
	ioctl PCM ops
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

ASoC PCM core deals the empty ioctl field now as default.
Let's kill the redundant lines.

Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/atmel/atmel-pcm-pdc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
index 18a2fd02fffe..59c1331a6984 100644
--- a/sound/soc/atmel/atmel-pcm-pdc.c
+++ b/sound/soc/atmel/atmel-pcm-pdc.c
@@ -379,7 +379,6 @@ static int atmel_pcm_close(struct snd_soc_component *component,
 static const struct snd_soc_component_driver atmel_soc_platform = {
 	.open		= atmel_pcm_open,
 	.close		= atmel_pcm_close,
-	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= atmel_pcm_hw_params,
 	.hw_free	= atmel_pcm_hw_free,
 	.prepare	= atmel_pcm_prepare,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
