Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA043C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jun 2022 05:55:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E2F316A9;
	Thu, 30 Jun 2022 07:54:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E2F316A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656568512;
	bh=btuff1inIAcxTvAkvp3AeUQ3zqV732wrwpFF4cdifhY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t7WUa/WuauPuGU8R9QkUkvFmHqlMvFIJ2mBl338HkVhyj93+fob2lAHczJ5KbrZmt
	 4x0XmTK7qRcgqQZeNrfmd9/Rp1WUGsGLAVmL6EEnPFw74Vd4xTYJ++HF0ckmeAmQDA
	 ZVQ4fqRmmUr5jkE1YMYBs7b6i5cPEXkCSTWOFtgk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BC03F8052D;
	Thu, 30 Jun 2022 07:54:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B05BF804EB; Thu, 30 Jun 2022 07:54:19 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAE57F80107
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2022 07:54:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AAE57F80107
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 013051A09D4;
 Thu, 30 Jun 2022 07:54:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B84B71A06F8;
 Thu, 30 Jun 2022 07:54:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E7FC2180222C;
 Thu, 30 Jun 2022 13:54:10 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/6] Add support of two Audio PLL source
Date: Thu, 30 Jun 2022 13:39:08 +0800
Message-Id: <1656567554-32122-1-git-send-email-shengjiu.wang@nxp.com>
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

i.MX8MQ/MN/MM/MP platforms typically have 2 AUDIO PLLs being
configured to handle 8kHz and 11kHz series audio rates.

The patches implement the functionality to select at runtime
the appropriate AUDIO PLL for root clock, if there is no
two PLL registered, then no action taken.

Shengjiu Wang (6):
  ASoC: fsl_utils: Add function to handle PLL clock source
  ASoC: fsl_spdif: Add support for PLL switch at runtime.
  ASoC: fsl_micfil: Add support for PLL switch at runtime
  ASoC: fsl_sai: Add support for PLL switch at runtime
  ASoC: dt-bindings: fsl_spdif: Add two PLL clock source
  ASoC: dt-bindings: fsl-sai: Add two PLL clock source

 .../devicetree/bindings/sound/fsl,spdif.yaml  |  4 ++
 .../devicetree/bindings/sound/fsl-sai.txt     |  3 +
 sound/soc/fsl/Kconfig                         |  3 +
 sound/soc/fsl/fsl_micfil.c                    | 41 +++++++++++
 sound/soc/fsl/fsl_sai.c                       | 54 +++++++++++++++
 sound/soc/fsl/fsl_sai.h                       |  2 +
 sound/soc/fsl/fsl_spdif.c                     | 57 +++++++++++++--
 sound/soc/fsl/fsl_utils.c                     | 69 +++++++++++++++++++
 sound/soc/fsl/fsl_utils.h                     |  9 +++
 9 files changed, 237 insertions(+), 5 deletions(-)

-- 
2.17.1

