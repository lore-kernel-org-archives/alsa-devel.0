Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D4606A31C
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=C2gWIqU8;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X3Nt7zpb
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C17B460285;
	Mon,  9 Nov 2026 16:03:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C17B460285
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236622;
	bh=0jHaIvEi80e3WZKoZC0TdFMDYOIqWSkrxlQPbEcJHho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=C2gWIqU88vSKRhkDJ2UUV1ITlQB23rybH2DTKYWfhR+tnA1DXCI9xynxnPCGraIuV
	 bwSu5kqKWyYkJiUuHtRbQlG52hi7whRKtsRm7OtzWlSqkbh1nIw1GLoJ8Ff8atbEUi
	 OUSTLdzTLBDIPF9JU/pfMZQGeuOsQGu02FGhA5bQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C1CDF807B6; Mon,  9 Nov 2026 16:01:08 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 93F0BF80803;
	Mon,  9 Nov 2026 16:01:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 434E8F805BA; Thu,  5 Nov 2026 16:17:14 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793891831;
	b=UqBhBMi2Y2K7G+XJYMxWRRlUSupCDh0btYzh+loqwjSgDuipQ5g6ENOWIFSEVtlvxmk9
	 4p7Ro8/zwi0J4b+fXD/BGNjPUyB7kK+03pBMW7jRaHgZ61VmKT19cJTmbdHioQi/GMWvj
	 kUfUtL2/RUYCj+driU7w3h9MRxwu1sawC7lhnnHn5RK37MiuCxNI1yJPxtw79ymgaRRWc
	 Y+8Y6XtX9Db3Y1clqtNraPcqEsYF8D3LNHyiI6Kpw1Kini5JcKPPAc5gyqa8eLyq3wiaO
	 ZUqdbcfJS/zkBykqo7NAKy3gtr+srheUhYXQwnKI/lN5JM4Pn4hOu/0SMW6tf1rICww==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793891831;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0jHaIvEi80e3WZKoZC0TdFMDYOIqWSkrxlQPbEcJHho=;
	b=FwSl/dCRtFfuQPqczb0VYmjtAAlW2gPiqoCrRIlQpPlbGX4KnLHjM/WeZZyaM7IYgm/S
	 q+++Ss/EkRxiNQkTn0H55sWqqGYm0lT44zgAscxIuWyB5bOv0GkfRC3JNiRVfNypr170H
	 BQYS1LU0oMe/vp19u3g2BbfLPiAquvTxX+KUfWR7Rw5RDrRPIK+PVrNRnPaP05jNDl1CK
	 Oa1u958LVm0lQgBk/annu0QyZ6UvcmPYxWTMoRV7ilcAIXP+wLU+vF7h8tlwQVuNDgqbe
	 gV0+PCdmTdeAhFpGE6a1GZRrVksu3Rnr3xrf0exS7Z+KWNlfCnfVhpU8s35cN1YAF+Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=X3Nt7zpb;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9EBDBF802DB
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 16:17:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EBDBF802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=X3Nt7zpb
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36a315ed211so916317eec.0
        for <alsa-devel@alsa-project.org>;
 Thu, 05 Nov 2026 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793891828; x=1794496628;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X27i5FPNg3qBGWY/ZcsKTiIs7Fy6HXSgU+WNK4go2Y4=;
        b=X3Nt7zpbqX5aPVO3a0Wop1XJgJYGgU6fZSkxzptRvGn0/XFREon6b3RWuh9ZiTn1VH
         t8+FeE2j/v/EkU4/OO2ALs72rdV7iFb5V/9QX0jJevJX+RmKVA9RZupQ+8xFvkwDZphq
         mx2iWkbDPc4U5hQ2UJWHjGhDz8nQeLMxJtSJWeLicrq/DNg4WjClC97hloRCViUQ0A2C
         x1AHuKrL92zIAbPy1UP9Ksl+N8wFREVV9cglFPJzmaAcaDG/JNZ3SSNxpW1zoANRgMfN
         9zIcBxtvqGddd4nR2B5UfZ1c+fTCgSSBR81KqyN3QlI38Bk+JuWTNJGgNz39iQ1XiweT
         p8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891828; x=1794496628;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X27i5FPNg3qBGWY/ZcsKTiIs7Fy6HXSgU+WNK4go2Y4=;
        b=HL4rGFbEF0if0GO/Ue4uaWGY1RJZaVupO0Oc1TN72ap0ihcHCWwsqMjl/JxqIz+nok
         Jed/cBzb/o4B6ET6tLeIPqhLf8L3O2PVCo87SbsI1xNebOi+uTyLZzCiEqjJo3brL9yO
         hKBh+Dqw6uLcnyMdIPsNlSOdMkP1Z9fHHMKiENANn+GEyh17JtNCgAVuZ3XcV5jp1xQz
         24OCPaHp+pLvznkx/vZLLn1eRaKKKE2MW87eZDVVKwvzXZV44EKiM9r3esf2EdZvl09Z
         0b6wjLOLFL2rsuVm603LRn4kOzlVfR2Z4Pg/fK2XgrIxGC9KuLGAea5FKGafCper+eOY
         T00w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2j/Pcn3IHX4yFkXZ29+x+vo9QGqPp3RL7uHr2QqLLIEexYdRBgoKwOEUO4k1rkZ6k+kmV2nZZDy+c@alsa-project.org
