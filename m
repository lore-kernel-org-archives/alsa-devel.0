Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A27C79F82
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:40:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 356D5602B6;
	Tue,  8 Sep 2026 20:39:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 356D5602B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892801;
	bh=Czq3MNo7sXIZWnn8uBDLBQFXIm6qfEkwxwLoghWYtU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Pvfrw/kJC+uUlciaJCTdhkWSck8e6KE13a/r4doUFLwQkHtZCoH8cWsCY01Bynxuz
	 8vl+htaSRy8vk9S+OTZiJB0n45GD4ybCaTA3zgg3EzowTnLQOPdqag4H2zP5K5Z3jD
	 x9mYSGIYx6GTuRuD49GX4oMXgkwXiODbLQYwHooA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3BD1FF80CB3; Tue,  8 Sep 2026 20:36:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B292AF80CBC;
	Tue,  8 Sep 2026 20:36:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B8FFF805CA; Wed,  2 Sep 2026 12:11:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788343897;
	b=gFSTcZJDbvLLLTRdawfgk9V/CtUQL7YCpZKw7lHoIw5zunrjKuhT240iHSkMVBVK8v+v
	 NxTZ/VEiyFrfm+UWO3MqoWtvssacpy0oyq8eVDWXARvyj8eWHwPmSUnp88cGwtSfNoiq3
	 eDgz1gF4r/YcX/Dga0qQ7r50VjudfMN7HHe5tIhTBewP+UqHNT4zHJ13JvIoED3Ueay9j
	 y3OukjH2zk0RLkXuHQp5M/L0evMmlCf3fKRGM3QsYEcrm7rUNs87ezgvlf9V3adG60fnj
	 d4BgB0BgVK3/EwjoCD0sc4QbpyIb753IxBUChWiPbLDwIHGfWh61AvN0zH2bCzeZojg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788343897;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Czq3MNo7sXIZWnn8uBDLBQFXIm6qfEkwxwLoghWYtU4=;
	b=YWtgMQqTXBZuEsoJmKxyjUOP2CtSiYzS6/mbWx8lKA1O/+jS6REvPTc10XZ/Wne1NQlI
	 4QZieKy/sH+7rc284IxLsDEmOOILFi+eUA39Hk8UOPNdh1KUmPV0y2PZWJHZHVGOJpc9K
	 xCDDWpdihD2/tfIQF97JiCgVc4kdHdQNe0gvGkkkjMZH4SslJiseUgagHlcCA5s9qevm6
	 BT1JhqYxZCoG+/u5ln5v/r7KH9JX7xjxXFkOYvPUa2FrUhOwYIm1UCJe+dJRAEAnWwOLv
	 3TkWANG2zFmk0fax7sK6x/iLL0zBofu9k3aaChojBEj73RJXN4pWnmYQN6cAhTwYOsg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dDRqiI7A;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 733FDF8016D
	for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2026 12:11:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 733FDF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dDRqiI7A
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so8526205e9.1
        for <alsa-devel@alsa-project.org>;
 Wed, 02 Sep 2026 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788343895; x=1788948695;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zGakF+5UgC/Qyae+DfDML9mtCfg1kDn0jWYGe/geyPE=;
        b=dDRqiI7AHsfWOP9NwR12Pkq7B441PFRIpYFsVcZG9lJzkrQZ+48E34PXwBGffBIFfk
         /3OmtTgYk/2XTLB09av+UTNZz2a5qZSrfstQJrTh2O3xXrEgp9xRIU5+zRSeMacD3WPd
         3vjAgbkvLChguKA5vxTSz/zCHnj9Gr60P45WvQIYxaTTV3Haf2gZlFWzgQe+U2/Kzk3m
         HkwYSxJxforHT/hlLNhFJA8v+/U0HZl7KlGBf5bYfIKJ6GGlz6Q77nIFG/vo5EX1VM8y
         Us0wfXYQP28jr2FOkxxb3PQST/VczS3V+qv9nS3P6+4ssFtACMtAW8Z+E51yiDidanuR
         HuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788343895; x=1788948695;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGakF+5UgC/Qyae+DfDML9mtCfg1kDn0jWYGe/geyPE=;
        b=R/83b6egFXjVvuaT57Fv7l97y/TRQ9dqU7MX2dZd/eT5UbkOQbZVSE8d54WYFU0iku
         /R+/fKykw6dKymVOu9MFJzeRo598woRL0PjqUINyY6BqmIU5J/oQ3yBpq+uDTZWKwGGj
         XYDrjKUc2G2yYJuw+TtAZ0aC/XSqraupJsQFxj5YW4+g5pZJJ41gFtJVQeo8aWFom+qJ
         zRL7aric2YwFyj3bE9MI0vJhm+IvZiVP8j9hjM3Uc+TqoEWyNlzZPxkMPXuxl8DLyaK7
         fvVE6xFUQDlcD7IvrNO4p0+5KmGb3du2B73bzSmVk9C0XLEuaaPCMEvhIvrPUDMHORhe
         HhTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqJpobEC95OuAzUb/UY+E7rqkjcCDFrMtV/bNfOXuTdy6wxtJjG8C8qdU1Cvc8g/on0qFY5a6GRL1o@alsa-project.org
