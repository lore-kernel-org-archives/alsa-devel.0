Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0BDEEAA5D
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Sep 2023 17:34:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5DD9852;
	Thu, 14 Sep 2023 19:33:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5DD9852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694712839;
	bh=JTFl73t3Lx5K1modcJ7wG+PSUnRGXJ402giRm5529hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qtd9IntwjWu0EorE6Y6b9nmcnkGCfEBwrWg+MKrNir8cMR2cZlbefli6nlDHEiL8v
	 weABedDRNzwh76FPFgRlonzNUs4UjO8lfwye5ycFUInrgW+Dlhv7Vdd9/AGfm8NOVz
	 Dl9IaV4ENY+U8Aw0wy1puB1kRA37gsd+H+JFZUgM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AED8F805A1; Thu, 14 Sep 2023 19:32:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AC939F80212;
	Thu, 14 Sep 2023 19:32:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2949F8057E; Thu, 14 Sep 2023 19:32:46 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1808CF80551
	for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2023 19:32:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1808CF80551
Received: by m.b4.vu (Postfix, from userid 1000)
	id 26485604F2A7; Fri, 15 Sep 2023 03:02:37 +0930 (ACST)
Date: Fri, 15 Sep 2023 03:02:37 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Philippe Perrot <philippe@perrot-net.fr>
Subject: [PATCH 3/4] ALSA: scarlett2: Add support for Clarett 8Pre USB
Message-ID: <e59f47b29e2037f031b56bde10474c6e96e31ba5.1694705811.git.g@b4.vu>
References: <cover.1694705811.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694705811.git.g@b4.vu>
Message-ID-Hash: KUIKDVCRW3JU5OS4ZQXG5G7O4PBHKR3B
X-Message-ID-Hash: KUIKDVCRW3JU5OS4ZQXG5G7O4PBHKR3B
X-MailFrom: g@b4.vu
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KUIKDVCRW3JU5OS4ZQXG5G7O4PBHKR3B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Clarett 8Pre USB works the same as the Clarett+ 8Pre, only the USB
ID is different.

Tested-by: Philippe Perrot <philippe@perrot-net.fr>
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_quirks.c        |  1 +
 sound/usb/mixer_scarlett_gen2.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index ab0d459f4271..9911859d2750 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3420,6 +3420,7 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x1235, 0x8213): /* Focusrite Scarlett 8i6 3rd Gen */
 	case USB_ID(0x1235, 0x8214): /* Focusrite Scarlett 18i8 3rd Gen */
 	case USB_ID(0x1235, 0x8215): /* Focusrite Scarlett 18i20 3rd Gen */
+	case USB_ID(0x1235, 0x8208): /* Focusrite Clarett 8Pre USB */
 	case USB_ID(0x1235, 0x820c): /* Focusrite Clarett+ 8Pre */
 		err = snd_scarlett_gen2_init(mixer);
 		break;
diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index e4f1bfc54533..9b668ea57cb6 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1,13 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *   Focusrite Scarlett Gen 2/3 and Clarett+ Driver for ALSA
+ *   Focusrite Scarlett Gen 2/3 and Clarett USB/Clarett+ Driver for ALSA
  *
  *   Supported models:
  *   - 6i6/18i8/18i20 Gen 2
  *   - Solo/2i2/4i4/8i6/18i8/18i20 Gen 3
+ *   - Clarett 8Pre USB
  *   - Clarett+ 8Pre
  *
- *   Copyright (c) 2018-2022 by Geoffrey D. Bennett <g at b4.vu>
+ *   Copyright (c) 2018-2023 by Geoffrey D. Bennett <g at b4.vu>
  *   Copyright (c) 2020-2021 by Vladimir Sadovnikov <sadko4u@gmail.com>
  *   Copyright (c) 2022 by Christian Colglazier <christian@cacolglazier.com>
  *
@@ -56,6 +57,9 @@
  * Support for Clarett+ 8Pre added in Aug 2022 by Christian
  * Colglazier.
  *
+ * Support for Clarett 8Pre USB added in Sep 2023 (thanks to Philippe
+ * Perrot for confirmation).
+ *
  * This ALSA mixer gives access to (model-dependent):
  *  - input, output, mixer-matrix muxes
  *  - mixer-matrix gain stages
@@ -899,7 +903,8 @@ static const struct scarlett2_device_entry scarlett2_devices[] = {
 	{ USB_ID(0x1235, 0x8214), &s18i8_gen3_info },
 	{ USB_ID(0x1235, 0x8215), &s18i20_gen3_info },
 
-	/* Supported Clarett+ devices */
+	/* Supported Clarett USB/Clarett+ devices */
+	{ USB_ID(0x1235, 0x8208), &clarett_8pre_info },
 	{ USB_ID(0x1235, 0x820c), &clarett_8pre_info },
 
 	/* End of list */
-- 
2.41.0

