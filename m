Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4DEC3DA4A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Aug 2024 07:32:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2F57850;
	Thu, 22 Aug 2024 09:32:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2F57850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724311946;
	bh=SdzzK5ESTsrf2b+s0cNEeMQxEP25YRTv9jY6URGt0FQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ehw8aQgPQIYNVd8K8STJ3xbAZz4nw7dljFxqFL0O5D+l+RAncF5SXgIkcmFVai5t5
	 nFXe2KBTXk/xqKAB9mIbag1Re7+hSlM+KohkSLdQ6N8B8m3EmQGqxizxcXIC2XoXON
	 q9pGnn7/E5xzUTr450/h7PqsMCxAmwxkhcIhD3aI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CA4FF805F3; Thu, 22 Aug 2024 09:31:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C949F805E6;
	Thu, 22 Aug 2024 09:31:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25226F8016E; Wed, 21 Aug 2024 09:00:53 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B424CF8016E
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2024 09:00:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B424CF8016E
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wpcfb5J1dzyRC9;
	Wed, 21 Aug 2024 15:00:23 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 394441401E0;
	Wed, 21 Aug 2024 15:00:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 15:00:46 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <peter.ujfalusi@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next 0/5] sound/soc: fix some macro definitions and usages
Date: Wed, 21 Aug 2024 15:08:10 +0800
Message-ID: <20240821070815.2326534-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-MailFrom: lihongbo22@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: ZZF625ZEAE62DSIOUKJVLT7KPY72M24Y
X-Message-ID-Hash: ZZF625ZEAE62DSIOUKJVLT7KPY72M24Y
X-Mailman-Approved-At: Thu, 22 Aug 2024 07:28:19 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZZF625ZEAE62DSIOUKJVLT7KPY72M24Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Many variable in macro are not used as we used macro_check
script to detect and mamually check, let us address these
issues.

Hongbo Li (5):
  sound/soc: fix macro definition on TWL4030_OUTPUT_PGA
  sound/soc remove unused substream in macro soc_component_mark_pop
  sound/soc remove unused substream in macro soc_dai_mark_pop
  sound/soc remove unused substream in macro soc_link_mark_pop
  sound/soc: fix macro definition on STM_SAI_HAS_EXT_SYNC

 sound/soc/codecs/twl4030.c    | 12 ++++++------
 sound/soc/soc-component.c     | 14 +++++++-------
 sound/soc/soc-dai.c           | 10 +++++-----
 sound/soc/soc-link.c          | 10 +++++-----
 sound/soc/stm/stm32_sai_sub.c |  2 +-
 5 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.34.1

