Return-Path: <SRS0=I/J9=ZL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FA2C432C3
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:45:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FE1222A2
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BtjFvxOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FE1222A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4C1E168C;
	Tue, 19 Nov 2019 12:37:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4C1E168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574163497;
	bh=eWtWOaZs5KffVEpQBJWGf22uE1LBTBsbABtKX37jyuc=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BtjFvxOcln4utxo7xMvD2qpvqZJdfp9QVJSnktfKcM5MwCbAJgCxsDD55BM0U0ADC
	 AmX5D09jsNUi83sWN81aBD9TN2e7fljnSf4l59y97RPcI/YlrD6H8mHPygjazEwifv
	 uyM7TovzapSzKS6Xgm0aFCsb79U0eWQFM2PlGROY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FDB8F80135;
	Tue, 19 Nov 2019 12:37:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC46FF80137; Tue, 19 Nov 2019 12:37:23 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17C70F800FF
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 12:37:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17C70F800FF
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1iX1oG-0007Z8-Bf; Tue, 19 Nov 2019 11:36:40 +0000
From: Colin King <colin.king@canonical.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
 Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org
Date: Tue, 19 Nov 2019 11:36:40 +0000
Message-Id: <20191119113640.166940-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ASoC: Intel: mrfld: fix incorrect check on
	p->sink
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Colin Ian King <colin.king@canonical.com>

The check on p->sink looks bogus, I believe it should be p->source
since the following code blocks are related to p->source. Fix
this by replacing p->sink with p->source.

Addresses-Coverity: ("Copy-paste error")
Fixes: 24c8d14192cc ("ASoC: Intel: mrfld: add DSP core controls")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

[ Note: this has not been tested ]

---
 sound/soc/intel/atom/sst-atom-controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index baef461a99f1..f883c9340eee 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -1333,7 +1333,7 @@ int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute)
 				dai->capture_widget->name);
 		w = dai->capture_widget;
 		snd_soc_dapm_widget_for_each_source_path(w, p) {
-			if (p->connected && !p->connected(w, p->sink))
+			if (p->connected && !p->connected(w, p->source))
 				continue;
 
 			if (p->connect &&  p->source->power &&
-- 
2.24.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
