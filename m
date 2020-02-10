Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EC4C352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:10:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0264220714
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lfLxTw76";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x7QuikBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0264220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50F8A16C9;
	Mon, 10 Feb 2020 15:10:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50F8A16C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581343852;
	bh=+XHIWxZMGJ2NIOU5fWzLfUorOyf2EaCnKknqHgab89s=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lfLxTw767+DtXoinX5vyVw49HPTr0/D3ZvaWoWc1Xz+xM5UBD7JbllNIbKyVLb4oD
	 NGhs2bLzR/pDreWdq4/rJoRfCT4nNJRyWoLoHHKY0jK7tQLOikV2J40iWUC7DH2ryw
	 3JameTh9LqBsITokjjFI5SWMfDhrWv6khV7i3sEs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 357FAF8020B;
	Mon, 10 Feb 2020 15:09:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E724DF80158; Mon, 10 Feb 2020 15:09:54 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1945AF800E7
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 15:09:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1945AF800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x7QuikBu"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01AE9nqD042976;
 Mon, 10 Feb 2020 08:09:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1581343789;
 bh=5SWEDjV8RjZqu6QNQ9A81HKRSvkfZXZG5JQT8OU6c7s=;
 h=From:To:CC:Subject:Date;
 b=x7QuikBu7HLkdaKpnAPF/NcI0hr2JXXAgqUr8ghZ2ryUDDwODDqdFYNkaxT0hwuuu
 GyquK0ooCLwa0O9omxxVIm+GmNmBlNW5gw+2rQ4Yd0GCwhDGkE3LD9NMEUvW8crEsn
 LMMZhKUx5TG4aTMaNUCjRk4ZDT+OIdmFOpojprLM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01AE9nLX095987
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2020 08:09:49 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 08:09:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 08:09:49 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01AE9lrt046182;
 Mon, 10 Feb 2020 08:09:48 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Date: Mon, 10 Feb 2020 16:09:48 +0200
Message-ID: <20200210140950.11090-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 0/2] ASoC: ti: Support for TI K3 family of
	devices
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

K3 devices (am654 and j721e) have UDMAP as system DMA and McASP for audio
interface.

5.6-rc1 includes the DMA support.
This series will enable the audio support for devices using UDMAP.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: ti: Add udma-pcm platform driver for UDMA
  ASoC: ti: davinci-mcasp: Add support for platforms using UDMA

 sound/soc/ti/Kconfig         |  8 ++++++-
 sound/soc/ti/Makefile        |  2 ++
 sound/soc/ti/davinci-mcasp.c |  7 ++++++
 sound/soc/ti/udma-pcm.c      | 43 ++++++++++++++++++++++++++++++++++++
 sound/soc/ti/udma-pcm.h      | 18 +++++++++++++++
 5 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/ti/udma-pcm.c
 create mode 100644 sound/soc/ti/udma-pcm.h

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