X-Gm-Message-State: AFuF++kCOjuxk29gY39comShPG3491fJ7Pzbvvr8pv787SFfEO98A5sf
	2eFWmkW5wpJ/nl2JBlm3PwdJ+3Sli799SMFlN0MdX3Z9nEga5u2AZOEx
X-Gm-Gg: AR+sD13+mNrX9cBzXngaYrkUfqGQBRy9gffDlbSEewp76zGyNdgFxtYBbjLNvsHkVQ1
	eZJ2OweW4SMUS3xskLgrPobVp31yGApO6jQpaaN+0GuM5CLgfQqKufeZ/K31jMJ2VmtHWcC4qhV
	Heleke9nYwhlv6jPolr/6r9dHWXXYKZjHhnBTVcAo1ayEjEttuNSuYFIVbC7IjssozKUIGLlDdR
	5iAczFi9C0htI+pyggF/CVyXLqhu3HS8ts3Tdo7JzQBMBEM05X2bKF25fUXcE4axO+jq2JyOqW3
	/M0gswlRn9uVnvKWwAqTjA0VJE4wPRYtqlUxZZX1/bExV6suOde1Ww2USzoF0r7d5Oc49KdfS4t
	it9zRfEEpM6wO0zC5B/1nXWGidKLZtPTYAvLY2gaxF8Ba5FN9Cybsh1kMk5oOee3MRhS2G8DgSq
	lYtvGh08Y6hPEcC6CK76NS57WbHvtwB/xtbIZttykXOwbPBFJ8hFJWLDi90XZp+RaFQmFQoeXaK
	a3K42uaCJwScRYy
X-Received: by 2002:a05:600c:63c6:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49ceb160bb1mr12572905e9.3.1788343894994;
        Wed, 02 Sep 2026 03:11:34 -0700 (PDT)
Received: from cachyos ([196.77.120.180])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47885b1sm57294265e9.14.2026.09.02.03.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 03:11:34 -0700 (PDT)
From: =?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
To: linux-sound@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
Subject: [RFC PATCH v3 4/4] ALSA: usb: babyface-pro: add the hardware DSP EQ
Date: Wed,  2 Sep 2026 11:11:17 +0100
Message-ID: <20260902101117.11671-5-i.bahloul01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902101117.11671-1-i.bahloul01@gmail.com>
References: <20260902101117.11671-1-i.bahloul01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: i.bahloul01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: QOKZ6Z67VOTDPUWN4VJ6QK4S6JKVXCQE
X-Message-ID-Hash: QOKZ6Z67VOTDPUWN4VJ6QK4S6JKVXCQE
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:32 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QOKZ6Z67VOTDPUWN4VJ6QK4S6JKVXCQE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Program the four EQ strips (3-band bell/shelf + low cut) via the
fixed-point Q27 coefficient synthesis (CORDIC sin/cos, exp2) and bulk
uploads on EP 0x0A, exposed as the standard ALSA control set.  The
coefficients depend on the stream rate, so they are re-uploaded on
hw_params.

