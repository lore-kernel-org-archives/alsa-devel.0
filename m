Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D22C2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 01:38:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EE56140F
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 01:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EE56140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD95E168B;
	Tue, 15 Jun 2021 03:38:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD95E168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623721130;
	bh=Vp+MQR/1NmN8O+iA5nmUWgDSSI/Y0X8Rd02xYSjMc9M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lJQLspZAIiPYvZqEbj6fFXTOlOBduQrvgatj9WaWWwv5fJc67sq3dU7jjmdCrMKUU
	 Qgl66o+BN73eKMGwMeL9pR9k0s+BbqC00D2EFVFbDcHfwB3+G3QJ9Gu0jSadVYQQJz
	 F8zY0GH2NdDVa5ttTTs27KnR6Eb6hOLSIKNg9m20=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9FE8F804E2;
	Tue, 15 Jun 2021 03:35:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7ACDBF8028B; Tue, 15 Jun 2021 03:35:44 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4FD5F804C2
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 03:35:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4FD5F804C2
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G3rNg31Shz1BMYl;
 Tue, 15 Jun 2021 09:30:27 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:35:25 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 09:35:24 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <alsa-devel@alsa-project.org>
Subject: [PATCH -next v2 0/9] ASoC: fsl: Use
 devm_platform_get_and_ioremap_resource()
Date: Tue, 15 Jun 2021 09:39:13 +0800
Message-ID: <20210615013922.784296-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Cc: broonie@kernel.org, timur@kernel.org
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

patch #1 ~ #8:
  Use devm_platform_get_and_ioremap_resource()

patch #9
  check return value of platform_get_resource_byname()

v2:
  change error message in patch #9

Yang Yingliang (9):
  ASoC: fsl_asrc: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_aud2htx: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_easrc: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_esai: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_micfil: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_sai: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_spdif: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_ssi: Use devm_platform_get_and_ioremap_resource()
  ASoC: fsl_xcvr: check return value after calling
    platform_get_resource_byname()

 sound/soc/fsl/fsl_asrc.c    | 3 +--
 sound/soc/fsl/fsl_aud2htx.c | 3 +--
 sound/soc/fsl/fsl_easrc.c   | 3 +--
 sound/soc/fsl/fsl_esai.c    | 3 +--
 sound/soc/fsl/fsl_micfil.c  | 3 +--
 sound/soc/fsl/fsl_sai.c     | 3 +--
 sound/soc/fsl/fsl_spdif.c   | 3 +--
 sound/soc/fsl/fsl_ssi.c     | 3 +--
 sound/soc/fsl/fsl_xcvr.c    | 4 ++++
 9 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.25.1

