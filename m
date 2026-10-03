Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8416CA5FF1
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:00:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82C8560209;
	Wed,  7 Oct 2026 08:59:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82C8560209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791356401;
	bh=UTMNVBmpziD/6OkhW7k2qdyc4szYQYqPlEN6mgqscUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=O20BWZ8ZYg8ELyYlcINNkclzm90OJhjZdxqEnRJbvlxbu1+4gpcfhhaWxG18V7Qdc
	 8Q4NQDN6E34VHKPpBDYQLuBp/jTb5tSbs/jAK8DDCNmECZ4zu+OMP7/r90kzKrxdjM
	 lcX/XvB+s/VXQ9RNw9x9gHmKJ9z3xXdrFGNUpjvQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA9EDF806E1; Wed,  7 Oct 2026 08:58:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D7C7F806DC;
	Wed,  7 Oct 2026 08:58:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D4C8F80548; Sat,  3 Oct 2026 21:42:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.225.99
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791056533;
	b=EMQTqaqQHP7qce8+hYGnqf0LYFCjd82A474eopagV/LMvFdvZYHw5/za3sKK6DJfFzcY
	 hhhnnUzMBq/hW8AlT7ji4df90xt/ZUILqOBJiROM8TEeonkZfvUv8W5bJWLXXnacex9qv
	 PAH2UNOvbLXyLPklMyrs+1GJN2a1UTph25QFDmF2rme7jY1Lp4VgGMVTDLy967Zwh8R3x
	 xKCgXxnW8DCdW6qpbsJB9gxah9QrDDmWkOV+B+5+lF41aJqfP8pcdXG5raxH66BBSM1nm
	 dTcJvZvPqY9/mD+g6sEvv7Ts2Hsh9RXJeTxJZ29WZyWW4S0jiOY68wV3xegfowENQ7g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791056533;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UTMNVBmpziD/6OkhW7k2qdyc4szYQYqPlEN6mgqscUM=;
	b=HtDE2g7SGhPQYQeqqgc4vYwyH49H7nn2MN8e/sG9IYLLe6KbgLj3fPka2nBS2GABwwXW
	 lToO7huePkXDNswY8SD02f3ogUETZlcku6pl+GjFqsM+ij/PQhIccCJAS/EYE7PBXeq0M
	 QwnoRy34t0NUQL0CdEyNIik6QAM2IMDS+YrpOQtuHdbcu6XhTu38L+oyDhqJRewnVHPqd
	 LzTxaO0cWAR5uxwPc/eN03kQLdHz3QvVf0UUF+bIiZMut0Jm/r2U5ns9JEQrsbiVkuNrX
	 UPcmm2d7oxD/+RfmufBljdBG+zGk37zZGSq1EKLzOHjk2gMGL+Qzz6rv6ef/SAoEw6Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DgbnBK5Q;
	arc=none smtp.remote-ip=74.125.225.99
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0DA82F805A0
	for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2026 21:42:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DA82F805A0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DgbnBK5Q
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48b08452cafso396516f8f.3
        for <alsa-devel@alsa-project.org>;
 Sat, 03 Oct 2026 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056531; x=1791661331;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QTR+lSUTRfb3BDBDCpeSoEx+7dbL4rm5VwUuFbtL9I0=;
        b=DgbnBK5QZDIBkd1gkbkHwb/eQLLmqxaFOUWVJ16HBKQ3V8UR6Y/XLzxoEqmsi6kzZo
         gV5Yj4XGKiw5yMTAqOtJf7NSAiYDVMX1JsvKs1KkSvRdfS7JDzgsMnjWWTGWENJupOSW
         SF3GeDRNzSu7OV0Wtj/ENKnZQJS80LDXexO6/kCfMuYymOVzLkHliXg9liBS86Fcj9J5
         z5eIky5ee3I053vQj33UQKZHMFrEmX34sBic1+ZDqziNXJCmt/2BTQCtq4iRpqCJsJSh
         PrYqP+gMnYBTiXoeH3RNq73faXA+wWpQYvWXc0sn9XnBDmsmvPyn8KaRFM4gtQrmoo5D
         4lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056531; x=1791661331;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QTR+lSUTRfb3BDBDCpeSoEx+7dbL4rm5VwUuFbtL9I0=;
        b=iX/Nhnj4iXEMcpBhIxZOGgTc/V7/wYbFQyt5CgzBck3eiiMmyHElldmg+dkh761wnH
         Vokic/v4qfeYy2JZynJtg+m6pgfaQPnQhCkGsBxWAYiD/ju25j6ejyjk/l3hcpL0y4Q9
         hI6kk7ya9MvupQHqbQTbLCdmxQbYZaKQ/7p8A8U42Ef8geGbjaywVEuF6f7ef916dJSf
         VMYfTV3t6/u+ICbvONdAr+b2GRVoTgDwpxAwY7AmU8kx2JMi6PE3Rvvr3BsiIWVGDWZ1
         Z4HjPisAFCKVNW4n7KlsSaAtYo5XO7l+aS6294vhtg3G43fG/r8E8zMwYt+j4FibjzWd
         9qew==
