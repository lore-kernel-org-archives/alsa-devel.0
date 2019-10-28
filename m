Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FDECA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:52:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9A621721
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ro3yqJdD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="js4Q4L9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9A621721
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 408661ED8;
	Mon, 28 Oct 2019 12:51:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 408661ED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572263525;
	bh=qb+AL75ie4uSwrDzVxkF4iAOXcTXhZnzQS+L1fUhRo0=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ro3yqJdD93hm9PfID8N+1YHmqWugAhuRphLCvmHyhvT8AUGksmvmUrRzroeni1SQb
	 cwbZDyJzn/lFec/NMFTaF5Z6YtC+nNEcD4wjGOWy6fuXB+4AM4c7TLJS07aoX2YPWd
	 th9qFTEuwJvNHM7GZxC7TM8dYClPK/HSBON4em1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA2AFF800E7;
	Mon, 28 Oct 2019 12:51:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99ED5F80361; Mon, 28 Oct 2019 12:51:12 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2C22F800E7
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 12:51:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2C22F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="js4Q4L9w"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9SBp4l0014421;
 Mon, 28 Oct 2019 06:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1572263464;
 bh=2Bk6SFdTKe5T7juvvX1CTvVyu3CLk7EpdHR8cVFfQrk=;
 h=From:To:CC:Subject:Date;
 b=js4Q4L9w1ptkXv9s5qzSgr8rgPCUoEJ3/Les8OGnHN9JZA/I0IGVG3WVq4/Jx/nCj
 /A/wFBz2en0+t68FWkU8iFXmcElfWKfmKl+lGDEf1zRszp6546Vob41dtrTxkI4/cn
 pqm/bo/V4NXa8Ll3oYQUFWCLHJK9y8XDnWR8FNzI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9SBp3tE083876
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Oct 2019 06:51:04 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 28
 Oct 2019 06:51:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 28 Oct 2019 06:51:04 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9SBp1sh105070;
 Mon, 28 Oct 2019 06:51:02 -0500
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <jarkko.nikula@bitmer.com>
Date: Mon, 28 Oct 2019 13:52:07 +0200
Message-ID: <20191028115207.5142-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: tony@atomide.com, alsa-devel@alsa-project.org, arnd@arndb.de
Subject: [alsa-devel] [PATCH] ASoC: ti: sdma-pcm: Add back the flags
	parameter for non standard dma names
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

When non standard names are used it is possible that one of the directions
are not provided, thus the flags needs to be present to tell the core that
we have half duplex setup.

Fixes: 642aafea8889 ("ASoC: ti: remove compat dma probing")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/sdma-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/sdma-pcm.c b/sound/soc/ti/sdma-pcm.c
index a236350beb10..2b0bc234e1b6 100644
--- a/sound/soc/ti/sdma-pcm.c
+++ b/sound/soc/ti/sdma-pcm.c
@@ -62,7 +62,7 @@ int sdma_pcm_platform_register(struct device *dev,
 	config->chan_names[0] = txdmachan;
 	config->chan_names[1] = rxdmachan;
 
-	return devm_snd_dmaengine_pcm_register(dev, config, 0);
+	return devm_snd_dmaengine_pcm_register(dev, config, flags);
 }
 EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
