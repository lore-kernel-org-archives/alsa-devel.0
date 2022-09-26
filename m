Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2206C07E9D
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Sep 2022 14:09:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B7F786E;
	Mon, 26 Sep 2022 16:08:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B7F786E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664201372;
	bh=fCGmx8CJfN6xdifRThUNzIF/rlZ8GYWhGAF1PWV880A=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nvLP6A3vZL5UJUI/uT5KwZ0CFFqwZ83YXNnSo8txr+RIdnhBPYG+YxImNg8ThaSAx
	 wB8i9F2rS6TAqOpsZcLGzKRBxfHGgOutRRGiE7uwp5zrS8+KtXymS0HRe5QA+VWibM
	 hCSiGXkGZpqS+psDHQUQMBAr7B3VBWG3j8bevFc4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D50AF80254;
	Mon, 26 Sep 2022 16:08:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA300F80510; Mon, 26 Sep 2022 16:08:15 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C0FDF80254
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2022 16:08:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C0FDF80254
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mbkxw5RDZzlXXs;
 Mon, 26 Sep 2022 22:03:48 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 22:08:02 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 22:08:02 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <arnaud.pouliquen@foss.st.com>
Subject: [PATCH -next 0/2] Fix PM disable depth imbalance in stm32 probe
Date: Mon, 26 Sep 2022 22:11:30 +0800
Message-ID: <20220926141132.124245-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, linux-stm32@st-md-mailman.stormreply.com
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
keep it balanced. We fix it by moving pm_runtime_enable to the
endding of probe.

Zhang Qilong (2):
  ASoC: stm32: dfsdm: Fix PM disable depth imbalance in
    stm32_adfsdm_probe
  ASoC: stm32: spdifrx: Fix PM disable depth imbalance in
    stm32_spdifrx_probe

 sound/soc/stm/stm32_adfsdm.c  | 8 +++++---
 sound/soc/stm/stm32_spdifrx.c | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.25.1

