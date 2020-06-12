Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC20EC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 07:49:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CB8207ED
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 07:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KP7GqlM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CB8207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC3531676;
	Fri, 12 Jun 2020 09:48:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC3531676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591948183;
	bh=4ciDqPJ0syEMdiCSd88hyKAcRLpGLyR/XZiR+/geoGM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KP7GqlM1BdM5c4dns66dvpOBKt0uo+FtRVKC4bvg/0b8moEINTwKlvA2W1OUhSiKw
	 wpoPTy9dr/vvePRgAkvSOmfin3svYNKFer9yc/Aa23rz6nG7oWxUBowcC6DdfSFjFr
	 exyY/f3vQYSbJlX8fZM/qEaxvGADgP42oG1MsumI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05B9FF800C7;
	Fri, 12 Jun 2020 09:48:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2635F800C7; Fri, 12 Jun 2020 09:48:51 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB4B3F800C7
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 09:48:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB4B3F800C7
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 77AE61A0B5F;
 Fri, 12 Jun 2020 09:48:47 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8EB311A0B5E;
 Fri, 12 Jun 2020 09:48:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3FBAA402D3;
 Fri, 12 Jun 2020 15:48:36 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lars@metafoo.de, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, festevam@gmail.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 0/4] Reuse the dma channel if available in Back-End
Date: Fri, 12 Jun 2020 15:37:47 +0800
Message-Id: <cover.1591947428.git.shengjiu.wang@nxp.com>
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

Reuse the dma channel if available in Back-End

Shengjiu Wang (4):
  ASoC: soc-card: export snd_soc_lookup_component_nolocked
  ASoC: dmaengine_pcm: export soc_component_to_pcm
  ASoC: fsl_asrc_dma: Reuse the dma channel if available in Back-End
  ASoC: fsl_asrc_dma: Fix data copying speed issue with EDMA

changes in v3:
- update according to Nicolin's comments
- split previous 0003 patch to two patches

changes in v2:
- update according to Mark's comments and split the patch

 include/sound/dmaengine_pcm.h         | 11 +++++++
 include/sound/soc.h                   |  2 ++
 sound/soc/fsl/fsl_asrc_common.h       |  2 ++
 sound/soc/fsl/fsl_asrc_dma.c          | 47 +++++++++++++++++++--------
 sound/soc/soc-core.c                  |  3 +-
 sound/soc/soc-generic-dmaengine-pcm.c | 12 -------
 6 files changed, 50 insertions(+), 27 deletions(-)

-- 
2.21.0

