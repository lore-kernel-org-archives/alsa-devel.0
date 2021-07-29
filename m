Return-Path: <SRS0=Qkbk=MV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA0C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 10:16:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D0D60E09
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 10:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30D0D60E09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C164E1F4F;
	Thu, 29 Jul 2021 12:16:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C164E1F4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627553813;
	bh=DtRM9dv7NEpGxflpwiB0NWeVKcUG67n4+Enq7Le4G/4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MFCAm7QO/oMx5NWyFESF0LE6WEV+cAQ7MsjLL7EGl12n4uRgLZj9Bk1UUcSDSQ0q+
	 TflJWRnSlyR78j/SS1qTxLAfKInNWly2jVnJd5Rw8UaoRJuu9myf63dzhk4Lyp8EEk
	 mRUNpaVmHgLhmtbWly+0YqRPsVB/FTVuJJQchlxA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BDF32F804FD;
	Thu, 29 Jul 2021 12:14:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8E19F804EC; Thu, 29 Jul 2021 12:14:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68B32F802E7
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 12:13:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68B32F802E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="oaA/qROd"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="pBdpNWI6"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 901E3224E0
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627553626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGMOViJ8/IVgqnD/FZvQigQyRIxfhB6rHYfXackLMdQ=;
 b=oaA/qROdz8Oyfe06zSULge3ONVnun/C3LCdZKxlSkwJMM1sUWF901umuaymw6pL9USl7NU
 t6/ZnPuCXvYvz9eA9jvBBTo67cdM9rs0S8cr9hxYXRibkXTb6wklm9mFjWlN/gvuf+pvUH
 I77+QtPeqTVXkdlufEWFicWrXLuH1WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627553626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGMOViJ8/IVgqnD/FZvQigQyRIxfhB6rHYfXackLMdQ=;
 b=pBdpNWI6KicA6npVMz2+Sf0YXXerM3kJPsJeQ7RbqEYzPAmTIYtgM4222KC8pTmacFXsvX
 +AZallnYLmCwlRDQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 05E46A3C86;
 Thu, 29 Jul 2021 07:44:06 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/15] ALSA: usb-audio: Move generic DSD raw detection into
 quirk_flags
Date: Thu, 29 Jul 2021 09:44:02 +0200
Message-Id: <20210729074404.19728-4-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210729073855.19043-1-tiwai@suse.de>
References: <20210729073855.19043-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The generic DSD raw detection is based on the known allow list, and we
can integrate it into quirk_flags, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c   | 51 +++++++++++++++++++++++---------------------
 sound/usb/usbaudio.h |  3 +++
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index fce3a341adc8..670abc6318f2 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1673,29 +1673,9 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
 
-	/* Mostly generic method to detect many DSD-capable implementations -
-	 * from XMOS/Thesycon
-	 */
-	switch (USB_ID_VENDOR(chip->usb_id)) {
-	case 0x152a:  /* Thesycon devices */
-	case 0x20b1:  /* XMOS based devices */
-	case 0x22d9:  /* Oppo */
-	case 0x23ba:  /* Playback Designs */
-	case 0x25ce:  /* Mytek devices */
-	case 0x278b:  /* Rotel? */
-	case 0x292b:  /* Gustard/Ess based devices */
-	case 0x2972:  /* FiiO devices */
-	case 0x2ab6:  /* T+A devices */
-	case 0x3353:  /* Khadas devices */
-	case 0x3842:  /* EVGA */
-	case 0xc502:  /* HiBy devices */
-		if (fp->dsd_raw)
-			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
-		break;
-	default:
-		break;
-
-	}
+	/* Mostly generic method to detect many DSD-capable implementations */
+	if ((chip->quirk_flags & QUIRK_FLAG_DSD_RAW) && fp->dsd_raw)
+		return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 
 	return 0;
 }
@@ -1917,10 +1897,33 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY | QUIRK_FLAG_IFACE_DELAY),
 	VENDOR_FLG(0x07fd, /* MOTU */
 		   QUIRK_FLAG_VALIDATE_RATES),
+	VENDOR_FLG(0x152a, /* Thesycon devices */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x1de7, /* Phoenix Audio */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	VENDOR_FLG(0x20b1, /* XMOS based devices */
+		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x22d9, /* Oppo */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x23ba, /* Playback Design */
-		   QUIRK_FLAG_CTL_MSG_DELAY | QUIRK_FLAG_IFACE_DELAY),
+		   QUIRK_FLAG_CTL_MSG_DELAY | QUIRK_FLAG_IFACE_DELAY |
+		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x25ce, /* Mytek devices */
+		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x278b, /* Rotel? */
+		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x292b, /* Gustard/Ess based devices */
+		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2972, /* FiiO devices */
+		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2ab6, /* T+A devices */
+		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x3353, /* Khadas devices */
+		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x3842, /* EVGA */
+		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0xc502, /* HiBy devices */
+		   QUIRK_FLAG_DSD_RAW),
 
 	{} /* terminator */
 };
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index a152f5b08c7a..4e93668a2a48 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -159,6 +159,8 @@ extern bool snd_usb_skip_validation;
  *  Disable runtime PM autosuspend
  * QUIRK_FLAG_IGNORE_CTL_ERROR:
  *  Ignore errors for mixer access
+ * QUIRK_FLAG_DSD_RAW:
+ *  Support generic DSD raw U32_BE format
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -176,5 +178,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_VALIDATE_RATES	(1U << 12)
 #define QUIRK_FLAG_DISABLE_AUTOSUSPEND	(1U << 13)
 #define QUIRK_FLAG_IGNORE_CTL_ERROR	(1U << 14)
+#define QUIRK_FLAG_DSD_RAW		(1U << 15)
 
 #endif /* __USBAUDIO_H */
-- 
2.26.2

