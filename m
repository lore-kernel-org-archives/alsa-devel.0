Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9FCC74A5B
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Mar 2023 16:09:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B53651FA;
	Wed, 29 Mar 2023 18:08:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B53651FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680106158;
	bh=IodIOhCVLN4y1Y0ir+/s3cyf2XSbGcgQTQtUCqAXF6E=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MT9LMJd0QuI4YywEMaMtqSVQ80ms0RJlMzJCVZBWxPnSH1J+MzhUrd0yd/yn+PNvJ
	 nDxh898sMaZW9Eb6xynZ4dmxf1SYo6BbBoY0QO57VaxREbDafIwqybcQH+2l6Zgq/0
	 BPzE/ux314C+m0PJkcC0gac9pTmci4BSiy72G81Q=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 15F29F805AA;
	Wed, 29 Mar 2023 18:06:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4D7CDF802E8; Sat, 25 Mar 2023 09:37:04 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1ECD5F8027B
	for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2023 09:36:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1ECD5F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=C63Ln4cb
Received: by mail-wr1-x432.google.com with SMTP id h17so3864916wrt.8
        for <alsa-devel@alsa-project.org>;
 Sat, 25 Mar 2023 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq9FEnTj7FoMjw/gmnidJvZt7UB0t16wRzVKOg51PoU=;
        b=C63Ln4cbdBEFNaAtwZnNcK3wxmaH9YcpZlBQhu9BFowDQX4wPmVFaTXFVbDWSC95GS
         B+xgj6im0tCPY2KPNId1xDxggGn8KDT6NuW7HrNnovnoiAwFi13zV2zcr54g4Hidc6+e
         Y+v7NcW6ZxKGYT3cgSTWUF9eUO7MVrZlld0da4SGiCzJQ3HbKdBRtGvsLyafy+DstAfA
         fukfS99IOoZvf252KgsqjRKxARdBskv5Ql5UKUvFhgSn5u7M/a+zx/r41OTxOIrjZZE0
         /9AcQu1SUCnNij8FHBDeYQ+iTc1c3CoKb3g23/e4QXcHO6Vhm0nlJdTBWCQ5OFi/A5dU
         ixUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jq9FEnTj7FoMjw/gmnidJvZt7UB0t16wRzVKOg51PoU=;
        b=c4trvwq5gIZ0+FVVxKU3uXgtJpAa0x6sdsmfy/HN3urE1F7+OxD975H0Ophlgkh4Yo
         5YYlJjwMq+DsbBr7lrXA4fUKdrPLM/DWFxpo8CQU4zDCtFcO8Tlqt9rzgxRBWwdI9miL
         CFleSYmPwBeWzQrNEN9sXkKAI43HAuzgksVZF1Ue1QEeWpvDgouLY/l6eU23l5JIELid
         Pfl6XfKpnNttgJxrOWgQYjJV0Gsk1j//QTSsR2FCkCdcIGaIRqR6UqBHnP8Z+/J05M9E
         BNhtV5kUlRPKJfMnyZXO8ZVGd/Tp79QHVa2JQNBuCHomRka4cmHl5JfZDj5U5ynqxEWk
         vKug==
X-Gm-Message-State: AAQBX9fFk+sxXdDmmCLju6YCan3a5dGY7Bl1i7dJSRyHE63BICJX7oVO
	b4iopqdtoDSDPa+D3Y/UWUk=
X-Google-Smtp-Source: 
 AKy350YcjB+FqjbJ1ISjNYEgRniwUWZU5VaL6gKZI1bJIVjHEv5O1AEiuA8r8boXGibMdT9c6rNpFg==
X-Received: by 2002:a5d:6b8b:0:b0:2ce:ad08:ca4 with SMTP id
 n11-20020a5d6b8b000000b002cead080ca4mr4027591wrx.35.1679733415092;
        Sat, 25 Mar 2023 01:36:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id
 a18-20020a5d4d52000000b002d1e49cff35sm20108204wru.40.2023.03.25.01.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:36:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>,
	Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 1/1] ASoC: wm8903: implement DMIC support
Date: Sat, 25 Mar 2023 10:36:43 +0200
Message-Id: <20230325083643.7575-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230325083643.7575-1-clamor95@gmail.com>
References: <20230325083643.7575-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: clamor95@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: WWDGYBLDC3DONJEAVGR33KTD7HI3G7A7
X-Message-ID-Hash: WWDGYBLDC3DONJEAVGR33KTD7HI3G7A7
X-Mailman-Approved-At: Wed, 29 Mar 2023 16:06:15 +0000
CC: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WWDGYBLDC3DONJEAVGR33KTD7HI3G7A7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add DMIC input and routing.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF300T
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 sound/soc/codecs/wm8903.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 41346e5ec5ad..9c2f0aadcff3 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -9,7 +9,6 @@
  *
  * TODO:
  *  - TDM mode configuration.
- *  - Digital microphone support.
  */
 
 #include <linux/module.h>
@@ -816,6 +815,7 @@ SND_SOC_DAPM_INPUT("IN2L"),
 SND_SOC_DAPM_INPUT("IN2R"),
 SND_SOC_DAPM_INPUT("IN3L"),
 SND_SOC_DAPM_INPUT("IN3R"),
+SND_SOC_DAPM_INPUT("DMIC"),
 SND_SOC_DAPM_INPUT("DMICDAT"),
 
 SND_SOC_DAPM_OUTPUT("HPOUTL"),
@@ -996,6 +996,9 @@ static const struct snd_soc_dapm_route wm8903_intercon[] = {
 	{ "AIFTXL", NULL, "Left Capture Mux" },
 	{ "AIFTXR", NULL, "Right Capture Mux" },
 
+	{ "ADCL", NULL, "DMIC" },
+	{ "ADCR", NULL, "DMIC" },
+
 	{ "ADCL", NULL, "Left ADC Input" },
 	{ "ADCL", NULL, "CLK_DSP" },
 	{ "ADCR", NULL, "Right ADC Input" },
-- 
2.37.2

