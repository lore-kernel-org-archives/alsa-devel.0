Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA03ACA6002
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2026 06:59:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08EE16021E;
	Wed,  7 Oct 2026 08:58:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08EE16021E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791356340;
	bh=rQFxxwdssJGiodKt8EKiW1jNcBpZILip0owEE6kFmJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sFBELmTbCS6gxn7SWM9EbFdivhlUU31lAab0CW5HuYKa1Y99mwUg2EgzcFUERYP8E
	 6nJZoG6R6ALjqIEAYYkNh0YiyLfGLQcHvCvjdEl8a5CknMvk5qPSbIRXQ6ppU/EUCb
	 x+p2woEe5+92No9gr42qBu2O6SRzwSISaFjzY8os=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BE35F80636; Wed,  7 Oct 2026 08:58:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A030F80633;
	Wed,  7 Oct 2026 08:58:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87C46F805E4; Sat,  3 Oct 2026 21:42:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791056532;
	b=I4YQT6COB1u9wntWJ6hkLMx7Ha0qS2mWNSoN2lLayLB1KJUTnJHcxzjQ/aw3H6ozOZ+l
	 5wt1scjlKPLEtihWaLDXk2ih4HObtgMjBmkfS5JchDSiAaNFd9olfU+J088P+uJMC3GqK
	 RU7mtt8b722czWUpPuHYmtVdRKORryCKV5a7vD1tw2cI4t6Gi/PIR0YAUKPDURWMhQ3ZR
	 V8a5KJUsCDLY4otw29P4x8DUAqOtt8nJxUGWm32TilMwxB7EBYkkyB+WFrIEshXoWXQUg
	 5n08u/ZX1BVI8bCWy6WWy9ZZVZyuRQ85BC+xOmlWrNZfJCp4FQUPZNQGTB5P0x7hqLg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791056532;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rQFxxwdssJGiodKt8EKiW1jNcBpZILip0owEE6kFmJc=;
	b=AfKS2tZmSTTGeQlJ/6+DyUPqL0vO67lBB52LmqbVbL9DbundTGDU9vWoCHYr06nqWlKM
	 Ys79t6xuLy3UePQMgMBeeHdZ5CwqiHQwVj/PtmCmq4/ZgJ1kfibr/0C0Rk18W3sW2JE1T
	 gHrcs5rdj6XEARJ1RZRCByDkF0WN5zHkReT28oq/06O99IpcWQERYwteEc5KuMywH/o2K
	 soBo3aVq/LhXmkMlP9LQPeH1Y9JBXt7aDQmD92qA8L9Sb2FMEwyAbkSFKWu009OCIwWK3
	 3AvcwzIwlFCWgZ2/cNmvK5eWyVEuMdyU1Ki7DBfReKp/RQ9yC5n3sEoaOA3ziUKQAhA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jPOPrkXF;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2BCE8F8057E
	for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2026 21:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BCE8F8057E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jPOPrkXF
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so4093225e9.0
        for <alsa-devel@alsa-project.org>;
 Sat, 03 Oct 2026 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056530; x=1791661330;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hAg1mhs3p15CgJcWTKtuL8O59d5nnuxtvtSMfKAXXi0=;
        b=jPOPrkXFSzCqJcmIvQHvjmT3oebrH+2lQOedOJDpj6m8Pfi/xzmoyVOV2a1a7XeynE
         edGsAmMn07Qn5QZKZR4XzG1VQFfPB2bSWRTU17ZzUINsCMUbA/SokbH0d3LNq3RKs4fG
         Ey1P+npVQAMIHk1HGuW9vIY70FlcSn0tPosoRf+GssHK1cmjtf22HdSvHH7WApQXa8Rx
         uUagf+X4E1wfeXmRGeF4AB4Nr9+eodj/iMfm4YS6KIWHA+pKL6QQCzXuV+vz+JnTGNmk
         sqpC4vQi50kP4vPSSkAjdfXRzRVFZb9dMDgOfbNp3trDaafS9E8WmmItg0dWaM6b0d7I
         FN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056530; x=1791661330;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAg1mhs3p15CgJcWTKtuL8O59d5nnuxtvtSMfKAXXi0=;
        b=jLas09sG47DaUqyXR/NdOkRCeqVqXpDySa1w4CcetvZeGOvOpq0bhpc3Ch33P2Iy19
         bkb67MMvygEUy9NoYN9nDiBjPQAqo0nMAyMlh250resmfSPUIKXNFIG8kaUtGExahxdA
         RwNdwy8gD+Fl/P6meN5F358zqvXY+k3hw6/tUvIUTPtycL5i30rhfOYuHtJwdHUsufg5
         eGEDIbyllLd9bwqp+CvQDld0jEKynR12WhI0q1g2Y9FfbTRKl5kIvtgMmJHlXJRG7k5f
         s/P/NGfFKJVAWQK1tkWWmtHExco+QbXBoVkmiR34NzjVTbmc/jrHY/1L1DrUn+1MPccN
         4ekw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzx/ELN3JYonS85ocsP6PqYk6GAKpYnYV45hAw2BuyDN9mLDbwclxacTv+1Y1Ps1XpNMOYnP7gVDu8V@alsa-project.org