X-Gm-Message-State: APuU4Z8yXKouDwe+hdVJ08msKBtmF+HH+gaV4IulRwDU2oTLPNorLuLf
	EaNUC0ETizAa4uKYTpQiUiIufR1SDqHEdwsNAveyx/vRA71KBy6VvMbB
X-Gm-Gg: AYBFou29fW6cjujqVrA5z193U9HgLxvPCYE9ZgtMewF+UndI0HHOeplUUfOrx24VObR
	ndjPDrylXDI7ep3GAmiX4BCbSMtY4UI1Cshj7RQW1PH9JxueDGC+XmA1L++fl00p9bVsY260+gN
	AaWCdNwuMZ1f0Q5KA+tGXJz91r8z3nQAmpbPrw+kFiXHl2X8bc/hAsI2yIy4jejxXAR2qRTQeiL
	L98xeUpD/CTbk7NTT2TIHVFUNQFl45UxzbS3yuSH/J+a1cCndR1JGGwFT1nfyw6xofW1zgk16pH
	OK1Ec5CvE84EjhNKA8FZov3WZdwGFUuATRhjr1VGHEtAbmVY3UH9CrwpR56xWcJ7QTuNB3fnVZa
	03x37+L60VvbIiQlC4kMyD/S6hbQtm5+cZAWgGdLOADSLzMTJLMgQoGgbavZA2QLvwrpxtA+B+Y
	NWlbJpNtvTdGzUUdQIf/AubjHd1ULfJg6u1hZVgZG26EO8VGhvD5LnKG+Qd9jxHmOaQR0cifP9a
	satI8tGM6U2+rEvTQnnmqJ5jqT+ifTzS3piBDMa+NhE9wQhaqp34XaFu9FF/YjCrfKUJ9axowjh
	ebyPbvE062MVeP1/dFpmzKoRh+B7UkU8ubNGqyyfMYRH64JqILtCWXOm9fXUfBKhukZlngfIr4a
	+u3Yj3PiY+KwB/2GBiN2Rz1/X+ZN78H+bvxFnhePwAEOnbYGY
X-Received: by 2002:a05:693c:41c5:20b0:369:f17d:efb with SMTP id
 5a478bee46e88-36de655f12fmr3758341eec.10.1793891828185;
        Thu, 05 Nov 2026 07:17:08 -0800 (PST)
Received: from cachyos (2a01cb0c82caf900a186612f304bfea5.ipv6.abo.wanadoo.fr.
 [2a01:cb0c:82ca:f900:a186:612f:304b:fea5])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38a6d3dsm21567087eec.7.2026.11.05.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:17:07 -0800 (PST)
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
Subject: [PATCH v8 7/8] ALSA: usb: babyfacepro: add the hardware DSP EQ
Date: Thu,  5 Nov 2026 16:15:52 +0100
Message-ID: <20261105151553.223722-8-i.bahloul01@gmail.com>
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
Message-ID-Hash: B7FGT6MQQ7P3BOQ4DCAFWWWEFNPDIS5A
X-Message-ID-Hash: B7FGT6MQQ7P3BOQ4DCAFWWWEFNPDIS5A
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:00:52 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B7FGT6MQQ7P3BOQ4DCAFWWWEFNPDIS5A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Add the 4-strip (AN1-AN4) 3-band + low-cut parametric EQ: the
fixed-point (Q27, CORDIC) biquad coefficient math, the 64-byte blocks
uploaded on bulk endpoint 0x0A of interface 1, and 15 controls per
strip.

The coefficients depend on the sample rate, so hw_params re-uploads
them on a rate change.  The DSP is not part of the register state the
cold init clears, so resume re-uploads them as well; after a re-probe,
alsactl restores the EQ controls and their puts re-upload the
coefficients.  The Q controls start at 1.0, and a band with no gain or
no Q uploads the identity.

