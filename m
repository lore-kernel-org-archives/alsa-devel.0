Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89735606A331
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=GYoOfJT3;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ChQgdMSB
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC5CC60244;
	Mon,  9 Nov 2026 16:02:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC5CC60244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236550;
	bh=RpsLquG7CKzglYKKlyXi159zxboEQWTcK64zunaNQfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GYoOfJT3PDBiDj9ziCYEfBwKLCFuBMSa/nQNf1eJwwz/cR8HVY78vRRKRYQEUYHYz
	 kHQ+KEBVN/P1EGPNDJREEUqLU6lPMAkrKZdIPWHNA2tXqflxGOBVEfWNkYzziySTJg
	 2dbSB4rIZDLUAFHbKgrxlnEtkL79sTqX3ijjrVCQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E69AF80733; Mon,  9 Nov 2026 16:00:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 193D8F80735;
	Mon,  9 Nov 2026 16:00:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2EEEF80423; Thu,  5 Nov 2026 16:16:45 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793891803;
	b=d9pXr7YTnN9ELuHSV7oumibRdG+hk/oEb7X2t6E+sbWHFs21BzlF3zkaVIY+s1EpaiPP
	 uiqVqAAH58P0SFqmBM4349u2+jEWXMak9JKk1CPDg5pQChSJA4+DnLmYQoG7KxGd0h2OZ
	 LH+nqYF2ckNdUJRF4Tk4PxkC4EuWeAWG/OgkMKBDtaDFogVMGOZjg+zgKkb9+P/a8gUkt
	 QfB0PXWNiPQjxQzPW5BhHQG2aCKCaDMOCk21EtcyU7B/cIkuVRCuvXM1n0RbiSV8IMhaT
	 vzdKWIzsVrvGjH9fXmaYTN0Gz7F0ixuJR/bOqpeJgk90K3F75iCaGpFwcND/eoQ0fbQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793891803;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RpsLquG7CKzglYKKlyXi159zxboEQWTcK64zunaNQfQ=;
	b=CTdRD/TGue8bPtD4NO44NTiiZ9ieXZU4EHnITQOu+Y30qCaMPV67bXc/ghSqqtPBgQof
	 U9FavRq9nedI57nfScd3KW4b00gHPue4GkvD2WNbr+x/AnYxX8AJBePMEYYClpOBsqDpO
	 22DJvoLS1LE+pwkKG0PUSxI51gnhMkQUL46VICu2l8UbdTXUjrBhC/HHGz6cZC8qm3UJR
	 YXXlQ99+RRqlHsLtnQNBt3wb24yLYzSkwS/iEZPxWcPhKcl0RCEx6qimOOn3bDHRSx2fd
	 G5x/OT0Mwk9CE0GdjLMkPEy17akW2YVrQR8PD/9LxX5xOMTxrZRVJ0rFfyX4ehcTwEQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ChQgdMSB;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 33DADF80588
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 16:16:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33DADF80588
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ChQgdMSB
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-3282db206d3so3857758eec.0
        for <alsa-devel@alsa-project.org>;
 Thu, 05 Nov 2026 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793891800; x=1794496600;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E9pf1p4N8AGrxFirV7DhKEylVwd+aAFRw1U3mKKifS0=;
        b=ChQgdMSBPKDzLP6LbiZSko0w9R6ostOtw89EUg7YS+E6r0yJkcPH3rkd0azoaFrQr1
         Xw9pwzDeTFsv2cFsHNULOvlwUyhoOFjZfl59ZWJUmF8rkd5UO1yu9BpbCXU1kEZWeL/H
         0xgyNI2/8UGbntiw1WHpfcjrvtoXB/C2kowAseT9jDj+26kSP9x4nlkOpUKSbzfhhNFe
         x+U6CBLtWEhbtSHNVMMdjwNVwLttoW3htzafLG7M+8XxOudOyTOcRAey5JUGLiojfzZC
         8wieTloehNi7G3clsw2GAYbNTwGqr4dw9/U3hqNNHLS26BJtKs9JPs26fzRjjhdwR6H4
         mFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891800; x=1794496600;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9pf1p4N8AGrxFirV7DhKEylVwd+aAFRw1U3mKKifS0=;
        b=qgD1nkjuJIfMiR0kzjLgndIayHdMn8bjHlKV+6d0Rtp4BSbhN7zkC2YL6d3aj1Tj1d
         OKbdJyf93d+WOsyJz9GgHV2E5xTpg2fghUO2/JuHHzUn5iFr4jPTp7sAlpaEZxIqv/L5
         gK1dMQzOmABML8KO7qUqS0Houjg/oX8SmH8AM+pU98O6fEJjRmb68yX1rgTT+Fm0dD0U
         kf5X7MtW9AoVJuEMvFldqMI83IlsU+jEPCls8OjxqCCzGrGwcLqN4+f0uyo8K0dFsVq2
         4UCLW1/1jCihy88GF6I9YC1XFnWthEjTt91TAEyfx/ZMYCLm8R02GgNKD3LjlCxtwD4W
         tcOA==
X-Forwarded-Encrypted: i=1;
 AKwUvByoEh2gv044XvUXH8Uc8pQQY0tvnwVUhiFHwpvH9vif5vOhtizBtydRjxHYtXWsKQ2I7TIIh0SGF+dl@alsa-project.org
