Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6A606A31C
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=qomaleic;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2KZ3WuW
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32851601DC;
	Mon,  9 Nov 2026 10:04:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32851601DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794215081;
	bh=bQ3trnLF5f6m2gxJ975+lagyt30TQnbKtEIZXwHaclw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qomaleic2Bykt60V3V5lZ28IORtv+l2YwghOBWmwhlkHCpnz3n3dyldMMZ1QRhxay
	 ABSTEyvEicB6XlTiN8DMam6tydIN/2/ayT1c+6zwNjN0A/zkqjKtvFHdorvyD8yRmO
	 oO4zyU6or2MOIqWO2B/OpJDPSSPNnTgWn91MVe0g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DFD4F805EF; Mon,  9 Nov 2026 10:04:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C57FCF805EF;
	Mon,  9 Nov 2026 10:04:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A13AF805C7; Mon,  9 Nov 2026 10:03:57 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794215035;
	b=o0sDw+awDgVsNH3PYzw4wXrBzYLUHhriT/22FF7taAKKEyg8tstn4iMtN3e92fqk64r/
	 MWFNh8xwFepYS00ancUA2skqMhgctiTwKKy/XASXOX6KhhDxE8AD/5guXr8wJLJA7c1k2
	 Y+pRWWok6+noLdXIZcir2kU/65ncnTqALXPMbgF6NvUzW6O+b+M1yny+KcbsfWdJWH8CK
	 t9fKJf6LHnY8NHR3ht0uOVDFwI5XJaRgS77s97s0T0tEVT2DLvoSPflI1OJLEZbxuIeRt
	 XsLbGfAr7QoBg2Xh40uuU37AgHcZeJIBk/aV6E6JeM0VenTvyHGuMnakUhp5RzDQKLA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794215035;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bQ3trnLF5f6m2gxJ975+lagyt30TQnbKtEIZXwHaclw=;
	b=fD7wGce3ok4vqFOAh1GEUn2eVF3fyi/tRr14KuUlJtf+OoqV5yvrbJdLVbIVa6gOhpfo
	 MoJ+aFdQjjuTf8qyh2pTYtJro5wm3I+xv4bKZvswPjeJxZIiddsDdmLYuWCUB0l3PjVOD
	 0JdD9XmeRyrCP9/1gm4PtuO/jVLdoGZP9CwFIKR1fEA62P/J8OxP1B2Wq7oKQtkkYzPzu
	 Z976JdCqrDHdER8yb0yA9F4FS7uv1tfednznZ0kZ9QMl42pB8rJy8ngfnw6f1zTjp9dAv
	 /beSOFdC42lElSAY+6weiEdJJ+zqJW/VJFhGGH1J8uGT4zUYO82mpYPlNukcBNWN0FQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=C2KZ3WuW;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 49413F805B0
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2026 10:03:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49413F805B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=C2KZ3WuW
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 648CE40564;
	Mon,  9 Nov 2026 09:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107FA1F0089F;
	Mon,  9 Nov 2026 09:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215030;
	bh=xL7NICnviPylGawuY6UFdSAue0kDWn0dNEjgPy6oRAo=;
	h=From:To:Cc:Subject:Date;
	b=C2KZ3WuWjUIzoa8FcZUcaFzzQZhqMrHjM++x3qrdMIuFFCSVoc+/Ozkksr8Btqymr
	 woteoGAq+NPOYL4t2nZT/EnFjR889tG3rGDRry5BhOVYpez37nrqrpJTVXD7P9nNda
	 Fqo5uLViJhTiVN9ct41r6psIXua2EUoB6R2NL7yxFhvX4Lk2SlDKyMEQVA59ijHtTp
	 rBI7dhrjR2bt4HFsQO2te6Vh8hoCrAzXOUoKFrk3iGHls+xbVmfzt8Z+ggM6bMEajt
	 cUnKm96emTdtZlA+lTjLAV0dI9EXub9WqLAeGDbI9eHDlTSEon3dSuQrh9m8KJOvqp
	 WDWFVgIYEhusw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [STABLE v6.1-v5.15] ALSA: usb-audio: Don't try to submit URBs after
 disconnection
