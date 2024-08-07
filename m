Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2D0C3DA7F
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Aug 2024 08:24:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CD2B22A6;
	Thu, 15 Aug 2024 10:24:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CD2B22A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723710293;
	bh=5dGec4BtOSX629Q9D8fwLxG2Wg9I8wXgjSG4Ryur2Oc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=B3Rq1bDl2q4EUYN1zHhcMAv0Kp+VD+kHrpvmL2I0BeWTeTsRdjh8kOdZBXQzj6zc+
	 RVkI9o8lYZf2+AZ923bvmGEZb/ZBs8V6UlxKQS2WMnS0epljdTQwuRJayzc55Gh3Yb
	 8+C4+6ntW1vl78VNru2Mc7S/s1hc7eVol8kOgk0A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3402FF80620; Thu, 15 Aug 2024 10:23:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AD6CF8061C;
	Thu, 15 Aug 2024 10:23:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DAE8AF8047C; Wed,  7 Aug 2024 04:54:25 +0200 (CEST)
Received: from smtp134-91.sina.com.cn (smtp134-91.sina.com.cn
 [180.149.134.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AB6DFF80236
	for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2024 04:54:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB6DFF80236
Received: from unknown (HELO zy-virtual-machine.localdomain)([180.172.39.131])
	by sina.net (10.185.250.31) with ESMTP
	id 66B2E1C800005724; Wed, 7 Aug 2024 10:54:01 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 6ECF8FEFE79D42E59A78B7C1A48E0E9B
X-SMAIL-UIID: 6ECF8FEFE79D42E59A78B7C1A48E0E9B-20240807-105401
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com,
	zhangyi@everest-semi.com
Subject: [PATCH 0/2] ASoC: codecs: ES8326: button and input issue
Date: Wed,  7 Aug 2024 10:53:54 +0800
Message-Id: <20240807025356.24904-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 5DOBDZW2VS5BZXKZXPMAWBCRBUSCEAJG
X-Message-ID-Hash: 5DOBDZW2VS5BZXKZXPMAWBCRBUSCEAJG
X-Mailman-Approved-At: Thu, 15 Aug 2024 08:21:42 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5DOBDZW2VS5BZXKZXPMAWBCRBUSCEAJG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

TO solve button and input issue, We have modified parts of the driver
related to button and input.

Zhang Yi (2):
  ASoC: codecs: ES8326: button detect issue
  ASoC: codecs: ES8326: input issue after init

 sound/soc/codecs/es8326.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.17.1