X-Gm-Message-State: APuU4Z9/6oPQ91r5OoSwcby9PjPC2sxjKjdlyZN1cVpIfWlNBhoQD7hT
	PXZd+Bs9JDzYveo4eNu7b4BioaxVJBgW/oR/a0xtOXyVGtsHutlRLDcG
X-Gm-Gg: AYBFou2V9WgzbBRWOij0/X83QJB51cf6RV+U/bUF4c7pRK4EvB8Z56gWEYefSj9amyu
	qQ48kSX6jDSd1wWMleaYCa2EkNaYp7kaVRCHQU2cAMxt3SHaZNpuglESRI7YPgVvZ/56C+jdOTC
	Q2wYT2SPBTzzFp3CB4aBestH2jAIrmHboU4/684jy6vJijToi4AeHNURi+oSC1cYyKG0+EBoD+c
	Go7aDGq+TtDPujrVpoSau9kV6to9uG+Jll7Hswu8o9MxXk9nabGlaXK/O2rFr6PAP1IStjtQ+nt
	bpV9Ov550pH50rlaxDG0wHi0R+pSM0rNgWhxoA5oriKcaU42obmUtC2vuNhg8Wz1DKYiwg3SNM/
	AFdR2QekcVovg1s+YkNb2h5oFAY6nxw94PZjlJx13KILenucG3EH/DPBsj7IyMhV2eslupbQX2T
	2+ClOdJIodp9qWG/aDTV4J7jm1Vzrx3IOS4n3Qq1T7qpyaaUfuOCYC4DZbfQDqTV24swTi2v8oB
	Ytg4IXPi3k6WgbfusknvaApD1XMNlGM2zY0E9D1ikDz660lZH3GBDpWwDLsdtBFw8cLXQ0ILrVl
	nwuA9zvG+ULfrVmaiyXVfTlUA/V0X1sAzZFwv3gtyGKgGMeJJ2TDafNkflULyfwPd9qFIUmYtM6
	7IEpNS4bTGQut1KoVkTcWxMM0VZV+dsHT+tLWKM6PikZ+yU3T
X-Received: by 2002:a05:693c:639b:20b0:369:f2f4:b227 with SMTP id
 5a478bee46e88-36a4238e9e4mr29804445eec.18.1793891799220;
        Thu, 05 Nov 2026 07:16:39 -0800 (PST)
Received: from cachyos (2a01cb0c82caf900a186612f304bfea5.ipv6.abo.wanadoo.fr.
 [2a01:cb0c:82ca:f900:a186:612f:304b:fea5])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38a6d3dsm21567087eec.7.2026.11.05.07.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:16:38 -0800 (PST)
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
Subject: [PATCH v8 3/8] ALSA: usb: babyfacepro: add mic preamp,
 phantom/pad and input trim
Date: Thu,  5 Nov 2026 16:15:48 +0100
Message-ID: <20261105151553.223722-4-i.bahloul01@gmail.com>
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
Message-ID-Hash: 6HTF4SZC6JDT7GO5ZPW5ILTCNGOXRQF3
X-Message-ID-Hash: 6HTF4SZC6JDT7GO5ZPW5ILTCNGOXRQF3
X-Mailman-Approved-At: Mon, 09 Nov 2026 14:59:26 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6HTF4SZC6JDT7GO5ZPW5ILTCNGOXRQF3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Add the input side of the mixer: phantom power and pad, the instrument
ref level, the four preamp gains, and phase invert, stereo split and
trim.  The mic gain byte is packed: bits 0-4 count 3 dB steps and bits
5-7 hold the 0-2 dB remainder.  Phase, split and trim have no
registers of their own: the device implements them on the AN1/2
crosspoint registers, and trim writes the trim alone on the master
curve (0x2000 = 0 dB).

bf_state_apply_flags() re-applies phase, split and trim on top of a
restored crosspoint state.  A failed preamp write leaves the cached
state as it was.

Co-developed-by: David Fredman <davfre@gmail.com>
Signed-off-by: David Fredman <davfre@gmail.com>
Signed-off-by: Ismaïl Bahloul <i.bahloul01@gmail.com>
---
 sound/usb/babyfacepro/babyfacepro-ctl.c | 624 ++++++++++++++++++++++++
 sound/usb/babyfacepro/babyfacepro.c     | 111 ++++-
 sound/usb/babyfacepro/babyfacepro.h     |  79 +++
 3 files changed, 813 insertions(+), 1 deletion(-)

diff --git a/sound/usb/babyfacepro/babyfacepro-ctl.c b/sound/usb/babyfacepro/babyfacepro-ctl.c
index 942d4732c..fe6266ea1 100644
--- a/sound/usb/babyfacepro/babyfacepro-ctl.c
+++ b/sound/usb/babyfacepro/babyfacepro-ctl.c
@@ -654,3 +654,627 @@ int babyface_create_masters(struct snd_usb_babyface *chip)
 
 	return 0;
 }