The three checkpatch CHECK notes on this code (BIT() vs (1 << 27),
'ang' twice) are known false positives: BIT() returns unsigned long,
wrong for this file's signed Q27 math, and 'ang' is the CORDIC angle.

Signed-off-by: Ismaïl Bahloul <i.bahloul01@gmail.com>
---
 sound/usb/babyfacepro/babyfacepro-ctl.c | 610 +++++++++++++++++++++++-
 sound/usb/babyfacepro/babyfacepro.c     |  59 ++-
 sound/usb/babyfacepro/babyfacepro.h     |  25 +-
 3 files changed, 679 insertions(+), 15 deletions(-)

diff --git a/sound/usb/babyfacepro/babyfacepro-ctl.c b/sound/usb/babyfacepro/babyfacepro-ctl.c
index 51cf8c7bd..a1b8caa28 100644
--- a/sound/usb/babyfacepro/babyfacepro-ctl.c
+++ b/sound/usb/babyfacepro/babyfacepro-ctl.c
@@ -4,7 +4,8 @@
  *
  * ALSA control surface: the hardware mixer (output masters and mutes,
  * the crosspoint matrix, preamps, routing flags, varispeed pitch),
- * and the front-panel poll and controls.
+ * the front-panel poll and controls, and the hardware DSP EQ
+ * (3-band + low cut).
  *
  * See babyfacepro.h for the shared device state and register map,
  * and babyfacepro.c for the core driver (protocol, PCM streaming,
@@ -3336,3 +3337,610 @@ int babyface_create_panel(struct snd_usb_babyface *chip)
 
 	return 0;
 }
+
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
+
+/* sin/cos of an angle in [0, pi/2] (Q27).  Simultaneous CORDIC, 28
+ * iterations (~1e-8 residual).  eq_selftest.c verifies the whole
+ * pipeline against the double-precision reference.
+ */
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
+{
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
+	s64 w0, c, s, u, su, cu, alpha, A, sq;
+	s64 b0, b1, b2, a0, a1, a2;
+	s64 pi = 0x1921FB54;	/* pi, Q27 */
+	s64 hpi = 0xC90FDAA;	/* pi/2, Q27 */
+	s64 t;
+	int both = 0, cflip = 0;
+
+	if (type == 0 || gain_x10 == 0 || q100 <= 0) {
+		/* Inactive band (type Off, or no gain/Q yet): identity
+		 * words.  Also guards the alpha division below against
+		 * the default Q=0 the controls start with - a user
+		 * setting gain before Q used to hit a kernel
+		 * divide-by-zero oops.
+		 */
+		w[0] = 0;
+		w[1] = 0;
+		w[2] = 0;
+		w[3] = 0;
+		/* w[4] is the shared scale bf_eq_update_strip() reads when the
+		 * band has a type and a gain but no Q yet (Q defaults to 0).
+		 * Leaving it unwritten uploaded a garbage shared scale.
+		 */
+		w[4] = BF_EQ_Q27;
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
+	/* alpha = sin(w0 / (2Q)), the way TotalMix computes it, not the
+	 * cookbook's sin(w0) / (2Q): the two agree where w0 is small and
+	 * part ways as it grows, which is the effective Q that shrinks above
+	 * a few kHz in the captures (tools/usbdump/eq_biquad.md).  Checked
+	 * for Q 0.7 to 5 up to 16 kHz.  The angle is held to pi/2: past it
+	 * sin() falls again, and towards pi it would make a vanishing alpha,
+	 * a resonance with its poles on the unit circle.  It only matters for
+	 * a low Q at a high frequency (below Q 1, w0 > pi.Q), where the band
+	 * is as wide as it gets.
+	 */
+	u = div64_s64(w0 * 100 + q100, 2 * (s64)q100);
+	if (u > hpi)
+		u = hpi;
+	bf_sincos(u, &su, &cu);
+	alpha = su;
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
+/* Slope byte: 2^n-1 (n poles) -> 6/12/18/24 dB per oct; 0 = off. */
+static u8 bf_eq_lc_slope_byte(s32 slope_db)
+{
+	switch (slope_db) {
+	case 6:  return 0x01;
+	case 12: return 0x03;
+	case 18: return 0x07;
+	case 24: return 0x0F;
+	}
+	return 0;
+}
+
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
+	word = div64_s64(11508 * f * 11656 + (11656 + f) / 2, 11656 + f);
+	return (u32)word;
+}
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
+static int bf_eq_update_strip(struct snd_usb_babyface *chip, int strip)
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
+	return bf_eq_write_strip(chip, strip);
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
+void bf_eq_reupload(struct snd_usb_babyface *chip)
+{
+	int strip;
+
+	for (strip = 0; strip < 4; strip++)
+		bf_eq_update_strip(chip, strip);
+}
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
+	guard(mutex)(&chip->mutex);
+	if (param == 0) {
+		if (e->on != !!nv) {
+			e->on = !!nv;
+			ret = bf_eq_update_strip(chip, strip);
+			if (ret < 0)
+				return ret;
+			ret = 1;
+		}
+	} else if (v && *v != nv) {
+		*v = nv;
+		ret = bf_eq_update_strip(chip, strip);
+		if (ret < 0)
+			return ret;
+		ret = 1;
+	}
+	return ret;
+}
+
+/* The Q controls declare 5..1000 (Q x 100) and bf_eq_put() rejects
+ * anything below 5, so a zeroed band_q would read back out of range -
+ * alsactl then fails to restore it (EINVAL) - and could reach the
+ * coefficient math.  Seed the neutral Q 1.0 on every strip at probe,
+ * before any saved state is applied so a restore still overrides it.
+ */
+void bf_eq_defaults(struct snd_usb_babyface *chip)
+{
+	int strip, band;
+
+	for (strip = 0; strip < 4; strip++) {
+		chip->eq[strip].slope_db = 6;
+		for (band = 0; band < 3; band++)
+			chip->eq[strip].band_q[band] = 100;
+	}
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
+}
diff --git a/sound/usb/babyfacepro/babyfacepro.c b/sound/usb/babyfacepro/babyfacepro.c
index ece2bd0c4..ed17600ab 100644
--- a/sound/usb/babyfacepro/babyfacepro.c
+++ b/sound/usb/babyfacepro/babyfacepro.c
@@ -1230,6 +1230,8 @@ static int babyface_pcm_hw_params(struct snd_pcm_substream *subs,
 		new_rate = true;
 		chip->alt = r->alt;
 		chip->frame_bytes = r->frame_bytes;
+		/* The DSP EQ coefficients depend on fs: re-upload. */
+		bf_eq_reupload(chip);
 		dev_dbg(&chip->dev->dev, "rate %u Hz (alt %u)\n",
 			chip->rate, chip->alt);
 	}
