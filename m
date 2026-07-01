Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB695C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:24:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28E626022A;
	Wed,  1 Jul 2026 10:24:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28E626022A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782894272;
	bh=AHrJOtRyPTXsqpOxlarEIZTkBKD9UtEKgNRiKhOiQQg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=WnAFYCtkxGXsG5wms+13tEBjvj5g4NFu5H1J/xATlBb3VNRLm3SlDC5FV8SS+b7Wk
	 BUW3qsTvvKj+1oIhdmFFrudStDIWN++mEJxsWof9KBWLm7riB+MAGRkFMQyIH35964
	 3t4csZV3WG62ZYwfg4JGofixHOv/XiWbCb8HiBeM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4209F805F7; Wed,  1 Jul 2026 10:23:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 352B5F80602;
	Wed,  1 Jul 2026 10:23:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43771F8051F; Wed,  1 Jul 2026 08:55:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782888943;
	b=BkQWCj8y1WatzrluSfBpbe+XheD0Ez7RA/vWDgZmMIYTF0jzCT+lGb+RtFfFAvgOdJ33
	 cID0phxS6qj5OhXuHWxXyxTpWDD7zFVy/Ak8CLoNScXkQr5OGyUcqafVnqzMhTSll8PxV
	 B+jM5DRQMaXBSyPZlrnTfJRJ+qf1lDgyai3hZ7RukbPP7KnmV39ve4r0c0RsLQwK2DdGp
	 kmR2hCNyusjZ15rckxh5u/7rhlp3Jq+/xej7lyLkLlIvT9EzVJJUT0IhLy7szncsgSFxg
	 1nvaEzjMv9cBtIzLTsArj8GheuFzSM7jxd6byrFT56n8OCD563A+g97tda76bAyfuFw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782888943;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AHrJOtRyPTXsqpOxlarEIZTkBKD9UtEKgNRiKhOiQQg=;
	b=osW8is/oBWEb9k5uPlTuAamdjRe2dBt5m2waPfn7R8lWGdwO00kqfv4GBYWurGVnynZl
	 bnor+ctRbGedHjW/jDlorJAMGBkNbvUqiXog50Idn0MY3QrdDt/uJhS5ivMwilpXoI17W
	 8I2H0LhHe5r0ysgcT6jawy2wcDIPpgq0G6KPL7ewTaz5QyopTtLGLHL3T/Aw5Vaz9SLWn
	 UyEl5WwdmrBcUiiGQzS87HD8cSoEUL7vBRPK5OuCTZlVed+YWXyw9ELmlq1TW4Dofiig+
	 2FXgt5Tri7TXMo2y1RcwKVZBsaPbdlVepqEEHGcW73SewtEv/H9FUlSCUQHN8g5XMpg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=lOfpweoY;
	arc=none smtp.remote-ip=117.135.210.8
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B0800F8016D
	for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2026 08:55:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0800F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=lOfpweoY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=so
	nrMvJLK/amL5eQ+ccEO4MK0O5mP8xkijg2XDChhWc=; b=lOfpweoY33x5Hamxl5
	C0Npn5aSLEC/wvrlDu/FdAgXTM8k0Zv7MzlIGYQmxEdKg5XmFJJkfcTBvx9tc4RF
	ol1pCE+1XQq62yLHlvoF7jS12gLZx6tlXkDJlXRv2lQPDFQgExyF7pXSsJ3pjeGP
	u4Oidpu9HnvruPOnRraP9tJEU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3v5znuURqgJOrCA--.16176S2;
	Wed, 01 Jul 2026 14:55:36 +0800 (CST)
From: dengxiang <os_dengxiang82@126.com>
To: tiwai@suse.com,
	bo.liu@senarytech.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	dengxiang <os_dengxiang82@126.com>
Subject: [PATCH] ALSA: hda/conexant: Fix microphone mute after power-on reboot
Date: Wed,  1 Jul 2026 14:55:33 +0800
Message-Id: <20260701065533.72517-1-os_dengxiang82@126.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PikvCgD3v5znuURqgJOrCA--.16176S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4DWFy8Ar15JF4rAr4kCrg_yoW8CFy5pF
	1aga4rKrs3t3WIk3yft3y8A3WrKryruFs3tw1xt3WSgr4Sqry7W3WxZFy8ZFyrCFZF9ry7
	XF42gry8G3y7A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UROJOUUUUU=
X-Originating-IP: [2408:840d:6c00:2160:74b4:7e14:61ae:876d]
X-CM-SenderInfo: xrvbvv5qj0xtdqjyjqqrswhudrp/xtbBoQhUDGpEuehinQAA3x
X-MailFrom: os_dengxiang82@126.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: QJ2ZITLV44MLT4656TJCARQFTS6HLSZR
X-Message-ID-Hash: QJ2ZITLV44MLT4656TJCARQFTS6HLSZR
X-Mailman-Approved-At: Wed, 01 Jul 2026 08:23:52 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QJ2ZITLV44MLT4656TJCARQFTS6HLSZR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Some devices have mute settings in their firmware set by the factory.
This is to stop popping noise when the devices turn on. But this setting
makes the microphones unable to record sound properly. This patch
solves this problem and is compatible with conexant chips.

Signed-off-by: dengxiang <os_dengxiang82@126.com>
---
 sound/hda/codecs/conexant.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index 3d92262763f6..3229f9ef5969 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -1184,6 +1184,24 @@ static void add_cx5051_fake_mutes(struct hda_codec *codec)
 	spec->gen.dac_min_mute = true;
 }
 
+static void cxt_fixed_mic_boost(struct hda_codec *codec, hda_nid_t node_id)
+{
+	struct conexant_spec *spec = codec->spec;
+	unsigned int value = 0;
+
+	value = snd_hda_codec_read(codec, node_id, 0, AC_VERB_GET_AMP_GAIN_MUTE, 0);
+	snd_hda_codec_amp_stereo(codec, node_id, HDA_INPUT, 0, HDA_AMP_VOLMASK, value);
+}
+
+static void cxt_capture_hook(struct hda_pcm_stream *hinfo,  struct hda_codec *codec,
+			       struct snd_pcm_substream *substream, int action)
+{
+	struct conexant_spec *spec = codec->spec;
+	hda_nid_t mux_pin = spec->gen.imux_pins[spec->gen.cur_mux[0]];
+
+	cxt_fixed_mic_boost(codec, mux_pin);
+}
+
 static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
 {
 	struct conexant_spec *spec;
@@ -1271,6 +1289,9 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
 	if (err < 0)
 		goto error;
 
+	if (spec->gen.pcm_capture_hook == NULL)
+		spec->gen.pcm_capture_hook = cxt_capture_hook;
+
 	/* Some laptops with Conexant chips show stalls in S3 resume,
 	 * which falls into the single-cmd mode.
 	 * Better to make reset, then.
-- 
2.39.5

