Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB6DC6FD1F
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Apr 2024 07:16:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98CA52D52;
	Tue,  2 Apr 2024 09:15:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98CA52D52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712042158;
	bh=JDdQUktKOfhua2+Bxj626Bhw5OtcneVpPvwHo6tsN1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fY/kNuj/Yk8+SD8OPW0OWp6nbFArAyj6WdJeGtkH71/leZI8cHFW89HWeDl/YJspn
	 Xsb+eSYsgCH5XDouzHIInqtGI3d7k+0tEZzxSeKbyUinxLr+MDeXm1zcilns5cwEhj
	 RD2gpelZdxBxrkbDfOYEf7FtX6NlgGS1ciaRcBiY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7A1F6F89B48; Tue,  2 Apr 2024 08:58:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 49D36F89CDA;
	Tue,  2 Apr 2024 08:58:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A54C4F8016E; Tue,  2 Apr 2024 08:23:29 +0200 (CEST)
Received: from mail78-50.sinamail.sina.com.cn (mail78-50.sinamail.sina.com.cn
 [219.142.78.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9C3A2F80236
	for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2024 08:20:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C3A2F80236
Received: from unknown (HELO zy-virtual-machine.localdomain)([116.232.53.71])
	by sina.net (10.75.30.234) with ESMTP
	id 660BA3B800029E89; Tue, 2 Apr 2024 14:20:47 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: B79AA415AEFD44DB8D18C2260402F5CB
X-SMAIL-UIID: B79AA415AEFD44DB8D18C2260402F5CB-20240402-142047
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com,
	zhangyi@everest-semi.com
Subject: [PATCH 3/4] ASoC: codecs: ES8326: Solve a headphone detection issue
 after suspend and resume
Date: Tue,  2 Apr 2024 14:20:42 +0800
Message-Id: <20240402062043.20608-4-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240402062043.20608-1-zhangyi@everest-semi.com>
References: <20240402062043.20608-1-zhangyi@everest-semi.com>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: BIFQTBFRQCTJ6Q76NU5M2PDIP4JHOFPY
X-Message-ID-Hash: BIFQTBFRQCTJ6Q76NU5M2PDIP4JHOFPY
X-Mailman-Approved-At: Tue, 02 Apr 2024 06:55:03 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BIFQTBFRQCTJ6Q76NU5M2PDIP4JHOFPY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

We got a headphone detection issue after suspend and resume.
And we fixed it by modifying the configuration at es8326_suspend
and invoke es8326_irq at es8326_resume.

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 sound/soc/codecs/es8326.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 7f4788265e53..17711dc5df0a 100755
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -1054,6 +1054,8 @@ static int es8326_resume(struct snd_soc_component *component)
 	es8326->hp = 0;
 	es8326->hpl_vol = 0x03;
 	es8326->hpr_vol = 0x03;
+
+	es8326_irq(es8326->irq, es8326);
 	return 0;
 }
 
@@ -1064,6 +1066,9 @@ static int es8326_suspend(struct snd_soc_component *component)
 	cancel_delayed_work_sync(&es8326->jack_detect_work);
 	es8326_disable_micbias(component);
 	es8326->calibrated = false;
+	regmap_write(es8326->regmap, ES8326_CLK_MUX, 0x2d);
+	regmap_write(es8326->regmap, ES8326_DAC2HPMIX, 0x00);
+	regmap_write(es8326->regmap, ES8326_ANA_PDN, 0x3b);
 	regmap_write(es8326->regmap, ES8326_CLK_CTL, ES8326_CLK_OFF);
 	regcache_cache_only(es8326->regmap, true);
 
-- 
2.17.1

