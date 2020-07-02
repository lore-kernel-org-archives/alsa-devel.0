Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54525C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:01:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1ECB20885
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aGX9RzuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1ECB20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A82816D2;
	Thu,  2 Jul 2020 19:00:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A82816D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593709265;
	bh=cr+VvBHnPzmryAljzb81/26NXCYKhDn4hLqGQsIDiNI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aGX9RzuCt3J8mRbNGGrSIgDR2Ifst9AZTcd5Jhofci5/AciIiE4lx86Dc3Bt3V0Io
	 PkCMiIyn0swwz4PdR4QjFUlGCBP/1qDo58Yrv7AsUi6E26b40bvY8jrEFCmn7XbmEf
	 qiK9kHMP4b5OmqCol6AlGcuh04HpiA4ithiSlAYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E46BF8022D;
	Thu,  2 Jul 2020 18:59:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCBA7F802BC; Thu,  2 Jul 2020 18:59:23 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C432F800C1
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 18:59:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C432F800C1
IronPort-SDR: OdGpCk2ABjnxYUlEFju7EzCoQQ5CxElYCqnZtZGGYhog5kIy/niTLrM14qcpM80eCu/4gl04fk
 hk5VDyz9w4BA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="126583256"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="126583256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:59:14 -0700
IronPort-SDR: 9mpoW28nlvswRk4tGoP5yhadeIfybkNCkh+pHtUoF1yDhJ5DNtvqihrsfp41GPhxH0JnjPu6kM
 EWhcGOe2XmqA==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="426014841"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:59:13 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/8] ASoC: atmel: fix kernel-doc
Date: Thu,  2 Jul 2020 11:58:54 -0500
Message-Id: <20200702165901.164100-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>, broonie@kernel.org,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 "moderated list:ARM/Microchip AT91 SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
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

Fix W=1 warning

Kernel-doc is not used in one file and missing argument in the second.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/atmel/atmel-pcm-dma.c | 2 +-
 sound/soc/atmel/atmel_ssc_dai.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index cb03c4f7324c..0a2e956232af 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -44,7 +44,7 @@ static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
 	.buffer_bytes_max	= 512 * 1024,
 };
 
-/**
+/*
  * atmel_pcm_dma_irq: SSC interrupt handler for DMAENGINE enabled SSC
  *
  * We use DMAENGINE to send/receive data to/from SSC so this ISR is only to
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 0f18dfb85bfe..6a63e8797a0b 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -887,6 +887,7 @@ static int asoc_ssc_init(struct device *dev)
 
 /**
  * atmel_ssc_set_audio - Allocate the specified SSC for audio use.
+ * @ssc_id: SSD ID in [0, NUM_SSC_DEVICES[
  */
 int atmel_ssc_set_audio(int ssc_id)
 {
-- 
2.25.1

