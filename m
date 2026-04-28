Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC4ACD342C
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2026 11:33:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE84660205;
	Mon,  4 May 2026 13:33:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE84660205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777894420;
	bh=MSNGniOg8caUHapSWb6qVKePj1Pttht3yNcd8qlt9wU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=RvSCKAH7T/wSTazyB8Hyy/Qu0wQfCHp7aryUjmuZV8ZR9S3DZ3NfT9yOM0q4/5Dme
	 ww0ftNLhE9+Z9wNt6pftKg7QY/aUS6egD8tZgx6yUMHR5/MDbHjPS6ey7K7C7V65pE
	 yS5XwM5Kwm+U6nPRyGxgHFpUzytT6lHmjcv15my0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27296F80528; Mon,  4 May 2026 13:33:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C12E7F805EC;
	Mon,  4 May 2026 13:33:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 84516F804CF; Tue, 28 Apr 2026 10:05:02 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B149F8016D
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2026 10:04:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B149F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=frNPXHu1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ih
	AwFagRcfWmN4mKHyd4J+Yp6aQiKbMSFvFpZToE6Sc=; b=frNPXHu1dCvw0p7i0S
	IY4t4O2MH5AgHlBUKoniDj0kGLvWeIyfFPyQQP5r4Mm7tFN6wNfcq7d5Xls4DPPR
	febADlyEP+2KKAor6jqG60tqWFtk6IwLm0OzZ7C0PHQnth1SmcD8PPXhGzuxp0i1
	nU7pwH+PVB9GZAym8ROqvcEDE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wCHTwYkavBpamoNCQ--.34861S2;
	Tue, 28 Apr 2026 16:04:53 +0800 (CST)
From: wangdich9700@163.com
To: tiwai@suse.com,
	wangdich9700@163.com,
	bo.liu@senarytech.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH v2] ALSA: hda/conexant: Fix missing error check for jack
 detection
Date: Tue, 28 Apr 2026 16:04:50 +0800
Message-Id: <20260428080450.108801-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHTwYkavBpamoNCQ--.34861S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyUJFykKw4fJr47WF18Grg_yoW8Zrykpr
	yUua4rK39xKayI9F4xKr1xC3WFkFWruFW5C3ykK3WYvr45JF18Wa4qq34UtayfC39YkF17
	ZF42q34UJFW5ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ztYLJbUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbCvwU6iWnwaiX5wgAA3k
X-MailFrom: wangdich9700@163.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: BVGUSCZ7PXLFGRJBV6MAWRHHRCDJ3SWT
X-Message-ID-Hash: BVGUSCZ7PXLFGRJBV6MAWRHHRCDJ3SWT
X-Mailman-Approved-At: Mon, 04 May 2026 11:33:02 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BVGUSCZ7PXLFGRJBV6MAWRHHRCDJ3SWT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: wangdicheng <wangdicheng@kylinos.cn>

In cx_probe(), the return value of snd_hda_jack_detect_enable_callback()
is ignored. This function returns a pointer, and if it fails (e.g., due
to memory allocation failure), it returns an error pointer which must
be checked using IS_ERR().

If the registration fails, the driver continues to probe, but the jack
detection callback will not be registered. This can lead to a kernel
crash later when the driver attempts to handle jack events or accesses
the uninitialized structure.

Check the return value using IS_ERR() and propagate the error via
PTR_ERR() to the probe caller.

Fixes: 7aeb25908648 ("ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140")
Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
v1 -> v2:
Use IS_ERR() and PTR_ERR() to handle pointer return value.
Add Fixes tag.

 sound/hda/codecs/conexant.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index 3a9717df39b4..e3b6aaabe3a9 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -1175,6 +1175,7 @@ static void add_cx5051_fake_mutes(struct hda_codec *codec)
 static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
 {
 	struct conexant_spec *spec;
+	struct hda_jack_callback *callback;
 	int err;
 
 	codec_info(codec, "%s: BIOS auto-probing.\n", codec->core.chip_name);
@@ -1190,7 +1191,12 @@ static int cx_probe(struct hda_codec *codec, const struct hda_device_id *id)
 	case 0x14f11f86:
 	case 0x14f11f87:
 		spec->is_cx11880_sn6140 = true;
-		snd_hda_jack_detect_enable_callback(codec, 0x19, cx_update_headset_mic_vref);
+		callback = snd_hda_jack_detect_enable_callback(codec, 0x19,
+				cx_update_headset_mic_vref);
+		if (IS_ERR(callback)) {
+			err = PTR_ERR(callback);
+			goto error;
+		}
 		break;
 	}
 
-- 
2.25.1

