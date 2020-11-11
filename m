Return-Path: <SRS0=kIe0=ER=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D4EC55ABD
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 13:06:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41BD2074B
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 13:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dRzoM5wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41BD2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDFA61713;
	Wed, 11 Nov 2020 14:05:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDFA61713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605100005;
	bh=mI5LjzoHLqkntEZePTw3xI1Rv+LO79yefPxEr1uApmM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dRzoM5wkfXMud1IKsS4TX+cXycuxejprlKuJE9fvwanQn/zYLj0uLvRk65Ve1NN5d
	 JZ9d0wo00hJ6oI57SjX/+8pRbceRJthbzRXHRrazGpwB6biCYIWOBsAb78rqrSVHME
	 B3rN/yZFSFDcCdd5ZVmeel/qddaQJr5A8ZWO7o60=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BF4AF8020C;
	Wed, 11 Nov 2020 14:05:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59CCBF80271; Wed, 11 Nov 2020 14:05:52 +0100 (CET)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05194F800AE
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 14:05:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05194F800AE
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CWQ2S2j5yzhhtn;
 Wed, 11 Nov 2020 21:05:36 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Nov 2020
 21:05:36 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/4] ASoC: Fix error handling in wm899x
Date: Wed, 11 Nov 2020 21:09:19 +0800
Message-ID: <20201111130923.220186-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
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

The first patch fixed a wrong free in wm8997_probe. The
remaining three patches fixed PM disable depth imbalance
on error handling.

Zhang Qilong (4):
  ASoC: arizona: Fix a wrong free in wm8997_probe
  ASoC: arizona: Fix PM disable depth imbalance on error
  ASoC: wm8994: Fix PM disable depth imbalance on error
  ASoC: wm8998: Fix PM disable depth imbalance on error

 sound/soc/codecs/wm8994.c | 6 +++++-
 sound/soc/codecs/wm8997.c | 8 ++++++--
 sound/soc/codecs/wm8998.c | 4 +++-
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.25.4

