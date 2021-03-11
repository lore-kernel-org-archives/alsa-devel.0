Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365F7C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 00:51:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A535864FC0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 00:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A535864FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B84C01711;
	Thu, 11 Mar 2021 01:50:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B84C01711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615423873;
	bh=i7lWhACUHiy2rItuu95HGQz6kFc0bK891k89kQFL0zQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hFh5bPpTbNvYGuLBEr5Mag/CLa7Qjp4xJz3I/SLNBUKsugMVB012YCWzc4KE8dBke
	 +aynsI+MBbndqLzzMD2AABCXBhSlmxcDwa5+FEIkcEUhEba6JUNTJKApUjR023inWw
	 wgzOXBP88LzRMaOHZbRoQo1MhSai6N/Mv5WH8Aa0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46871F80423;
	Thu, 11 Mar 2021 01:49:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A070F802E7; Thu, 11 Mar 2021 01:49:31 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F31FF8012F
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 01:49:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F31FF8012F
IronPort-SDR: ahPHGzlJ5cS9tISqxbRqrUtw5ve5Md8k0V/hQeyNK/1MsVpZIqCFxOZvqcRQo4Dbt1hODjer9H
 4gDLsNbTS9IQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="167865533"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; d="scan'208";a="167865533"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 16:49:18 -0800
IronPort-SDR: J9Y1cPxBOqkMSqBlXVxAyMKHdXz3bOTZ6QWhFCYOJFXIkotC51XUhFBTXSIS5uELwiYy1VkrGk
 BC79uQFsu+/g==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; d="scan'208";a="370386789"
Received: from theer-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.101.109])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 16:49:16 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ASoC: mediatek: mtk-btcvsd: remove useless assignment
Date: Wed, 10 Mar 2021 18:49:01 -0600
Message-Id: <20210311004904.121205-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
References: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Lumi Lee <lumi.lee@mediatek.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

cppcheck warning:

sound/soc/mediatek/common/mtk-btcvsd.c:783:34: style: Variable 'avail'
is assigned a value that is never used. [unreadVariable]
 int written_size = count, avail = 0, cur_write_idx, write_size, cont;
                                 ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index a554c57b6460..f85b5ea180ec 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -780,7 +780,7 @@ static ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
 				    char __user *buf,
 				    size_t count)
 {
-	int written_size = count, avail = 0, cur_write_idx, write_size, cont;
+	int written_size = count, avail, cur_write_idx, write_size, cont;
 	unsigned int cur_buf_ofs = 0;
 	unsigned long flags;
 	unsigned int packet_size = bt->tx->packet_size;
-- 
2.25.1

