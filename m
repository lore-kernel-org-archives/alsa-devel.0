Return-Path: <SRS0=rTHd=XI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07646C4CEC9
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Sep 2019 19:30:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9F5206A5
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Sep 2019 19:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MveQk9Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9F5206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D371E166C;
	Fri, 13 Sep 2019 21:29:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D371E166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568403006;
	bh=D3ZpRR2fhkoF6k9QS+qquQBNIUPaIJsMrT8ZIXRznaA=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MveQk9TmdVac0DeWjeSh6ZFyexu/qthtC2DxXMpbuI8wmsHNl7ZIz6qjf43Ys00QB
	 xonGGQm1J9ZMYG6M0hkdRGQtOcHMDuyQFLm+sU6U4UV1DAxmNEZo7f4oXK8tTG4hBq
	 Arr4cP1FwX2QEA0LBQTAqW65JVR6z5hUbPMf19ms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C029BF804FD;
	Fri, 13 Sep 2019 21:28:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04300F804AB; Fri, 13 Sep 2019 21:28:16 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F827F80143
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2019 21:28:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F827F80143
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 90E1A1A016E;
 Fri, 13 Sep 2019 21:28:10 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 843F71A00D0;
 Fri, 13 Sep 2019 21:28:10 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net
 (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 02806205DB;
 Fri, 13 Sep 2019 21:28:09 +0200 (CEST)
From: Daniel Baluta <daniel.baluta@nxp.com>
To: broonie@kernel.org
Date: Fri, 13 Sep 2019 22:28:04 +0300
Message-Id: <20190913192807.8423-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: Daniel Baluta <daniel.baluta@nxp.com>, alsa-devel@alsa-project.org,
 timur@kernel.org, Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, nicoleotsuka@gmail.com,
 festevam@gmail.com
Subject: [alsa-devel] [PATCH v2 0/3] Several SAI fixes
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

This series contains several fixes for SAI. They are unrelated
but grouped them in a patch series to be easier applied.

Daniel Baluta (1):
  ASoC: fsl_sai: Fix TCSR.TE/RCSR.RE in synchronous mode

Mihai Serban (1):
  ASoC: fsl_sai: Fix noise when using EDMA

Shengjiu Wang (1):
  ASoC: fsl_sai: Fix xMR setting in synchronous mode

 sound/soc/fsl/fsl_sai.c | 31 ++++++++++++++++++++++---------
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
