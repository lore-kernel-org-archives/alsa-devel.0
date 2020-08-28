Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42CEC433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:02:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0C32086A
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OTmcnpo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0C32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CED6C187C;
	Fri, 28 Aug 2020 16:01:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CED6C187C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598623328;
	bh=ak3LxgZSmJxZZJ68Rtxng2D1AcSnT3S1aL3i257Vf9k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OTmcnpo/womNRzzXK/R7ZlunPKji0en4we8HhY6l1IyyPUTqPLUJclN+BJjqpfNXY
	 zK4J5o9+D+WKzZkTlxPARAxbMSu7Ekuvj1rE5T+DZ8gXm4aLe8ZFCfzo6K0MUGf+uW
	 /YqLnfDd7YykLDh6N7oZWpHzrgfeuVypD8OltVMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56DA8F80143;
	Fri, 28 Aug 2020 16:01:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CFF0F8016F; Fri, 28 Aug 2020 16:01:17 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2AE82F80118
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 16:01:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2AE82F80118
IronPort-SDR: b5ZWJ/rZu/WTXbE8xnxCBjdRgyKUFlzOQ0UfDzggA6Mm66RSc6EAJJ4awQQ3RKaF2+0viJL7PM
 ba8vhbmdPe6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="241482159"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; d="scan'208";a="241482159"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2020 07:00:58 -0700
IronPort-SDR: bbQUPkkBkzfMfpW1glDhP5gGUUH7TRkODSDmEQ54+fffqxFus6GId2OW8KQ3W4tPhgiIHSS4Kx
 2jBtk60UAT/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; d="scan'208";a="296130510"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga003.jf.intel.com with ESMTP; 28 Aug 2020 07:00:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 9CD3F1B4; Fri, 28 Aug 2020 17:00:57 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1] ASoC: core: Replace dma_request_slave_channel() with
 dma_request_chan()
Date: Fri, 28 Aug 2020 17:00:57 +0300
Message-Id: <20200828140057.4198-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Drivers should use dma_request_chan() instead of dma_request_slave_channel().

dma_request_slave_channel() is a simple wrapper for dma_request_chan() eating
up the error code for channel request failure and makes deferred probing
impossible.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index fb95c1464e66..ab13e08cd636 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -249,8 +249,7 @@ static int dmaengine_pcm_new(struct snd_soc_component *component,
 			continue;
 
 		if (!pcm->chan[i] && config && config->chan_names[i])
-			pcm->chan[i] = dma_request_slave_channel(dev,
-				config->chan_names[i]);
+			pcm->chan[i] = dma_request_chan(dev, config->chan_names[i]);
 
 		if (!pcm->chan[i] && (pcm->flags & SND_DMAENGINE_PCM_FLAG_COMPAT)) {
 			pcm->chan[i] = dmaengine_pcm_compat_request_channel(
-- 
2.28.0

