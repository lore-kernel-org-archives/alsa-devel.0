Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792CAC79F99
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:36:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 144086028D;
	Tue,  8 Sep 2026 20:36:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 144086028D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892613;
	bh=DY3aGA71M5brUHY1t9eFomVD0psr5xaRzmYYQvL/GEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KgLNGxl/5aTBJhVI0qstVs4fzUrnNFo/lRRLhweWbzobxlxrxiajFVOic6C4rHKPV
	 gaFYuivpEb/xrMTSh5/Ui3N0svbgHbxubs/gVLHaJTHOFUJKHi1dYncCZosHtfP219
	 lMvuF1HHH0X6kNoJ4+fRCGOgatnCM4ZSG2AQVo4Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA9C5F80690; Tue,  8 Sep 2026 20:35:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3146F8067F;
	Tue,  8 Sep 2026 20:35:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A041EF804CC; Tue,  1 Sep 2026 11:07:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788253635;
	b=DUz9WsYg+NmkdUqDi/B8y/+SX8XBr80rd+N4ae64iWy+vCA1jCnGnM7PsRlXlFzuxOkO
	 OiY/wCFOcssVjHEVVa8OWHbZ66oADNxRwjBvVvDYnN84Fm9shuw72+M/igV1YSeAjfxjn
	 unMQeaS1A9dOxrpMzYkIzLEvvfecugMUYn59OjdPYzrueUi12p3ejKqRt403yl3kzXGdO
	 ldr5vzHycGwwohTQYTFJ/51FQlOE+MDoY5dNtoURnoA4E9VGQRYj3YbgetMPIUbHynZTh
	 wt6FnceCrYr1M5KTZPEbuLi1R3YAhPZ30AoQ+jINBtG6EFeVJEpr1tjmwRxbOuK3I9w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788253635;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DY3aGA71M5brUHY1t9eFomVD0psr5xaRzmYYQvL/GEE=;
	b=XkmwY/B7UodSMSE1gRdOtDj0iJP9zFouN4fcMh3CenEHGVJfamkaXQZUy8b8phsXhYw+
	 TEXNr7Hp/wFnQ3gFM266CtgbRxdzNyhrWOr77qEGCBVR1O0JzZENDWyBwYzKkimop+AsF
	 lJKjSNfBej5PxgI/g3opUETJ/OXYfWV5z85TcrggUSwTcXzX8W33TM3e+6pYt/tPp6DJd
	 otTWQsgl6O0CxIODdXPwwmSoYcklBTGD1/2zKcUinXhFTXCJE9poK7IntGe8krdkXxupn
	 uJPQrKtJg3N8FUBDYcnVL2inFuulq6dClT823p9VUcio5P/T+7Yw4kU7kVp1f9NXZXQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E1Ra2WHV;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5F567F804F3
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 11:07:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F567F804F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E1Ra2WHV
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-484362f5c4aso2161991f8f.3
        for <alsa-devel@alsa-project.org>;
 Tue, 01 Sep 2026 02:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788253633; x=1788858433;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KkIIOAYjYAqLcsdb7lFesQWgIS689+8MWdFQ/W4oAJo=;
        b=E1Ra2WHVz/Ht3ZtasKMeuLsGWlA3D4cCiqb9pH2TvgHblrSkUWGE1Jip3Zc0IedZql
         w1Y1OSvQTyEChcrkS/2H7H2ErrMzvZjOuZ9U1J9NDuNznmQRzIILnPqihkNxO8mxm/UZ
         vrn60/u7r2h+rtuC33zUOkpraeL61XrIeK7y7F9p5XFmn82u8p/P7m5FrbvOI7b75d0S
         1i3XPUqYLmxwfUKe26Ki4yt1dgDhYtKfYmhZXAxk9IHExQ/dQM+hSZJWopkBASpcyIHA
         sMPhmC0nUUP1LWmzMRmgUJhRYpwyOkYGVAkq6PWp1fyzYRsiAECBAdcl4uR0xSchKMEY
         BXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788253633; x=1788858433;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KkIIOAYjYAqLcsdb7lFesQWgIS689+8MWdFQ/W4oAJo=;
        b=obxXAQlZ/UAyXU6tWgshrP6V+hsoD1HE9SxoEaH0VZ0zWEpOfaNX16OTmAIL4BHxDh
         yUx5siipa9KN+aHenxNK6lTZaG8QDI6uN6KtWtwmapMs0/VAGnOXwrbpIHf+t2dyxdJw
         6HOaOVEmizbEHjRb/qmwwKI7f0T4lqLeETt4zEf9O3m+fnu7RPW1ljq6Teh0Lf/7g12+
         DYwjnlDGlBOtWaNZLOHLUtmy/nWAjY+ZZfIguToaCGI+pa8JdLVGCJOLh2j40jG7w2ly
         ZnR4v/h1UkZLeZwMPey0hmADBtAgPy2Wp8/eF0tHhWbMqJEv5/HN7+t50pFiYhQOFK+6
         oUYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx8YNBNMPrseyTqHOF1S34L+SEB38aQhMfRFGur2h0jnjclGcyK73GHp6qW4lxy10hvG4P+GHTi+fB@alsa-project.org
