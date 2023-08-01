Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076E7C00528
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Aug 2023 09:38:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4FADD823;
	Fri,  4 Aug 2023 11:37:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4FADD823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691141928;
	bh=APvmFx+ixVZPNNg9SQLgbVZGoledUVf4eez0op5aHUo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TvSB+kY3FG2qBzBV25BBXF5XesRsdCxLU/3JqnizO+dn7DJalUTzx3hMj8c9MBCnn
	 idK2LTMlkqDMb0yzKDKRSuqF7pwZn2TV/Jbn3gRsRp7+iJPIC2YpHeikoEufxAAM6p
	 rlawBabImlVXT4d4HKXQGBF43WRekW2XwxJZd2Hs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD15CF80425; Fri,  4 Aug 2023 11:37:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03599F80425;
	Fri,  4 Aug 2023 11:37:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C8F7AF801D5; Tue,  1 Aug 2023 18:06:09 +0200 (CEST)
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 05E63F80087
	for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2023 18:05:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05E63F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256
 header.s=s201512 header.b=v/etJO1I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1690905931;
	bh=OMeXsTEoSV37i5q3b+jlJxSVQJjMWTEe0h/gT1sAYts=;
	h=From:To:Cc:Subject:Date;
	b=v/etJO1I/XGgjVtV8dSMgQo6NExGr6Mj4/9tGODLapml58371/LsVKjsvfxvUmICU
	 X+riAjxSNERN7vidUO7Rt2koXHfGcnRiLILH2xA3onspNA2typQgjGE8LSPsNJ7P1P
	 Lh61wCIwkKXw4/4C+c/ZWwnZnCKOTwl/cC1IpklE=
Received: from KernelDevBox.byted.org ([180.184.51.134])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id ECCB1097; Tue, 01 Aug 2023 23:59:12 +0800
X-QQ-mid: xmsmtpt1690905552tyfhwer0f
Message-ID: <tencent_A560D01E3E0A00A85A12F137E4B5205B3508@qq.com>
X-QQ-XMAILINFO: NGS5xw3DVfAMV/jfbZlCf9owjwKZJdc3ehD5Gs0w53jsUCSTCupG6mehI+9XiQ
	 uXUUz5H8aBY/XIKy9L6NsIq/3YoujfAQN2JwExL7Kl2PVe1wmxQtqGeXQjWXMd+lxX7p6tm1mXix
	 MkMo4Mmm4aFi/v4OD2ANDG5xylKl9J6H6HNvY/WmuudbwgVRDSswAJi5svJFF6dOFWkIEAz7IVjZ
	 74yYk9MkQli4YXGENrXXJXfONnFxdxoiPO988ZMSaZS0l7GiLStQIy/lY9dZoiedHvts0gczYPZY
	 BWPgLq3mlLYK6iAxiH4xAlY2KkPGNA8Xv9LObpMyRqqwSLrsblrxrvLhxL53U/96utkUSD6iMIeo
	 nsVcfQwXKOQlP/B9wGjaxVtc0N6y7FYmB/5flfRfQW6KANAsH7jv7CwTjIadrDnYCsvHpjUro5rR
	 0IlZ8+yXg3KG44KrXMPFWdxYHvibSXIw85NkJ+/xYQ5anwyuGAe0scJO8uYgrjOTaN5MvyRD1dST
	 Rr7TjrHTHF2su1kXAPnnyq04g83Ozp9iyLqmBpBp3oPvIYPhI5BimwcZUodKMnIk3WAnohowjV7Z
	 zOcMK/hepZQVDukqM7kMOU9osC0fXBrk9hdehVk7qHSsTjEx1UHESFUEWubSuvggn9qGdHIFY7tA
	 RY3ireifn37EbPmjUdUIgpxv+6n0y7Rq1Xeg+ZLIlQqNeuW6Es49rv4JS8dcs+kWe1OwE6FI3uCa
	 S+BSS8vSydaExCqfqIrBmBNAqdg4mdd9AJf32mYXm4uSEnEIEo7jZT0OnfhHkzhGJ/LzaoLroXc7
	 xZcupIy4mk0KJPSb/Zpect3SvgzKAdPNEbA3H+p5puq3ajD33g63C67af2PuJjWpWe/3myNAWn0W
	 oknMsFGurP/K0TrKyzq46RFZRL8H2qIND38vVntWugtZqbWUPXF0NZMLL1oD48afO5HwBBSVAO/x
	 cyyty2ptUVyMYqLeSeucMT/SYpTdHUe97ZWEOUpCUGt9Rqj4/dHqjkRlICiedJhSEiMAwKyg6kH6
	 gNZ5kf+Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Zhang Shurong <zhang_shurong@foxmail.com>
To: broonie@kernel.org,
	oder_chiou@realtek.com
Cc: lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v2] ASoC: rt5665: add missed regulator_bulk_disable
Date: Tue,  1 Aug 2023 23:59:11 +0800
X-OQ-MSGID: <20230801155911.372244-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: zhang_shurong@foxmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: HKSJSGJ5FIA7U7VA3MJZU6YJWMQRCO7U
X-Message-ID-Hash: HKSJSGJ5FIA7U7VA3MJZU6YJWMQRCO7U
X-Mailman-Approved-At: Fri, 04 Aug 2023 09:37:28 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HKSJSGJ5FIA7U7VA3MJZU6YJWMQRCO7U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The driver forgets to call regulator_bulk_disable()

Add the missed call to fix it.

Fixes: 33ada14a26c8 ("ASoC: add rt5665 codec driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
Changes in v2:
 - move regulator_bulk_disable() in rt5665_remove() 

 sound/soc/codecs/rt5665.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 83c367af91da..525713c33d71 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4472,6 +4472,8 @@ static void rt5665_remove(struct snd_soc_component *component)
 	struct rt5665_priv *rt5665 = snd_soc_component_get_drvdata(component);
 
 	regmap_write(rt5665->regmap, RT5665_RESET, 0);
+
+	regulator_bulk_disable(ARRAY_SIZE(rt5665->supplies), rt5665->supplies);
 }
 
 #ifdef CONFIG_PM
-- 
2.30.2