X-Gm-Message-State: AFuF++nKcQ5nIMItShnnJLqTuUml4Mc17XuY5evH7JK0VbPJTpSxvp3K
	JKU5mumLTuz+TXZuLjKR+nDvwT4TtIPjefTwozo1uGgTI8Qd3v207lcF
X-Gm-Gg: AYBFou3dFbC724VxMeKiPJVDyUMHv/CGLnEGIjUvmoEeeKOMKkTsi6MPFoecDXAeVJC
	/48Njtv672UX/WpcQzZlBE8RnsLng2xFOZWqkxGAlni5C2Y/GqwkVh83+8YCFWu49ZaFzgtNgLy
	4TpvPCILMZn7PA1OvTsvhJxUnTa2Vdusb/W1ectuZcZGV6A1KEhPlkYzY12yoRQ84/6OqFIPSKG
	q5IO/2pZ0Plzd4YgNMt6YnKS+q2bnBEt/a00sHymM56iFvvF6EJrJ6TuUUZlVHpMtNJOUfN+Tac
	hRz5mCsw0o5tgN+tp6CLo1yOwB/qYJKIhboAQOnWlm73p5DrP5kT1ShEtJHiEqMM2JfdSB7HPTl
	nhDsD7dNbtbSfURGxp5gvG4FJVF71yPOfqGxzjXDQ5hyI7Z4NB9TqZEuFermoJ7ISzdQ/z9yjbp
	VDKD98EIj04A9HUAh80YNoQQehc/6VlPPP7JzHfL546jozjL6nqPGVhYqJYqTciN1VL72JzYZ6m
	0tj++4cZTxzRDeLy7H71lYfv0D10eFKg1iQVu0b2chldH3Bg5B3KyDfFnfa74Y+jGHC7iKU1HY5
	aLQTTZEMMiaPbCJZGUt7zttP2faJpwAlQM4=
X-Received: by 2002:a05:600c:b95:b0:49f:d087:6526 with SMTP id
 5b1f17b1804b1-4a168106239mr46431645e9.34.1791056530112;
        Sat, 03 Oct 2026 12:42:10 -0700 (PDT)
Received: from cachyos.home
 (2a01cb0c82caf900a186612f304bfea5.ipv6.abo.wanadoo.fr.
 [2a01:cb0c:82ca:f900:a186:612f:304b:fea5])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a162e867e8sm161520495e9.15.2026.10.03.12.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:42:09 -0700 (PDT)
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
	=?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
Subject: [RFC PATCH v6 4/8] ALSA: usb: babyfacepro: add routing flags and
 varispeed pitch
Date: Sat,  3 Oct 2026 21:41:33 +0200
Message-ID: <20261003194137.86176-5-i.bahloul01@gmail.com>
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
Message-ID-Hash: XNSWINHF6M2FSIS57V2JJKKNSDQEXE7S
X-Message-ID-Hash: XNSWINHF6M2FSIS57V2JJKKNSDQEXE7S
X-Mailman-Approved-At: Wed, 07 Oct 2026 06:57:57 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XNSWINHF6M2FSIS57V2JJKKNSDQEXE7S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add loopback, AN 1>2, the sample clock source, the AN1/2 input link,
the MS processor, DIM, width, FX send and the varispeed pitch.  The
clock source is not a register write: it is a bit of the host settings
word sent with the keepalive, so bf_settings_write() now composes that
word from the tracked state.

bf_state_apply_flags() re-applies this state too, and probe also runs
it after writing the power-on default, since the cold init cleared the
flag registers.  A Phones master change made while DIM is engaged
moves the level DIM releases back to.

Signed-off-by: Ismaïl Bahloul <i.bahloul01@gmail.com>
---
 sound/usb/babyfacepro/babyfacepro-ctl.c | 650 +++++++++++++++++++++++-
 sound/usb/babyfacepro/babyfacepro.c     | 162 +++++-
 sound/usb/babyfacepro/babyfacepro.h     |  39 +-
 3 files changed, 838 insertions(+), 13 deletions(-)

diff --git a/sound/usb/babyfacepro/babyfacepro-ctl.c b/sound/usb/babyfacepro/babyfacepro-ctl.c
index 988766c59..f72879502 100644
--- a/sound/usb/babyfacepro/babyfacepro-ctl.c
+++ b/sound/usb/babyfacepro/babyfacepro-ctl.c
@@ -10,8 +10,10 @@
  * state persistence, card lifecycle).
  */
 #include <linux/log2.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/string.h>
 #include <linux/unaligned.h>
 #include <linux/usb.h>
 #include <linux/workqueue.h>
@@ -288,7 +290,9 @@ int babyface_write_default_mixer(struct snd_usb_babyface *chip)
 			chip->xpoint[out][src][1] = level;
 		}
 
-	/* Host settings word (clock source Internal). */
+	/* Host settings word - composed from tracked state (clock defaults
+	 * to Internal, chip->clock_optical is zero-initialized).
+	 */
 	return bf_settings_write(chip);
 }
 