@@ -1638,6 +1640,8 @@ static int babyface_probe(struct usb_interface *intf,
 			BF_REF_LEVEL_4DBU : BF_REF_LEVEL_MINUS10DBV;
 	}
 
+	bf_eq_defaults(chip);
+
 	/* The 0x16 clear zeroed the mixer registers: apply the factory
 	 * default routing to keep the outputs live out of the box.  alsactl
 	 * restores the user's settings once the card is registered.
@@ -1654,6 +1658,7 @@ static int babyface_probe(struct usb_interface *intf,
 		dev_err(&intf->dev, "flag restore failed: %d\n", err);
 		goto error;
 	}
+
 	/* Keep the allocation size independent of the active USB mode. */
 	urbsize = BF_WORDS_PER_FRAME * sizeof(u32) * chip->frames_per_urb;
 	chip->urbs_in = kcalloc(chip->nurbs, sizeof(*chip->urbs_in), GFP_KERNEL);
@@ -1743,6 +1748,20 @@ static int babyface_probe(struct usb_interface *intf,
 	 */
 	chip->reprobe = bf_seen_before(dev);
 
+	/* The DSP coefficient stream (EQ, bulk ep 0x0A) lives on interface
+	 * 1, which has a single altsetting (alt 0) already active in the
+	 * default configuration - the endpoint is scheduled, no
+	 * SET_INTERFACE or interface claim is needed (the earlier
+	 * -EAGAIN was the on-stack transfer buffer, and SET_INTERFACE on
+	 * interface 1 wedged the iface-5 audio stream - playback URBs
+	 * never completed).
+	 */
+	err = babyface_create_eq(chip);
+	if (err < 0) {
+		dev_err(&intf->dev, "EQ control creation failed: %d\n", err);
+		goto error;
+	}
+
 	err = snd_card_register(chip->card);
 	if (err < 0) {
 		dev_err(&intf->dev, "snd_card_register failed: %d\n", err);
@@ -1838,6 +1857,31 @@ static int babyface_suspend(struct usb_interface *intf, pm_message_t message)
 	return 0;
 }
 
+/* The register state of a resumed device.  Caller holds chip->mutex. */
+static int bf_resume_locked(struct snd_usb_babyface *chip)
+{
+	int err;
+
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
+	if (err < 0)
+		return err;
+	/* The device lost its DSP across the suspend; the bulk EQ uploads
+	 * are not part of the register state re-applied above, so re-send
+	 * them.
+	 */
+	bf_eq_reupload(chip);
+	return 0;
+}
+
 static int babyface_resume(struct usb_interface *intf)
 {
 	struct snd_usb_babyface *chip = usb_get_intfdata(intf);
@@ -1858,19 +1902,8 @@ static int babyface_resume(struct usb_interface *intf)
 	 * fail, and udev's alsactl restore then loads the mixer state
 	 * stored at the last shutdown over the current one.
 	 */
-	mutex_lock(&chip->mutex);
-	err = usb_set_interface(chip->dev, BF_IFACE, chip->alt);
-	if (err < 0)
-		goto out;
-	err = bf_cold_init(chip);
-	if (err < 0)
-		goto out;
-	err = babyface_restore_state(chip);
-	if (err < 0)
-		goto out;
-	err = bf_state_apply_flags(chip);
-out:
-	mutex_unlock(&chip->mutex);
+	scoped_guard(mutex, &chip->mutex)
+		err = bf_resume_locked(chip);
 	if (!err)
 		babyface_panel_start(chip);
 	return err;
diff --git a/sound/usb/babyfacepro/babyfacepro.h b/sound/usb/babyfacepro/babyfacepro.h
index 984d1d175..c9ef366f1 100644
--- a/sound/usb/babyfacepro/babyfacepro.h
+++ b/sound/usb/babyfacepro/babyfacepro.h
@@ -14,7 +14,7 @@
  * babyfacepro.c holds the card lifecycle, the PCM stream and the
  * mixer-state persistence across re-probes and resume;
  * babyfacepro-ctl.c holds the ALSA control surface - the hardware
- * mixer and the front panel.
+ * mixer, the front panel and the DSP EQ.
  *
  * The protocol (vendor requests + 14x32-bit frame layout) was
  * reverse-engineered from Windows captures and validated on hardware -
@@ -313,6 +313,21 @@ extern const struct bf_source bf_sources[14];
  */
 #define BF_SRC_PB1			8
 
+/* One analog-input strip of the DSP EQ (babyfacepro-ctl.c). */
+struct bf_eq_channel {
+	bool on;		/* EQ engaged (else identity blocks) */
+	s32 slope_db;		/* low-cut slope 6/12/18/24 (0 = off) */
+	s32 lc_hz;		/* low-cut freq, 0 = off */
+	u32 lc_raw;		/* cached 0x38 word */
+	u8 slope;		/* cached slope byte (2^n - 1) */
+	s32 band_type[3];	/* 0 off, 1 bell, 2 low shelf, 3 high shelf */
+	s32 band_freq[3];	/* Hz */
+	s32 band_q[3];		/* Q x 100 */
+	s32 band_gain[3];	/* dB x 10 */
+	s32 words[3][4];	/* cached c0..c3 */
+	s32 shared;		/* cached c4 (shared by the slots) */
+};
+
 struct snd_usb_babyface {
 	struct snd_card *card;
 	struct usb_device *dev;
@@ -480,6 +495,9 @@ struct snd_usb_babyface {
 	struct snd_kcontrol *panel_select_kctl[3]; /* per IN pair, likewise */
 	struct snd_kcontrol *dim_press_kctl;
 	u32 dim_press_count;		/* front-panel DIM presses, wraps */
+
+	/* DSP EQ (babyfacepro-ctl.c) - 4 analog-input strips, params kept in state */
+	struct bf_eq_channel eq[4];
 };
 
 struct bf_rate {
@@ -538,6 +556,11 @@ int babyface_create_panel(struct snd_usb_babyface *chip);
 void babyface_panel_start(struct snd_usb_babyface *chip);
 void babyface_panel_stop(struct snd_usb_babyface *chip);
 void babyface_panel_work(struct work_struct *work);
+void bf_eq_band_words(s32 *w, int type, s32 freq_hz, s32 q100,
+		      s32 gain_x10, s32 fs);
+void bf_eq_reupload(struct snd_usb_babyface *chip);
+void bf_eq_defaults(struct snd_usb_babyface *chip);
+int babyface_create_eq(struct snd_usb_babyface *chip);
 
 /* Master gain-law helpers (babyfacepro-ctl.c). */
 int bf_master_16bit(int half_db);	/* dBx2 -> 16-bit master */
-- 
2.56.0

