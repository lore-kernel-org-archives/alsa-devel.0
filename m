Return-Path: <SRS0=oqyN=5V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E6EC2BA15
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Apr 2020 15:43:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312EA20675
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Apr 2020 15:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jI/D0SSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312EA20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D2301607;
	Sun,  5 Apr 2020 17:42:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D2301607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586101411;
	bh=OKeC7ejWJlug9X28zlkb45D9xBuAtfgyZsOBex6QvwA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jI/D0SSnI50TCzeXboR+Xh0Nna0nCgt0b+bHn2Z/cdgOtYc81N6+K1Y8pob1NtPOt
	 cuenRa47sus6Ep29Ipl7bpJP5YbCUBFecu0XP9IGKs1CSje7F32hPhfOK7HrzFUco1
	 ncx3NTcVqx1GxK7XutogXB2TaWUaaTRkC7mq6gzw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFAD6F8015A;
	Sun,  5 Apr 2020 17:42:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 060EBF801D8; Sun,  5 Apr 2020 17:42:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06690F800E4
 for <alsa-devel@alsa-project.org>; Sun,  5 Apr 2020 17:42:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06690F800E4
X-IronPort-AV: E=Sophos;i="5.72,348,1580770800"; d="scan'208";a="443899687"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256;
 05 Apr 2020 17:42:31 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH] ASoC: stm32: sai: Add missing cleanup
Date: Sun,  5 Apr 2020 17:03:48 +0200
Message-Id: <1586099028-5104-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@st.com>, kernel-janitors@vger.kernel.org,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
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

The commit 0d6defc7e0e4 ("ASoC: stm32: sai: manage rebind issue")
converts some function calls to their non-devm equivalents.  The
appropriate cleanup code was added to the remove function, but not
to the probe function.  Add a call to snd_dmaengine_pcm_unregister
to compensate for the call to snd_dmaengine_pcm_register in case
of subsequent failure.

Fixes: commit 0d6defc7e0e4 ("ASoC: stm32: sai: manage rebind issue")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---

Not tested.

 sound/soc/stm/stm32_sai_sub.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 2bd280c..0d0c9af 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1556,8 +1556,10 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_component,
 					 &sai->cpu_dai_drv, 1);
-	if (ret)
+	if (ret) {
+		snd_dmaengine_pcm_unregister(&pdev->dev);
 		return ret;
+	}
 
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
 		conf = &stm32_sai_pcm_config_spdif;

