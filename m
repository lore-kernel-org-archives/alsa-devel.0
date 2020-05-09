Return-Path: <SRS0=KGvk=6X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5048AC28CBC
	for <alsa-devel@archiver.kernel.org>; Sat,  9 May 2020 09:31:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEC0206D6
	for <alsa-devel@archiver.kernel.org>; Sat,  9 May 2020 09:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SVvVBxaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEC0206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20DE0846;
	Sat,  9 May 2020 11:30:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20DE0846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589016665;
	bh=BnM2q2iyAX4XFSkopkUzB2hRPN4ggj5eUF6yO75PWMw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SVvVBxaTncUlKY7uzpykP5jUHnbmTq6HU6n5j6iLnV7hTNcYkUelz5U2L30urrnXo
	 yL2OsRRlL7tInTISbsYtLviyvaMGhKhw8HFn+5ub6rkwAS2RAJKAaqeXAL9tIoyUpI
	 9SZLw5cMJwxdT/Mz1t07EUftEgYGIa0W5qtgwKaM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CEC7F8015B;
	Sat,  9 May 2020 11:30:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2854CF8015F; Sat,  9 May 2020 11:30:08 +0200 (CEST)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20BA4F800E7;
 Sat,  9 May 2020 11:29:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20BA4F800E7
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B8EAA1A5248D2D890D87;
 Sat,  9 May 2020 17:29:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 17:29:41 +0800
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood
 <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood
 <liam.r.girdwood@linux.intel.com>
Subject: [PATCH -next] ASoC: SOF: core: fix error return code in
 sof_probe_continue()
Date: Sat, 9 May 2020 09:33:37 +0000
Message-ID: <20200509093337.78897-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
 Wei Yongjun <weiyongjun1@huawei.com>, sound-open-firmware@alsa-project.org
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

Fix to return negative error code -ENOMEM from the IPC init error
handling case instead of 0, as done elsewhere in this function.

Fixes: c16211d6226d ("ASoC: SOF: Add Sound Open Firmware driver core")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/sof/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 94a2cb58ab9a..ef9be4f45e27 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -176,6 +176,7 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 	/* init the IPC */
 	sdev->ipc = snd_sof_ipc_init(sdev);
 	if (!sdev->ipc) {
+		ret = -ENOMEM;
 		dev_err(sdev->dev, "error: failed to init DSP IPC %d\n", ret);
 		goto ipc_err;
 	}