Signed-off-by: Ismaïl Bahloul <i.bahloul01@gmail.com>
Assisted-by: DeepSeek V4 Flash
---
 sound/usb/babyfacepro/babyfacepro-ctl.c | 570 +++++++++++++++++++++++-
 1 file changed, 565 insertions(+), 5 deletions(-)

diff --git a/sound/usb/babyfacepro/babyfacepro-ctl.c b/sound/usb/babyfacepro/babyfacepro-ctl.c
index 9422a73d3..938e47368 100644
--- a/sound/usb/babyfacepro/babyfacepro-ctl.c
+++ b/sound/usb/babyfacepro/babyfacepro-ctl.c
@@ -1343,7 +1343,6 @@ int babyface_create_controls(struct snd_usb_babyface *chip)
 	return 0;
 }
 
-
 /* Control indices in chip->panel_kctl[] (for snd_ctl_notify). */
 enum {
 	BF_PANEL_KCTL_BUTTON,
@@ -2278,16 +2277,577 @@ int babyface_create_panel(struct snd_usb_babyface *chip)
 	return 0;
 }
 
+#define BF_EQ_Q27		(1 << 27)
+#define BF_EQ_LC_OFF		0x04000000
+#define BF_EQ_BLOCK_LEN		64
+
+/* atan(2^-i) x 2^27 (CORDIC). */
+static const s64 bf_atan_tab[28] = {
+	0x6487ED5, 0x3B58CE1, 0x1F5B760, 0xFEADD5,
+	0x7FD56F, 0x3FFAAB, 0x1FFF55, 0xFFFEB,
+	0x7FFFD, 0x40000, 0x20000, 0x10000,
+	0x8000, 0x4000, 0x2000, 0x1000,
+	0x800, 0x400, 0x200, 0x100,
+	0x80, 0x40, 0x20, 0x10,
+	0x8, 0x4, 0x2, 0x1,
+};
 
-/* ── DSP-EQ stubs ─────────────────────────────────────────────
- * Replaced by the eq patch.  The core driver calls these from
- * probe() and hw_params() (fs-dependent re-upload).
+/* ---- fixed-point helpers (Q27 in/out, s64 intermediates) ---- */
+
+/* sin/cos of an angle in [0, pi/2] (Q27).  Simultaneous CORDIC, 28
+ * iterations (~1e-8 residual).  eq_selftest.c verifies the whole
+ * pipeline against the double-precision reference.
  */
