Return-Path: <SRS0=0Fuw=ZA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E00C5DF60
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:52:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C59521D6C
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FkHp3e9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C59521D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DC33168C;
	Fri,  8 Nov 2019 10:51:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DC33168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573206758;
	bh=2yNNRgDwAT20ua6gjmGyXJwVP83kl/CmMPV4zUU+14g=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FkHp3e9dhCxH/0IBwVbTavC+p9WWI7PNk0iQ+NIpsgF4rQklxPWfPlo77y+HDEB0+
	 EV7mKOxbjhCNnPN+bsC9gDsmOTz8ALFuJcKUfgmiHCA0m1488f0ZGF9W11wG+DffnZ
	 EAhvNgAEliHkckdyHrZcDUn9bh0VHeO2shxuaSd0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FF95F80634;
	Fri,  8 Nov 2019 10:49:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1F4DF803D0; Fri,  8 Nov 2019 10:48:18 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6CAE5F8048D
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 10:46:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CAE5F8048D
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D93B3AD77;
 Fri,  8 Nov 2019 09:46:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  8 Nov 2019 10:46:38 +0100
Message-Id: <20191108094641.20086-6-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191108094641.20086-1-tiwai@suse.de>
References: <20191108094641.20086-1-tiwai@suse.de>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Curtis Malainey <cujomalainey@chromium.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [alsa-devel] [PATCH 5/8] ASoC: SOF: Drop superfluous
	snd_pcm_sgbuf_ops_page
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

snd_pcm_sgbuf_ops_page is no longer needed to be set explicitly to PCM
page ops since the recent change in the PCM core (*).  Leaving it NULL
should work as long as the preallocation has been done properly.

This patch drops the redundant lines.

(*) 7e8edae39fd1: ALSA: pcm: Handle special page mapping in the
                  default mmap handler

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/sof/pcm.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 3d5cd1b445ba..549238a98b2a 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -454,17 +454,6 @@ static snd_pcm_uframes_t sof_pcm_pointer(struct snd_soc_component *component,
 	return host;
 }
 
-#ifdef CONFIG_SND_DMA_SGBUF
-static struct page *sof_pcm_page(struct snd_soc_component *component,
-				 struct snd_pcm_substream *substream,
-				 unsigned long offset)
-{
-	return snd_pcm_sgbuf_ops_page(substream, offset);
-}
-#else
-#define sof_pcm_page	NULL
-#endif /* CONFIG_SND_DMA_SGBUF */
-
 static int sof_pcm_open(struct snd_soc_component *component,
 			struct snd_pcm_substream *substream)
 {
@@ -788,7 +777,6 @@ void snd_sof_new_platform_drv(struct snd_sof_dev *sdev)
 	pd->hw_free = sof_pcm_hw_free;
 	pd->trigger = sof_pcm_trigger;
 	pd->pointer = sof_pcm_pointer;
-	pd->page = sof_pcm_page;
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_COMPRESS)
 	pd->compr_ops = &sof_compressed_ops;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
