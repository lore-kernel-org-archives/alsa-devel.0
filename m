Return-Path: <SRS0=z7f8=PA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FE1C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 20:10:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CD36103D
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 20:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77CD36103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hahnjo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8E151674;
	Tue, 12 Oct 2021 22:09:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8E151674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634069443;
	bh=b8hZSY2MK2PXZiqaOmVdMaiI0ze11hyOkpJDFUIeKyE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LgF78Cj4Me251XWC3ScawYeScy1SvZ9sDYZJD8NEr8OyfblT09tYKSiekYcJZe8h7
	 4PTOLPhLjyZ9paGzKs/RX4CUX43e7f5k0y7I264gdT5FsGe4FaT+7uAtsaN6ud6R6i
	 5PhmDDbBVNotSOdPUgwOY7JRS85VHzZWeYhb55Rk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11F40F801F7;
	Tue, 12 Oct 2021 22:09:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE131F80212; Tue, 12 Oct 2021 22:09:50 +0200 (CEST)
Received: from mail.hahnjo.de (backus.hahnjo.de [193.30.122.186])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76BA1F800C0
 for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2021 22:09:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76BA1F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=hahnjo.de header.i=@hahnjo.de
 header.b="mCsIxoja"
Received: from Jonas-Dell.home (unknown
 [IPv6:2a01:cb15:40c:c100:cf0a:528a:fee7:c993])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.hahnjo.de (Postfix) with ESMTPSA id A03AB51F1F0C;
 Tue, 12 Oct 2021 22:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hahnjo.de; s=default;
 t=1634069377; bh=b8hZSY2MK2PXZiqaOmVdMaiI0ze11hyOkpJDFUIeKyE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mCsIxojajVnqD36LN4MxtqN3KcuyPDq5VRf3bgydFQy2WaDP/r3O7mwtYGgGhh4DU
 BUhv9l6+uIywNmc18DOA1YZqSiFjCPBfqNI6RC8cN5raV5LmobL+/YPdrW2bRkuDWz
 zgFcP5gD+znBA4fdBVzllsefqf/ttziCPMzR9XoazdVUBeEYtrtzFsZj73TKZjA82h
 HDvx6/ZWLNva2k5Kydvd4ML1V52MVpP5T66tDI3f2kRe7M93L89ha1OAf8hfjlVv29
 FEQ3D3KwkSKjVrKqloaHZtzUNqUvtXkHABdnYS4tU0lY7OIStGTzwnb7F18arMz1hg
 L5Oj426jQBqAA==
From: Jonas Hahnfeld <hahnjo@hahnjo.de>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2] ALSA: usb-audio: Add quirk for VF0770
Date: Tue, 12 Oct 2021 22:09:07 +0200
Message-Id: <20211012200906.3492-1-hahnjo@hahnjo.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <s5hk0ii397m.wl-tiwai@suse.de>
References: <s5hk0ii397m.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Jonas Hahnfeld <hahnjo@hahnjo.de>,
 linux-kernel@vger.kernel.org
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

The device advertises 8 formats, but only a rate of 48kHz is honored
by the hardware and 24 bits give chopped audio, so only report the
one working combination. This fixes out-of-the-box audio experience
with PipeWire which otherwise attempts to choose S24_3LE (while
PulseAudio defaulted to S16_LE).

Signed-off-by: Jonas Hahnfeld <hahnjo@hahnjo.de>
---
v2: added terminator entry

 sound/usb/quirks-table.h | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index e03043f7dad3..de18fff69280 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -77,6 +77,48 @@
 /* E-Mu 0204 USB */
 { USB_DEVICE_VENDOR_SPEC(0x041e, 0x3f19) },
 
+/*
+ * Creative Technology, Ltd Live! Cam Sync HD [VF0770]
+ * The device advertises 8 formats, but only a rate of 48kHz is honored by the
+ * hardware and 24 bits give chopped audio, so only report the one working
+ * combination.
+ */
+{
+	USB_DEVICE(0x041e, 0x4095),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = &(const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S16_LE,
+					.channels = 2,
+					.fmt_bits = 16,
+					.iface = 3,
+					.altsetting = 4,
+					.altset_idx = 4,
+					.endpoint = 0x82,
+					.ep_attr = 0x05,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 48000 },
+				},
+			},
+			{
+				.ifnum = -1
+			},
+		},
+	},
+},
+
 /*
  * HP Wireless Audio
  * When not ignored, causes instability issues for some users, forcing them to
-- 
2.33.0

