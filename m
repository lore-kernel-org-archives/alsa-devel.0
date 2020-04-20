Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E59C3815B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 20:21:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B0220782
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 20:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ufERaRYO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3EwKK9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B0220782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 448F81684;
	Mon, 20 Apr 2020 22:20:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 448F81684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587414080;
	bh=YJUix7Fb5iq10VHJscp5lsL12vjHUFzVmfENE1kAiDk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ufERaRYOO+bm9xYfnlPljmVA4Xb8PDfMQoiKzjpaZ5pmoqLReJyahVQHcJx6iw2W9
	 7l7LNW/SrLGruVBxe+TlsnF0yIxvhirrlf5VMHc2FmCqoTcXnUC8woD/Qz+EV0FR1L
	 RzzdPGY+7YwmWwQkZnL1/htdAqS6OoPCEQHZr6Ik=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0D51F800E7;
	Mon, 20 Apr 2020 22:20:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9894F801D9; Mon, 20 Apr 2020 22:20:27 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26EC1F8012F
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 22:20:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26EC1F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Y3EwKK9Y"
Received: by mail-wr1-x444.google.com with SMTP id s10so4672395wrr.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WaNkYITjpr2SJjowiiyR8sRi3eo+gyei8bJaiA5cLw0=;
 b=Y3EwKK9Y5HCD6i0fmisN2pj7R3M+p4Ukl2HwAWgKkuyHdWJOKD3hAvOAs3MFDiaOmX
 SPpTk7WcQJIAQhUyNqkiLDyC88nU1aCgLqZke94+xejuqmQmQMYxmpdaYYWK24xtbfVH
 CMRWCyZ0/qhfHG6rQRRlj/JIrhY1I3JbsM3Js69YIS5plZecPEqRq1j2c559p2BIJNWg
 o7z+8IfmeUV7Z+MvizXjkbo5F8AU/5Oir5+W66XBFQEZdNxIuSw1vMCqd1UGd+MVTvsC
 p1w+LTV8fsKfE5joQamgpZdFJ+S8jCHXzFRolk+p83sJRHPf2THpkwlAme7aYtn8UBAw
 9tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WaNkYITjpr2SJjowiiyR8sRi3eo+gyei8bJaiA5cLw0=;
 b=tPoJr9dRplyKYWVgj5UJFWGTlWzdMFUvb2BWZ4YuYz7wyEa1dO3mHYUSYtIQy7f4Bw
 OuZROIOYQCr2dNzMCBUoBzgIFjR8GF1Dgzn4dQ+d1VT3AA/Q0vz1+JO54heIFpkHc9cX
 xM84oSMS1GiI5gZ0mdqUxZnmx2+DQI4B6MzHhTmMcEobZ/6nlw7VK+KkAg+gxccso8c3
 ZhBIU/GUFzVXslyDr4aBD3NHCRG69+pEVDqRvJSPOm9suEN3gHXcvv27iO+V+Lqo2xCa
 1JIgKQUna27avVLhhKDw4g2XjQJCAYbqopoYMSfDzD3Df1uv6TUrpjKDKFP3wFyHAxWQ
 MYpQ==
X-Gm-Message-State: AGi0PuZgizKwiNdR/U3XZmVkxn+MlkKe1AKIxK8P54t8boDhw7T+lWqa
 S5MKpnPWdPNys3laaafjgQg=
X-Google-Smtp-Source: APiQypKOFZ/OsoFUO7Ip+UczM4P7hW+gEVwybr4+Ux4Vbi2V+C8fm37/5IMLcEVQXuL+BuKVbSWCFw==
X-Received: by 2002:a5d:4b49:: with SMTP id w9mr20692680wrs.359.1587414023070; 
 Mon, 20 Apr 2020 13:20:23 -0700 (PDT)
Received: from localhost.localdomain ([91.221.170.230])
 by smtp.googlemail.com with ESMTPSA id o18sm773682wrp.23.2020.04.20.13.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 13:20:22 -0700 (PDT)
From: Gregor Pintar <grpintar@gmail.com>
To: tiwai@suse.com,
	perex@perex.cz
Subject: [PATCH] ALSA: usb-audio: Add quirk for Focusrite Scarlett 2i2
Date: Mon, 20 Apr 2020 22:19:37 +0200
Message-Id: <20200420201937.12634-1-grpintar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: grpintar@gmail.com, alsa-devel@alsa-project.org,
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

Force it to use asynchronous playback.

Same quirk has already been added for Focusrite Scarlett Solo (2nd gen)
with a commit 46f5710f0b88 ("ALSA: usb-audio: Add quirk for Focusrite
Scarlett Solo").

This also seems to prevent regular clicks when playing at 44100Hz
on Scarlett 2i2 (2nd gen). I did not notice any side effects.

Signed-off-by: Gregor Pintar <grpintar@gmail.com>
---
 sound/usb/quirks-table.h | 84 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index e009d584e..bc936bf79 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2840,6 +2840,90 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	/*
+	 * Focusrite Scarlett 2i2 2nd generation
+	 * Reports that playback should use Synch: Synchronous
+	 * while still providing a feedback endpoint. Synchronous causes
+	 * snapping on some sample rates.
+	 * Force it to use Synch: Asynchronous.
+	 */
+	USB_DEVICE(0x1235, 0x8202),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 2,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = 0,
+					.endpoint = 0x01,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.protocol = UAC_VERSION_2,
+					.rates = SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000 |
+						SNDRV_PCM_RATE_176400 |
+						SNDRV_PCM_RATE_192000,
+					.rate_min = 44100,
+					.rate_max = 192000,
+					.nr_rates = 6,
+					.rate_table = (unsigned int[]) {
+						44100, 48000, 88200,
+						96000, 176400, 192000
+					},
+					.clock = 41
+				}
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 2,
+					.iface = 2,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = 0,
+					.endpoint = 0x82,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC |
+						USB_ENDPOINT_USAGE_IMPLICIT_FB,
+					.protocol = UAC_VERSION_2,
+					.rates = SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000 |
+						SNDRV_PCM_RATE_176400 |
+						SNDRV_PCM_RATE_192000,
+					.rate_min = 44100,
+					.rate_max = 192000,
+					.nr_rates = 6,
+					.rate_table = (unsigned int[]) {
+						44100, 48000, 88200,
+						96000, 176400, 192000
+					},
+					.clock = 41
+				}
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 /* Access Music devices */
 {
-- 
2.20.1