X-Forwarded-Encrypted: i=1;
 AKwUvBxL7iz0JddSmtKe+OIoVmq1Exnesemj0M7ZmTrKRiH7uqYrYGSS9iG92s2wMUW7qyf/HjfgQzsUl28I@alsa-project.org
X-Gm-Message-State: AFuF++kZ/Cz08FCnmodSpefHqJQThWz/uw4zvWDHLsBGOeznQHG9z45V
	f56JC4Yo/E3tQfIm7/oo9BNPwndYadLKtD7tgIqLg4s6yfoD6BQFmnKT
X-Gm-Gg: AYBFou3EFXGOGsHvdDDzFxq3FV5A2Dccfhi9klSuYUVnejTPZe4ULEXJPFMsY1VlyHJ
	fBuW50Davu7S5ZKQB+QScs8Zb9DhlbA5pqPJ7pJwK3okcagBZpdfS4P6LYAmDN11LlWxkthAHIe
	wdRtLYW7jgSXIyQziC26FbsrnC3tMX5yiDXfBUCmNNOZBBTINWJutu2L+FETCxRCOv2QcMAYkQb
	KnHBHhoh3duAWggWOEvCP7peoXvneJXCQPa5LjerUAL1zbVK7c/ZvfgIWe45kmS09sYf/R0dxx9
	zXDxz1kb1C79vgjKH+zAOfz9t9GyPcU5EfNjdk2UgbSy/D0Hjx3LL3ladBG0vxlUJohd0zttyel
	2Ja1IlZGTq1qkiIU/CNBmj4p81Zm+qVMHHiEm3QTfwV8AeTIjkrYReFBCnzbC2SJmnBmJBZF/OF
	BdRZO1EeJVDeMCJK/S1/m9izbbczvLvrfXHl2KDDjHO/wl7RhwG9YJ2W4dgFjmRJuoDDIfMiw8n
	cjeHGUxiIgk/Bf2CC4pE/zFAn6GKEw2PVYuszI8l7PcVSH8C+D3c/Kr9TGdxagBFVapzHqhN7Nn
	1gen60nhkustMApCtV5JA1/6
X-Received: by 2002:a05:600c:3e07:b0:4a0:1ea2:10c6 with SMTP id
 5b1f17b1804b1-4a0275864a6mr106751835e9.17.1791056531016;
        Sat, 03 Oct 2026 12:42:11 -0700 (PDT)
Received: from cachyos.home
 (2a01cb0c82caf900a186612f304bfea5.ipv6.abo.wanadoo.fr.
 [2a01:cb0c:82ca:f900:a186:612f:304b:fea5])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a162e867e8sm161520495e9.15.2026.10.03.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:42:10 -0700 (PDT)
From: =?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>,
	David Fredman <davfre@gmail.com>
Subject: [RFC PATCH v6 5/8] ALSA: usb: babyfacepro: add S3 suspend/resume
Date: Sat,  3 Oct 2026 21:41:34 +0200
Message-ID: <20261003194137.86176-6-i.bahloul01@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003194137.86176-1-i.bahloul01@gmail.com>
References: <20261003194137.86176-1-i.bahloul01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: i.bahloul01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: CLNKUSEFNANWL5EEYNMNEMES2LJCRQEO
X-Message-ID-Hash: CLNKUSEFNANWL5EEYNMNEMES2LJCRQEO
X-Mailman-Approved-At: Wed, 07 Oct 2026 06:57:57 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CLNKUSEFNANWL5EEYNMNEMES2LJCRQEO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The device loses its registers across a system suspend.  On suspend,
let the PCM core suspend the substreams (applications get -ESTRPIPE and
restart), then kill the session's URBs before cancelling the stream
work their handlers queue.  On resume, re-run the cold init and replay
the cached mixer state and flags.

