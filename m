Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C42FC43331
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:06:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19F62084E
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FXkXWokP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19F62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B04981669;
	Tue, 12 Nov 2019 14:05:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B04981669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573563972;
	bh=BvM8cEDtCn/jZ3SV/NJB9lM0Jb8E73IYC6iPtQzVCvM=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FXkXWokP/LBSf06a9zzaVue7WjVuoTq1FOHbT9QmqhqXJac9WKRETi8quPWXpPjir
	 Eu1q1Ev6JM0ugVPbv/m+tWEdl84Unt5zKWgwvxMjxIjfVmPlxR64sfAhaptCS6uh+k
	 IJHUXk53bdpzBSGOeSAgrHY7zqSsIylnpr3Petrg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED1FFF80507;
	Tue, 12 Nov 2019 14:04:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3057BF805FB; Tue, 12 Nov 2019 14:04:39 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC696F8049A;
 Tue, 12 Nov 2019 14:04:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC696F8049A
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Nov 2019 05:04:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,296,1569308400"; d="scan'208";a="234854786"
Received: from pharlozi-hp-elitedesk.igk.intel.com ([10.237.149.38])
 by fmsmga002.fm.intel.com with ESMTP; 12 Nov 2019 05:04:29 -0800
From: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 12 Nov 2019 14:02:37 +0100
Message-Id: <20191112130237.10141-2-pawel.harlozinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112130237.10141-1-pawel.harlozinski@linux.intel.com>
References: <20191112130237.10141-1-pawel.harlozinski@linux.intel.com>
Cc: cezary.rojewski@intel.com, patch@alsa-project.org, tiwai@suse.de,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org,
 Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
Subject: [alsa-devel] [PATCH] ASoC: rt274: Disable jack report IRQ with
	disabling jack
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

When machine driver is unloaded there is nothing to handle
jack detect reports. This were causing flood of messages
from unhandled IRQs.

Signed-off-by: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>

---
 sound/soc/codecs/rt274.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index cbb5e176d11a..993fd365524a 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -408,13 +408,13 @@ static int rt274_mic_detect(struct snd_soc_component *component,
 		/* Disable jack detection */
 		regmap_update_bits(rt274->regmap, RT274_EAPD_GPIO_IRQ_CTRL,
 					RT274_IRQ_EN, RT274_IRQ_DIS);
-
+		disable_irq(rt274->i2c->irq);
 		return 0;
 	}
 
 	regmap_update_bits(rt274->regmap, RT274_EAPD_GPIO_IRQ_CTRL,
 				RT274_IRQ_EN, RT274_IRQ_EN);
-
+	enable_irq(rt274->i2c->irq);
 	/* Send an initial report */
 	rt274_irq(0, rt274);
 
@@ -1197,6 +1197,8 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 				"Failed to reguest IRQ: %d\n", ret);
 			return ret;
 		}
+		/* Gets re-enabled by .set_jack = rt274_mic_detect  */
+		disable_irq(rt274->i2c->irq);
 	}
 
 	ret = devm_snd_soc_register_component(&i2c->dev,
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