-int babyface_create_eq(struct snd_usb_babyface *chip)
+static void bf_sincos(s64 ang, s64 *sn, s64 *cs)
+{
+	s64 x = 0x4DBA76D;	/* 1/1.64676 x 2^27 (CORDIC gain) */
+	s64 y = 0;
+	s64 z = ang;
+	int i;
+
+	for (i = 0; i < 28; i++) {
+		s64 d = z >= 0 ? 1 : -1;
+		s64 nx = x - d * (y >> i);
+		s64 ny = y + d * (x >> i);
+
+		x = nx;
+		y = ny;
+		z -= d * bf_atan_tab[i];
+	}
+	*cs = x;
+	*sn = y;
+}
+
+/* 2^u for u in Q27, u in [-2, 2] (gain-amplitude range). */
+static s64 bf_exp2(s64 u)
 {
+	s64 n = u >> 27;
+	s64 r = u - (n << 27);
+	s64 rl = (r * 0x58B90C0 + (1 << 26)) >> 27;	/* r.ln2 */
+	s64 e = BF_EQ_Q27;
+	s64 term = BF_EQ_Q27;
+	int k;
+
+	for (k = 1; k <= 10; k++) {
+		term = div_s64((term * rl + (1 << 26)) >> 27, k);
+		e += term;
+	}
+	return n >= 0 ? e << n : e >> -n;
+}
+
+/* The 5 stored words (c0..c3 + shared c4) for one band.
+ * type: 1 bell, 2 low shelf, 3 high shelf.  freq_hz, fs in Hz;
+ * q100 = Q x 100; gain_x10 = dB x 10.  fs is the stream rate.
+ */
+void bf_eq_band_words(s32 *w, int type, s32 freq_hz, s32 q100,
+		      s32 gain_x10, s32 fs)
+{
+	s64 f = freq_hz;
+	s64 w0, c, s, alpha, A, sq;
+	s64 b0, b1, b2, a0, a1, a2;
+	s64 pi = 0x1921FB54;	/* pi, Q27 */
+	s64 hpi = 0xC90FDAA;	/* pi/2, Q27 */
+	s64 t;
+	int both = 0, cflip = 0;
+
+	if (gain_x10 == 0 || q100 <= 0) {
+		/* Inactive band: identity words (also guards the alpha
+		 * division below against the default Q=0 the controls start
+		 * with - a user setting gain before Q used to hit a kernel
+		 * divide-by-zero oops).
+		 */
+		w[0] = 0;
+		w[1] = 0;
+		w[2] = 0;
+		w[3] = 0;
+		return;
+	}
+
+	/* w0 = 2.pi.f/fs (Q27), reduced to [0, pi/2]. */
+	w0 = div_s64(f * BF_EQ_Q27, fs);
+	w0 = (w0 * 0x3243F6A9) >> 27;	/* x 2.pi */
+	t = w0;
+	if (t > pi) {
+		t -= pi;
+		both = 1;
+	}
+	if (t > hpi) {
+		t = pi - t;
+		cflip = 1;
+	}
+	bf_sincos(t, &s, &c);
+	if (both) {
+		s = -s;
+		c = -c;
+	}
+	if (cflip)
+		c = -c;
+
+	alpha = div64_s64(s * 100 + q100, 2 * (s64)q100);	/* sin(w0)/(2Q) */
+	/* A = 10^(g/40), sqrt(A): g = gain_x10/10 dB */
+	A = bf_exp2((s64)gain_x10 * 0x11021E);
+	sq = bf_exp2((s64)gain_x10 * 0x8810F);
+
+	if (type == 1) {
+		s64 ta = (alpha * A + (1 << 26)) >> 27;
+
+		b0 = BF_EQ_Q27 + ta;
+		b1 = -2 * c;
+		b2 = BF_EQ_Q27 - ta;
+		a0 = BF_EQ_Q27 + div64_s64(alpha * BF_EQ_Q27 + A / 2, A);
+		a1 = -2 * c;
+		a2 = BF_EQ_Q27 - div64_s64(alpha * BF_EQ_Q27 + A / 2, A);
+	} else {
+		s64 ap1 = A + BF_EQ_Q27;
+		s64 am1 = A - BF_EQ_Q27;
+		s64 cp0 = (am1 * c + (1 << 26)) >> 27;	/* (A-1).c */
+		s64 cp1 = (ap1 * c + (1 << 26)) >> 27;	/* (A+1).c */
+		s64 ab = (2 * sq * alpha + (1 << 26)) >> 27;
+
+		if (type == 2) {	/* low shelf */
+			b0 = (A * (ap1 - cp0 + ab) + (1 << 26)) >> 27;
+			b1 = (2 * A * (am1 - cp1) + (1 << 26)) >> 27;
+			b2 = (A * (ap1 - cp0 - ab) + (1 << 26)) >> 27;
+			a0 = ap1 + cp0 + ab;
+			a1 = -2 * (am1 + cp1);
+			a2 = ap1 + cp0 - ab;
+		} else {		/* high shelf */
+			b0 = (A * (ap1 + cp0 + ab) + (1 << 26)) >> 27;
+			b1 = (-2 * A * (am1 + cp1) + (1 << 26)) >> 27;
+			b2 = (A * (ap1 + cp0 - ab) + (1 << 26)) >> 27;
+			a0 = ap1 - cp0 + ab;
+			a1 = -2 * (am1 - cp1);
+			a2 = ap1 - cp0 - ab;
+		}
+	}
+
+	w[0] = (s32)div64_s64(a1 * BF_EQ_Q27 + a0 / 2, a0);
+	w[1] = (s32)div64_s64(a2 * BF_EQ_Q27 + a0 / 2, a0);
+	w[2] = (s32)div64_s64(b1 * BF_EQ_Q27 + b0 / 2, b0);
+	w[3] = (s32)div64_s64(b2 * BF_EQ_Q27 + b0 / 2, b0);
+	w[4] = (s32)div64_s64(b0 * BF_EQ_Q27 + a0 / 2, a0);
+}
+
+/* ---- low cut ---- */
+
+/* Slope byte: 2^n-1 (n poles) -> 6/12/18/24 dB per oct; 0 = off. */
+static u8 bf_eq_lc_slope_byte(s32 slope_db)
+{
+	switch (slope_db) {
+	case 6:  return 0x01;
+	case 12: return 0x03;
+	case 18: return 0x07;
+	case 24: return 0x0F;
+	}
 	return 0;
 }
 