@@ -418,6 +422,11 @@ static int bf_master_put(struct snd_kcontrol *kctl,
 
 	chip->master[out][0] = l;
 	chip->master[out][1] = r;
+	/* A Phones change while DIM is engaged re-bases the restore point. */
+	if (chip->dim && out == 1) {
+		chip->dim_saved[0] = l;
+		chip->dim_saved[1] = r;
+	}
 	ret = 1;
 out:
 	mutex_unlock(&chip->mutex);
@@ -1450,3 +1459,642 @@ int babyface_create_preamp(struct snd_usb_babyface *chip)
 	return 0;
 }
 
+static int bf_switch_info(struct snd_kcontrol *kctl,
+			  struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int bf_pitch_info(struct snd_kcontrol *kctl,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = -50;		/* -5.0 % */
+	uinfo->value.integer.max = 50;		/* +5.0 % */
+	uinfo->value.integer.step = 1;		/* 0.1 % */
+	return 0;
+}
+
+static int bf_pitch_get(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.integer.value[0] = chip->pitch;
+	return 0;
+}
+
+static int bf_pitch_put(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int p = ucontrol->value.integer.value[0];
+	int ret = 0;
+
+	if (p < -50 || p > 50)
+		return -EINVAL;
+
+	mutex_lock(&chip->mutex);
+	if (p == chip->pitch)
+		goto out;
+
+	/* The DDS quad is a ratio on top of the family rate, the same at
+	 * every sample rate; bf_pitch_write() sends it with the settings
+	 * keepalive that commits it.
+	 */
+	ret = bf_pitch_write(chip, p);
+	if (ret < 0)
+		goto out;
+	chip->pitch = p;
+	ret = 1;
+out:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static int bf_loopback_get(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int out = kctl->private_value;
+
+	ucontrol->value.integer.value[0] = chip->loopback[out];
+	ucontrol->value.integer.value[1] = chip->loopback[out];
+	return 0;
+}
+
+/* Write the full 30-channel loopback map: pair (2*out, 2*out+1) at
+ * `on` (0x0001/0x0000), all other channels cleared - exactly what
+ * TotalMix sends on every loopback toggle (cap_loopback2.pcap).  The
+ * full-map write is also the reliable OFF (the old per-pair write
+ * sometimes failed to disengage on the hardware).
+ */
+int bf_loopback_write_map(struct snd_usb_babyface *chip, int out,
+			  bool on)
+{
+	int ch, ret;
+
+	for (ch = 0; ch < BF_LOOPBACK_CHANNELS; ch++) {
+		u16 val = (on && (ch == out * 2 || ch == out * 2 + 1))
+			  ? 0x0001 : 0x0000;
+
+		ret = bf_vendor_write(chip, BF_REQ_LOOPBACK, val, ch);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int bf_loopback_put(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int out = kctl->private_value;
+	bool on = ucontrol->value.integer.value[0];
+	int ret = 0;
+
+	mutex_lock(&chip->mutex);
+	if (on == chip->loopback[out])
+		goto out;
+	ret = bf_loopback_write_map(chip, out, on);
+	if (ret < 0)
+		goto out;
+	/* Single-active model (TotalMix writes one pair at 0x0001, the
+	 * rest 0x0000): toggling one output clears the others.
+	 */
+	memset(chip->loopback, 0, sizeof(chip->loopback));
+	chip->loopback[out] = on;
+	ret = 1;
+out:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static int bf_an12_get(struct snd_kcontrol *kctl,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.integer.value[0] = chip->an12;
+	return 0;
+}
+
+static int bf_an12_put(struct snd_kcontrol *kctl,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	bool an12 = ucontrol->value.integer.value[0];
+	u16 v;
+	int ret = 0;
+
+	mutex_lock(&chip->mutex);
+	if (an12 == chip->an12)
+		goto out;
+	v = (chip->linked ? 0x0400 : 0x0000) | (an12 ? 0x1000 : 0x0000);
+	ret = bf_vendor_write(chip, BF_REQ_PREAMP, v, 0x1000);
+	if (ret < 0)
+		goto out;
+	ret = bf_vendor_write(chip, BF_REQ_PREAMP_COMMIT, 0x0000, 0x0000);
+	if (ret < 0)
+		goto out;
+	chip->an12 = an12;
+	ret = 1;
+out:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+/* Clock source (PROTOCOL.md "Clock source / no-lock state",
+ * hardware-verified 2026-08-22, clktest.c): NOT a register write at
+ * all - only the BF_REG_KEEPALIVE_SETTINGS word changes (bit 2 =
+ * Optical). Matches the naming TuxMix's ALSA backend already looks
+ * for ("Sample Clock Source", the same name found on the stock
+ * snd-usb-audio Class-Compliant driver) so it picks this control up
+ * with zero changes on that side.
+ */
+static const char *const bf_clock_texts[] = {
+	"Internal", "Optical In", NULL
+};
+
+static int bf_clock_info(struct snd_kcontrol *kctl,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	return snd_ctl_enum_info(uinfo, 1, 2, bf_clock_texts);
+}
+
+static int bf_clock_get(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.enumerated.item[0] = chip->clock_optical ? 1 : 0;
+	return 0;
+}
+
+static int bf_clock_put(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	bool optical = ucontrol->value.enumerated.item[0] != 0;
+	int ret = 0;
+
+	mutex_lock(&chip->mutex);
+	if (optical == chip->clock_optical)
+		goto out;
+	chip->clock_optical = optical;
+	ret = bf_settings_write(chip);
+	if (ret < 0) {
+		chip->clock_optical = !optical;
+		goto out;
+	}
+	ret = 1;
+out:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static int bf_link_get(struct snd_kcontrol *kctl,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.integer.value[0] = chip->linked;
+	return 0;
+}
+
+static int bf_link_put(struct snd_kcontrol *kctl,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	bool linked = ucontrol->value.integer.value[0];
+	u16 v;
+	int ret = 0;
+
+	mutex_lock(&chip->mutex);
+	if (linked == chip->linked)
+		goto out;
+	v = (linked ? 0x0400 : 0x0000) | (chip->an12 ? 0x1000 : 0x0000);
+	ret = bf_vendor_write(chip, BF_REQ_PREAMP, v, 0x1000);
+	if (ret < 0)
+		goto out;
+	ret = bf_vendor_write(chip, BF_REQ_PREAMP_COMMIT, 0x0000, 0x0000);
+	if (ret < 0)
+		goto out;
+	chip->linked = linked;
+	ret = 1;
+out:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static int bf_ms_get(struct snd_kcontrol *kctl,
+		     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.integer.value[0] = chip->ms_proc;
+	return 0;
+}
+
+/* MS-proc: engage per the cap_ms2.pcap ON pattern - write 0x0000 to
+ * ALL FOUR AN2 (side) crosspoints: standard map 0x0035/0x004F (L/R)
+ * + low map 0x0001/0x001B (L/R) - the side path is muted (ear-
+ * verified 2026-08-26 with the mic on AN2: MS ON = silence); release
+ * restores the cached fader values (host-side, like TotalMix).
+ * (The 0x1000/0x0004 writes are the DISENGAGE restore values seen in
+ * cap_ms2 - the driver had them inverted on the engage path.)
+ */
+static int bf_ms_put(struct snd_kcontrol *kctl,
+		     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	bool on = ucontrol->value.integer.value[0];
+	int ret = 0;
+
+	mutex_lock(&chip->mutex);
+	if (on == chip->ms_proc)
+		goto out;
+	if (on) {
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, 0x0000, 0x0035);
+		if (ret < 0)
+			goto out;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, 0x0000, 0x004f);
+		if (ret < 0)
+			goto out;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, 0x0000, 0x0001);
+		if (ret < 0)
+			goto out;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, 0x0000, 0x001b);
+		if (ret < 0)
+			goto out;
+	} else {
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT,
+				      chip->xpoint[1][1][0], 0x0001);
+		if (ret < 0)
+			goto out;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT,
+				      chip->xpoint[1][1][0], 0x0035);
+		if (ret < 0)
+			goto out;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT,
+				      chip->xpoint[1][1][1], 0x001b);
+		if (ret < 0)
+			goto out;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT,
+				      chip->xpoint[1][1][1], 0x004f);
+		if (ret < 0)
+			goto out;
+	}
+	chip->ms_proc = on;
+	ret = 1;
+out:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+/* DIM - cap_dim2.pcap: an absolute -20 dB on the Phones master
+ * (out 1: 8-bit 0xCB / 16-bit 0x0333) regardless of the current level,
+ * plus the 0x17 wVal=0x2000 wIdx=0x2000 flag; release restores the
+ * pre-DIM master host-side.  The master cache keeps the real volume.
+ */
+static int bf_dim_get(struct snd_kcontrol *kctl,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.integer.value[0] = chip->dim;
+	return 0;
+}
+
+/* Apply DIM on the wire.  chip->mutex must be held by the caller, the
+ * "Dim Switch" put.
+ */
+static int bf_dim_apply(struct snd_usb_babyface *chip, bool on)
+{
+	u16 flag;
+	int ret;
+
+	lockdep_assert_held(&chip->mutex);
+	if (on) {
+		chip->dim_saved[0] = chip->master[1][0];
+		chip->dim_saved[1] = chip->master[1][1];
+		ret = bf_vendor_write(chip, BF_REQ_GAIN, BF_MASTER_MINUS20_8,
+				      BF_REG_MASTER_8 + 2 * 1);
+		if (ret < 0)
+			return ret;
+		ret = bf_vendor_write(chip, BF_REQ_GAIN, BF_MASTER_MINUS20_8,
+				      BF_REG_MASTER_8 + 2 * 1 + 1);
+		if (ret < 0)
+			return ret;
+		flag = bf_flag_cycle[chip->flag_cnt];
+		chip->flag_cnt = (chip->flag_cnt + 1) & 3;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT,
+				      BF_MASTER_MINUS20_16,
+				      (BF_REG_MASTER_16 + 2 * 1) | flag);
+		if (ret < 0)
+			return ret;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT,
+				      BF_MASTER_MINUS20_16,
+				      (BF_REG_MASTER_16 + 2 * 1 + 1) | flag);
+		if (ret < 0)
+			return ret;
+		ret = bf_vendor_write(chip, BF_REQ_PREAMP, 0x2000, 0x2000);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = bf_vendor_write(chip, BF_REQ_GAIN,
+				      bf_master_8bit(chip->dim_saved[0]),
+				      BF_REG_MASTER_8 + 2 * 1);
+		if (ret < 0)
+			return ret;
+		ret = bf_vendor_write(chip, BF_REQ_GAIN,
+				      bf_master_8bit(chip->dim_saved[1]),
+				      BF_REG_MASTER_8 + 2 * 1 + 1);
+		if (ret < 0)
+			return ret;
+		flag = bf_flag_cycle[chip->flag_cnt];
+		chip->flag_cnt = (chip->flag_cnt + 1) & 3;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT,
+				      chip->dim_saved[0],
+				      (BF_REG_MASTER_16 + 2 * 1) | flag);
+		if (ret < 0)
+			return ret;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT,
+				      chip->dim_saved[1],
+				      (BF_REG_MASTER_16 + 2 * 1 + 1) | flag);
+		if (ret < 0)
+			return ret;
+		ret = bf_vendor_write(chip, BF_REQ_PREAMP, 0x0000, 0x2000);
+		if (ret < 0)
+			return ret;
+	}
+	chip->dim = on;
+	return 0;
+}
+
+static int bf_dim_put(struct snd_kcontrol *kctl,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	bool on = ucontrol->value.integer.value[0];
+	int ret = 0;
+
+	mutex_lock(&chip->mutex);
+	if (on == chip->dim)
+		goto out;
+	ret = bf_dim_apply(chip, on);
+	if (ret == 0)
+		ret = 1;
+out:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static int bf_width_info(struct snd_kcontrol *kctl,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = -100;
+	uinfo->value.integer.max = 100;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int bf_width_get(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.integer.value[0] = chip->width;
+	return 0;
+}
+
+static int bf_width_put(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int w = ucontrol->value.integer.value[0];
+	u16 l, r;
+	int ret = 0;
+
+	if (w < -100 || w > 100)
+		return -EINVAL;
+
+	mutex_lock(&chip->mutex);
+	if (w == chip->width)
+		goto out;
+	/* Width spread: L = 0x1000*(1+w), R = 0x1000*(1-w), L+R = 0x2000.
+	 * TotalMix writes the strip's src pair on BOTH maps (cap_width3-7,
+	 * PROTOCOL.md "Width strip mapping"): the low map (0x0000+src L /
+	 * 0x001A+src R) and the std block-0 map (0x0034+src L /
+	 * 0x004E+src R) - the stereo pair spreads L/R in opposition, the
+	 * mirror src (AN2) gets the swapped values.
+	 */
+	l = (u16)(((0x2000 * (100 + w) / 2) + 50) / 100);
+	r = 0x2000 - l;
+	/* Low map: AN1 L=0x0000, R=0x001A; AN2 L=0x0001, R=0x001B. */
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, l, 0x0000);
+	if (ret < 0)
+		goto out;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, r, 0x001a);
+	if (ret < 0)
+		goto out;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, r, 0x0001);
+	if (ret < 0)
+		goto out;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, l, 0x001b);
+	if (ret < 0)
+		goto out;
+	/* Std block-0 map (item 0b, the missing half): AN1 L=0x0034,
+	 * R=0x004E; AN2 L=0x0035, R=0x004F.  (The playback strips PB2-6
+	 * target block n-2 - 0x00AE family - reserved for the per-strip
+	 * controls.)
+	 */
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, l, 0x0034);
+	if (ret < 0)
+		goto out;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, r, 0x004e);
+	if (ret < 0)
+		goto out;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, r, 0x0035);
+	if (ret < 0)
+		goto out;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, l, 0x004f);
+	if (ret < 0)
+		goto out;
+	chip->width = w;
+	ret = 1;
+out:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+static int bf_fx_send_info(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0x1000;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int bf_fx_send_get(struct snd_kcontrol *kctl,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.integer.value[0] = chip->fx_send;
+	return 0;
+}
+
+static int bf_fx_send_put(struct snd_kcontrol *kctl,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	long nv = ucontrol->value.integer.value[0];
+	u16 v;
+	int ret = 0;
+
+	/* Check before narrowing (a value >= 0x10000 would wrap to a
+	 * passing u16); see bf_master_put().
+	 */
+	if (nv < 0 || nv > 0x1000)
+		return -EINVAL;
+	v = nv;
+
+	mutex_lock(&chip->mutex);
+	if (v == chip->fx_send)
+		goto out;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, v, 0x0138);
+	if (ret < 0)
+		goto out;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, v, 0x0153);
+	if (ret < 0)
+		goto out;
+	chip->fx_send = v;
+	ret = 1;
+out:
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+int babyface_create_flags(struct snd_usb_babyface *chip)
+{
+	struct snd_kcontrol *kctl;
+	int i, err;
+
+	kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Varispeed Pitch",
+		.info = bf_pitch_info,
+		.get = bf_pitch_get,
+		.put = bf_pitch_put,
+	}, chip);
+	err = snd_ctl_add(chip->card, kctl);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < 6; i++) {
+		kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+			.name = "Loopback Switch",
+			.index = i,
+			.info = bf_mute_info,
+			.get = bf_loopback_get,
+			.put = bf_loopback_put,
+			.private_value = i,
+		}, chip);
+		err = snd_ctl_add(chip->card, kctl);
+		if (err < 0)
+			return err;
+	}
+
+	kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "AN 1>2 Switch",
+		.info = bf_switch_info,
+		.get = bf_an12_get,
+		.put = bf_an12_put,
+	}, chip);
+	err = snd_ctl_add(chip->card, kctl);
+	if (err < 0)
+		return err;
+
+	kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Sample Clock Source",
+		.info = bf_clock_info,
+		.get = bf_clock_get,
+		.put = bf_clock_put,
+	}, chip);
+	err = snd_ctl_add(chip->card, kctl);
+	if (err < 0)
+		return err;
+
+	kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "AN1/2 Link Switch",
+		.info = bf_switch_info,
+		.get = bf_link_get,
+		.put = bf_link_put,
+	}, chip);
+	err = snd_ctl_add(chip->card, kctl);
+	if (err < 0)
+		return err;
+
+	kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "MS Processor Switch",
+		.info = bf_switch_info,
+		.get = bf_ms_get,
+		.put = bf_ms_put,
+	}, chip);
+	err = snd_ctl_add(chip->card, kctl);
+	if (err < 0)
+		return err;
+
+	kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Dim Switch",
+		.info = bf_switch_info,
+		.get = bf_dim_get,
+		.put = bf_dim_put,
+	}, chip);
+	chip->dim_kctl = kctl;
+	err = snd_ctl_add(chip->card, kctl);
+	if (err < 0)
+		return err;
+
+	kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Width",
+		.info = bf_width_info,
+		.get = bf_width_get,
+		.put = bf_width_put,
+	}, chip);
+	err = snd_ctl_add(chip->card, kctl);
+	if (err < 0)
+		return err;
+
+	kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "FX Send Volume",
+		.info = bf_fx_send_info,
+		.get = bf_fx_send_get,
+		.put = bf_fx_send_put,
+	}, chip);
+	err = snd_ctl_add(chip->card, kctl);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
diff --git a/sound/usb/babyfacepro/babyfacepro.c b/sound/usb/babyfacepro/babyfacepro.c
index 1d7aa832b..0678bea58 100644
--- a/sound/usb/babyfacepro/babyfacepro.c
+++ b/sound/usb/babyfacepro/babyfacepro.c
@@ -105,14 +105,23 @@ int bf_vendor_read(struct snd_usb_babyface *chip, u8 req, u16 idx, u8 *buf)
 				    0, idx, buf, 4, BF_CTL_TIMEOUT, GFP_KERNEL);
 }
 
