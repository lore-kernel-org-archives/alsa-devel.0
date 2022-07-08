Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81551C43334
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jul 2022 10:46:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3F891674;
	Fri,  8 Jul 2022 12:45:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3F891674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657277185;
	bh=T5jJbEnazMVcoItbd2r700U06xzxu9Fs29EqH4dqJYM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SrdvSAFRyf4omvZrqQSaXs45Nimc7uSpWuNFj43KlDxGlpLYYLFJqjgSVvQf8/UGC
	 qaNRckeOc2ESx+yAn7s+EkTo2cWn2qCKntMKzfM71B85KZBs04H0BVsneCzXK0Suy6
	 95opsLO109IgdbwV6hNB6aEBKBw5KhMRTUyupM+Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96E1AF805B2;
	Fri,  8 Jul 2022 12:42:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D65F6F80568; Fri,  8 Jul 2022 12:42:42 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2916DF80568
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2022 12:42:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2916DF80568
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="e5u9BfKd"
Received: by mail-wm1-x334.google.com with SMTP id
 v67-20020a1cac46000000b003a1888b9d36so932534wme.0
 for <alsa-devel@alsa-project.org>; Fri, 08 Jul 2022 03:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G5dmS78zz1zwy89jfeWA97TI8jj2tS8e0cDJN/8sutk=;
 b=e5u9BfKdTH0e9Yr1UQs/E6TkGAQoWdB4Q2og2eVbiciEviKhMW+wfTpOUocZQsfYZr
 CcMolD759bJi9Ugem7Vn0CaYRhskmFXYDGD5o4Hha8P3iATrn1Mr3taUlKOktRSzjKZ9
 q4UOeeZ3FMQM18FZRkVeN/Yr7Y3BGBgqNB3lKi+08YZu9qvQxE4TEE+G014/WvC17Fsg
 A1+NBddTF0yNg0A3TJ+l4HyuT6K9N7NdGboUi+aogPas+TFYgUYu1ByLotMYsacN6eDt
 GIgZAB4maR+6mleWniowHlN2+wtsLAMm+Fygn3pI2VJqUVSYvzceLD0UrVEXxeusMg93
 hI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G5dmS78zz1zwy89jfeWA97TI8jj2tS8e0cDJN/8sutk=;
 b=iHt1qAWCbGnJf4ACTkChxOl6K9fnltMEu86ZV/0PxKANx81UeUFgwzJt03CWDPBhlC
 dcYoI3is1NMGk5D+KHHcOBRLE81KuyQNgpqpjtyWiIYzgLuDyvOMvV7vJCK9+G4FEDAZ
 D/fhTaW0sF7C1NkntzfNEsuV19HtpPwr0zunyuB4u6iFw6zu+LAfv58SPuR9CtUnNeXC
 RIMrGVSbpdtLwNefS/hD6LLlohPRNqWZVD4Ynvxb+FfhJuC9PaeEwsSwIr8AXIpaorPe
 oMtOEJj85pcEb71aeJbrgU7tWzwppb73hH1R+8pl+sgzV/QDTfIwYgGsiqAHceV7O/KH
 ImHA==
X-Gm-Message-State: AJIora9ncy2PitqcryTYgvOxqmii0n12pgxocEnK4vmteUzIFY/v+awp
 TjedfOmbj7fV+QLifkEVQ1o=
X-Google-Smtp-Source: AGRyM1uUIIhrHjXA3atkwDHxUcfUonFLE00wtHCyQbfSsbMbHHuHTxrblm9sUuPVgJmPcKRzTC2/4Q==
X-Received: by 2002:a05:600c:3593:b0:3a1:8909:b5b2 with SMTP id
 p19-20020a05600c359300b003a18909b5b2mr9878772wmq.77.1657276954141; 
 Fri, 08 Jul 2022 03:42:34 -0700 (PDT)
Received: from localhost (92.40.203.220.threembb.co.uk. [92.40.203.220])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a05600c064900b003a0323463absm1622817wmm.45.2022.07.08.03.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jul 2022 03:42:33 -0700 (PDT)
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com
Subject: [PATCH v3 09/11] ASoC: jz4740-i2s: Support continuous sample rate
Date: Fri,  8 Jul 2022 11:43:02 +0100
Message-Id: <20220708104304.51415-10-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
References: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
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

The I2S controller on JZ47xx SoCs doesn't impose restrictions on
sample rate and the driver doesn't make any assumptions about it,
so the DAI should advertise a continuous sample rate range.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 9be2f3f1b376..70b9d28a40ce 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -391,13 +391,13 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.symmetric_rate = 1,
@@ -429,13 +429,13 @@ static struct snd_soc_dai_driver jz4770_i2s_dai = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.ops = &jz4740_i2s_dai_ops,
-- 
2.35.1