USB autosuspend stays disabled: nothing in the driver holds a PM
reference while streaming.

Co-developed-by: David Fredman <davfre@gmail.com>
Signed-off-by: David Fredman <davfre@gmail.com>
Signed-off-by: Ismaïl Bahloul <i.bahloul01@gmail.com>
---
 sound/usb/babyfacepro/babyfacepro.c | 77 ++++++++++++++++++++++++-----
 sound/usb/babyfacepro/babyfacepro.h |  6 +--
 2 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/sound/usb/babyfacepro/babyfacepro.c b/sound/usb/babyfacepro/babyfacepro.c
index 0678bea58..aaa74ee68 100644
--- a/sound/usb/babyfacepro/babyfacepro.c
+++ b/sound/usb/babyfacepro/babyfacepro.c
@@ -3,8 +3,8 @@
  * RME Babyface Pro / Pro FS - proprietary-mode USB audio driver
  *
  * Core driver: USB vendor requests + cold init, interrupt-URB PCM
- * streaming, mixer-state persistence across re-probes, and the card
- * lifecycle (probe/disconnect/module entry).
+ * streaming, mixer-state persistence across re-probes/resume, and
+ * the card lifecycle (probe/disconnect/PM/module entry).
  *
  * See babyfacepro.h for the shared device state and register map,
  * and babyfacepro-ctl.c for the ALSA control surface.