-/* Sends the BF_REG_KEEPALIVE_SETTINGS word (PROTOCOL.md: "keepalive
- * 0x10 0x05CF wVal = host settings-state register" - a single shared
- * word, not independent per-setting writes).  The clock source is
- * Internal.
+/* Composes and sends the BF_REG_KEEPALIVE_SETTINGS word from every
+ * currently-tracked flag together (PROTOCOL.md: "keepalive 0x10 0x05CF
+ * wVal = host settings-state register" - a single shared word, not
+ * independent per-setting writes).  Only clock source is tracked so
+ * far; the single call site this replaces (which used to hardcode
+ * 0x0001, i.e. "always Internal") is why this exists as its own
+ * function rather than an inline write at each call site - the next
+ * flag added to this word (EQ for Record / Optical-Out SPDIF, this
+ * driver's own upstream follow-up list) just OR's in here too, instead
+ * of every caller needing to remember every other bit.
  */
 int bf_settings_write(struct snd_usb_babyface *chip)
 {
-	return bf_vendor_write(chip, BF_REQ_KEEPALIVE, BF_SETTINGS_CLOCK_INTERNAL,
+	u16 w = chip->clock_optical ? BF_SETTINGS_CLOCK_OPTICAL :
+				       BF_SETTINGS_CLOCK_INTERNAL;
+
+	return bf_vendor_write(chip, BF_REQ_KEEPALIVE, w,
 			       BF_REG_KEEPALIVE_SETTINGS);
 }
 
@@ -231,7 +240,9 @@ int bf_cold_init(struct snd_usb_babyface *chip)
 	if (!r)
 		return -EINVAL;
 	ret = bf_vendor_write(chip, BF_REQ_KEEPALIVE,
-			      (bf_rate_family(r) << 4) | BF_SETTINGS_CLOCK_INTERNAL,
+			      (bf_rate_family(r) << 4) |
+			      (chip->clock_optical ? BF_SETTINGS_CLOCK_OPTICAL :
+						     BF_SETTINGS_CLOCK_INTERNAL),
 			      BF_REG_KEEPALIVE_INIT);
 	if (ret < 0)
 		return ret;
@@ -323,14 +334,111 @@ int babyface_restore_state(struct snd_usb_babyface *chip)
 	return bf_pitch_write(chip, chip->pitch);
 }
 
