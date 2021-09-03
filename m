Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6396CC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457B260F21
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 457B260F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 082DB17E3;
	Fri,  3 Sep 2021 12:52:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 082DB17E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630666420;
	bh=vRsPkS5ZlwYEGTuk39PEx3iXm4yDarIe4yir8DDWSBs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rhfc0ZyKFV0d6OUwp1QoUiEV0msvjl6pGdRZ4iNiEt0byCStHVxNyZKrRTaDgYDdE
	 qSt01u/AOe+O8MUHY1VfME/NAeE+U0Shj7xftJ381QqFMUY36Su/8ayJze4Qro/HA0
	 jlNhO1TP+5X7xg+XlyMsyxP+xz5bt63WhFgiy1MQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79441F80254;
	Fri,  3 Sep 2021 12:52:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10225F80256; Fri,  3 Sep 2021 12:52:48 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D0A4F80088
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 12:52:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D0A4F80088
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2FD5E1A301E;
 Fri,  3 Sep 2021 12:52:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ECEA21A3028;
 Fri,  3 Sep 2021 12:52:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 87113183AC8B;
 Fri,  3 Sep 2021 18:52:42 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH for-5.15 0/5] ASoC: fsl: register platform component before
 registering cpu dai
Date: Fri,  3 Sep 2021 18:30:01 +0800
Message-Id: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

There is no defer probe when adding platform component to
snd_soc_pcm_runtime(rtd), the code is in snd_soc_add_pcm_runtime()

snd_soc_register_card()
  -> snd_soc_bind_card()
    -> snd_soc_add_pcm_runtime()
      -> adding cpu dai
      -> adding codec dai
      -> adding platform component.

So if the platform component is not ready at that time, then the
sound card still registered successfully, but platform component
is empty, the sound card can't be used.

As there is defer probe checking for cpu dai component, then register
platform component before cpu dai to avoid such issue.

This patch set is to fix this issue for SAI, ESAI, MICFIL, SPDIF,
XCVR drivers.

Shengjiu Wang (5):
  ASoC: fsl_sai: register platform component before registering cpu dai
  ASoC: fsl_esai: register platform component before registering cpu dai
  ASoC: fsl_micfil: register platform component before registering cpu
    dai
  ASoC: fsl_spdif: register platform component before registering cpu
    dai
  ASoC: fsl_xcvr: register platform component before registering cpu dai

 sound/soc/fsl/fsl_esai.c   | 16 ++++++++++------
 sound/soc/fsl/fsl_micfil.c | 15 ++++++++++-----
 sound/soc/fsl/fsl_sai.c    | 14 +++++++++-----
 sound/soc/fsl/fsl_spdif.c  | 14 +++++++++-----
 sound/soc/fsl/fsl_xcvr.c   | 15 ++++++++++-----
 5 files changed, 48 insertions(+), 26 deletions(-)

-- 
2.17.1

