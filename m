Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB81C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Sep 2022 15:04:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4935386F;
	Thu, 29 Sep 2022 17:03:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4935386F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664463864;
	bh=jZXbI8O39ZzMKhbivj+zUyvpeARrxjq3+6luMkD/vlw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SetNa7D/Eu8AnkumtA89w6C4DYam1R9f95NQEPZx6XWnnwU2sFAYtEVxLR7pb3sJp
	 rxIOVWVfYzac+gxnkVnyrmnnjOMbqAIJ4lbPmLlzM68CX+H6aIeu7mr9P8Zq+mQ3e7
	 uBEbBpAnSn3CAEAq0yw8luRFFlK4P8LfD4NkQ6Ks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C44E7F804B4;
	Thu, 29 Sep 2022 17:03:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27EF2F804CA; Thu, 29 Sep 2022 17:03:33 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCEB2F80095
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2022 17:03:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCEB2F80095
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mdc1l0qGkzHth2;
 Thu, 29 Sep 2022 22:58:35 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 23:03:23 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 29 Sep
 2022 23:03:22 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <matthias.bgg@gmail.com>,
 <ckeepax@opensource.wolfsonmicro.com>, <jeff_chang@richtek.com>
Subject: [PATCH v2 -next 0/4] Fix PM disable depth imbalance in probe
Date: Thu, 29 Sep 2022 23:06:49 +0800
Message-ID: <20220929150653.63845-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-mediatek@lists.infradead.org
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

The pm_runtime_enable will increase power disable depth. Thus
a pairing decrement is needed on the error handling path to
keep it balanced according to context. We fix it by calling
pm_runtime_disable when error returns.
---
v2:
- call pm_runtime_disable when error returns.

Zhang Qilong (4):
  ASoC: wm8997: Fix PM disable depth imbalance in wm8997_probe
  ASoC: wm5110: Fix PM disable depth imbalance in wm5110_probe
  ASoC: wm5102: Fix PM disable depth imbalance in wm5102_probe
  ASoC: mt6660: Fix PM disable depth imbalance in mt6660_i2c_probe

 sound/soc/codecs/mt6660.c | 3 +++
 sound/soc/codecs/wm5102.c | 1 +
 sound/soc/codecs/wm5110.c | 1 +
 sound/soc/codecs/wm8997.c | 1 +
 4 files changed, 6 insertions(+)

-- 
2.25.1

