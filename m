Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB9606A322
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=OYGIPcvs;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=erCe6p9J
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59F5E6022A;
	Mon,  9 Nov 2026 16:03:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59F5E6022A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236590;
	bh=wx1I0banXX7s3DL2huRr8fCvcews8holDCSosTvHYyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OYGIPcvsclxdR1ifdQLS83YMC/xbqscGlpjW1oQOOUEfKwTzZ2VAEYDMymbKQz+80
	 5yZbxlOABWv3RtzbqlREn1JS+gyPD6Wxw41ytVgrk+36MbMZfKwcMCqhkXWisHORI3
	 yG09ZK4U2L+tAbjbqPCF34rflm6YuBLYZ4u/wRpk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91C75F80679; Mon,  9 Nov 2026 16:00:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 92E6CF80673;
	Mon,  9 Nov 2026 16:00:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 276FFF805BA; Thu,  5 Nov 2026 16:16:58 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793891816;
	b=HC8H84xaW7PuIwauI6T0NgkUZPAGipDoSCDaUusA2f8g4va4rDtADEL0mskXvZNlqp3R
	 7xX7jVkTH++rjnQg7nbCRjI+8R8k6HZCpeN7n7IgEigyCmHw4SWz0bovk7/Kr9uzRunD+
	 8Pgb5sVj/vbuWasIDAty2/QVGgCS23dAIM815GMiaNfW8AZiDsmdRfp3YdF1nzIMxfO7l
	 4ewEciw+VmASVGxPCbuGHSyVZ/FWyLmLUa7ZoK/0YzQTq8i+4ilxnjaq7IzFnMWtBv1db
	 HnlCQt/00khFiQh1W/j8ZoiJQ8JQu7QzqBRNQiyJnDHJIHznU009WJiG4tZXYoSLHEQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793891816;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wx1I0banXX7s3DL2huRr8fCvcews8holDCSosTvHYyg=;
	b=lYSQ8fqt1aL6kT3wadvZsJDKzcVnwzWB+UbQjeGDTIAbKCvJaqsbr6RfxqikaGU5KkTj
	 RhpF0sMWmHss27ZU+xvCBW6URfmguedEKGPKKjZGomxq1OVx4+QDnsfgusnkYeW/OKv0r
	 Q62UIHA7xi0/BoITRH9e1wmynQODfuse4CLsRDEv7EmYBMAUtCM1Mx+VAd4/6KanuNqKV
	 Q8fJlQTKfUTBy1Jcwha0P1ow4TjLAywKPJl/IGl98esVMmnZKigAvrRIosHKQbrfWgeuX
	 g0pkj1X+MluWAeh+pkczZfqaKVtgsO8OLCFXNgWMIekC7B3/UrFQXXkh8wRMMxSa/qA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=erCe6p9J;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C60AEF802DB
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 16:16:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C60AEF802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=erCe6p9J
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-353804b591eso3792888eec.0
        for <alsa-devel@alsa-project.org>;
 Thu, 05 Nov 2026 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793891814; x=1794496614;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d1DBG15Qs677IqV1qKCXQt1NSsOYDVjlbEUzBHqWXEY=;
        b=erCe6p9JgKk+Xpr9Jm+15lsEFH3ESY6YS3sGmGZWvORSIPckl9CVPQ8apMD5Hkdq/6
         rb0/BZWAxvaXX/XDsGAxcyRdVvW5cvZCOVwaDhH5kje4mowFlKJGtMG+PtVYnURBmd6h
         BPPPz9cil11aaDrzxp0aJNU94ZcDmTRMFdFKbbHDbt+tdwhZ/0rQHeVus6ORr2DMyDCt
         pWV9MOrzX3tBl0PFN9v4nLAks9XusZWytNQKGFF3VlJjMhO/8Il/UkjTwCakBe5jJknw
         dnyJ9bbtmea2bpKGF14MVXYk3+A8wOTg1rvG3nY1YQHr1Ssj5QNsAJpQ5XaGgUfmjHel
         ud9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891814; x=1794496614;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d1DBG15Qs677IqV1qKCXQt1NSsOYDVjlbEUzBHqWXEY=;
        b=de/byU9nLE50D3aNbMfyHpfeqiNneeGtMlwodJY/Fe3lhvVornWOwhheCoX7y0gkCr
         inRGgXUIyb6x9B69wyaRBy/5evXOOSyYaXs607fd8OzsZfblVW4s45xz/x9g2QYRnDm2
         GXQqcNY42Ls5rNU9CjU/7e0McidW2dDIAoKqvvVOyF1It5tGwaJ3lvfCKgWz4dRo0bvj
         7cVbO/LdLk4Bgd1YqqmMUiMv3XPrkYzIeiapRso4AydIRbXDRJ8A0NJqpWHm61T/gfyO
         HnBLxY1N/UDLYJn+eDt7kA5KVo+CxFsMsZQGPxc8LShokvfyVu3zFIZoL1F6Eug2fdeE
         /y2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnx1kX0O2rEeUdXVg83viw6qz8l72JgeZueIR4giWRPSA0mVYLtPNyd4I+AnE67G9/lh6zMFTi4JI9@alsa-project.org
