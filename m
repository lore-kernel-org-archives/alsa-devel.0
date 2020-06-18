Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2853C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:13:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDAB2078D
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UhhiWkXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDAB2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D42C7175D;
	Thu, 18 Jun 2020 13:12:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D42C7175D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592478794;
	bh=HIeOK2FUMBmnW1/NNvAXlW885rfyhsEqw+RhGvl9w0M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UhhiWkXbdM+Ist5+h95LaofpepoOWCXu/RJB+ROQW93b92wU5iAGMLxTzMweg1dvb
	 4Ll2mkvq0oRtSOoqy+fxh5FoM+L+x8aqSD5MHxJqPbwOGkZZegoF0n8Qq61Q4S/zgZ
	 yDFXvmkHfk7q3Z8LT0PJdTvucsP5K7r96ph8x6Xo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0D8BF802DD;
	Thu, 18 Jun 2020 13:09:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3DE5F802A9; Thu, 18 Jun 2020 13:09:07 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EA11F80217
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 13:08:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EA11F80217
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 91F3DAF36;
 Thu, 18 Jun 2020 11:08:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/13] ALSA: hda/conexant: Convert to cdev-variant of mic-mute
 LED controls
Date: Thu, 18 Jun 2020 13:08:33 +0200
Message-Id: <20200618110842.27238-5-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200618110842.27238-1-tiwai@suse.de>
References: <20200618110842.27238-1-tiwai@suse.de>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
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

This patch converts the remaining user of
snd_hda_gen_add_micmute_led() in Conexant codec driver into the new
snd_hda_gen_add_micmute_led_cdev().

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 396b5503038a..5a7c16e39d7a 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -640,12 +640,14 @@ static void cxt_fixup_gpio_mute_hook(void *private_data, int enabled)
 }
 
 /* turn on/off mic-mute LED via GPIO per capture hook */
-static void cxt_gpio_micmute_update(struct hda_codec *codec)
+static int cxt_gpio_micmute_update(struct led_classdev *led_cdev,
+				   enum led_brightness brightness)
 {
+	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
 	struct conexant_spec *spec = codec->spec;
 
-	cxt_update_gpio_led(codec, spec->gpio_mic_led_mask,
-			    spec->gen.micmute_led.led_value);
+	cxt_update_gpio_led(codec, spec->gpio_mic_led_mask, brightness);
+	return 0;
 }
 
 
@@ -665,7 +667,7 @@ static void cxt_fixup_mute_led_gpio(struct hda_codec *codec,
 		spec->mute_led_polarity = 0;
 		spec->gpio_mute_led_mask = 0x01;
 		spec->gpio_mic_led_mask = 0x02;
-		snd_hda_gen_add_micmute_led(codec, cxt_gpio_micmute_update);
+		snd_hda_gen_add_micmute_led_cdev(codec, cxt_gpio_micmute_update);
 	}
 	snd_hda_add_verbs(codec, gpio_init);
 	if (spec->gpio_led)
-- 
2.16.4

