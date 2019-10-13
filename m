Return-Path: <SRS0=GSx5=YG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255E5C4360C
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Oct 2019 19:01:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B12A20679
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Oct 2019 19:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iK3qDqjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B12A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C677A950;
	Sun, 13 Oct 2019 21:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C677A950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570993273;
	bh=AUaJ7DCYxoLNK/jTptawUcvxYO6Jwc22snUW/ZMaLmc=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iK3qDqjdcXProMzUzCqZVMc4NQXznJe3TV9GUjX0edtwvXYyKopmnE7GtW5GdDt2O
	 qDC+kDFyz/PGEvZHPz3IGmWLs09UBA9xy4D7WnU/ZXeGfdOcyIENxxUSHu6WQxI3ty
	 he88hjzNBnrT+ijIQBtyup2G1+3mxqPvnZldDQBM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08E66F80369;
	Sun, 13 Oct 2019 21:00:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38B8DF80322; Sun, 13 Oct 2019 21:00:21 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 781B1F80322
 for <alsa-devel@alsa-project.org>; Sun, 13 Oct 2019 21:00:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 781B1F80322
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2682F20031D;
 Sun, 13 Oct 2019 21:00:16 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 23BF120014F;
 Sun, 13 Oct 2019 21:00:16 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net
 (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 761BC20624;
 Sun, 13 Oct 2019 21:00:15 +0200 (CEST)
From: Daniel Baluta <daniel.baluta@nxp.com>
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
 kuninori.morimoto.gx@renesas.com
Date: Sun, 13 Oct 2019 22:00:12 +0300
Message-Id: <20191013190014.32138-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-imx@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [alsa-devel] [RFC PATCH 0/2] Introduce for-dpcm DT property
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

We need to be able to create DPCM links even if we have a single CPU DAI
or just a dummy CPU DAI.

Daniel Baluta (2):
  ASoC: simple-card: Introduce force-dpcm DT property
  ASoC: simple-card: Add documentation for force-dpcm property

 .../devicetree/bindings/sound/simple-card.txt |  1 +
 include/sound/simple_card_utils.h             |  4 +++
 sound/soc/generic/simple-card-utils.c         | 17 +++++++++++++
 sound/soc/generic/simple-card.c               | 25 +++++++++++++++++--
 4 files changed, 45 insertions(+), 2 deletions(-)

-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