X-Gm-Message-State: APuU4Z/bdJ5dVEiExu2M5TfeaAowUHi/7IHNNAzoJ++iagluQxetQnH4
	y0hZqJQqjwSePp9cbF3GvVie4XcApezn266FVrAB1k3qIG2+xLVoTUO6
X-Gm-Gg: AYBFou1x6vfT/Ll6D1ocYWaPxUq88uilYQmnoamb94c+GXbIJkbT+cRzmOnb3MqarjM
	9j6shN+6qwJhqg6K4tlKGouwhR1nkIHFlsS3Cz9AkCXwTvcCQY+xgWf3AZcfLb58gCN+bu60stI
	+gdl0MyVarUFlZlQpqVduu4/EEGcvVpNlBtMjD3tOX76ohRmRo+KXrOXxiWEk4koZACLaHOyKK4
	1zYUsjpZlPXwUFphDCSkQ7aX0yCKPPvwAe3mCp80Tf1EbLoMH/acp4zV2s6z47k7A3HEra0vZG3
	OFTEKCor72tmnEfmVmwgBOV/l6yXrry9jfiZ8XhvWG6wVoQ3/jKZ374xdefOPxMegZyjhzHViGy
	hyQjiRxRoa9XuyU60GFMgVbjtp7F1epfio/UdZqpHdy29jXK7mUu7JZJjEULL/ttOhyozUYD3bv
	xq7ITCNbkHPQql3CrhiY2S9KOwC6VUN+bfUDixafwZyhqwVhvE9Kr+lI6tyNTITS32lOYlUV9CW
	fIkX6lPMo/Jg0wg0z0puGHZCFgZ3CcDrcUq0jzDjhi1573p6g3iRC1aEuXjv7R7y1FlbUNtShIW
	RDzOSO3EbvPHa0tHYZY85OCcH/eMqUSs5t6N3+Vr7OFtYMNlLmEpg72bBYgq8C/Q8VBWp0auog9
	upjijCYA6KBTAZkfBlBAQ6P10J3sw5SaYRkXEcAR1bLy/dJA9
X-Received: by 2002:a05:693c:630c:b0:36c:a360:9c42 with SMTP id
 5a478bee46e88-36ca360cda7mr9483693eec.31.1793891813414;
        Thu, 05 Nov 2026 07:16:53 -0800 (PST)
Received: from cachyos (2a01cb0c82caf900a186612f304bfea5.ipv6.abo.wanadoo.fr.
 [2a01:cb0c:82ca:f900:a186:612f:304b:fea5])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38a6d3dsm21567087eec.7.2026.11.05.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:16:52 -0800 (PST)
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
Subject: [PATCH v8 5/8] ALSA: usb: babyfacepro: add S3 suspend/resume
Date: Thu,  5 Nov 2026 16:15:50 +0100
Message-ID: <20261105151553.223722-6-i.bahloul01@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105151553.223722-1-i.bahloul01@gmail.com>
References: <20261105151553.223722-1-i.bahloul01@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: i.bahloul01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: BS5ECXOA6QFVSOU5KX5DFRTH7GVKGZJX
X-Message-ID-Hash: BS5ECXOA6QFVSOU5KX5DFRTH7GVKGZJX
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:00:52 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BS5ECXOA6QFVSOU5KX5DFRTH7GVKGZJX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

The device loses its registers across a system suspend.  On suspend,
let the PCM core suspend the substreams (applications get -ESTRPIPE and
restart), then kill the session's URBs before cancelling the stream
work their handlers queue.  On resume, re-run the cold init and replay
the cached mixer state and flags.  A resume that follows a device reset
goes through reset_resume instead of a re-probe, so the cached state is
replayed in place.

USB autosuspend stays disabled: nothing in the driver holds a PM
reference while streaming.

Co-developed-by: David Fredman <davfre@gmail.com>
Signed-off-by: David Fredman <davfre@gmail.com>
Signed-off-by: Ismaïl Bahloul <i.bahloul01@gmail.com>
---
 sound/usb/babyfacepro/babyfacepro.c | 89 ++++++++++++++++++++++++++---
 sound/usb/babyfacepro/babyfacepro.h |  4 +-
 2 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/sound/usb/babyfacepro/babyfacepro.c b/sound/usb/babyfacepro/babyfacepro.c
