Return-Path: <SRS0=3BcS=MA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254EAC07E96
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 10:05:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE672619B6
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 10:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE672619B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5910385D;
	Thu,  8 Jul 2021 12:04:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5910385D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625738718;
	bh=XNWlBZfM7mH/gyKHv/th4XIV5Pw370O5lAgIBERdu8Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uxdwvXZeSjulTjNyZcOS7wXe990rkJZK5WHRnHg0cOYKd8SoZ1W+4EL62yKEzB68d
	 N+XL5bzKSPRWdVIR8H1k2uA3a3aHsSd2heWJNUxfRqmlIGC+O8Uf3v8CZkFS4uLbDv
	 rMNBKqZ4I9OjuvXLem3MwlMAxl8W/0ZrJZ6EN1Fk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBA62F8012F;
	Thu,  8 Jul 2021 12:04:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CA91F80224; Mon,  5 Jul 2021 09:38:01 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92078F80124
 for <alsa-devel@alsa-project.org>; Mon,  5 Jul 2021 09:37:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92078F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="RURpQEki"
Received: by mail-pl1-x635.google.com with SMTP id a14so9588398pls.4
 for <alsa-devel@alsa-project.org>; Mon, 05 Jul 2021 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uIYkWEg6ddHgyeOZ+TasZ9tt9xSrdpyE5MFOa1Fdx4E=;
 b=RURpQEkiG89CAuGiDuimdVkL4MKD3H9WowmHt3ZTKdEgfEvqvKYljuU/SaSeHinBW0
 5oaa9s8J1UodnyjLvOk6QdBTFD/f3Q9+iuCHs/Whnqqlwlw4pZh0qX+BV3q1ZR5Hz5Yk
 oGDaoh7BmvRTZAxwX0BT9bthVDqALGu8zmam5HL/fgQGdXyg+5z7RtJQvWN08uMjv5jC
 Mldc3udVmwc+SXCNTgIY7zqM60rWf9xAYwfq/5LS3PAMmrXb9WIEYMs3sw1D/fkO/ApB
 TlnrXf9nHPMDmWrFW9hRhyIj9CMZWMVemHpIpyxbj3JuDYqkWXpzxkdaiyBIphB6O7bk
 KCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uIYkWEg6ddHgyeOZ+TasZ9tt9xSrdpyE5MFOa1Fdx4E=;
 b=t1Ki3xx7VjW6IPCZ6G2avuWgAuXhM9+FciZOdxhvphoxLY59a67ytURCxK09U5hoEF
 AZBsq5pYBlVuO7mYI8pE/7cZSBlJhE3HmrMTP2Q5cRGAqWwRFUsa5z4CJLVvRsmYMMhX
 ykVEv2UCy1zfJzrwaBDEnSdWms7gmtf7RT1uxgaFpu04TEcoik7PpzAQ+R0o/Pywophl
 P3zwkRjahNSoPqdxozbj4wNKys/KRB6XeI/ZJRcEU3Vh3ViX/9W9T4FgYpqtK98y+Pj1
 s9TquHqaVKsCDPUC+F1gPe9RxszEXmT+ghgPAvnNYg3u60KgyGOB96I1Hd/bBMVNwm+q
 CMig==
X-Gm-Message-State: AOAM532ITWgr7FgQuRzyHE8rWgK+x0z1WBkEu2ZjkvBB8lQz0t2cVlt6
 KV8xcVuiaAh3Hm98y30mPoM=
X-Google-Smtp-Source: ABdhPJxwk9VAwLAt6zdodDdK4aaJMDRuD9OasQ3YaXQSuVpnBPtwDVw+vAGCokaehZ/TR5Zp/RZ10Q==
X-Received: by 2002:a17:90b:1403:: with SMTP id
 jo3mr14330309pjb.160.1625470670034; 
 Mon, 05 Jul 2021 00:37:50 -0700 (PDT)
Received: from ubuntu.localdomain ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id g4sm2694975pfo.44.2021.07.05.00.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 00:37:49 -0700 (PDT)
From: gushengxian <gushengxian507419@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] sound: x86: fix spelling mistakes
Date: Mon,  5 Jul 2021 00:37:36 -0700
Message-Id: <20210705073736.662875-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Jul 2021 12:04:25 +0200
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 gushengxian <gushengxian@yulong.com>
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

From: gushengxian <gushengxian@yulong.com>

Fix some spelling mistakes as follows:
regiter ==> register
confgiuration ==> configuration
playabck ==> playback
platoform ==> platform

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 sound/x86/intel_hdmi_audio.c | 6 +++---
 sound/x86/intel_hdmi_audio.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 33b12aa67cf5..a34d7d9c2a57 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -236,7 +236,7 @@ static void had_write_register(struct snd_intelhad *ctx, u32 reg, u32 val)
  * updating AUD_CONFIG register.
  * This is because:
  * Bit6 of AUD_CONFIG register is writeonly due to a silicon bug on VLV2
- * HDMI IP. As a result a read-modify of AUD_CONFIG regiter will always
+ * HDMI IP. As a result a read-modify of AUD_CONFIG register will always
  * clear bit6. AUD_CONFIG[6:4] represents the "channels" field of the
  * register. This field should be 1xy binary for configuration with 6 or
  * more channels. Read-modify of AUD_CONFIG (Eg. for enabling audio)
@@ -342,7 +342,7 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 
 /*
  * function to initialize audio
- * registers and buffer confgiuration registers
+ * registers and buffer configuration registers
  * This function is called in the prepare callback
  */
 static int had_init_audio_ctrl(struct snd_pcm_substream *substream,
@@ -1790,7 +1790,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 		pcm->private_data = ctx;
 		pcm->info_flags = 0;
 		strscpy(pcm->name, card->shortname, strlen(card->shortname));
-		/* setup the ops for playabck */
+		/* setup the ops for playback */
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 
 		/* allocate dma pages;
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 0d91bb5dbab7..bb3853195922 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -96,7 +96,7 @@ struct pcm_stream_info {
  * @had_spinlock: driver lock
  * @aes_bits: IEC958 status bits
  * @buff_done: id of current buffer done intr
- * @dev: platoform device handle
+ * @dev: platform device handle
  * @chmap: holds channel map info
  */
 struct snd_intelhad {
-- 
2.25.1

