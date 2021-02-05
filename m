Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CA0C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 07:38:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8865A64F3C
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 07:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8865A64F3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86FA0852;
	Fri,  5 Feb 2021 08:37:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86FA0852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612510712;
	bh=gEalmXNM1g5ccgQk7FnpawHlXE4W0cptxm4RGveUz6w=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q4GvuMsWOPGuU6kbYaWeOCLW/hV8mLre+Eewl32t6jFaazfaQObRvoRcAqnsqYo4P
	 rRIOPwL86zHQKyvhAuzWxN9TQ0RUCvD9AlhTukKlTkRrgVPko/mVLxQN/0BWe8bpH+
	 NPHYo5KgR8nQyHm8sCU+eYk3LNcoZKmr3x7jrlo4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A2DDF80156;
	Fri,  5 Feb 2021 08:37:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1DB2F8015A; Fri,  5 Feb 2021 08:37:40 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86DDCF800C0
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 08:37:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86DDCF800C0
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2452E1A01E1;
 Fri,  5 Feb 2021 08:37:32 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7410B1A1476;
 Fri,  5 Feb 2021 08:37:29 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C7911402B7;
 Fri,  5 Feb 2021 08:37:25 +0100 (CET)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 broonie@kernel.org
Subject: [RESEND PATH] ASoC: dmaengine_pcm: add peripheral configuration
Date: Fri,  5 Feb 2021 15:26:25 +0800
Message-Id: <1612509985-11063-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
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

The commit e7bbb7acabf4 ("dmaengine: add peripheral configuration")
adds peripheral configuration for dma_slave_config.

This configuration is useful for some audio peripherals, for
example, the peripheral supports multi fifos, we can
let the DMA know which fifos are selected. So also add
this configuration for snd_dmaengine_dai_dma_data.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/dmaengine_pcm.h | 5 +++++
 sound/core/pcm_dmaengine.c    | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 8c5e38180fb0..96666efddb39 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -66,6 +66,9 @@ struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
  * @chan_name: Custom channel name to use when requesting DMA channel.
  * @fifo_size: FIFO size of the DAI controller in bytes
  * @flags: PCM_DAI flags, only SND_DMAENGINE_PCM_DAI_FLAG_PACK for now
+ * @peripheral_config: peripheral configuration for programming peripheral
+ * for dmaengine transfer
+ * @peripheral_size: peripheral configuration buffer size
  */
 struct snd_dmaengine_dai_dma_data {
 	dma_addr_t addr;
@@ -76,6 +79,8 @@ struct snd_dmaengine_dai_dma_data {
 	const char *chan_name;
 	unsigned int fifo_size;
 	unsigned int flags;
+	void *peripheral_config;
+	size_t peripheral_size;
 };
 
 void snd_dmaengine_pcm_set_config_from_dai_data(
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 4d0e8fe535a1..1fc2fa077574 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -125,6 +125,8 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
 	}
 
 	slave_config->slave_id = dma_data->slave_id;
+	slave_config->peripheral_config = dma_data->peripheral_config;
+	slave_config->peripheral_size = dma_data->peripheral_size;
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
 
-- 
2.27.0

