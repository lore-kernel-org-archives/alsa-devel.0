Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4019C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Apr 2022 16:02:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 798151716;
	Fri, 22 Apr 2022 18:01:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 798151716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650643352;
	bh=74VwXmJWc48POLZ/OJpyJAT81W/F0WkDDgXGw3N0sek=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CKZcguj9au/X5PtYOEnfvvkp9Vdlo+RMMbSB9t3fO3vdPTsCLfJ3y+/IAFcLutd3J
	 sScYgCMI36BnsLLPcr2W+bzbwfoN8Kk1DisWHGVZXHrcuvU0KlcPZqhq+9b0pRF3i3
	 2YrfJW1ZpFqxBTmYSnPOUNj0oG4xo5jKjStcb7LU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4431F80249;
	Fri, 22 Apr 2022 18:01:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3923CF80154; Fri, 22 Apr 2022 18:01:40 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35AB1F80134
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2022 18:01:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35AB1F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="EFxyogNc"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MEIxDB004439;
 Fri, 22 Apr 2022 11:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=eGFNm16x7UEwxlj+/sSHzatTIBynBkqIUzT8BzcYbK8=;
 b=EFxyogNcWIojIPOSyVUOhs3g2JHafc9KIuQTjyqD5jfTZZE840yNcZztemOI62+H0LNW
 TlJJhLzeqQHbC0wKRbeY0lwGUVXjjS+9m1dLsy3N28Dj4mhOYPtLjHXVrIxvBgCVMvs+
 IOQHSpvtfLvbPaGVVGae37kwxCvJCWzVWej512X00b+3JTDdkoQTBXCoOxYEpdwCrRwC
 UG37hMNV6cpOS5y0blnXdhQNAbATe3yL59CHFul1ZgV7W/Z+FGt05X5VP/To8B6YNAtM
 +KRMMw4gHBeyg/yTnZ1TMzKAkjYlYofFN0gtnirEgij9vdd+PfnicV5e8FXXd0AoaDlX WQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ffu70qb7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 22 Apr 2022 11:01:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 17:01:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Fri, 22 Apr 2022 17:01:19 +0100
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com
 [198.90.251.83])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B3259B16;
 Fri, 22 Apr 2022 16:01:14 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 0/2] ASoC: Add macros for signed TLV controls with callbacks
Date: Fri, 22 Apr 2022 17:01:10 +0100
Message-ID: <20220422160112.3026542-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -pcEuf_PAuXQvSGlmQj-91fNPbydsV8l
X-Proofpoint-GUID: -pcEuf_PAuXQvSGlmQj-91fNPbydsV8l
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org
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

This adds SOC_DOUBLE_R_S_EXT_TLV and SOC_SINGLE_S_EXT_TLV macros for
signed TLV controls that need custom get/put callbacks. These will be
needed by future Cirrus codec drivers, but are not particularly exotic
so could be useful for others.

Richard Fitzgerald (1):
  ASoC: soc.h: Add SOC_SINGLE_S_EXT_TLV macro

Simon Trimmer (1):
  ASoC: soc.h: Introduce SOC_DOUBLE_R_S_EXT_TLV() macro

 include/sound/soc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.30.2