-/* Re-apply the per-input state that sits on top of the crosspoints
- * (phase invert, stereo split, trim) after a state restore.  The write
- * patterns mirror the corresponding _put() handlers.  Caller holds
- * chip->mutex.
+/* Re-apply the state that sits on top of the masters and crosspoints
+ * (the routing flags, DIM, phase invert, stereo split, trim) after a
+ * state restore.  The write patterns mirror the corresponding _put()
+ * handlers.  Caller holds chip->mutex.
  */
 int bf_state_apply_flags(struct snd_usb_babyface *chip)
 {
-	int ret;
+	int out, ret, on_out = -1;
+	u16 l, r;
+
+	/* Loopback: the full 30-channel map from the cached state (the
+	 * single-active invariant keeps at most one pair at 0x0001).
+	 */
+	for (out = 0; out < 6; out++) {
+		if (chip->loopback[out]) {
+			on_out = out;
+			break;
+		}
+	}
+	ret = bf_loopback_write_map(chip, on_out, on_out >= 0);
+	if (ret < 0)
+		return ret;
+
+	ret = bf_vendor_write(chip, BF_REQ_PREAMP,
+			      (chip->linked ? 0x0400 : 0x0000) |
+			      (chip->an12 ? 0x1000 : 0x0000), 0x1000);
+	if (ret < 0)
+		return ret;
+	ret = bf_vendor_write(chip, BF_REQ_PREAMP_COMMIT, 0x0000, 0x0000);
+	if (ret < 0)
+		return ret;
+
+	l = (u16)(((0x2000 * (100 + chip->width) / 2) + 50) / 100);
+	r = 0x2000 - l;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, l, 0x0000);
+	if (ret < 0)
+		return ret;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, r, 0x001a);
+	if (ret < 0)
+		return ret;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, r, 0x0001);
+	if (ret < 0)
+		return ret;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, l, 0x001b);
+	if (ret < 0)
+		return ret;
+
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, chip->fx_send, 0x0138);
+	if (ret < 0)
+		return ret;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, chip->fx_send, 0x0153);
+	if (ret < 0)
+		return ret;
+
+	if (chip->ms_proc) {
+		/* Same ON pattern as bf_ms_put (cap_ms2.pcap): mute the AN2
+		 * (side) crosspoints, both maps.
+		 */
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, 0x0000, 0x0035);
+		if (ret < 0)
+			return ret;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, 0x0000, 0x004f);
+		if (ret < 0)
+			return ret;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, 0x0000, 0x0001);
+		if (ret < 0)
+			return ret;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, 0x0000, 0x001b);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Re-apply an engaged DIM (the fixed -20 dB Phones pair + flag).  The
+	 * level DIM releases back to is not persisted: it always tracks the
+	 * Phones master while DIM is engaged, so rebuild it here - otherwise a
+	 * DIM released after a re-probe would drive Phones to
+	 * silence (dim_saved still zero on the fresh chip).
+	 */
+	if (chip->dim) {
+		chip->dim_saved[0] = chip->master[1][0];
+		chip->dim_saved[1] = chip->master[1][1];
+		ret = bf_vendor_write(chip, BF_REQ_GAIN, 0xcb,
+				      BF_REG_MASTER_8 + 2 * 1);
+		if (ret < 0)
+			return ret;
+		ret = bf_vendor_write(chip, BF_REQ_GAIN, 0xcb,
+				      BF_REG_MASTER_8 + 2 * 1 + 1);
+		if (ret < 0)
+			return ret;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, 0x0333,
+				      (BF_REG_MASTER_16 + 2 * 1) |
+				      bf_flag_cycle[chip->flag_cnt]);
+		if (ret < 0)
+			return ret;
+		chip->flag_cnt = (chip->flag_cnt + 1) & 3;
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, 0x0333,
+				      (BF_REG_MASTER_16 + 2 * 1 + 1) |
+				      bf_flag_cycle[chip->flag_cnt]);
+		if (ret < 0)
+			return ret;
+		chip->flag_cnt = (chip->flag_cnt + 1) & 3;
+		ret = bf_vendor_write(chip, BF_REQ_PREAMP, 0x2000, 0x2000);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* Re-apply any engaged Phase invert - the crosspoint restore loop
 	 * above already re-wrote xpoint[][] as PLAIN values, so a phase
