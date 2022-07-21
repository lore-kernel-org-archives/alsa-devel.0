Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DFBC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jul 2022 10:46:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04DB91709;
	Thu, 21 Jul 2022 12:45:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04DB91709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658400396;
	bh=TBTg02g2tOF18yYp/Ys9qqntrVmgY0GA4/G7cyO0Ka0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bw4FzuY7xSXgZdsrmwPtpNr36NR4n+jrhAoT7Yu4PrR/SGU0dbUjAZK4wc5Ih7TCm
	 7Q9Jv5JoDo9h0Q8X9bZ9mtpkNAZdeNIj3y68MeQa9EZD3BkEvX8zarSd4lJ1MrJ3JX
	 lxGWN+KtL06O9KwBuVAfCXp1xmR4Y7Wbg1CUp8js=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7ED4CF8047C;
	Thu, 21 Jul 2022 12:45:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF0A2F80256; Thu, 21 Jul 2022 12:45:43 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A91FF80166
 for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2022 12:45:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A91FF80166
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B0EE32038F8;
 Thu, 21 Jul 2022 12:45:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A5082038F6;
 Thu, 21 Jul 2022 12:45:40 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F280E180222B;
 Thu, 21 Jul 2022 18:45:38 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH v2 -next 0/5] ASoC: fsl: Fix sparse warning
Date: Thu, 21 Jul 2022 18:29:48 +0800
Message-Id: <1658399393-28777-1-git-send-email-shengjiu.wang@nxp.com>
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

Fix sparse warning

changes in v2:
- use pcm_format_to_bits
- use u32 asrc_fmt, then convert it to snd_pcm_format_t

Shengjiu Wang (5):
  ASoC: fsl_sai: Don't use plain integer as NULL pointer
  ASoC: fsl_asrc: force cast the asrc_format type
  ASoC: fsl-asoc-card: force cast the asrc_format type
  ASoC: fsl_easrc: use snd_pcm_format_t type for sample_format
  ASoC: imx-card: use snd_pcm_format_t type for asrc_format

 sound/soc/fsl/fsl-asoc-card.c | 5 +++--
 sound/soc/fsl/fsl_asrc.c      | 6 ++++--
 sound/soc/fsl/fsl_easrc.c     | 9 ++++++---
 sound/soc/fsl/fsl_easrc.h     | 2 +-
 sound/soc/fsl/fsl_sai.c       | 2 +-
 sound/soc/fsl/imx-card.c      | 8 +++++---
 6 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.34.1

