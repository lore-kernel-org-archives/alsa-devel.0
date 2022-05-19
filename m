Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E3BC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 19 May 2022 12:42:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 292A715C3;
	Thu, 19 May 2022 14:41:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 292A715C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652964167;
	bh=Nk1SwRNFqFfYX+crMx6Iv++YlHlKRY6wh1nxSRS2nE4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UXm+YZxvkZogJlflKoutk6e36rU73SWiVQZmbjohuVf8iQdkoZOhcEA22DUcDT41M
	 50ISdSlK6k6nABa5LkIamWn2ksfC8Grj0JHb8jV1vgAiaQiGeX0TsHVb1Uot7FPvDS
	 jGYsM+SSpnl0UtlwEi7MYRwWKxbc44jSUwGs2mKU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8949F80237;
	Thu, 19 May 2022 14:41:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A609F8025D; Thu, 19 May 2022 14:41:54 +0200 (CEST)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [221.176.66.80])
 by alsa1.perex.cz (Postfix) with ESMTP id 423A7F80109
 for <alsa-devel@alsa-project.org>; Thu, 19 May 2022 14:41:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 423A7F80109
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1])
 by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee562863b06ea7-a80ce;
 Thu, 19 May 2022 20:41:43 +0800 (CST)
X-RM-TRANSID: 2ee562863b06ea7-a80ce
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.99])
 by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee162863b03441-e1d79;
 Thu, 19 May 2022 20:41:43 +0800 (CST)
X-RM-TRANSID: 2ee162863b03441-e1d79
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Subject: [PATCH] ASoC: stm32: sai: Use of_device_get_match_data() to simplify
 code
Date: Thu, 19 May 2022 20:42:35 +0800
Message-Id: <20220519124235.21100-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Tang Bin <tangbin@cmss.chinamobile.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

Retrieve of match data, it's better and cleaner to use
'of_device_get_match_data' over 'of_match_device'.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/stm/stm32_sai_sub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index dd636af81..d300605a2 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1500,7 +1500,6 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 static int stm32_sai_sub_probe(struct platform_device *pdev)
 {
 	struct stm32_sai_sub_data *sai;
-	const struct of_device_id *of_id;
 	const struct snd_dmaengine_pcm_config *conf = &stm32_sai_pcm_config;
 	int ret;
 
@@ -1508,10 +1507,9 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	if (!sai)
 		return -ENOMEM;
 
-	of_id = of_match_device(stm32_sai_sub_ids, &pdev->dev);
-	if (!of_id)
+	sai->id = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	if (!sai->id)
 		return -EINVAL;
-	sai->id = (uintptr_t)of_id->data;
 
 	sai->pdev = pdev;
 	mutex_init(&sai->ctrl_lock);
-- 
2.20.1.windows.1



