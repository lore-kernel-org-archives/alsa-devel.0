Return-Path: <SRS0=z7f8=PA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73664C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 12:14:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2100D60EB4
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 12:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2100D60EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hahnjo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 342F6167D;
	Tue, 12 Oct 2021 14:13:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 342F6167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634040852;
	bh=euYIU/P6O7NV+xmb08ycljLE1YgZeMPZ2GgVpN+dqMA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KLppM31y5k6Q/38UlWem7BzIe+hKZDU8yYLPPxTy7unKv/6vVsCf7ZVzgremQKijw
	 5iQJpyq/d9QLSFz88WsIFQpUK+d5T40YVfdLLDdzK4csigU6x5C82cKRt5jg/rBpGt
	 sHrBaOljSd4VCTlqXYu2ROYnX62sJiHa0V4MCdVE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD9C9F801F7;
	Tue, 12 Oct 2021 14:13:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D897F801F7; Sun, 10 Oct 2021 13:20:38 +0200 (CEST)
Received: from mail.hahnjo.de (backus.hahnjo.de [IPv6:2a03:4000:2a:2c1::1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 359B8F80059
 for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2021 13:20:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 359B8F80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=hahnjo.de header.i=@hahnjo.de
 header.b="XWbJ7Y7a"
Received: from Jonas-Dell.home (unknown
 [IPv6:2a01:cb15:40c:c100:cf0a:528a:fee7:c993])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.hahnjo.de (Postfix) with ESMTPSA id DC73B51CFA5A;
 Sun, 10 Oct 2021 13:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hahnjo.de; s=default;
 t=1633864831; bh=euYIU/P6O7NV+xmb08ycljLE1YgZeMPZ2GgVpN+dqMA=;
 h=From:To:Cc:Subject:Date;
 b=XWbJ7Y7a2jQ9Yp0JEXe6ThLSU9ktxeGpsnmk246SYaIMJ2xX0PKwRKqfDcy6TH6rx
 ClR6mfLDWRr0iZRez547/rd/5n3bDXY9eAUL6ZpfagGzXSUmGx9usuyALiyRLcQg2J
 +6UGfY1qNyBmD7e0zEGtd+r3rBuvVkI7rCMv/NXX6JNzSbGCGkH+CY1hCpGO/BgIBC
 Y1Jp0SnPBDB1WvUpmrwMlBabnVlXU+NYWLpSLJNn3QhRFoJq5DraQ9LcTkQhQuCanr
 5+Qk5e9c52C83BrLkILHADHvVlyEufT3BdLqKGTKJ4EAxIlLsU+BvQ6k7avlvUwV5G
 gG08Xe3Cvf2qQ==
From: Jonas Hahnfeld <hahnjo@hahnjo.de>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: usb-audio: Add quirk for VF0770
Date: Sun, 10 Oct 2021 13:19:47 +0200
Message-Id: <20211010111947.5796-1-hahnjo@hahnjo.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Oct 2021 14:13:20 +0200
Cc: alsa-devel@alsa-project.org, Jonas Hahnfeld <hahnjo@hahnjo.de>,
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

The device advertises 8 formats, but only a rate of 48kHz is honored
by the hardware and 24 bits give chopped audio, so only report the
one working combination. This fixes out-of-the-box audio experience
with PipeWire which otherwise attempts to choose S24_3LE (while
PulseAudio defaulted to S16_LE).

Signed-off-by: Jonas Hahnfeld <hahnjo@hahnjo.de>
---
 sound/usb/quirks-table.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index e03043f7dad3..be5c2bc26a1d 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -77,6 +77,45 @@
 /* E-Mu 0204 USB */
 { USB_DEVICE_VENDOR_SPEC(0x041e, 0x3f19) },
 
+/*
+ * Creative Technology, Ltd Live! Cam Sync HD [VF0770]
+ * The device advertises 8 formats, but only a rate of 48kHz is honored by the
+ * hardware and 24 bits give chopped audio, so only report the one working
+ * combination.
+ */
+{
+	USB_DEVICE(0x041e, 0x4095),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = &(const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S16_LE,
+					.channels = 2,
+					.fmt_bits = 16,
+					.iface = 3,
+					.altsetting = 4,
+					.altset_idx = 4,
+					.endpoint = 0x82,
+					.ep_attr = 0x05,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 48000 },
+				},
+			},
+		},
+	},
+},
+
 /*
  * HP Wireless Audio
  * When not ignored, causes instability issues for some users, forcing them to
-- 
2.33.0