index 12cfd7fea..06ef1a97d 100644
--- a/sound/usb/babyfacepro/babyfacepro.c
+++ b/sound/usb/babyfacepro/babyfacepro.c
@@ -3,7 +3,8 @@
  * RME Babyface Pro / Pro FS - proprietary-mode USB audio driver
  *
  * Core driver: USB vendor requests + cold init, interrupt-URB PCM
- * streaming, and the card lifecycle (probe/disconnect/module entry).
+ * streaming, the mixer-state replay after a resume, and
+ * the card lifecycle (probe/disconnect/PM/module entry).
  *
  * See babyfacepro.h for the shared device state and register map,
  * and babyfacepro-ctl.c for the ALSA control surface.
@@ -198,9 +199,9 @@ int bf_pitch_write(struct snd_usb_babyface *chip, int pitch)
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
@@ -267,8 +268,17 @@ int bf_cold_init(struct snd_usb_babyface *chip)
 	return 0;
 }
 
-/* Re-apply the whole cached mixer state to the device, whose registers
- * the cold init cleared.  Caller holds chip->mutex.
+/* Units probed since the module was loaded.
+ * The SELECT selection is not in the readback, and the values alsactl
+ * restores right after a probe are the ones of the last alsactl store.
+ * After a boot that is the last shutdown, the newest there is.  A later
+ * probe of the same unit (a usbfs claim released, an unbind, a replug)
+ * may follow SELECT presses made since, so bf_panel_select_put() needs
+ * to tell the two apart.
+ */
+/* Re-apply the whole cached mixer state after a resume (the device
+ * lost its registers across a system suspend - TotalMix does the same
+ * re-apply).  Caller holds chip->mutex.
  */
 int babyface_restore_state(struct snd_usb_babyface *chip)
 {
@@ -797,8 +807,9 @@ static int babyface_stream_start(struct snd_usb_babyface *chip)
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
@@ -1497,7 +1508,8 @@ static int babyface_probe(struct usb_interface *intf,
 	chip->card = card;
 
 	chip->dev = usb_get_dev(dev);
-	/* USB autosuspend is untested: nothing in this driver holds a PM
+	/* USB autosuspend is untested: babyface_suspend()/_resume() don't
+	 * check PMSG_IS_AUTO, and nothing in this driver holds a PM
 	 * reference while streaming, so an autosuspend request could race
 	 * a live stream.  Disable it explicitly rather than ship an
 	 * untested code path - full autosuspend support (correct
@@ -1752,6 +1764,62 @@ static void babyface_disconnect(struct usb_interface *intf)
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
+	scoped_guard(mutex, &chip->mutex) {
+		if (chip->streaming)
+			babyface_stream_kill(chip);
+	}
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
+	 *
+	 * This is also the reset_resume handler.  Some hosts reset the
+	 * device on resume; that needs nothing more than the cold init
+	 * already does here, and without the handler the USB core unbinds
+	 * and re-probes the driver instead: the card goes away, open PCMs
+	 * fail, and udev's alsactl restore then loads the mixer state
+	 * stored at the last shutdown over the current one.
+	 */
+	guard(mutex)(&chip->mutex);
+	err = usb_set_interface(chip->dev, BF_IFACE, chip->alt);
+	if (err < 0)
+		return err;
+	err = bf_cold_init(chip);
+	if (err < 0)
+		return err;
+	err = babyface_restore_state(chip);
+	if (err < 0)
+		return err;
+	err = bf_state_apply_flags(chip);
+
+	return err;
+}
+
 static const struct usb_device_id babyface_ids[] = {
 	{ USB_DEVICE(USB_VENDOR_RME, USB_PRODUCT_BABYFACE_PRO_FS) },
 	{ }
@@ -1762,6 +1830,9 @@ static struct usb_driver babyface_driver = {
 	.name = "snd-usb-babyface-pro",
 	.probe = babyface_probe,
 	.disconnect = babyface_disconnect,
+	.suspend = babyface_suspend,
+	.resume = babyface_resume,
+	.reset_resume = babyface_resume,
 	.id_table = babyface_ids,
 };
 
diff --git a/sound/usb/babyfacepro/babyfacepro.h b/sound/usb/babyfacepro/babyfacepro.h
index 1d4c358d9..a32849f83 100644
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
@@ -386,7 +386,7 @@ void babyface_pcm_stop_both(struct snd_usb_babyface *chip, snd_pcm_state_t state
 void babyface_stream_work(struct work_struct *work);
 extern const struct snd_pcm_hw_constraint_list bf_rates_constraint;
 
-/* Mixer-state persistence across interface re-probes. */
+/* Mixer-state persistence across interface re-probes/resume. */
 int babyface_restore_state(struct snd_usb_babyface *chip);
 int bf_state_apply_flags(struct snd_usb_babyface *chip);
 
-- 
2.56.0

