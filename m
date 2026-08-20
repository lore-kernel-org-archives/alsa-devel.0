Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD98C5DF81
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:25:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D19C6025B;
	Thu, 20 Aug 2026 11:25:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D19C6025B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787217921;
	bh=ETk2u79/TwTxlCcJTdyLfYXOCGif+diIn7dGVBFY8uE=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=O4MdUGAdFEazpPq7OXakwBWvKH3ktsaS0u+SdYfRlVqFdeYrro1QIPjG5VHEc6tVz
	 7N8nfI72ygI6yGv+SYwdzw9MeLEtoxlOqyXalImS2A/4guOyEg8ji/j3lpkjoNXYy+
	 YlFzg6H6WgMj+km1TjDNOJfPvaAecZYVrY5fCIi0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A293F805FE; Thu, 20 Aug 2026 11:24:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59967F805F2;
	Thu, 20 Aug 2026 11:24:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80978F8053D; Thu, 20 Aug 2026 11:24:40 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787217876;
	b=A1+S4HV5onjr6Dz7KGhy/oljrcHNhvw9aFJoiDidpmiIOGtSw/fGaY4TBlEC2jnZtZVh
	 Usmaw5++kvcVQDI0mFxTbZG09R24Ht4lTLpTVIERvBPyAW2XDP0Es4u0Q6Ltfa4mvGLgo
	 lkCcI8SzGH2ImM6+X2BdeINM1W9gNElBPxsoHhoTsKwOpDvMyaITyMlotlDnxgy4KswFr
	 nYdvxT9M0Xs1oY1AhilVUZXs0dAUrreDhkQbonCJM5UUPc3iGbfAbyfqk2RohSCtT0MQL
	 QwWclA/6CJSUWFtG75N5DvlOEJq8DbClRasZU0HA1AZPoTaSRYAuR725ciADI+wglBw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787217876;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ETk2u79/TwTxlCcJTdyLfYXOCGif+diIn7dGVBFY8uE=;
	b=h7u2B3cV23fUBByfmfS8jx9guC2Xq1+5tvw23BCei3yDD/Uj3u3aMcMhtttMxQqaz5qC
	 GZwzzZNRxyMFZyAxx4728Ux0HEd63thvmNQHsBhN8NmTke7hSkaSmWgDTLALX2TbIHIYq
	 BQTnE8h4UhCizrNttJ2NCcoK0Da3cd1TVgSzmtKCpy+wST6xTnQjcUp5Vm7vYB2ovuV70
	 Vkr55jFPhInYhaSzaKXC2+0Nm7eJ3BBxP5QXkWAqT2qgcWLOMqHaMYELMhP/cVy/pW2QL
	 T/wgNFDgdHaNequXi2f1ssrKgO9mLaUg5Ss3Hr/kHeEZBquV+2A5u2SNfA41+sCUToQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=OgJTQuja;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C08AEF80246
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2026 11:24:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C08AEF80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=OgJTQuja
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67K9OLWB03286074,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1787217861; bh=nqonArHbeiPuwojUo0t49+09bMV/1aiL3T3nKI2THKE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=OgJTQujavmd7NkAFe0tZEhoVUsb4dKyATbGpO1C8ZpooSFcZFsYCsG47ZAkS62HJa
	 uHh1NcpYUfpr/DbdATobmIEq6oka8AbjX0VjIszIAGeGmOY8DjaEu8FFEs534FalHO
	 +DKBMehwOaykajsFX4AlQ4Rmovz1IIUG8YOWjmjvi5Fh7PM3AHAhl5oxP/S3Ly1JSR
	 Zzc1uMNbdaiNpsznrnQnZYTmveOxOm9aLGisukKloxDQAQA05+YC0IQmGzdzF3MwZU
	 cXJHnAw4lAdpcRatsk2eYYbzDQHEYj9jJXXMHeL8iS0+QD3+1HUgkxktB4seZZEiJq
	 G+ldz+A2NUoRQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67K9OLWB03286074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 17:24:21 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 20 Aug 2026 17:24:20 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Thu, 20 Aug 2026 17:24:19 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	<Trevor.Wu@mediatek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] ASoC: rt712-sdca: Pull high JD2 to prevent from entering TV
 mode
Date: Thu, 20 Aug 2026 17:24:15 +0800
Message-ID: <20260820092415.2979641-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: MXP2HW5CRKP5MKDWXCSV3JIO5RIJI3FF
X-Message-ID-Hash: MXP2HW5CRKP5MKDWXCSV3JIO5RIJI3FF
X-MailFrom: jack.yu@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MXP2HW5CRKP5MKDWXCSV3JIO5RIJI3FF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

Add a patch setting to prevent ALC712 from entering TV mode which
may cause unexpected issues.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt712-sdca.c | 1 +
 sound/soc/codecs/rt712-sdca.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt712-sdca.c b/sound/soc/codecs/rt712-sdca.c
index 2218f9918ae3..13574513b181 100644
--- a/sound/soc/codecs/rt712-sdca.c
+++ b/sound/soc/codecs/rt712-sdca.c
@@ -1779,6 +1779,7 @@ static void rt712_sdca_vb_io_init(struct rt712_sdca_priv *rt712)
 	dev_dbg(dev, "%s jack/mic/amp func_status=0x%x, 0x%x, 0x%x\n",
 		__func__, jack_func_status, mic_func_status, amp_func_status);
 
+	rt712_sdca_index_write(rt712, RT712_VENDOR_REG, RT712_JD_CTL3, 0x7778);
 	/* DMIC */
 	if ((mic_func_status & FUNCTION_NEEDS_INITIALIZATION) || (!rt712->first_hw_init)) {
 		rt712_sdca_index_write(rt712, RT712_VENDOR_HDA_CTL, RT712_DMIC2_FU_IT_FLOAT_CTL, 0x1526);
diff --git a/sound/soc/codecs/rt712-sdca.h b/sound/soc/codecs/rt712-sdca.h
index 7ab7d5feb50a..46740281a5c1 100644
--- a/sound/soc/codecs/rt712-sdca.h
+++ b/sound/soc/codecs/rt712-sdca.h
@@ -74,6 +74,7 @@ struct rt712_dmic_kctrl_priv {
 #define RT712_JD_PRODUCT_NUM			0x00
 #define RT712_ANALOG_BIAS_CTL3			0x04
 #define RT712_JD_CTL1				0x09
+#define RT712_JD_CTL3				0x0b
 #define RT712_IO_CTL				0x0c
 #define RT712_LDO2_3_CTL1			0x0e
 #define RT712_PARA_VERB_CTL			0x1a
-- 
2.54.0

