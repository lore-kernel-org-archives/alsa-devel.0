Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CA0C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:09:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF75A2068E
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kw1WugJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF75A2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A9FF17A7;
	Thu, 21 Nov 2019 20:08:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A9FF17A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574363389;
	bh=9e1N6XdpLBbE8LiN3+klGQ0XRs3ZiCIZaDrbAOPhcrI=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kw1WugJLoGmtd9ElEaTEQiM3tYeHIkhSInLvYgEmtBmYaeI0/42wL4bCXzTfhCeBi
	 rLo8OghVb8a1d3x1iGGn2HUHX2UwkCDmdVqi93L1LVXFJhhI4sYXdj0bMiZYcKeUn4
	 NJvMSvU/kaguev9bR5uLAEJTjYB/RDQoztHR1bSg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EDD8F80150;
	Thu, 21 Nov 2019 20:07:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10222F8014F; Thu, 21 Nov 2019 20:07:20 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46C7BF80146
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 20:07:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46C7BF80146
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4A67CAE52;
 Thu, 21 Nov 2019 19:07:11 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Thu, 21 Nov 2019 20:07:08 +0100
Message-Id: <20191121190709.29121-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191121190709.29121-1-tiwai@suse.de>
References: <20191121190709.29121-1-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 1/2] ASoC: pcm: Make ioctl ops optional
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

Now PCM core accepts the NULL ioctl ops as default, and passing a proper
ioctl ops is no longer mandatory.  Adjust soc_new_pcm() to allow also
the NULL for component ioctl ops, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 493a2e80e893..4dd13c9249ab 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -3005,7 +3005,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 		rtd->ops.hw_free	= dpcm_fe_dai_hw_free;
 		rtd->ops.close		= dpcm_fe_dai_close;
 		rtd->ops.pointer	= soc_pcm_pointer;
-		rtd->ops.ioctl		= snd_soc_pcm_component_ioctl;
 	} else {
 		rtd->ops.open		= soc_pcm_open;
 		rtd->ops.hw_params	= soc_pcm_hw_params;
@@ -3014,12 +3013,13 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 		rtd->ops.hw_free	= soc_pcm_hw_free;
 		rtd->ops.close		= soc_pcm_close;
 		rtd->ops.pointer	= soc_pcm_pointer;
-		rtd->ops.ioctl		= snd_soc_pcm_component_ioctl;
 	}
 
 	for_each_rtd_components(rtd, rtdcom, component) {
 		const struct snd_soc_component_driver *drv = component->driver;
 
+		if (drv->ioctl)
+			rtd->ops.ioctl		= snd_soc_pcm_component_ioctl;
 		if (drv->copy_user)
 			rtd->ops.copy_user	= snd_soc_pcm_component_copy_user;
 		if (drv->page)
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
