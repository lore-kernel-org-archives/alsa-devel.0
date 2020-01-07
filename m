Return-Path: <SRS0=M4Y+=24=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35192C33C99
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:11:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342CC207FD
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rvjLQqrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342CC207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01F501800;
	Tue,  7 Jan 2020 08:10:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01F501800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578381062;
	bh=+vO552ftNE2O01MeOEasxWcYafGPPfhhppde1m5RUXc=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rvjLQqrxAyg7Sq0ojDhge8jgx6RPSgKaKRVNkZEamBvNTAMtZfwlmzc40x2rptJRL
	 BgXMhvNO/ZWq1l5OdCOBkTtWxvmAuIoZhlbItvroV3/4HJldxDv1MK4ZdB1hk/RDvj
	 ng2bA7T1tVHlg3111IpiOWkSyqDJR7Zlq2DjbV0E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B9A3F80140;
	Tue,  7 Jan 2020 08:10:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5F0FF8014A; Tue,  7 Jan 2020 08:10:09 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9D4BF80116
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2020 08:10:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9D4BF80116
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 072B3AD20;
 Tue,  7 Jan 2020 07:10:04 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Tue,  7 Jan 2020 08:09:56 +0100
Message-Id: <20200107070956.15807-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Ben Ho <Ben.Ho@mediatek.com>,
 linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [alsa-devel] [PATCH] ASoC: Fix NULL dereference at freeing
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

When an ASoC driver with pcm_destruct component ops is freed before
the PCM object instantiation (e.g. deferring the probe), it hits an
Oops at snd_soc_pcm_component_free() that calls the pcm_destruct ops
unconditionally.

Fix it by adding a NULL-check of rtd->pcm before calling callbacks.

Fixes: c64bfc906600 ("ASoC: soc-core: add new pcm_construct/pcm_destruct")
Reported-by: Matthias Brugger <matthias.bgg@gmail.com>
Tested-by: Ben Ho <ben.ho@mediatek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-component.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index 9054558ce386..b94680fb26fa 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -539,6 +539,9 @@ void snd_soc_pcm_component_free(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_component *component;
 
+	if (!rtd->pcm)
+		return;
+
 	for_each_rtd_components(rtd, rtdcom, component)
 		if (component->driver->pcm_destruct)
 			component->driver->pcm_destruct(component, rtd->pcm);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
