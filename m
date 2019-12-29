Return-Path: <SRS0=/yeG=2T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B618AC2D0CE
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Dec 2019 15:06:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C387D2071E
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Dec 2019 15:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="J09B+yyN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgHR3+f5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C387D2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9675F172A;
	Sun, 29 Dec 2019 16:05:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9675F172A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577632002;
	bh=oN7u5UzxhApK3oYjJJ5IWnkoo/6p9pHFHGmpUoTG0SY=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J09B+yyN9FQqxrOgMadNOyh9L4HYpuTNsZ4EwLp87BU77qz1yhzrtPAe5jLvDK6cA
	 UbD2YVrtzP2+N4EjVqVxofYyEltDXo+4GiPFVwD00d0MJWqfDJD9Gjuy8AZQSahugc
	 tQpMNSvkuIdd/II3Zfr/lwyguHmMnI3M9AXTdzD4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2896CF80130;
	Sun, 29 Dec 2019 16:05:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B104BF8014F; Sun, 29 Dec 2019 16:05:50 +0100 (CET)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 321F0F8011E
 for <alsa-devel@alsa-project.org>; Sun, 29 Dec 2019 16:05:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 321F0F8011E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HgHR3+f5"
Received: by mail-lj1-x243.google.com with SMTP id m26so28663614ljc.13
 for <alsa-devel@alsa-project.org>; Sun, 29 Dec 2019 07:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RJFIpVK2l7JXb5O04n2/M1EaQnjqMlSNsPUjZ7jwbQg=;
 b=HgHR3+f5o25GXaOkOvlHmxuo1Bpvp6kkFLcbq666Z3/HlmCnCYnZzNCqKTxrMEzedU
 2VY8KPlckXzrh1PWs3kjkvEFSHkDjb3pp0FeuahToE+h6nA+u0D/AeYwX+L5Xxg7RHne
 5MObwlJrqutFM9qqw+fte556N7rci3/oKYmYljMf30u216eWu1VhEO+5DYnDh+qluQPj
 V0Y3iR9VrGrSoEmyKNf72sPOKCBF/8BfJKokB0AIRJWEbgeiu/Nt/vixARJDNwvXLl8z
 HpKoJNg6Vjn/WWEQMzfchTsJfRL7bjddFrwpsH9q4mkIV66/EV4ufWyf1zOOWkCUCsNY
 2nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RJFIpVK2l7JXb5O04n2/M1EaQnjqMlSNsPUjZ7jwbQg=;
 b=cr3bKEbCb1uHGXATfrgcbqeqEnpNfP4zK7QFw+IrxH0OuxF5Xe87McVSq7PKeLxYPk
 vCjjmfMCupUJyHlTKya9GV7wF/S+R08qB9tS+v1Q3yeAWjebUZOqBZA0H1SL0c+EW6ij
 Q6V5ctUdZd9wX7tGYTz50onp8hwizcoDM+G1P+2xNH07RWri46s24OtqPluG9jjiz3H9
 o8RJo9cs9FVhigMde1trEX9PFcrA1z7OxYxyKP+JUI0rYhNw8UpSmam0AMSeHcLA0hwj
 k7OhWz5BWPoA2OSAQ+vpLSw0LzxZR8tqCa/RJlmZyr/XOdiKzq2JTLBE5y3BbpxOUoec
 t7Rg==
X-Gm-Message-State: APjAAAUjKwB7Kv+sE2TONRE/sxW+5vg8hFI9Utl0ksMBz/ioyoZwvdGh
 X21stYvMInRBm6vJaH4BkLs=
X-Google-Smtp-Source: APXvYqxUYqdjm3+Kq4VoxnGBV1ftdbjy1Hm09N0pSP0z+s/IcVyFV6uvWfnNZngH3u5evG0k3D6ifQ==
X-Received: by 2002:a2e:844e:: with SMTP id u14mr34903503ljh.183.1577631946992; 
 Sun, 29 Dec 2019 07:05:46 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru.
 [79.139.233.37])
 by smtp.gmail.com with ESMTPSA id d24sm16169472lja.82.2019.12.29.07.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2019 07:05:46 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Bard Liao <bardliao@realtek.com>,
 Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>
Date: Sun, 29 Dec 2019 18:04:54 +0300
Message-Id: <20191229150454.2127-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH v1] ASoC: rt5640: Fix NULL dereference on
	module unload
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The rt5640->jack is NULL if jack is already disabled at the time of
driver's module unloading.

 Unable to handle kernel NULL pointer dereference at virtual address 00000024
 ...
 (rt5640_set_jack [snd_soc_rt5640]) from [<bf86f7ed>] (snd_soc_component_set_jack+0x11/0x1c [snd_soc_core])
 (snd_soc_component_set_jack [snd_soc_core]) from [<bf8675cf>] (soc_remove_component+0x1b/0x54 [snd_soc_core])
 (soc_remove_component [snd_soc_core]) from [<bf868859>] (soc_cleanup_card_resources+0xad/0x1cc [snd_soc_core])
 (soc_cleanup_card_resources [snd_soc_core]) from [<bf86945f>] (snd_soc_unregister_card+0x47/0x78 [snd_soc_core])
 (snd_soc_unregister_card [snd_soc_core]) from [<bf8b4013>] (tegra_rt5640_remove+0x13/0x1c [snd_soc_tegra_rt5640])
 (tegra_rt5640_remove [snd_soc_tegra_rt5640]) from [<c0516d2f>] (platform_drv_remove+0x17/0x24)
 (platform_drv_remove) from [<c0515aed>] (device_release_driver_internal+0x95/0x114)
 (device_release_driver_internal) from [<c0515bd9>] (driver_detach+0x4d/0x90)
 (driver_detach) from [<c0514d59>] (bus_remove_driver+0x31/0x70)
 (bus_remove_driver) from [<bf8b4215>] (tegra_rt5640_driver_exit+0x9/0xdf4 [snd_soc_tegra_rt5640])
 (tegra_rt5640_driver_exit [snd_soc_tegra_rt5640]) from [<c019336f>] (sys_delete_module+0xe7/0x184)
 (sys_delete_module) from [<c0101001>] (ret_fast_syscall+0x1/0x28)

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/codecs/rt5640.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index adbae1f36a8a..b245c44cafbc 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2432,16 +2432,22 @@ static void rt5640_disable_jack_detect(struct snd_soc_component *component)
 {
 	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
-	disable_irq(rt5640->irq);
-	rt5640_cancel_work(rt5640);
+	/*
+	 * soc_remove_component() force-disables jack and thus rt5640->jack
+	 * could be NULL at the time of driver's module unloading.
+	 */
+	if (rt5640->jack) {
+		disable_irq(rt5640->irq);
+		rt5640_cancel_work(rt5640);
 
-	if (rt5640->jack->status & SND_JACK_MICROPHONE) {
-		rt5640_disable_micbias1_ovcd_irq(component);
-		rt5640_disable_micbias1_for_ovcd(component);
-		snd_soc_jack_report(rt5640->jack, 0, SND_JACK_BTN_0);
-	}
+		if (rt5640->jack->status & SND_JACK_MICROPHONE) {
+			rt5640_disable_micbias1_ovcd_irq(component);
+			rt5640_disable_micbias1_for_ovcd(component);
+			snd_soc_jack_report(rt5640->jack, 0, SND_JACK_BTN_0);
+		}
 
-	rt5640->jack = NULL;
+		rt5640->jack = NULL;
+	}
 }
 
 static int rt5640_set_jack(struct snd_soc_component *component,
-- 
2.24.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