X-Gm-Message-State: AFuF++lQbx0+6fxxt0b/o5LN+4JuQkVkO05ebWzdOeU/LtVFOYkssdDj
	knOuacly+x2aWgsifRsutDg7QmhK20UNMs2Q5pdTauHtrkQkwdEv+tnqaLx7mnyUJQw=
X-Gm-Gg: AYBFou2Cuq7aQvoRM15ivoqg2xcG45N+6FQwMdZ8cMSlYxKTHlVFo10y1tUxXb9HmN7
	tgWhasDWFqUTVC2Zh1AoIU9Q3QWiH7CfR8XrQP80HY4pCGEpWS4FfcTZpdH2O7v8uwODaZxtnVR
	rrVvMACIeK7I2DqM+CRswZPs7cI1b0DqtYQ+Gcd4Hfe8+RqS6uUywIU9og5BU1W31p9wUP9Huna
	NGJsKzrFlAiwLVenOxKImmp6xffTqSDbsb6i0a6enbOsWiq1dboTR+hx9HFVDKR0yHKA5VB+6mH
	rUqlPgVchsZBP8dt09eQ1NAI7Ke3UE27y5vQCcxAT1D587e+YMRqh3x6+ZVnZHDPkiKIThF/IUc
	38GU98I+yuBfRknWDBOOgWNBKygu7bxSZZ42kuOgcDkc1GpmsgoKvZWWme0WgI3b1LhDpn8zDGx
	uXr5HCcETRzeU2H+mw8Q0vkZE2IaqMqR6hzCG3HSMywxYyrgD9/OWdmLW20VTYKreGqK1M/+II1
	qLXb2jbh+nRRPM5
X-Received: by 2002:a05:6000:bca:b0:47f:eac2:6f55 with SMTP id
 ffacd0b85a97d-4844101af6amr9961050f8f.19.1788253632527;
        Tue, 01 Sep 2026 02:07:12 -0700 (PDT)
Received: from cachyos ([41.142.112.134])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d6e905sm3124471f8f.23.2026.09.01.02.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:07:11 -0700 (PDT)
From: =?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
To: linux-sound@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
Subject: [RFC PATCH v2 4/4] ALSA: usb: babyface-pro: add the hardware DSP EQ
Date: Tue,  1 Sep 2026 10:06:35 +0100
Message-ID: <20260901090635.9208-5-i.bahloul01@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901090635.9208-1-i.bahloul01@gmail.com>
References: <20260901090635.9208-1-i.bahloul01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: i.bahloul01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: X5TII4A67MIPJTWPAYJSASKDMQ4KCP4Y
X-Message-ID-Hash: X5TII4A67MIPJTWPAYJSASKDMQ4KCP4Y
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:12 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X5TII4A67MIPJTWPAYJSASKDMQ4KCP4Y/>
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
index 4904fe486..c28175199 100644
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
+		 * with — a user setting gain before Q used to hit a kernel
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
+ * (bf_eq_put() and bf_eq_reupload() do) — asserting it here catches a
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
+ * hold chip->mutex — bf_eq_update_strip()/bf_eq_write_strip() are
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
+		 * receives — returning the raw dB value here (the bug this
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