+/* The 0x38 low-cut frequency word: round(K.f'.(11656)/(11656+f')) with
+ * K = 11508, f' = f x slope-compensation factor (cap_eq9 fit, 0.003%;
+ * the slope factor keeps the composite -3 dB point constant).
+ */
+static u32 bf_eq_lc_freq_raw(s32 freq_hz, s32 slope_db)
+{
+	s64 f, word;
+
+	if (freq_hz <= 0)
+		return BF_EQ_LC_OFF;
+	f = freq_hz;
+	switch (slope_db) {
+	case 6:
+		f = f * 15267 / 10000;
+		break;
+
+	case 18:
+		f = f * 8061 / 10000;
+		break;
+
+	case 24:
+		f = f * 6977 / 10000;
+		break;
+	}
+	word = (11508 * f * 11656 + (11656 + f) / 2) / (11656 + f);
+	return (u32)word;
+}
+
+/* ---- block build + bulk write ---- */
+
+static void bf_eq_build_block(u8 *b, int ch, u8 slope,
+			      const s32 bands[3][4], s32 shared, u32 lc)
+{
+	int slot, k;
+
+	memset(b, 0, BF_EQ_BLOCK_LEN);
+	b[0] = ch;
+	b[1] = slope;
+	b[2] = ch;
+	b[3] = 0x80;	/* EQ engine active */
+	for (slot = 0; slot < 3; slot++) {
+		for (k = 0; k < 4; k++) {
+			put_unaligned_le32((u32)bands[slot][k],
+					   b + 0x04 + slot * 0x10 + 4 * k);
+		}
+	}
+	put_unaligned_le32((u32)shared, b + 0x34);
+	put_unaligned_le32(lc, b + 0x38);
+}
+
+/* Upload one 64-byte block on bulk OUT ep 0x0A (interface 1). */
+static int bf_eq_upload(struct snd_usb_babyface *chip, const u8 *block)
+{
+	u8 *buf;
+	int ret, len;
+
+	/* usb_bulk_msg DMA-maps the buffer: it must not be on the stack
+	 * (usb_hcd_map_urb_for_dma returns -EAGAIN for stack buffers).
+	 */
+	buf = kmemdup(block, BF_EQ_BLOCK_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	ret = usb_bulk_msg(chip->dev, usb_sndbulkpipe(chip->dev, 0x0a),
+			   buf, BF_EQ_BLOCK_LEN, &len, 1000);
+	kfree(buf);
+	if (ret < 0)
+		dev_err(&chip->dev->dev, "EQ bulk upload failed: %d\n", ret);
+	return ret;
+}
+
+/* Write the L+R block pair for one strip (channel base = strip x 2). */
+static int bf_eq_write_strip(struct snd_usb_babyface *chip, int strip)
+{
+	struct bf_eq_channel *e = &chip->eq[strip];
+	u8 b[BF_EQ_BLOCK_LEN];
+	s32 identity[3][4] = { { 0 }, { 0 }, { 0 } };
+	s32 shared = e->on ? e->shared : BF_EQ_Q27;
+	u32 lc = e->on ? e->lc_raw : BF_EQ_LC_OFF;
+	/* The header slope byte (b[1]) is only valid while the low cut is
+	 * engaged: a stale slope with 0x38 = off made the device apply a
+	 * garbage-frequency cut (ear-verified: "low cut off" left only
+	 * highs).  cap_eq7: byte1 = 0x00 + 0x38 = 0x04000000 when off.
+	 */
+	u8 slope = (e->on && e->lc_hz > 0) ? e->slope : 0;
+	int ch, ret;
+
+	for (ch = 0; ch < 2; ch++) {
+		bf_eq_build_block(b, strip * 2 + ch, slope,
+				  e->on ? e->words : identity, shared, lc);
+		ret = bf_eq_upload(chip, b);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+/* Recompute one strip's words + low cut from its params, re-upload.
+ * Lock-free by convention: every caller must already hold chip->mutex
+ * (bf_eq_put() and bf_eq_reupload() do) - asserting it here catches a
+ * future caller that forgets, instead of a silent self-deadlock.
+ */
+static void bf_eq_update_strip(struct snd_usb_babyface *chip, int strip)
+{
+	struct bf_eq_channel *e = &chip->eq[strip];
+	s32 fs = chip->rate ? chip->rate : 48000;
+	s32 last_c4 = BF_EQ_Q27;
+	int band, i;
+
+	lockdep_assert_held(&chip->mutex);
+
+	for (band = 0; band < 3; band++) {
+		s32 w[5];
+
+		bf_eq_band_words(w, e->band_type[band], e->band_freq[band],
+				 e->band_q[band], e->band_gain[band], fs);
+		for (i = 0; i < 4; i++)
+			e->words[band][i] = w[i];
+		if (e->band_type[band] && e->band_gain[band])
+			last_c4 = w[4];	/* shared scale: the last band */
+	}
+	e->shared = last_c4;
+	e->lc_raw = bf_eq_lc_freq_raw(e->lc_hz, e->slope_db);
+	e->slope = bf_eq_lc_slope_byte(e->slope_db);
+	bf_eq_write_strip(chip, strip);
+}
+
+/* Recompute + re-upload all four strips (rate change). Caller must
+ * hold chip->mutex - bf_eq_update_strip()/bf_eq_write_strip() are
+ * lock-free by convention (see bf_eq_put()) and the only caller,
+ * babyface_pcm_hw_params(), already holds the lock across the rate
+ * change; locking here too self-deadlocked it (hung-task: "blocked
+ * on a mutex likely owned by" itself, hit via regress.sh's rate
+ * sweep).
+ */
 void bf_eq_reupload(struct snd_usb_babyface *chip)
 {
+	int strip;
+
+	for (strip = 0; strip < 4; strip++)
+		bf_eq_update_strip(chip, strip);
+}
+
+/* ---- ALSA controls (4 strips x 19 controls) ---- */
+
+#define EQ_STRIP(pv)	((pv) >> 8)
+#define EQ_PARAM(pv)	((pv) & 0xff)
+/* params: 0 enable, 1-3 type, 4-6 freq, 7-9 q, 10-12 gain, 13 lc freq, 14 lc slope */
+
+static const char *const bf_eq_type_texts[] = {
+	"Off", "Bell", "Low Shelf", "High Shelf", NULL
+};
+
+static const char *const bf_eq_slope_texts[] = {
+	"6 dB/oct", "12 dB/oct", "18 dB/oct", "24 dB/oct", NULL
+};
+
+static int bf_eq_info(struct snd_kcontrol *kctl,
+		      struct snd_ctl_elem_info *uinfo)
+{
+	int param = EQ_PARAM(kctl->private_value);
+
+	if (param == 0) {
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+		uinfo->count = 1;
+		return 0;
+	}
+	if (param == 1 || param == 2 || param == 3)
+		return snd_ctl_enum_info(uinfo, 1, 4, bf_eq_type_texts);
+	if (param == 14)
+		return snd_ctl_enum_info(uinfo, 1, 4, bf_eq_slope_texts);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = (param == 10 || param == 11 ||
+				    param == 12) ? -240 :
+				   (param == 7 || param == 8 ||
+				    param == 9) ? 5 : 0;
+	uinfo->value.integer.max = (param == 7 || param == 8 ||
+				    param == 9) ? 1000 :
+				   (param == 10 || param == 11 ||
+				    param == 12) ? 240 : 20000;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int bf_eq_get(struct snd_kcontrol *kctl,
+		     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	struct bf_eq_channel *e = &chip->eq[EQ_STRIP(kctl->private_value)];
+	int param = EQ_PARAM(kctl->private_value);
+	int band = (param - 1) % 3;
+	s32 *v = NULL;
+
+	switch (param) {
+	case 0:
+		break;
+
+	case 1:
+	case 2:
+	case 3:
+		v = &e->band_type[band];
+		break;
+
+	case 4:
+	case 5:
+	case 6:
+		v = &e->band_freq[band];
+		break;
+
+	case 7:
+	case 8:
+	case 9:
+		v = &e->band_q[band];
+		break;
+
+	case 10:
+	case 11:
+	case 12:
+		v = &e->band_gain[band];
+		break;
+
+	case 13:
+		v = &e->lc_hz;
+		break;
+
+	case 14:
+		v = &e->slope_db;
+		break;
+	}
+	if (param == 0) {
+		ucontrol->value.integer.value[0] = e->on;
+	} else if (param == 14) {
+		/* Inverse of put's index->dB map: slope_db stores the raw
+		 * 6/12/18/24 dB/oct value, but an ENUMERATED control's .get
+		 * must return the enum item index (0-3), same as .put
+		 * receives - returning the raw dB value here (the bug this
+		 * replaces) fed back an out-of-range index to every ALSA
+		 * consumer (confirmed via amixer: writing index 1 read back
+		 * as value 12, not 1).
+		 */
+		s32 slope = v ? *v : 6;
+
+		ucontrol->value.enumerated.item[0] =
+			slope >= 24 ? 3 : slope >= 18 ? 2 : slope >= 12 ? 1 : 0;
+	} else if (param == 1 || param == 2 || param == 3) {
+		/* ENUMERATED band type: use the enumerated union member. */
+		ucontrol->value.enumerated.item[0] = v ? *v : 0;
+	} else {
+		ucontrol->value.integer.value[0] = v ? *v : 0;
+	}
+	return 0;
+}
+
+static int bf_eq_put(struct snd_kcontrol *kctl,
+		     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int strip = EQ_STRIP(kctl->private_value);
+	int param = EQ_PARAM(kctl->private_value);
+	struct bf_eq_channel *e = &chip->eq[strip];
+	int band = (param - 1) % 3;
+	s32 nv;
+	s32 *v = NULL;
+	int ret = 0;
+
+	/* Read from the union member matching the control type: ENUMERATED
+	 * params (band type 1-3, slope 14) use .enumerated.item, everything
+	 * else (BOOL 0, INTEGER) uses .integer.value.
+	 */
+	if (param == 1 || param == 2 || param == 3 || param == 14)
+		nv = (s32)ucontrol->value.enumerated.item[0];
+	else
+		nv = (s32)ucontrol->value.integer.value[0];
+
+	/* Validate against the bounds bf_eq_info() declares.  The ALSA core
+	 * only checks these when CONFIG_SND_CTL_INPUT_VALIDATION is set, so
+	 * an out-of-range value here could otherwise reach the Q27
+	 * coefficient math (bf_eq_band_words/bf_exp2) and shift by >= width
+	 * (undefined behaviour).
+	 */
+	switch (param) {
+	case 0:
+		if (nv < 0 || nv > 1)
+			return -EINVAL;
+		break;
+	case 1:
+	case 2:
+	case 3:
+	case 14:
+		if (nv < 0 || nv > 3)
+			return -EINVAL;
+		break;
+	case 4:
+	case 5:
+	case 6:
+	case 13:
+		if (nv < 0 || nv > 20000)
+			return -EINVAL;
+		break;
+	case 7:
+	case 8:
+	case 9:
+		if (nv < 5 || nv > 1000)
+			return -EINVAL;
+		break;
+	case 10:
+	case 11:
+	case 12:
+		if (nv < -240 || nv > 240)
+			return -EINVAL;
+		break;
+	}
+
+	switch (param) {
+	case 0:
+		v = NULL;
+		break;
+
+	case 1:
+	case 2:
+	case 3:
+		v = &e->band_type[band];
+		break;
+
+	case 4:
+	case 5:
+	case 6:
+		v = &e->band_freq[band];
+		break;
+
+	case 7:
+	case 8:
+	case 9:
+		v = &e->band_q[band];
+		break;
+
+	case 10:
+	case 11:
+	case 12:
+		v = &e->band_gain[band];
+		break;
+
+	case 13:
+		v = &e->lc_hz;
+		break;
+
+	case 14:
+		v = &e->slope_db;
+		break;
+	}
+	if (param == 14)	/* slope enum items are 6/12/18/24 */
+		nv = nv == 0 ? 6 : nv == 1 ? 12 : nv == 2 ? 18 : 24;
+
+	mutex_lock(&chip->mutex);
+	if (param == 0) {
+		if (e->on != !!nv) {
+			e->on = !!nv;
+			bf_eq_update_strip(chip, strip);
+			ret = 1;
+		}
+	} else if (v && *v != nv) {
+		*v = nv;
+		bf_eq_update_strip(chip, strip);
+		ret = 1;
+	}
+	mutex_unlock(&chip->mutex);
+	return ret;
+}
+
+int babyface_create_eq(struct snd_usb_babyface *chip)
+{
+	static const char *const names[4] = { "AN1", "AN2", "AN3", "AN4" };
+	static const char *const params[] = {
+		"EQ Enable",
+		"EQ Band 1 Type", "EQ Band 2 Type", "EQ Band 3 Type",
+		"EQ Band 1 Freq", "EQ Band 2 Freq", "EQ Band 3 Freq",
+		"EQ Band 1 Q", "EQ Band 2 Q", "EQ Band 3 Q",
+		"EQ Band 1 Gain", "EQ Band 2 Gain", "EQ Band 3 Gain",
+		"EQ Low Cut Freq", "EQ Low Cut Slope",
+	};
+	int strip, i, err;
+
+	for (strip = 0; strip < 4; strip++) {
+		for (i = 0; i < 15; i++) {
+			struct snd_kcontrol *kctl;
+			char name[64];
+
+			snprintf(name, sizeof(name), "%s %s", names[strip],
+				 params[i]);
+			kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+				.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+				.name = "EQ",
+				.index = 0,
+				.info = bf_eq_info,
+				.get = bf_eq_get,
+				.put = bf_eq_put,
+				.private_value = (strip << 8) | i,
+			}, chip);
+			if (!kctl)
+				return -ENOMEM;
+			strscpy(kctl->id.name, name, sizeof(kctl->id.name));
+			err = snd_ctl_add(chip->card, kctl);
+			if (err < 0)
+				return err;
+		}
+	}
+	return 0;
 }
-- 
2.55.0

