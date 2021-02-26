Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9092FC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 13:46:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F2564DF1
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 13:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F2564DF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F31111668;
	Mon,  1 Mar 2021 14:45:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F31111668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614606375;
	bh=OQjTraQQXSq0SeYB3yWlM+OHyRDufnC/efmtiZk95iM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fBr3zr0a/c8vUqnSXGpld08IGB2CcKcDG9qYHhWI0LZ34xapak22Fu68rp5AxWRBL
	 p2wNyirwFSie+Iviv3HlNjho7KAu5Kr6LxMvF0sx2O8+AH9jX55ILI97ZvmuQtOFlg
	 dCSBZ7nbeGKl0Gi8DB3YKRSkqwGgyAhDTe+JYTCc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C70D2F804EB;
	Mon,  1 Mar 2021 14:43:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F57BF80249; Fri, 26 Feb 2021 14:35:26 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA5D9F8012C
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2021 14:35:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA5D9F8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Gho2tahP"
Received: by mail-wm1-x332.google.com with SMTP id u125so7792786wmg.4
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2021 05:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Lrsbjqm1gtI5vnM+ltxWfawo/4JXDdpL3EUuf+EhV8=;
 b=Gho2tahPWZJIf/AtegxIrR/xnv20JPvut0mrJat3K9rOTYOluMMijTrTWGuj+TLQdT
 2XcC1ijA3rTTK66WCcjhAxIRqXdWKfNkYfuzZR+MW0oNkgZkC+xzz3rMPZvOZ6rbiTme
 AYAQwK1dj9WtrSsbjad21hwyL3sMJntbwT/TZNvcSxtMZ7d8KoFIIDqQA299WHlNEKtr
 69C+uUBjjaLOROBjnbUf7xit4ou9S2vV3ICMJx4+zLYVIZ5ndYDkSORVycknquSFWjzo
 5d+qOLmHxUojQffQ7vwuYZGb2RSlfhBrWI6AqQWSTTki9Nz8be18WRYgsctAXOaow+EZ
 w2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Lrsbjqm1gtI5vnM+ltxWfawo/4JXDdpL3EUuf+EhV8=;
 b=pfpZpAbaILzZ9m9GlCflRnGIEkqFeS4egB5N8pFernJ0aL8qAPoFse7EYKPnJYsoyu
 rT32mBAb9K3U+QLzIE7EsghlFJINF6zZsQcAYK/7EFHjaAtg1x4IQn9i0X6uXoO4zRIF
 GL3iqpqJ5mBqRgi9i71jsN5UKrFNz81Ikgg0rr1FeQWPQXjHN6UPXXA3EvWvwGhFScYE
 n2mN5sSkaJbmvDUAgRroM3vOAK/3qDv/UBaNv7A/FZGVy0GWqeLFruSUjcxzt0bniXCY
 6hZkPXj2Kti9wEPmTChTB8+bzuzTHu+VwzhijPx4c01Txp0MEa1D0DixyHRceRFvorqR
 MEyA==
X-Gm-Message-State: AOAM530BoF1bRivDfDeH8YAjoNZwv6UAyV59XCPT2A5A9xk3r99Ofufm
 hDoFSlEUlglYKfHPUpYhj/54d9+9TcPfzax4
X-Google-Smtp-Source: ABdhPJxjDNDxu2RHNmlzyq0MOvfYcZgtfI6Iq8UOyfKfVhnQAftxYzG/hl0rB+twIflh7iTmI8TM5Q==
X-Received: by 2002:a1c:4b16:: with SMTP id y22mr2913388wma.99.1614346518732; 
 Fri, 26 Feb 2021 05:35:18 -0800 (PST)
Received: from localhost.localdomain (176-171-138-112.abo.bbox.fr.
 [176.171.138.112])
 by smtp.googlemail.com with ESMTPSA id c26sm13175547wrb.87.2021.02.26.05.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Feb 2021 05:35:18 -0800 (PST)
From: Nicolas MURE <nicolas.mure2019@gmail.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ALSA: usb-audio: Add Pioneer DJM-850 to quirks-table
Date: Fri, 26 Feb 2021 14:34:26 +0100
Message-Id: <20210226133429.20081-2-nicolas.mure2019@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210226133429.20081-1-nicolas.mure2019@gmail.com>
References: <20210226133429.20081-1-nicolas.mure2019@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Mar 2021 14:43:22 +0100
Cc: Nicolas MURE <nicolas.mure2019@gmail.com>, livvy@base.nu
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

Declare the Pioneer DJM-850 interfaces for capture and playback.

See https://github.com/nm2107/Pioneer-DJM-850-driver-reverse-engineering
    /blob/172fb9a61055960c88c67b7c416fe5bf3609807b
    /doc/usb-device-specifications.md

for the complete device spec.

Signed-off-by: Nicolas MURE <nicolas.mure2019@gmail.com>
---
 sound/usb/quirks-table.h | 63 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 1165a5ac60f2..9716a9f7c095 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3817,6 +3817,69 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		}
 	}
 },
+{
+	/*
+	 * Pioneer DJ DJM-850
+	 * 8 channels playback and 8 channels capture @ 44.1/48/96kHz S24LE
+	 * Playback on EP 0x05
+	 * Capture on EP 0x86
+	 */
+	USB_DEVICE_VENDOR_SPEC(0x08e4, 0x0163),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 8,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x05,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+					    USB_ENDPOINT_SYNC_ASYNC|
+						USB_ENDPOINT_USAGE_DATA,
+					.rates = SNDRV_PCM_RATE_44100|
+						SNDRV_PCM_RATE_48000|
+						SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) { 44100, 48000, 96000 }
+				}
+			},
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 8,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x86,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						USB_ENDPOINT_SYNC_ASYNC|
+						USB_ENDPOINT_USAGE_DATA,
+					.rates = SNDRV_PCM_RATE_44100|
+						SNDRV_PCM_RATE_48000|
+						SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) { 44100, 48000, 96000 }
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 {
 	/*
 	 * Pioneer DJ DJM-450
-- 
2.29.2

