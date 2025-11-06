Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F9ECCFA13
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:51:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84404603B4;
	Mon, 10 Nov 2025 15:51:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84404603B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762786281;
	bh=TQv944OsNJBy399bRPOXpN9cFgowfIvc7mJdW7mtYBc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=DAJeLpC9GoEgmum5F1MdHdPszSRzmqkDd31pKBVEoxcS7O7yqJ6KeW7fGQpj3o3Bs
	 ONBBH5Sif+ZkFF0/vH/9gHNYpSBxmfBuUgDy2s+21Sp24uBhOhcd0z1BuNAs1tVA/a
	 oGLfb4uiOt68Qc/BInfsKHVyMQLJAlDa3fAOhw0A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4FEA5F89886; Mon, 10 Nov 2025 15:42:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17176F89885;
	Mon, 10 Nov 2025 15:42:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7FDEEF80272; Thu,  6 Nov 2025 06:39:19 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D4C4AF80100
	for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2025 06:39:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4C4AF80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=jUljfr+5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=C/
	qSfn8XWm+oaCfY2V1Q0d+VxMXeZuMkTYlNsiNF8Y4=; b=jUljfr+5Q1323SHae5
	MkgDS4zSYU/yb6jIRf28Q+fMXdaY/vsr0TvgEeOow7LsWDwswmm7hgq/NG7zcIqK
	0TAk0UWJSwMnyzc60eMH5D8WWmwf2ZafVAU0hVJinzm+tV5NP7Itf3TNk+mojCv3
	I7aXl7VMnDznavLUwlVvwA3Hs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD3f5N4NAxpLAQPCA--.4683S2;
	Thu, 06 Nov 2025 13:39:05 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdich9700@163.com>,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH] ALSA: hda/senary: Replace magic numbers with defined
 constants
Date: Thu,  6 Nov 2025 13:39:02 +0800
Message-Id: <20251106053902.98614-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3f5N4NAxpLAQPCA--.4683S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur47tryktFy5KFWfAF43ZFb_yoW8GF18pF
	n0kFyrKrZ3Jr10yF18GayfZFyrGas8WF43K342g3WYvan2krykX3Wjqryaq3W3JF9rK3Wa
	vryxZ34UCryqyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pis2-UUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbiRwL9T2kMMBRlBwAAsU
X-MailFrom: wangdich9700@163.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: PT5G7FYTA3VGW6SFDVNDB5AKHNL7ADV3
X-Message-ID-Hash: PT5G7FYTA3VGW6SFDVNDB5AKHNL7ADV3
X-Mailman-Approved-At: Mon, 10 Nov 2025 14:42:06 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PT5G7FYTA3VGW6SFDVNDB5AKHNL7ADV3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: wangdicheng <wangdich9700@163.com>

Replace hardcoded GPIO node value with a defined constant for better
code readability and maintainability.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/hda/codecs/senarytech.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/hda/codecs/senarytech.c b/sound/hda/codecs/senarytech.c
index 99af8d5e51db..d61d57538bc9 100644
--- a/sound/hda/codecs/senarytech.c
+++ b/sound/hda/codecs/senarytech.c
@@ -19,6 +19,9 @@
 #include "hda_jack.h"
 #include "generic.h"
 
+/* GPIO node ID */
+#define SENARY_GPIO_NODE		0x01
+
 struct senary_spec {
 	struct hda_gen_spec gen;
 
@@ -131,11 +134,11 @@ static void senary_init_gpio_led(struct hda_codec *codec)
 	unsigned int mask = spec->gpio_mute_led_mask | spec->gpio_mic_led_mask;
 
 	if (mask) {
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
+		snd_hda_codec_write(codec, SENARY_GPIO_NODE, 0, AC_VERB_SET_GPIO_MASK,
 				    mask);
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION,
+		snd_hda_codec_write(codec, SENARY_GPIO_NODE, 0, AC_VERB_SET_GPIO_DIRECTION,
 				    mask);
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
+		snd_hda_codec_write(codec, SENARY_GPIO_NODE, 0, AC_VERB_SET_GPIO_DATA,
 				    spec->gpio_led);
 	}
 }
-- 
2.25.1