@@ -419,6 +527,15 @@ void bf_state_save(struct snd_usb_babyface *chip)
 	memcpy(s->trim, chip->trim, sizeof(s->trim));
 	memcpy(s->split, chip->split, sizeof(s->split));
 	s->ref_level = chip->ref_level;
+	s->pitch = chip->pitch;
+	memcpy(s->loopback, chip->loopback, sizeof(s->loopback));
+	s->an12 = chip->an12;
+	s->linked = chip->linked;
+	s->ms_proc = chip->ms_proc;
+	s->clock_optical = chip->clock_optical;
+	s->width = chip->width;
+	s->fx_send = chip->fx_send;
+	s->dim = chip->dim;
 	mutex_unlock(&bf_saved_mutex);
 }
 
@@ -447,6 +564,15 @@ int bf_state_restore(struct snd_usb_babyface *chip)
 		memcpy(chip->trim, s->trim, sizeof(chip->trim));
 		memcpy(chip->split, s->split, sizeof(chip->split));
 		chip->ref_level = s->ref_level;
+		chip->pitch = s->pitch;
+		memcpy(chip->loopback, s->loopback, sizeof(chip->loopback));
+		chip->an12 = s->an12;
+		chip->linked = s->linked;
+		chip->ms_proc = s->ms_proc;
+		chip->clock_optical = s->clock_optical;
+		chip->width = s->width;
+		chip->fx_send = s->fx_send;
+		chip->dim = s->dim;
 		ret = 1;
 		break;
 	}