Date: Mon,  9 Nov 2026 09:03:44 +0000
Message-ID: <20261109090346.2098226-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5EY6AXL4LTTBAIB34XPHQ7HMD7RABHIS
X-Message-ID-Hash: 5EY6AXL4LTTBAIB34XPHQ7HMD7RABHIS
X-MailFrom: lee@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5EY6AXL4LTTBAIB34XPHQ7HMD7RABHIS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: Takashi Iwai <tiwai@suse.de>

commit ab574d1629552b6831cd91b926b38092c15d6142 upstream.

USB-audio driver can still submit URBs while the device is being
disconnected, and it may result in spurious error messages like:
  usb 1-2: cannot submit urb (err = -19)
  usb 1-2: Unable to submit urb #0: -19 at snd_usb_queue_pending_output_urbs
  usb 1-2: cannot submit urb 0, error -19: no device
Although those are harmless, they are just ugly.

This patch tries to avoid spewing such error messages when the device
is already at the disconnected state.  It also skips the superfluous
xfer notification, too.

Link: https://lore.kernel.org/r/20230828101924.27107-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 sound/usb/endpoint.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index dd81c94cbb52..167eefc14d82 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -520,13 +520,18 @@ int snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 			return -EPIPE;
 		}
 
-		err = usb_submit_urb(ctx->urb, GFP_ATOMIC);
+		if (!atomic_read(&ep->chip->shutdown))
+			err = usb_submit_urb(ctx->urb, GFP_ATOMIC);
+		else
+			err = -ENODEV;
 		if (err < 0) {
-			usb_audio_err(ep->chip,
-				      "Unable to submit urb #%d: %d at %s\n",
-				      ctx->index, err, __func__);
-			if (!in_stream_lock)
-				notify_xrun(ep);
+			if (!atomic_read(&ep->chip->shutdown)) {
+				usb_audio_err(ep->chip,
+					      "Unable to submit urb #%d: %d at %s\n",
+					      ctx->index, err, __func__);
+				if (!in_stream_lock)
+					notify_xrun(ep);
+			}
 			return -EPIPE;
 		}
 
@@ -593,12 +598,17 @@ static void snd_complete_urb(struct urb *urb)
 		prepare_inbound_urb(ep, ctx);
 	}
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!atomic_read(&ep->chip->shutdown))
+		err = usb_submit_urb(urb, GFP_ATOMIC);
+	else
+		err = -ENODEV;
 	if (err == 0)
 		return;
 
-	usb_audio_err(ep->chip, "cannot submit urb (err = %d)\n", err);
-	notify_xrun(ep);
+	if (!atomic_read(&ep->chip->shutdown)) {
+		usb_audio_err(ep->chip, "cannot submit urb (err = %d)\n", err);
+		notify_xrun(ep);
+	}
 
 exit_clear:
 	clear_bit(ctx->index, &ep->active_mask);
@@ -1646,11 +1656,15 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
 			goto __error;
 		}
 
-		err = usb_submit_urb(urb, GFP_ATOMIC);
+		if (!atomic_read(&ep->chip->shutdown))
+			err = usb_submit_urb(urb, GFP_ATOMIC);
+		else
+			err = -ENODEV;
 		if (err < 0) {
-			usb_audio_err(ep->chip,
-				"cannot submit urb %d, error %d: %s\n",
-				i, err, usb_error_string(err));
+			if (!atomic_read(&ep->chip->shutdown))
+				usb_audio_err(ep->chip,
+					      "cannot submit urb %d, error %d: %s\n",
+					      i, err, usb_error_string(err));
 			goto __error;
 		}
 		set_bit(i, &ep->active_mask);
-- 
2.56.0.506.g506a7eabc5-goog

