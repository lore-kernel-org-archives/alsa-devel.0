Return-Path: <SRS0=9Cbg=PC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E7CC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 13:08:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584D9610CC
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 13:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 584D9610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF7EE1693;
	Thu, 14 Oct 2021 15:08:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF7EE1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634216936;
	bh=n+PBtyhri6Cdr3RV1BqRaeb8tAgefST717agpk2+72w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a/9DqVRWMxnPeIx3zKMLHs8tEeJPXcYyi5Sv4UQVknfkNafMX8oyvmnT0utfJchV4
	 bLG/mFo64FT6fgb5y5+6D7/i/QvNHOBsj0cHlgeWuL/IivSlKCytPQHtB0VYsyMJB4
	 Y1yqZqOTQPsqt7k/0xG49sHM0bEVHqHEELktSL0E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD94DF804FD;
	Thu, 14 Oct 2021 15:06:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6984EF804FC; Thu, 14 Oct 2021 15:06:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30168F80302
 for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2021 15:06:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30168F80302
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="QOw6ftX7"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="C+5p4qQP"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2DC8C1FD39;
 Thu, 14 Oct 2021 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634216799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIoIddnHoRRVBApdOl1PkrxDCOErtRrmELCndGsahpw=;
 b=QOw6ftX7s7vEoM2+YCrCfxdEjuiUtXr6mBPnuMoa30HdTAEBMPD1y9UXAQ1NIukYUshMdA
 ieG3rzZHvW0sY19p5Yvv1FQ5zclkRT/dovocAZtwhRPX9NOHY2WJTRvCBR3AvxcStOzG+M
 jyy+2Nk0258+1LiG6lqNORGOsuIVYPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634216799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIoIddnHoRRVBApdOl1PkrxDCOErtRrmELCndGsahpw=;
 b=C+5p4qQPCa5RGDyrKMqduDOKEg9pQml9mdu99ln5ITR7cbuNMQQcRfqZxf2GfB5RgugsE1
 clclTLd8cN882oBg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 1D21FA3B85;
 Thu, 14 Oct 2021 13:06:39 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ALSA: usb-audio: Initialize every feature unit once at
 probe time
Date: Thu, 14 Oct 2021 15:06:36 +0200
Message-Id: <20211014130636.17860-4-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211014130636.17860-1-tiwai@suse.de>
References: <20211014130636.17860-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

So far we used to read the current value of the mixer element
dynamically at the first access, and the error from a GET_CUR message
is treated as a fatal error (unless QUIRK_IGNORE_CTL_ERROR is set).
It's rather inconvenient, as most of GET_CUR errors are no fatal, and
we can continue operation with assumption of some fixed value.

This patch makes the USB-audio driver to change the behavior at probe
time; now it tries to initialize the current value of each mixer
element that is built from a feature unit (those for typically for
mixer volumes and switches).  When a read failure happens, it tries to
set the known minimum value.  After that point, a cached value is used
always, hence we won't hit GET_CUR message error any longer.

The error from GET_CUR message is still shown as a warning normally,
but only once at the probe time, and it'll keep operating.  If the
message is confirmed to be harmless, it can be shut up by
QUIRK_IGNORE_CTL_ERROR quirk flag, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 60d394361a43..4555de9830c5 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1199,12 +1199,32 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 	}
 }
 
+/* forcibly initialize the current mixer value; if GET_CUR fails, set to
+ * the minimum as default
+ */
+static void init_cur_mix_raw(struct usb_mixer_elem_info *cval, int ch, int idx)
+{
+	int val, err;
+
+	err = snd_usb_get_cur_mix_value(cval, ch, idx, &val);
+	if (!err)
+		return;
+	if (!cval->head.mixer->ignore_ctl_error)
+		usb_audio_warn(cval->head.mixer->chip,
+			       "%d:%d: failed to get current value for ch %d (%d)\n",
+			       cval->head.id, mixer_ctrl_intf(cval->head.mixer),
+			       ch, err);
+	snd_usb_set_cur_mix_value(cval, ch, idx, cval->min);
+}
+
 /*
  * retrieve the minimum and maximum values for the specified control
  */
 static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 				   int default_min, struct snd_kcontrol *kctl)
 {
+	int i, idx;
+
 	/* for failsafe */
 	cval->min = default_min;
 	cval->max = cval->min + 1;
@@ -1217,7 +1237,6 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 	} else {
 		int minchn = 0;
 		if (cval->cmask) {
-			int i;
 			for (i = 0; i < MAX_CHANNELS; i++)
 				if (cval->cmask & (1 << i)) {
 					minchn = i + 1;
@@ -1318,6 +1337,19 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 		}
 	}
 
+	/* initialize all elements */
+	if (!cval->cmask) {
+		init_cur_mix_raw(cval, 0, 0);
+	} else {
+		idx = 0;
+		for (i = 0; i < MAX_CHANNELS; i++) {
+			if (cval->cmask & (1 << i)) {
+				init_cur_mix_raw(cval, i + 1, idx);
+				idx++;
+			}
+		}
+	}
+
 	return 0;
 }
 
-- 
2.26.2