@@ -1640,6 +1766,14 @@ static int babyface_probe(struct usb_interface *intf,
 			dev_err(&intf->dev, "default mixer restore failed: %d\n", err);
 			goto error;
 		}
+		/* The cold init cleared the flag registers as well. */
+		mutex_lock(&chip->mutex);
+		err = bf_state_apply_flags(chip);
+		mutex_unlock(&chip->mutex);
+		if (err < 0) {
+			dev_err(&intf->dev, "flag restore failed: %d\n", err);
+			goto error;
+		}
 	} else if (err < 0) {
 		dev_err(&intf->dev, "mixer state restore failed: %d\n", err);
 		goto error;
@@ -1713,6 +1847,12 @@ static int babyface_probe(struct usb_interface *intf,
 		goto error;
 	}
 
+	err = babyface_create_flags(chip);
+	if (err < 0) {
+		dev_err(&intf->dev, "flag control creation failed: %d\n", err);
+		goto error;
+	}
+
 	err = snd_card_register(chip->card);
 	if (err < 0) {
 		dev_err(&intf->dev, "snd_card_register failed: %d\n", err);
diff --git a/sound/usb/babyfacepro/babyfacepro.h b/sound/usb/babyfacepro/babyfacepro.h
index 80848da06..783ea03ac 100644
--- a/sound/usb/babyfacepro/babyfacepro.h
+++ b/sound/usb/babyfacepro/babyfacepro.h
@@ -115,9 +115,16 @@
 
 /* Host settings-state word carried by the BF_REG_KEEPALIVE_SETTINGS
  * keepalive (PROTOCOL.md "keepalive 0x10 0x05CF wVal = host settings-
- * state register", hardware-verified 2026-08-22/23).
+ * state register", hardware-verified 2026-08-22/23): clock source is
+ * NOT a register write at all, only this flag word changes.  Bit 2 =
+ * clock Optical (bit clear = Internal, the default); bits 6/10 (EQ for
+ * Record / Optical-Out SPDIF) are next in the driver's own upstream
+ * follow-up list, not wired to a control yet - the composer below only
+ * OR's in the clock bit today, structured so those can be added the
+ * same way later without another flag-stomping rewrite.
  */
 #define BF_SETTINGS_CLOCK_INTERNAL	0x0001
+#define BF_SETTINGS_CLOCK_OPTICAL	0x0004
 
 /* Preamp state byte (0x17, wIdx 0x003F - full state, verified).
  * NOTE 2026-08-26 (cap_reflevel3.pcap): the 0x0C "base" is NOT a
@@ -174,6 +181,15 @@
 #define BF_REG_LOWMAP_BASE_L		0x0000	/* + idx_l */
 #define BF_REG_LOWMAP_BASE_R		0x001a	/* + idx_r */
 
+#define BF_REQ_LOOPBACK			0x15	/* per-output-channel flag */
+
+/* Loopback map width (captured 2026-08-25, cap_loopback2.pcap):
+ * TotalMix writes the FULL 30-channel 0x15 map on every toggle (ON =
+ * the pair at 0x0001 + the other 28 at 0x0000; OFF = all 0x0000).
+ * wIdx = 2xout_index: AN1/2 = 0/1, PH3/4 = 2/3, AS1/2 = 4/5, ...
+ */
+#define BF_LOOPBACK_CHANNELS		30
+
 /* The "cross" register block within each output: the L-registers sit at
  * odd offsets 5..23 and the R-registers at even offsets 4..22 (the stereo
  * source pairs that can be cross-linked).  bf_crosspoint_clear_cross()
@@ -316,6 +332,16 @@ struct snd_usb_babyface {
 					 * (0 = +4dBu, the default)
 					 */
 	struct snd_kcontrol *trim_kctl[4]; /* for snd_ctl_notify */
+	bool loopback[6];
+	bool an12;			/* AN 1>2 copy */
+	bool linked;			/* AN1/2 input link */
+	bool ms_proc;			/* MS processor engaged */
+	bool clock_optical;		/* clock source: false = Internal (default) */
+	int width;			/* width knob -100..+100 */
+	u16 fx_send;			/* FX send level 0..0x1000 */
+	u16 dim_saved[2];		/* pre-DIM Phones master (out 1 L/R) */
+	bool dim;			/* DIM engaged (fixed -20 dB on Phones) */
+	struct snd_kcontrol *dim_kctl;      /* for snd_ctl_notify */
 };
 
 /* The mixer state cached across interface re-probes (see
@@ -334,6 +360,15 @@ struct bf_saved {
 	int trim[4];
 	bool split[6];
 	int ref_level;
+	int pitch;
+	bool loopback[6];
+	bool an12;
+	bool linked;
+	bool ms_proc;
+	bool clock_optical;
+	int width;
+	u16 fx_send;
+	bool dim;
 };
 
 struct bf_rate {
@@ -387,6 +422,8 @@ int bf_trim_apply(struct snd_usb_babyface *chip, int mic, int trim_db2);
 int bf_gain_max_db(int mic);
 int bf_gain_db(int mic, u8 raw);
 u8 bf_gain_raw(int mic, int db);
+int bf_loopback_write_map(struct snd_usb_babyface *chip, int out, bool on);
+int babyface_create_flags(struct snd_usb_babyface *chip);
 
 /* Master gain-law helpers (babyfacepro-ctl.c). */
 int bf_master_half_db(u16 vol16);	/* 16-bit master -> dBx2 */
-- 
2.56.0

