Return-Path: <SRS0=Rqaf=N7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52067C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 14:56:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFF86124A
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 14:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FFF86124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D029016A6;
	Thu,  9 Sep 2021 16:55:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D029016A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631199375;
	bh=/dk/7/Og0j+KzCflzzreAEh8CFjXSoViFMZC2X57I7s=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PKLykghxlA742ZoJCYbGYrFSBsPKxLKdwSDWzNCnmNpCckKxdYNCJVrWiAjdLETk1
	 XuJ+Bz7gSASVx9bFWWXnWRncayq4lwYYicHwjr62LO5W0zkidPURhPWOh68kW5kLRz
	 ZmuJEVr0lEwcHPlS0AZnG/oyI4kQFz4MK2gcNHUI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63F7AF80217;
	Thu,  9 Sep 2021 16:55:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2550F80224; Thu,  9 Sep 2021 16:55:23 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7AE7F80166
 for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2021 16:55:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7AE7F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com
 header.b="DxjvpDNh"
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 189D2xEW008460;
 Thu, 9 Sep 2021 16:55:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=6VSAWmEbCA5S7HOgjWSLJ/kPpl3J+ONHFObQga3sbMs=;
 b=DxjvpDNhQbI+8ALBOVh6BQr8y7I3ERUA/vovpMt5r1xyDkfeZMa3V2qHNM9orOKROz0p
 uXPHOZTOI1Xz5W2UsNrtzPsFCyOezEPwFPiXY8YFk6dRFjz5gx6r9BomV1O4jmrP8xik
 ArvtNeIIFzYASTDyY5/CU64kPmrzL6CiH65aRsXwDXKKfcyC5kMyhCDdlThciOef1YbY
 Br8MztS/PEpIdQc2FmTCJfmo8kHeI3CnNahH7/M25jld49XXeLt9LMwqJBYkSVD8hp2y
 KuX7woaezFAmYrwRIDsupPU5vMR5wqv8ssZsE/uWjeLfJPEqVlDzjZ7v/ae2zrRrPVJ4 Mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 3ayej6t7x1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Sep 2021 16:55:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 729BC10002A;
 Thu,  9 Sep 2021 16:55:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node2.st.com [10.75.127.2])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D8FC21FA84;
 Thu,  9 Sep 2021 16:55:13 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG1NODE2.st.com (10.75.127.2)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Sep 2021 16:55:12
 +0200
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mark Brown
 <broonie@kernel.org>
Subject: [PATCH] MAINTAINERS: fix update references to stm32 audio bindings
Date: Thu, 9 Sep 2021 16:54:49 +0200
Message-ID: <20210909145449.24388-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG1NODE2.st.com
 (10.75.127.2)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-09_05,2021-09-09_01,2020-04-07_01
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
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

The 00d38fd8d2524 ("MAINTAINERS: update references to stm32 audio bindings")
commit update the bindings reference, by
removing bindings/sound/st,stm32-adfsdm.txt, to set the
new reference to bindings/iio/adc/st,stm32-*.yaml.

This leads to "get_maintainer finds" the match for the
Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml,
but also to the IIO bindings
Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml

And The commit fixes only a part of the problem:
Documentation/devicetree/bindings/sound/st,stm32-*.txt file have been
also moved to yaml.

Update references to include all stm32 audio bindings file and
exclude the st,stm32-adc.yaml bindings file.

cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Fixes: 0d38fd8d2524 ("MAINTAINERS: update references to stm32 audio bindings")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a9a7cbf9456..3f6dc482660e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17886,7 +17886,8 @@ M:	Olivier Moysan <olivier.moysan@foss.st.com>
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/adc/st,stm32-*.yaml
+F:	Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
+F:	Documentation/devicetree/bindings/sound/st,stm32-*.yaml
 F:	sound/soc/stm/
 
 STM32 TIMER/LPTIMER DRIVERS
-- 
2.17.1

