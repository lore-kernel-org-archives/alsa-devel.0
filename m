Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F068C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 06:19:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04344208E4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 06:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tm8XpSYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04344208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EAF14827;
	Thu, 17 Sep 2020 08:18:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EAF14827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600323550;
	bh=y4a3zH/awHsKpyhgq6tcgl1W4Rf9ojGkvhCihYXhJ3Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tm8XpSYQaCOEu0ui/tJUj8clWlCrIowBRKy6PAf9ABNtctBQgaTi5Dv/NpqAm/3v+
	 gdddaUe9Zgt1gwt6Rr8TNXSG10zZn9QurtbBPIaor0hamUazMQItvYN1aF9YZRjUbP
	 2bHJl6DD/FPIKKmXFg8aqSm/KB4oex6clzS3+K+Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B8C3F8025E;
	Thu, 17 Sep 2020 08:18:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEB24F80276; Thu, 17 Sep 2020 08:18:17 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9FDAAF800E8
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 08:18:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9FDAAF800E8
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CA8A200C65;
 Thu, 17 Sep 2020 08:18:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 286EB2000FF;
 Thu, 17 Sep 2020 08:18:06 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3CB73402C3;
 Thu, 17 Sep 2020 08:18:00 +0200 (CEST)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com
Subject: [PATCH v2 0/3] ASoC: fsl_sai: update the register list
Date: Thu, 17 Sep 2020 14:11:16 +0800
Message-Id: <1600323079-5317-1-git-send-email-shengjiu.wang@nxp.com>
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

As sai ip is upgraded, so update sai register list.

Shengjiu Wang (3):
  ASoC: fsl_sai: Add new added registers and new bit definition
  ASoC: fsl_sai: Add fsl_sai_check_version function
  ASoC: fsl_sai: Set MCLK input or output direction

changes in v2:
- update commit message for first commit
- Add acked-by Nicolin

 sound/soc/fsl/fsl_sai.c | 77 ++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_sai.h | 87 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

-- 
2.27.0

