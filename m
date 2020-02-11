Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6F2C352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:15:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDDC20714
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D6CB5ciy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDDC20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C2F2166F;
	Tue, 11 Feb 2020 12:14:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C2F2166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581419732;
	bh=mgHr1wfrAlCr078EkV6vnSv19Z5V5hFfDPmI6tFqjCc=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D6CB5ciyNpta+ucoZZx44sCixyKz+1rQRBCJSe7E5yuJmbKZG+iWdCF8t3BVk1gRk
	 tj4hW78NW5NgMeI2BfYYJ7dvz8HViD08wfun8SHHUbVbmg5YzY2KKFaFfdkVZgWDN9
	 BpGJwNZ7rjOMHwt8bmEe+SeIEPkwLMMBBhltnrbo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07AEFF80218;
	Tue, 11 Feb 2020 12:14:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B918F8021E; Tue, 11 Feb 2020 12:14:24 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88E82F8013D
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 12:14:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88E82F8013D
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 90CA9AB95
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 11:14:20 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 11 Feb 2020 12:14:19 +0100
Message-Id: <20200211111419.5895-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: usb-audio: Apply 48kHz fixed rate
	playback for Jabra Evolve 65 headset
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Jabra Evolve 65 headset appears as if supporting lower rates than
48kHz, but it actually doesn't work but with 48kHz for playback.

This patch applies a workaround to enforce the 48kHz like LINE6
devices already did.  The workaround is put in a unified helper
function, set_fixed_rate(), to be called from both places now.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206149
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/format.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 9260136e4c9b..50cb183958bf 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -151,6 +151,19 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 	return pcm_formats;
 }
 
+static int set_fixed_rate(struct audioformat *fp, int rate, int rate_bits)
+{
+	kfree(fp->rate_table);
+	fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
+	if (!fp->rate_table)
+		return -ENOMEM;
+	fp->nr_rates = 1;
+	fp->rate_min = rate;
+	fp->rate_max = rate;
+	fp->rates = rate_bits;
+	fp->rate_table[0] = rate;
+	return 0;
+}
 
 /*
  * parse the format descriptor and stores the possible sample rates
@@ -223,6 +236,14 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 		fp->rate_min = combine_triple(&fmt[offset + 1]);
 		fp->rate_max = combine_triple(&fmt[offset + 4]);
 	}
+
+	/* Jabra Evolve 65 headset */
+	if (chip->usb_id == USB_ID(0x0b0e, 0x030b)) {
+		/* only 48kHz for playback while keeping 16kHz for capture */
+		if (fp->nr_rates != 1)
+			return set_fixed_rate(fp, 48000, SNDRV_PCM_RATE_48000);
+	}
+
 	return 0;
 }
 
@@ -299,17 +320,7 @@ static int line6_parse_audio_format_rates_quirk(struct snd_usb_audio *chip,
 	case USB_ID(0x0e41, 0x4248): /* Line6 Helix >= fw 2.82 */
 	case USB_ID(0x0e41, 0x4249): /* Line6 Helix Rack >= fw 2.82 */
 	case USB_ID(0x0e41, 0x424a): /* Line6 Helix LT >= fw 2.82 */
-		/* supported rates: 48Khz */
-		kfree(fp->rate_table);
-		fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
-		if (!fp->rate_table)
-			return -ENOMEM;
-		fp->nr_rates = 1;
-		fp->rate_min = 48000;
-		fp->rate_max = 48000;
-		fp->rates = SNDRV_PCM_RATE_48000;
-		fp->rate_table[0] = 48000;
-		return 0;
+		return set_fixed_rate(fp, 48000, SNDRV_PCM_RATE_48000);
 	}
 
 	return -ENODEV;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
