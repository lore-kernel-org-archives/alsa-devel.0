Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8C5C2D0E4
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:03:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EF620724
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jYa22Dlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EF620724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C921E16C3;
	Mon, 23 Nov 2020 10:02:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C921E16C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606122188;
	bh=sFQK55Xo29stmXsXL7ZK2tWIrc7BQvtcGBaNAawLku4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jYa22DlqpNP0qZu4rHXGtQjUN8t3CnbWHpvjfiKqE2DZZewG5nqBkkan787zinjg7
	 J5qojIk90AlKp2Q4LvELkxeSB+cah6ZeCL98nCXNPsuCGzMOeQAR7iEC5RtAHoVxNC
	 OiecOC87krwhNDbRrqXGTZF1Utk1v7q0Tu3Mp3RI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AEB5F804FA;
	Mon, 23 Nov 2020 09:54:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A116F804DF; Mon, 23 Nov 2020 09:54:27 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7286EF804D6
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 09:54:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7286EF804D6
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 37019AFCB;
 Mon, 23 Nov 2020 08:53:58 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 23/41] ALSA: usb-audio: Always set up the parameters after
 resume
Date: Mon, 23 Nov 2020 09:53:29 +0100
Message-Id: <20201123085347.19667-24-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201123085347.19667-1-tiwai@suse.de>
References: <20201123085347.19667-1-tiwai@suse.de>
Cc: Matwey Kornilov <matwey.kornilov@gmail.com>,
 Dylan Robinson <dylan_robinson@motu.com>,
 Keith Milner <kamilner@superlative.org>
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

The commit 92adc96f8eec ("ALSA: usb-audio: set the interface format
after resume on Dell WD19") introduced the workaround for the broken
setup after the resume specifically on a Dell dock model.  However,
the full setup should have been performed after the resume on all
devices, as we can't guarantee the same state.  So this patch removes
the conditional check and applies the workaround always.

Tested-by: Keith Milner <kamilner@superlative.org>
Tested-by: Dylan Robinson <dylan_robinson@motu.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c          | 20 ++++++--------------
 sound/usb/quirks-table.h |  8 --------
 sound/usb/quirks.c       | 11 -----------
 sound/usb/usbaudio.h     |  1 -
 4 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 32237623de96..ac6385a4eb70 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1835,6 +1835,9 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 					      subs);
 		subs->running = 1;
 		return 0;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		subs->need_setup_fmt = true;
+		fallthrough;
 	case SNDRV_PCM_TRIGGER_STOP:
 		stop_endpoints(subs);
 		snd_usb_endpoint_set_callback(subs->data_endpoint,
@@ -1849,13 +1852,6 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 					      subs);
 		subs->running = 0;
 		return 0;
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-		if (subs->stream->chip->setup_fmt_after_resume_quirk) {
-			stop_endpoints(subs);
-			subs->need_setup_fmt = true;
-			return 0;
-		}
-		break;
 	}
 
 	return -EINVAL;
@@ -1879,6 +1875,9 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 					      subs);
 		subs->running = 1;
 		return 0;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		subs->need_setup_fmt = true;
+		fallthrough;
 	case SNDRV_PCM_TRIGGER_STOP:
 		stop_endpoints(subs);
 		fallthrough;
@@ -1887,13 +1886,6 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 					      NULL, NULL, NULL);
 		subs->running = 0;
 		return 0;
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-		if (subs->stream->chip->setup_fmt_after_resume_quirk) {
-			stop_endpoints(subs);
-			subs->need_setup_fmt = true;
-			return 0;
-		}
-		break;
 	}
 
 	return -EINVAL;
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 3c1697f6b60c..85b99c6d3c61 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3256,14 +3256,6 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		}
 	}
 },
-/* Dell WD19 Dock */
-{
-	USB_DEVICE(0x0bda, 0x402e),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_SETUP_FMT_AFTER_RESUME
-	}
-},
 /* MOTU Microbook II */
 {
 	USB_DEVICE_VENDOR_SPEC(0x07fd, 0x0004),
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 013ab93fb640..7e7f258011ff 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -508,16 +508,6 @@ static int create_standard_mixer_quirk(struct snd_usb_audio *chip,
 	return snd_usb_create_mixer(chip, quirk->ifnum, 0);
 }
 
-
-static int setup_fmt_after_resume_quirk(struct snd_usb_audio *chip,
-				       struct usb_interface *iface,
-				       struct usb_driver *driver,
-				       const struct snd_usb_audio_quirk *quirk)
-{
-	chip->setup_fmt_after_resume_quirk = 1;
-	return 1;	/* Continue with creating streams and mixer */
-}
-
 static int setup_disable_autosuspend(struct snd_usb_audio *chip,
 				       struct usb_interface *iface,
 				       struct usb_driver *driver,
@@ -565,7 +555,6 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
 		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk,
 		[QUIRK_AUDIO_STANDARD_MIXER] = create_standard_mixer_quirk,
-		[QUIRK_SETUP_FMT_AFTER_RESUME] = setup_fmt_after_resume_quirk,
 		[QUIRK_SETUP_DISABLE_AUTOSUSPEND] = setup_disable_autosuspend,
 	};
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index aa017a93f7bd..cc338e8e2597 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -35,7 +35,6 @@ struct snd_usb_audio {
 	wait_queue_head_t shutdown_wait;
 	unsigned int txfr_quirk:1; /* Subframe boundaries on transfers */
 	unsigned int tx_length_quirk:1; /* Put length specifier in transfers */
-	unsigned int setup_fmt_after_resume_quirk:1; /* setup the format to interface after resume */
 	unsigned int need_delayed_register:1; /* warn for delayed registration */
 	int num_interfaces;
 	int num_suspended_intf;
-- 
2.16.4