+
+int bf_preamp_state_write(struct snd_usb_babyface *chip)
+{
+	int ret;
+
+	ret = bf_vendor_write(chip, BF_REQ_PREAMP, chip->preamp, BF_REG_PREAMP);
+	if (ret < 0)
+		return ret;
+	/* Boost's 0x21 commit value (0x0003) is NOT a persisted register
+	 * bit - PROTOCOL.md's "Ref level" section found it only in the
+	 * one-shot 0x21 value alongside the 0x17 state write, so it has
+	 * to be re-sent alongside EVERY preamp write (phantom/PAD toggles
+	 * included), or Boost would silently degrade to plain -10dBV the
+	 * next time anything else touches this shared byte.
+	 */
+	return bf_vendor_write(chip, BF_REQ_PREAMP_COMMIT,
+			       chip->ref_level == BF_REF_LEVEL_BOOST ?
+			       0x0003 : 0x0000, 0x0000);
+}
+
+/* Phase (polarity) invert (AN1-4 only, PROTOCOL.md "Phase toggle",
+ * hardware-verified 2026-08-23): NEGATE (bitwise NOT, not two's
+ * complement) the L crosspoint register on every output pair's
+ * standard map, plus the AN1/2 low-map shadow specifically (the same
+ * single low-map register set CUE/mute/solo already use for that
+ * monitor bus - see this driver's own bf_ms_put for the address
+ * pattern). `chip->xpoint[out][mic][0]` is deliberately left holding
+ * the PLAIN value the user actually set - only the value WRITTEN to
+ * hardware is negated - so the crosspoint control's own readback still
+ * reports the real fader position while phase is engaged.
+ *
+ * KNOWN LIMITATION, same class TuxMix's own USB backend already has
+ * in `usb.rs::set_phase` (not fixed there either, as of this writing):
+ * this negates the CURRENT register value once, at toggle time. A
+ * later `bf_xpoint_put` on the same [out][mic] slot (i.e. the user
+ * drags that fader again while phase is engaged) writes the plain
+ * value, silently un-inverting phase until the user re-toggles it.
+ * Making the crosspoint hot path itself phase-aware would close this
+ * properly, but touches every one of the 84 crosspoint controls'
+ * write path - out of scope for this pass; flagged rather than
+ * silently shipped.
+ */
+int bf_phase_apply(struct snd_usb_babyface *chip, int mic, bool invert)
+{
+	const struct bf_source *s = &bf_sources[mic];
+	int out, ret;
+	u16 flag;
+
+	for (out = 0; out < 6; out++) {
+		u16 plain = chip->xpoint[out][mic][0];
+		u16 value = invert ? (u16)~plain : plain;
+
+		/* The AN1/2 block is written without the rotating bits, as
+		 * bf_xpoint_write() does.
+		 */
+		flag = 0;
+		if (out) {
+			flag = bf_flag_cycle[chip->flag_cnt];
+			chip->flag_cnt = (chip->flag_cnt + 1) & 3;
+		}
+		ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, value,
+				      (BF_REG_XPOINT_BASE_L +
+				       BF_REG_XPOINT_STRIDE * out + s->idx_l) |
+				      flag);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int bf_phase_info(struct snd_kcontrol *kctl,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int bf_phase_get(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int mic = kctl->private_value;
+
+	ucontrol->value.integer.value[0] = chip->phase[mic];
+	return 0;
+}
+
+static int bf_phase_put(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int mic = kctl->private_value;
+	bool invert = ucontrol->value.integer.value[0];
+	int ret = 0;
+
+	guard(mutex)(&chip->mutex);
+	if (invert == chip->phase[mic])
+		return 0;
+	ret = bf_phase_apply(chip, mic, invert);
+	if (ret < 0)
+		return ret;
+	chip->phase[mic] = invert;
+	return 1;
+}
+
+/* Stereo split (PROTOCOL.md "Stereo split", cap_ctrl3.pcap, hardware-
+ * verified): a playback pair's signal into the AN1/2 monitor bus goes
+ * hard-split (L=0x2000/R=0x0000, "split-mono").  Only reaches the AN1/2
+ * destination (its block of the map), the same scope as CUE/mute/solo.
+ * `chip->xpoint[][]` is deliberately left untouched, same reasoning as
+ * Phase.
+ *
+ * Joining the pair again puts back the pair's own AN1/2 crosspoint from
+ * the cache.  It used to write L=R=0x1000, read as "-6 dB per side",
+ * which issue #31 found to be 6 dB below what TotalMix FX writes for a
+ * joined pair at 0 dB (0x2000 per side), and which also dropped
+ * whatever level the user had set on that crosspoint.
+ */
+int bf_split_apply(struct snd_usb_babyface *chip, int pb, bool split)
+{
+	const struct bf_source *s = &bf_sources[8 + pb];
+	u16 l = split ? 0x2000 : chip->xpoint[0][8 + pb][0];
+	u16 r = split ? 0x0000 : chip->xpoint[0][8 + pb][1];
+	int ret;
+
+	/* The AN1/2 block.  The same values also went to a "standard map"
+	 * half at 0x0068, which is AS1/2's submix, not part of AN1/2: it
+	 * overwrote AS1/2's own crosspoint for this playback pair.
+	 */
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, l,
+			      BF_REG_XPOINT_BASE_L + s->idx_l);
+	if (ret < 0)
+		return ret;
+	return bf_vendor_write(chip, BF_REQ_CROSSPOINT, r,
+			       BF_REG_XPOINT_BASE_R + s->idx_r);
+}
+
+static int bf_split_get(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int pb = kctl->private_value;
+
+	ucontrol->value.integer.value[0] = chip->split[pb];
+	return 0;
+}
+
+static int bf_split_put(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int pb = kctl->private_value;
+	bool split = ucontrol->value.integer.value[0];
+	int ret = 0;
+
+	guard(mutex)(&chip->mutex);
+	if (split == chip->split[pb])
+		return 0;
+	ret = bf_split_apply(chip, pb, split);
+	if (ret < 0)
+		return ret;
+	chip->split[pb] = split;
+	return 1;
+}
+
+/* Input Trim (T button, AN1-4): PROTOCOL.md "Trim (T) write for the
+ * AN1/2 pair" (cap_trim2/3/4.pcap, hardware-verified) - the analog
+ * input's own gain-trim, applied through the crosspoint registers
+ * exactly like a fader (there is no separate trim register).  It
+ * writes the trim alone on the MASTER curve (0x2000 = 0 dB,
+ * `bf_master_16bit`) into the AN1/2 block, all 4 registers of the pair
+ * (both AN1+AN2 or both AN3+AN4, matching the vendor software's
+ * linked-strip behaviour); `mic` may be either channel of the pair, and
+ * the base is derived (`mic & ~1`) so the write always lands on the
+ * correct pair's registers regardless of which channel's control
+ * triggered it.  Destination is always the AN1/2 monitor bus, the same
+ * scope the MS-processor and CUE writes have, and the same one the
+ * vendor software's Trim reaches.
+ *
+ * It also wrote the fader and the trim summed, on the fader curve, to a
+ * "standard map" at 0x0068.  That block is AS1/2's submix (see
+ * bf_xpoint_write), so those writes never reached AN1/2: they only
+ * overwrote AS1/2's own crosspoints for these inputs, and are gone.
+ *
+ * Trim is a genuinely SHARED value per pair on real hardware (one
+ * write always touches both channels' registers) but is exposed as 2
+ * per-channel ALSA controls, one per input strip. `bf_trim_put` keeps
+ * the pair's two cache entries equal and notifies the sibling control,
+ * so the cache never claims a per-channel split the hardware cannot
+ * represent - and `bf_state_apply_flags`, which replays the pair from
+ * its even index, always replays the value that is actually on the
+ * wire.
+ */
+int bf_trim_apply(struct snd_usb_babyface *chip, int mic, int trim_db2)
+{
+	int base = mic & ~1;
+	int sib = base + 1;
+	const struct bf_source *sb = &bf_sources[base];
+	const struct bf_source *ss = &bf_sources[sib];
+	u16 trim_raw = bf_master_16bit(trim_db2);
+	int ret;
+
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, trim_raw,
+			      BF_REG_LOWMAP_BASE_L + sb->idx_l);
+	if (ret < 0)
+		return ret;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, trim_raw,
+			      BF_REG_LOWMAP_BASE_R + sb->idx_r);
+	if (ret < 0)
+		return ret;
+	ret = bf_vendor_write(chip, BF_REQ_CROSSPOINT, trim_raw,
+			      BF_REG_LOWMAP_BASE_L + ss->idx_l);
+	if (ret < 0)
+		return ret;
+	return bf_vendor_write(chip, BF_REQ_CROSSPOINT, trim_raw,
+			       BF_REG_LOWMAP_BASE_R + ss->idx_r);
+}
+
+/* Trim's control value is dB as well, -65..+6. */
+static const DECLARE_TLV_DB_SCALE(bf_trim_tlv, -6500, 100, 0);
+
+static int bf_trim_info(struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = -65;
+	uinfo->value.integer.max = 6;
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int bf_trim_get(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int mic = kctl->private_value;
+
+	ucontrol->value.integer.value[0] = chip->trim[mic];
+	return 0;
+}
+
+static int bf_trim_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int mic = kctl->private_value;
+	int sib = mic ^ 1;
+	int db = ucontrol->value.integer.value[0];
+	int ret = 0;
+
+	if (db < -65 || db > 6)
+		return -EINVAL;
+
+	scoped_guard(mutex, &chip->mutex) {
+		if (db == chip->trim[mic])
+			return 0;
+		ret = bf_trim_apply(chip, mic, db * 2);
+		if (ret < 0)
+			return ret;
+		/* One register per pair on the wire, so both channels of the
+		 * pair really did change: mirror the cache (the state restore
+		 * replays the pair from the even index) and tell user space
+		 * about the sibling control.
+		 */
+		chip->trim[mic] = db;
+		chip->trim[sib] = db;
+		ret = 1;
+	}
+	if (ret == 1 && chip->trim_kctl[sib])
+		snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &chip->trim_kctl[sib]->id);
+	return ret;
+}
+
+/* Phase, stereo split and input trim - registered together since all
+ * three are per-input-strip controls layered on the same AN1/2 monitor
+ * bus crosspoint registers the matrix in babyface_create_xpoints()
+ * already created controls for.
+ */
+int babyface_create_trim(struct snd_usb_babyface *chip)
+{
+	struct snd_kcontrol *kctl;
+	int src, err;
+
+	for (src = 0; src < 4; src++) {
+		kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+			.name = "Phase Switch",
+			.index = src,
+			.info = bf_phase_info,
+			.get = bf_phase_get,
+			.put = bf_phase_put,
+			.private_value = src,
+		}, chip);
+		if (!kctl)
+			return -ENOMEM;
+		strscpy(kctl->id.name, bf_sources[src].name, sizeof(kctl->id.name));
+		strlcat(kctl->id.name, " Phase Switch", sizeof(kctl->id.name));
+		err = snd_ctl_add(chip->card, kctl);
+		if (err < 0)
+			return err;
+	}
+
+	for (src = 0; src < 6; src++) {
+		kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+			.name = "Stereo Split Switch",
+			.index = src,
+			.info = bf_phase_info, /* plain boolean, same shape */
+			.get = bf_split_get,
+			.put = bf_split_put,
+			.private_value = src,
+		}, chip);
+		if (!kctl)
+			return -ENOMEM;
+		strscpy(kctl->id.name, bf_sources[8 + src].name, sizeof(kctl->id.name));
+		strlcat(kctl->id.name, " Stereo Split Switch", sizeof(kctl->id.name));
+		err = snd_ctl_add(chip->card, kctl);
+		if (err < 0)
+			return err;
+	}
+
+	for (src = 0; src < 4; src++) {
+		kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+			.name = "Trim Volume",
+			.index = src,
+			.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+				  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+			.info = bf_trim_info,
+			.get = bf_trim_get,
+			.put = bf_trim_put,
+			.tlv.p = bf_trim_tlv,
+			.private_value = src,
+		}, chip);
+		if (!kctl)
+			return -ENOMEM;
+		strscpy(kctl->id.name, bf_sources[src].name, sizeof(kctl->id.name));
+		strlcat(kctl->id.name, " Trim Volume", sizeof(kctl->id.name));
+		err = snd_ctl_add(chip->card, kctl);
+		if (err < 0)
+			return err;
+		chip->trim_kctl[src] = kctl;
+	}
+	return 0;
+}
+
+static int bf_bool_info(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int bf_phantom_get(struct snd_kcontrol *kctl,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.integer.value[0] =
+		!!(chip->preamp & kctl->private_value);
+	return 0;
+}
+
+static int bf_phantom_put(struct snd_kcontrol *kctl,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	u16 bit = kctl->private_value;
+	bool on = ucontrol->value.integer.value[0];
+	bool cur;
+	u16 old;
+	int ret = 0;
+
+	guard(mutex)(&chip->mutex);
+	cur = !!(chip->preamp & bit);
+	old = chip->preamp;
+	if (on == cur)
+		return 0;
+	chip->preamp = on ? (chip->preamp | bit) : (chip->preamp & ~bit);
+	ret = bf_preamp_state_write(chip);
+	if (ret < 0) {
+		/* Do not leave the cache claiming a state the device
+		 * never took.
+		 */
+		chip->preamp = old;
+		return ret;
+	}
+	return 1;
+}
+
+/* Ref Level (Instr 3/4) - see the constants' own comment in the
+ * header. A single shared 3-state switch, not per-channel (the
+ * protocol has no independent bits for IN3 vs IN4).
+ */
+static const char *const bf_reflevel_texts[] = {
+	"+4dBu", "-10dBV", "Boost", NULL
+};
+
+static int bf_reflevel_info(struct snd_kcontrol *kctl,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	return snd_ctl_enum_info(uinfo, 1, 3, bf_reflevel_texts);
+}
+
+static int bf_reflevel_get(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.enumerated.item[0] = chip->ref_level;
+	return 0;
+}
+
+static int bf_reflevel_put(struct snd_kcontrol *kctl,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	unsigned int item = ucontrol->value.enumerated.item[0];
+	u16 old_preamp;
+	int old_ref_level;
+	int ret = 0;
+
+	if (item > BF_REF_LEVEL_BOOST)
+		return -EINVAL;
+
+	guard(mutex)(&chip->mutex);
+	if ((int)item == chip->ref_level)
+		return 0;
+	old_preamp = chip->preamp;
+	old_ref_level = chip->ref_level;
+	chip->preamp = (chip->preamp & ~BF_PREAMP_REF_MASK) |
+		       (item == BF_REF_LEVEL_4DBU ? BF_PREAMP_REF_4DBU : 0);
+	chip->ref_level = item;
+	ret = bf_preamp_state_write(chip);
+	if (ret < 0) {
+		chip->preamp = old_preamp;
+		chip->ref_level = old_ref_level;
+		return ret;
+	}
+	return 1;
+}
+
+/* Gain scales.
+ *
+ * The mic preamps (AN1/2) span 0-65 dB in 1 dB steps, carried in a
+ * packed byte rather than a plain count:
+ *
+ *	coarse = min(db / 3, 20)	bits 0-4, 3 dB per step
+ *	fine   = db - 3 * coarse	bits 5-7, the 0-2 dB remainder
+ *	value  = (fine << 5) | coarse
+ *
+ * Above 60 dB coarse saturates at 20 and fine continues 3, 4, 5, so
+ * 65 dB is 0xb4.  Decoded from USBPcap captures of TotalMix on
+ * Windows (bbf-gain2/3/4.pcap, 48 writes, all matching).
+ *
+ * Bits 5-7 were previously read as a transaction counter and written
+ * with a rotating 0x20/0x00/0x40, which both discarded the fine part
+ * of the setting and applied 0-2 dB of error depending on where the
+ * rotation happened to be.
+ *
+ * The Hi-Z instrument inputs (AN3/4) are not packed: the value is the
+ * gain in 0.5 dB units, 0-9 dB over 0-18.
+ */
+int bf_gain_max_db(int mic)
+{
+	return mic < 2 ? BF_GAIN_MAX_DB : 9;
+}
+
+u8 bf_gain_raw(int mic, int db)
+{
+	int coarse, fine;
+
+	if (mic >= 2)
+		return db * 2;
+	coarse = min(db / 3, BF_GAIN_COARSE_MAX);
+	fine = db - 3 * coarse;
+	return (u8)((fine << BF_GAIN_FINE_SHIFT) | coarse);
+}
+
+/* The preamp control's value already IS the gain in dB (0..65 for the mic
+ * inputs, 0..9 for the instrument ones), and the hardware really does
+ * resolve every one of those steps - bf_gain_raw() packs it into the
+ * register's coarse and fine fields.
+ */
+static const DECLARE_TLV_DB_SCALE(bf_gain_tlv, 0, 100, 0);
+
+static int bf_gain_info(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = bf_gain_max_db(kctl->private_value);
+	uinfo->value.integer.step = 1;
+	return 0;
+}
+
+static int bf_gain_get(struct snd_kcontrol *kctl,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int mic = kctl->private_value;
+
+	/* chip->gain[] tracks the dB; the packed register value is derived
+	 * at write time (bf_gain_raw).
+	 */
+	ucontrol->value.integer.value[0] = chip->gain[mic];
+	return 0;
+}
+
+static int bf_gain_put(struct snd_kcontrol *kctl,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_babyface *chip = snd_kcontrol_chip(kctl);
+	int mic = kctl->private_value;
+	int db = ucontrol->value.integer.value[0];
+	u8 raw;
+	int ret = 0;
+
+	if (db < 0 || db > bf_gain_max_db(mic))
+		return -EINVAL;
+
+	guard(mutex)(&chip->mutex);
+	if (db == chip->gain[mic])
+		return 0;
+	raw = bf_gain_raw(mic, db);
+
+	ret = bf_vendor_write(chip, BF_REQ_GAIN, (u16)raw,
+			      BF_REG_GAIN + mic);
+	if (ret < 0)
+		return ret;
+	chip->gain[mic] = db;
+	return 1;
+}
+
+/* Preamp controls: phantom power, pad, instrument ref level and the
+ * four mic/instrument gains.  Registered separately from the output
+ * masters (babyface_create_masters()) since they cover a different
+ * part of the signal path (mic input, not output routing).
+ */
+int babyface_create_preamp(struct snd_usb_babyface *chip)
+{
+	struct snd_kcontrol *kctl;
+	int i, err;
+
+	/* The control name is the type and .index is the channel (0 =
+	 * Mic 1/AN1, 1 = Mic 2/AN2), the convention the companion mixer
+	 * and existing asound.state files use.
+	 */
+	for (i = 0; i < 2; i++) {
+		u16 bit = i == 0 ? BF_PREAMP_48V_MIC1 : BF_PREAMP_48V_MIC2;
+
+		kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+			.name = "Phantom Power Mic 1",
+			.index = i,
+			.info = bf_bool_info,
+			.get = bf_phantom_get,
+			.put = bf_phantom_put,
+			.private_value = bit,
+		}, chip);
+		if (!kctl)
+			return -ENOMEM;
+		err = snd_ctl_add(chip->card, kctl);
+		if (err < 0)
+			return err;
+	}
+
+	for (i = 0; i < 2; i++) {
+		u16 bit = i == 0 ? BF_PREAMP_PAD_MIC1 : BF_PREAMP_PAD_MIC2;
+
+		kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+			.name = "Pad Mic 1",
+			.index = i,
+			.info = bf_bool_info,
+			.get = bf_phantom_get,
+			.put = bf_phantom_put,
+			.private_value = bit,
+		}, chip);
+		if (!kctl)
+			return -ENOMEM;
+		err = snd_ctl_add(chip->card, kctl);
+		if (err < 0)
+			return err;
+	}
+
+	kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Instrument Ref Level",
+		.info = bf_reflevel_info,
+		.get = bf_reflevel_get,
+		.put = bf_reflevel_put,
+	}, chip);
+	err = snd_ctl_add(chip->card, kctl);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < 4; i++) {
+		kctl = snd_ctl_new1(&(struct snd_kcontrol_new){
+			.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+			.name = "Mic 1 Capture Volume",
+			.index = i,
+			.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+				  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+			.info = bf_gain_info,
+			.get = bf_gain_get,
+			.put = bf_gain_put,
+			.tlv.p = bf_gain_tlv,
+			.private_value = i,
+		}, chip);
+		if (!kctl)
+			return -ENOMEM;
+		err = snd_ctl_add(chip->card, kctl);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
diff --git a/sound/usb/babyfacepro/babyfacepro.c b/sound/usb/babyfacepro/babyfacepro.c
index 0bf94ff5d..019a46fc9 100644
--- a/sound/usb/babyfacepro/babyfacepro.c
+++ b/sound/usb/babyfacepro/babyfacepro.c
@@ -255,7 +255,21 @@ int bf_cold_init(struct snd_usb_babyface *chip)
  */
 int babyface_restore_state(struct snd_usb_babyface *chip)
 {
-	int out, src, ret;
+	int out, src, mic, ret;
+
+	/* Preamp state + commit. */
+	ret = bf_preamp_state_write(chip);
+	if (ret < 0)
+		return ret;
+
+	/* The four input gains. */
+	for (mic = 0; mic < 4; mic++) {
+		ret = bf_vendor_write(chip, BF_REQ_GAIN,
+				      (u16)bf_gain_raw(mic, chip->gain[mic]),
+				      BF_REG_GAIN + mic);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* Masters (8-bit = the real volume) + mutes. */
 	ret = bf_apply_masters(chip);
@@ -286,6 +300,68 @@ int babyface_restore_state(struct snd_usb_babyface *chip)
 	return bf_pitch_write(chip, chip->pitch);
 }
 
+/* Re-apply the per-input state that sits on top of the crosspoints
+ * (phase invert, stereo split, trim) after a state restore.  The write
+ * patterns mirror the corresponding _put() handlers.  Caller holds
+ * chip->mutex.
+ */
+int bf_state_apply_flags(struct snd_usb_babyface *chip)
+{
+	int ret;
+
+	/* Re-apply any engaged Phase invert - the crosspoint restore loop
+	 * above already re-wrote xpoint[][] as PLAIN values, so a phase
+	 * negation needs to be re-asserted on top, the same way the ON
+	 * state itself is applied (bf_phase_apply).
+	 */
+	{
+		int mic;
+
+		for (mic = 0; mic < 4; mic++) {
+			if (!chip->phase[mic])
+				continue;
+			ret = bf_phase_apply(chip, mic, true);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	/* Re-apply any engaged stereo split (fixed constants, no fader
+	 * dependency - see bf_split_apply's own comment).
+	 */
+	{
+		int pb;
+
+		for (pb = 0; pb < 6; pb++) {
+			if (!chip->split[pb])
+				continue;
+			ret = bf_split_apply(chip, pb, true);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	/* Re-apply any non-zero Trim (fader+trim combined, same reasoning
+	 * as phase - see bf_trim_apply's own comment). Only the pair's
+	 * even index needs to fire this (it always writes both channels),
+	 * and bf_trim_put keeps both entries of a pair equal, so the even
+	 * index holds the value that is really on the wire even when the
+	 * odd channel's control was the one the user touched.
+	 */
+	{
+		int mic;
+
+		for (mic = 0; mic < 4; mic += 2) {
+			if (!chip->trim[mic])
+				continue;
+			ret = bf_trim_apply(chip, mic, chip->trim[mic] * 2);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 static bool babyface_capture_copy(struct snd_usb_babyface *chip,
 				  struct snd_pcm_substream *subs,
 				  const u8 *data, unsigned int frames)
@@ -1320,6 +1396,7 @@ static int babyface_probe(struct usb_interface *intf,
 	struct snd_card *card;
 	struct snd_pcm *pcm;
 	unsigned int urbsize;
+	u8 st[4];
 	int i, err;
 
 	if (intf->cur_altsetting->desc.bInterfaceNumber != BF_IFACE) {
@@ -1359,6 +1436,7 @@ static int babyface_probe(struct usb_interface *intf,
 	chip->rate = 48000;
 	chip->alt = BF_ALT_1;
 	chip->frame_bytes = 56;
+	chip->preamp = BF_PREAMP_BASE;
 	mutex_init(&chip->mutex);
 	spin_lock_init(&chip->lock);
 	atomic_set(&chip->urb_err, 0);
@@ -1414,6 +1492,25 @@ static int babyface_probe(struct usb_interface *intf,
 		goto error;
 	}
 
+	/* Sync the preamp state from the 0x17 readback (byte 0 mirrors
+	 * the 48V/PAD bits and the ref level; it persists across power
+	 * cycles).  Boost shares -10dBV's bits and only exists in the
+	 * one-shot commit value, so it cannot be recovered here.
+	 */
+	err = bf_vendor_read(chip, BF_REQ_PREAMP, BF_REG_PREAMP, st);
+	if (err < 0) {
+		dev_dbg(&intf->dev, "preamp readback failed: %d\n", err);
+	} else {
+		chip->preamp = st[0] & (BF_PREAMP_REF_MASK |
+					BF_PREAMP_48V_MIC1 |
+					BF_PREAMP_48V_MIC2 |
+					BF_PREAMP_PAD_MIC1 |
+					BF_PREAMP_PAD_MIC2);
+		chip->ref_level =
+			(chip->preamp & BF_PREAMP_REF_MASK) == BF_PREAMP_REF_4DBU ?
+			BF_REF_LEVEL_4DBU : BF_REF_LEVEL_MINUS10DBV;
+	}
+
 	/* The 0x16 clear zeroed the mixer registers: apply the factory
 	 * default routing to keep the outputs live out of the box.  alsactl
 	 * restores the user's settings once the card is registered.
@@ -1483,6 +1580,18 @@ static int babyface_probe(struct usb_interface *intf,
 		goto error;
 	}
 
+	err = babyface_create_trim(chip);
+	if (err < 0) {
+		dev_err(&intf->dev, "phase/split/trim control creation failed: %d\n", err);
+		goto error;
+	}
+
+	err = babyface_create_preamp(chip);
+	if (err < 0) {
+		dev_err(&intf->dev, "preamp control creation failed: %d\n", err);
+		goto error;
+	}
+
 	err = snd_card_register(chip->card);
 	if (err < 0) {
 		dev_err(&intf->dev, "snd_card_register failed: %d\n", err);
diff --git a/sound/usb/babyfacepro/babyfacepro.h b/sound/usb/babyfacepro/babyfacepro.h
index a3b118bed..06af1aa82 100644
--- a/sound/usb/babyfacepro/babyfacepro.h
+++ b/sound/usb/babyfacepro/babyfacepro.h
@@ -119,6 +119,45 @@
  */
 #define BF_SETTINGS_CLOCK_INTERNAL	0x0001
 
+/* Preamp state byte (0x17, wIdx 0x003F - full state, verified).
+ * NOTE 2026-08-26 (cap_reflevel3.pcap): the 0x0C "base" is NOT a
+ * constant - it is the Instr 3/4 REF-LEVEL bits (bits 2-3, +4dBu =
+ * 0x0C set; -10dBV/Boost = clear; Boost additionally commits 0x21
+ * wVal 0x0003).  Keeping it always set = forcing the default +4dBu,
+ * which is correct for the driver (no ref-level control).
+ */
+#define BF_REG_PREAMP			0x003f
+#define BF_REG_GAIN			0x0000	/* + mic 0-3 (bReq 0x1a) */
+#define BF_PREAMP_REF_4DBU		0x000c
+#define BF_PREAMP_REF_MASK		0x000c
+#define BF_PREAMP_BASE			BF_PREAMP_REF_4DBU
+#define BF_PREAMP_48V_MIC1		0x0001
+#define BF_PREAMP_48V_MIC2		0x0002
+#define BF_PREAMP_PAD_MIC1		0x0010
+#define BF_PREAMP_PAD_MIC2		0x0020
+
+/* Ref Level (Instr 3/4) - PROTOCOL.md "Ref level (Instr 3/4) - LABELED"
+ * (cap_reflevel2.pcap, hardware-verified): a single shared 3-state
+ * switch for the Instrument pair.  +4dBu/-10dBV are bits 2-3 of the
+ * preamp byte (BF_PREAMP_REF_MASK); Boost shares -10dBV's bits and is
+ * distinguished only by the 0x21 commit value (0x0003, not the usual
+ * 0x0000) - not a persisted register bit, so it must be tracked
+ * host-side (chip->ref_level) and re-asserted on every preamp write,
+ * not just the one that engaged it (see bf_preamp_state_write).
+ */
+#define BF_REF_LEVEL_4DBU		0
+#define BF_REF_LEVEL_MINUS10DBV		1
+#define BF_REF_LEVEL_BOOST		2
+
+/* Preamp gain: 0-65 dB in 1 dB steps, packed coarse/fine (see the
+ * gain-scale comment above bf_gain_max_db).
+ */
+#define BF_GAIN_MAX_DB			65
+/* Mic gain is packed: bits 0-4 coarse (3 dB), bits 5-7 the 0-2 dB rest. */
+#define BF_GAIN_COARSE_MASK		0x1f
+#define BF_GAIN_COARSE_MAX		20
+#define BF_GAIN_FINE_SHIFT		5
+
 /* Register addresses (masters + crosspoint matrix). */
 #define BF_REG_MASTER_16		0x03e0	/* + 2*out (bReq 0x12) */
 #define BF_REG_MASTER_8			0x0004	/* + 2*out (bReq 0x1a) */
@@ -262,6 +301,37 @@ struct snd_usb_babyface {
 	u16 master[6][2];		/* cached masters, in BF_MASTER_STEP_* */
 	bool muted[6];
 	u16 xpoint[6][14][2];		/* cached crosspoints (out, src, L/R) */
+	u16 preamp;			/* 48V/PAD bits, base 0x0c */
+	u8 gain[4];			/* preamp gain in dB 0-65/9 (raw derived
+					 * at write: mic packed coarse/fine,
+					 * instr 0.5 dB/step)
+					 */
+	bool phase[4];			/* polarity invert, AN1-4 (bf_sources 0-3);
+					 * xpoint[][0..3][0] stays the PLAIN
+					 * value, only the wire write is
+					 * negated - see bf_phase_put's own
+					 * comment for the known limitation
+					 * this implies.
+					 */
+	int trim[4];			/* Trim (T), dB (-65..+6), AN1-4;
+					 * one shared register per pair, so
+					 * both entries of a pair are kept
+					 * equal; same "wire-only" caveat as
+					 * phase - see bf_trim_apply's own
+					 * comment.
+					 */
+	bool split[6];			/* stereo split, playback pairs PB1-PB6
+					 * (bf_sources idx 8-13); fixed
+					 * constants (PROTOCOL.md "Stereo
+					 * split"), not derived from the
+					 * fader - xpoint[][] is left
+					 * untouched, same as phase.
+					 */
+	int ref_level;			/* Instr 3/4 ref level, one of the
+					 * BF_REF_LEVEL_* values
+					 * (0 = +4dBu, the default)
+					 */
+	struct snd_kcontrol *trim_kctl[4]; /* for snd_ctl_notify */
 };
 
 struct bf_rate {
@@ -290,6 +360,7 @@ extern const struct snd_pcm_hw_constraint_list bf_rates_constraint;
 
 /* Mixer-state persistence across interface re-probes. */
 int babyface_restore_state(struct snd_usb_babyface *chip);
+int bf_state_apply_flags(struct snd_usb_babyface *chip);
 
 /* babyfacepro-ctl.c */
 extern const u16 bf_flag_cycle[4];
@@ -302,6 +373,14 @@ int bf_xpoint_write(struct snd_usb_babyface *chip, int out, int src,
 		    u16 l, u16 r);
 int babyface_create_masters(struct snd_usb_babyface *chip);
 int babyface_create_xpoints(struct snd_usb_babyface *chip);
+int babyface_create_trim(struct snd_usb_babyface *chip);
+int babyface_create_preamp(struct snd_usb_babyface *chip);
+int bf_preamp_state_write(struct snd_usb_babyface *chip);
+int bf_phase_apply(struct snd_usb_babyface *chip, int mic, bool invert);
+int bf_split_apply(struct snd_usb_babyface *chip, int pb, bool split);
+int bf_trim_apply(struct snd_usb_babyface *chip, int mic, int trim_db2);
+int bf_gain_max_db(int mic);
+u8 bf_gain_raw(int mic, int db);
 
 /* Master gain-law helpers (babyfacepro-ctl.c). */
 int bf_master_16bit(int half_db);	/* dBx2 -> 16-bit master */
-- 
2.56.0

