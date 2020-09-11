Return-Path: <SRS0=2sca=CU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1561BC43461
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:21:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618A7221EE
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NcJVqWVf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=st.com header.i=@st.com header.b="XKuj/FAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618A7221EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D0E21668;
	Fri, 11 Sep 2020 11:20:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D0E21668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599816081;
	bh=zSIN3tuGPgnprggFieabZse1yQesiWyDa4V9nPqNHKc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NcJVqWVfApj05CGkwqMvtA+/k3WLGrZmQkDpRAHKzuk3xS3u0hjiyjgLnVLmVDwdw
	 /1rf+8DDBgTFGTfMnJX+g0iZxMscaHNTIdfpmAsQzYYVlZnx4xL2yzDLQMsKNmvnso
	 T8s8EbHBRyuAgeHe8wAqul+L3IhPUnlQerKuJMdU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE54CF8021C;
	Fri, 11 Sep 2020 11:20:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3E62F80227; Fri, 11 Sep 2020 11:20:28 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A9AEF80100
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2020 11:20:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A9AEF80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="XKuj/FAT"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08B9HhWY013223; Fri, 11 Sep 2020 11:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=zPssAz57qPbck8kfcp9veYTq0xH11iTPM9Ncg86DhkU=;
 b=XKuj/FATPflF8FXfZDEYytr1MlZgK2wRKnYAHcDRqt2zyAMcb53GqDFVW8A1mnQATy7x
 cVyLDJcRNIK7TAN8zNlI1QG9YropmGb+Cr5JpZ8BLQtWf6vREJdnGW2KyAcIUdPBjwkm
 fOXmCb1ZNyG4AHWrHXvOzrP3QKp1jjc6TwhqvFzbwuXdrKE0WNYiCQHJTK61cn6492ng
 4LvXngSkPkhkAsy2QMDaUYs9ENkgAb1O9Athni0nAUus608bBvSZ9lvOmqVUz15NU4Bz
 0EZ0rxemEGqt2epCy0fk/oWpwSb7A2+lZwKeJ60UkAx21gUSwl9LbeSoUhRMZ3iDwtLl yQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 33c1jfgn2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2020 11:20:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9629A10002A;
 Fri, 11 Sep 2020 11:20:23 +0200 (CEST)
Received: from Webmail-eu.st.com (gpxdag6node5.st.com [10.75.127.81])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6E0DA21FEBE;
 Fri, 11 Sep 2020 11:20:23 +0200 (CEST)
Received: from localhost (10.75.127.44) by GPXDAG6NODE5.st.com (10.75.127.81)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Fri, 11 Sep 2020 11:20:22 +0200
From: Olivier Moysan <olivier.moysan@st.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <alexandre.torgue@st.com>, <robh@kernel.org>,
 <mark.rutland@arm.com>, <arnaud.pouliquen@st.com>
Subject: [PATCH 0/2] ASoC: stm32: i2s: add master clock provider
Date: Fri, 11 Sep 2020 11:19:50 +0200
Message-ID: <20200911091952.14696-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To GPXDAG6NODE5.st.com
 (10.75.127.81)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-11_03:2020-09-10,
 2020-09-11 signatures=0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 olivier.moysan@st.com, linux-kernel@vger.kernel.org,
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

Add master clock generation support in STM32 I2S driver.

Olivier Moysan (2):
  ASoC: dt-bindings: add mclk provider support to stm32 i2s
  ASoC: stm32: i2s: add master clock provider

 .../bindings/sound/st,stm32-i2s.yaml          |   4 +
 sound/soc/stm/stm32_i2s.c                     | 310 +++++++++++++++---
 2 files changed, 270 insertions(+), 44 deletions(-)

-- 
2.17.1

