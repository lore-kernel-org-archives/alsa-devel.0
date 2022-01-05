Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F316EC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Jan 2022 16:25:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9B461A44;
	Wed,  5 Jan 2022 17:24:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9B461A44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641399908;
	bh=CcdX2N69ne+eSqyA3M2iwxLCypKP3s4ANTuCjFBJkqs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dpCqP4VFn5sq8eFDMFuPtpoiw5CHyPJYrH1Zk4JtdfJfIzAFL8o3+06HvVoWijsJE
	 lN5Whf87X/C5gJI8/7OyE2H6BHM0IWL2zDiR9DURIVbZm9PvknSZhP+rMrfzr4Mad/
	 awi9RK5qr3ma467WF2Ci7gNdLvGzF17ZcJsd1st0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61622F80167;
	Wed,  5 Jan 2022 17:24:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 286D2F8007E; Wed,  5 Jan 2022 17:24:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B66FF8007E
 for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2022 17:24:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B66FF8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="11AEZb5a"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="4vDdxEXw"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id F30F21F37B;
 Wed,  5 Jan 2022 16:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1641399850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZoTAqvn3cSScz678Px3ymY3f7sM9aK8Jj+9p7LS7kX8=;
 b=11AEZb5awCdqT699PD70Yj2xBypzyi7ethzrkyvvTdDb4JSgYpKLQ6jgCREND4WtDDyj2N
 5DxIpXeWoozyZ06sZwWm8y6bLVckwoFKSgDetVaFpkM103WdtzViTJvimumEt2wWr1XARj
 ORYhOd7ykovzxb+tACXMDwlmdrGM5+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1641399850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZoTAqvn3cSScz678Px3ymY3f7sM9aK8Jj+9p7LS7kX8=;
 b=4vDdxEXw6meFYTLwPcUputVDpvJc5XPT508RsaLKMko/8R8C2hu7jdFrlEeow3ifuY6Fxl
 aYAewiHZqOwOY5Bw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id D7D6BA3B81;
 Wed,  5 Jan 2022 16:24:09 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: ak4375: Fix unused function error
Date: Wed,  5 Jan 2022 17:24:09 +0100
Message-Id: <20220105162409.20635-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Vincent Knecht <vincent.knecht@mailoo.org>
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

A randconfig caught a compile warning that is now treated as a fatal
error:
  sound/soc/codecs/ak4375.c:415:13: error: ‘ak4375_power_off’ defined but not used [-Werror=unused-function]

where ak4375_power_off() is used only from the PM handler.

As both suspend and resumes are already marked with __maybe_unused,
let's rip off the superfluous ifdef CONFIG_PM, so that the error above
can be avoided.

Fixes: 53778b8292b5 ("ASoC: Add AK4375 support")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/ak4375.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/ak4375.c b/sound/soc/codecs/ak4375.c
index 22cda0699341..9a7b662016b9 100644
--- a/sound/soc/codecs/ak4375.c
+++ b/sound/soc/codecs/ak4375.c
@@ -438,7 +438,6 @@ static int ak4375_power_on(struct ak4375_priv *ak4375)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int __maybe_unused ak4375_runtime_suspend(struct device *dev)
 {
 	struct ak4375_priv *ak4375 = dev_get_drvdata(dev);
@@ -463,7 +462,6 @@ static int __maybe_unused ak4375_runtime_resume(struct device *dev)
 
 	return regcache_sync(ak4375->regmap);
 }
-#endif /* CONFIG_PM */
 
 static const struct snd_soc_component_driver soc_codec_dev_ak4375 = {
 	.controls		= ak4375_snd_controls,
-- 
2.31.1

