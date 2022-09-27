Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A12C04A95
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Sep 2022 06:07:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95304850;
	Thu, 29 Sep 2022 08:07:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95304850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664431675;
	bh=hUDEj4ebDrV/SLvoEKu7aHR2jl4lFtNZo7LrS+4Dk0U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CykTpm4II5SbbJmDDjLA4zPr4/mFfPODXGpexXC9Q1ojlgH+28iCE11UXKhx2KZzj
	 BVq/TuPV6cQlZwgLEtVRDIvNNSIWn0JASovB36KVjDIK5mh2w7Fo2LK9Wl7ITHcuI1
	 RSuXm/sb5kMSWjFvGKF1buEDCIYEdCKhsoU2QVQU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AD68F804CA;
	Thu, 29 Sep 2022 08:06:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6240FF804D9; Tue, 27 Sep 2022 15:35:51 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF3E3F8024C
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 15:35:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF3E3F8024C
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4McLDQ3Nt7zHprT;
 Tue, 27 Sep 2022 21:33:26 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 21:35:42 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 21:35:41 +0800
From: Shang XiaoJing <shangxiaojing@huawei.com>
To: <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
 <tanureal@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <christophe.jaillet@wanadoo.fr>,
 <peter.ujfalusi@gmail.com>, <alsa-devel@alsa-project.org>,
 <patches@opensource.cirrus.com>
Subject: [PATCH -next 1/4] ASoC: cs35l36: Use DIV_ROUND_UP() instead of
 open-coding it
Date: Tue, 27 Sep 2022 22:09:45 +0800
Message-ID: <20220927140948.17696-2-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927140948.17696-1-shangxiaojing@huawei.com>
References: <20220927140948.17696-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 29 Sep 2022 08:06:37 +0200
Cc: shangxiaojing@huawei.com
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

Use DIV_ROUND_UP() instead of open-coding it, which intents and makes it
more clear what is going on for the casual reviewer.

The Coccinelle references Commit e4d8aef21403 ("ALSA: usb: Use
DIV_ROUND_UP() instead of open-coding it").

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 sound/soc/codecs/cs35l36.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index 31ae752e242f..a078dd422ea1 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -918,8 +918,8 @@ static int cs35l36_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 		fs1 = CS35L36_FS1_DEFAULT_VAL;
 		fs2 = CS35L36_FS2_DEFAULT_VAL;
 	} else {
-		fs1 = 3 * ((CS35L36_FS_NOM_6MHZ * 4 + freq - 1) / freq) + 4;
-		fs2 = 5 * ((CS35L36_FS_NOM_6MHZ * 4 + freq - 1) / freq) + 4;
+		fs1 = 3 * DIV_ROUND_UP(CS35L36_FS_NOM_6MHZ * 4, freq) + 4;
+		fs2 = 5 * DIV_ROUND_UP(CS35L36_FS_NOM_6MHZ * 4, freq) + 4;
 	}
 
 	regmap_write(cs35l36->regmap, CS35L36_TESTKEY_CTRL,
-- 
2.17.1