@@ -200,9 +200,9 @@ int bf_pitch_write(struct snd_usb_babyface *chip, int pitch)
 }
 
 /* The cold-start init (cap_coldplug.pcap), verbatim from the user-space
- * reference (protocol::streaming_init).  Run at probe, where the
- * device state is unknown; a session start does not need it (see
- * babyface_stream_start()).
+ * reference (protocol::streaming_init).  Run at probe and after resume,
+ * where the device state is unknown; a session start does not need it
+ * (see babyface_stream_start()).
  */
 int bf_cold_init(struct snd_usb_babyface *chip)
 {
@@ -280,8 +280,9 @@ int bf_cold_init(struct snd_usb_babyface *chip)
 static LIST_HEAD(bf_saved_list);
 static DEFINE_MUTEX(bf_saved_mutex);
 
-/* Re-apply the whole cached mixer state to the device, whose registers
- * the cold init cleared.  Caller holds chip->mutex.
+/* Re-apply the whole cached mixer state after a resume (the device
+ * lost its registers across a system suspend - TotalMix does the same
+ * re-apply).  Caller holds chip->mutex.
  */
 int babyface_restore_state(struct snd_usb_babyface *chip)
 {
@@ -409,7 +410,7 @@ int bf_state_apply_flags(struct snd_usb_babyface *chip)
 	/* Re-apply an engaged DIM (the fixed -20 dB Phones pair + flag).  The
 	 * level DIM releases back to is not persisted: it always tracks the
 	 * Phones master while DIM is engaged, so rebuild it here - otherwise a
-	 * DIM released after a re-probe would drive Phones to
+	 * DIM released after a re-probe or resume would drive Phones to
 	 * silence (dim_saved still zero on the fresh chip).
 	 */
 	if (chip->dim) {
@@ -979,8 +980,9 @@ static int babyface_stream_start(struct snd_usb_babyface *chip)
 	/* A session start is what the RME Windows driver sends
 	 * (cap_audio): the trigger pair, the URBs, the arm.  The device
 	 * keeps its mixer state between sessions, so nothing is cleared
-	 * or re-applied here; the cold init runs at probe only.  The rate
-	 * is written first: hw_params only re-points the speed multiplier.
+	 * or re-applied here; the cold init runs at probe and resume
+	 * only.  The rate is written first: hw_params only re-points the
+	 * speed multiplier.
 	 */
 	ret = bf_clock_write(chip);
 	if (ret < 0)
@@ -1667,7 +1669,8 @@ static int babyface_probe(struct usb_interface *intf,
 	chip->card = card;
 
 	chip->dev = usb_get_dev(dev);
-	/* USB autosuspend is untested: nothing in this driver holds a PM
+	/* USB autosuspend is untested: babyface_suspend()/_resume() don't
+	 * check PMSG_IS_AUTO, and nothing in this driver holds a PM
 	 * reference while streaming, so an autosuspend request could race
 	 * a live stream.  Disable it explicitly rather than ship an
 	 * untested code path - full autosuspend support (correct
@@ -1925,6 +1928,56 @@ static void babyface_disconnect(struct usb_interface *intf)
 	snd_card_free_when_closed(chip->card);
 }
 
+static int babyface_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct snd_usb_babyface *chip = usb_get_intfdata(intf);
+
+	struct snd_device *sdev;
+
+	if (!chip)
+		return 0;
+	list_for_each_entry(sdev, &chip->card->devices, list) {
+		if (sdev->type == SNDRV_DEV_PCM)
+			snd_pcm_suspend_all(sdev->device_data);
+	}
+	/* The URB handlers queue the work: kill them first. */
+	mutex_lock(&chip->mutex);
+	if (chip->streaming)
+		babyface_stream_kill(chip);
+	mutex_unlock(&chip->mutex);
+	cancel_work_sync(&chip->stream_work);
+	return 0;
+}
+
+static int babyface_resume(struct usb_interface *intf)
+{
+	struct snd_usb_babyface *chip = usb_get_intfdata(intf);
+	int err;
+
+	if (!chip)
+		return 0;
+
+	/* The device lost its state across the suspend; re-run the cold
+	 * init and re-apply the cached mixer state.  Suspended PCM
+	 * substreams are woken by the core - apps get -ESTRPIPE and
+	 * restart (prepare starts a new session).
+	 */
+	mutex_lock(&chip->mutex);
+	err = usb_set_interface(chip->dev, BF_IFACE, chip->alt);
+	if (err < 0)
+		goto out;
+	err = bf_cold_init(chip);
+	if (err < 0)
+		goto out;
+	err = babyface_restore_state(chip);
+	if (err < 0)
+		goto out;
+	err = bf_state_apply_flags(chip);
+out:
+	mutex_unlock(&chip->mutex);
+	return err;
+}
+
 static const struct usb_device_id babyface_ids[] = {
 	{ USB_DEVICE(USB_VENDOR_RME, USB_PRODUCT_BABYFACE_PRO_FS) },
 	{ }
@@ -1935,6 +1988,8 @@ static struct usb_driver babyface_driver = {
 	.name = "snd-usb-babyface-pro",
 	.probe = babyface_probe,
 	.disconnect = babyface_disconnect,
+	.suspend = babyface_suspend,
+	.resume = babyface_resume,
 	.id_table = babyface_ids,
 };
 
diff --git a/sound/usb/babyfacepro/babyfacepro.h b/sound/usb/babyfacepro/babyfacepro.h
index 783ea03ac..e324e8411 100644
--- a/sound/usb/babyfacepro/babyfacepro.h
+++ b/sound/usb/babyfacepro/babyfacepro.h
@@ -12,7 +12,7 @@
  * snd-usb-audio quirk.
  *
  * babyfacepro.c holds the card lifecycle, the PCM stream and the
- * mixer-state persistence across re-probes;
+ * mixer-state persistence across re-probes and resume;
  * babyfacepro-ctl.c holds the ALSA control surface - the hardware
  * mixer.
  *
@@ -344,7 +344,7 @@ struct snd_usb_babyface {
 	struct snd_kcontrol *dim_kctl;      /* for snd_ctl_notify */
 };
 
-/* The mixer state cached across interface re-probes (see
+/* The mixer state cached across interface re-probes/resume (see
  * babyfacepro.c's own comment on bf_state_save/bf_state_restore).
  */
 struct bf_saved {
@@ -395,7 +395,7 @@ void babyface_pcm_stop_both(struct snd_usb_babyface *chip, snd_pcm_state_t state
 void babyface_stream_work(struct work_struct *work);
 extern const struct snd_pcm_hw_constraint_list bf_rates_constraint;
 
-/* Mixer-state persistence across interface re-probes. */
+/* Mixer-state persistence across interface re-probes/resume. */
 void bf_state_save(struct snd_usb_babyface *chip);
 int bf_state_restore(struct snd_usb_babyface *chip);
 void bf_state_purge(void);
-- 
2.56.0

