Return-Path: <SRS0=DV51=IE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DCAC433E0
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Mar 2021 19:12:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B96650BC
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Mar 2021 19:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B96650BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D79F218E2;
	Sat,  6 Mar 2021 20:11:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D79F218E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615057937;
	bh=NQOvLtR4G8U3e38NHYJV3s54dAgh5KnV19wEqzAL9nw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n1SNCH0gRwUe5XdoHrKVjW7HSRKaRmdWqk01yzYruqOCkyW3jp38+WCKz6zDt4ZAA
	 RToHXE9OhNC//+fQ27lEUaYVWsm07Hvk/mD8QiELhUa8U8swZLApoePguCX0ygXeLD
	 34pOd5yHwLPV75GpBBZNBtmjQlzHdamG7qDvclDQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E271F8025B;
	Sat,  6 Mar 2021 20:11:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4E18F80269; Sat,  6 Mar 2021 20:11:25 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DC1EF80116
 for <alsa-devel@alsa-project.org>; Sat,  6 Mar 2021 20:11:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DC1EF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="XQ7AmZH9"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 126JBJQu032081; Sat, 6 Mar 2021 13:11:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=tGlCTr/SXqNaOxq3FAuT9q//6WMREi8RgP4eXgeJKIw=;
 b=XQ7AmZH9fxksoolVPBenfzQsJ0+K8BXZngIHulx9tRWDzCzuRDVRGBjhKJiNnU46GM6n
 I0nlIEc5F4uZqXdnxwCij4Ps4gCElHrqsiXfgfrKCMW/Sn/RqlEnKK/s4xr0GJwJWfrC
 y7IxhLHq1UUFCiEofy+HzvZFeNnZ+gXu6CWabBmIb4aKVvwHrDexjZ1W1zaB/rPoLHUg
 j8wWl9naO0pWpSPfu3Xx7c9jENZyaWkqXPUqahOr8AYyLWvis5cJ1S7iMR7JCGcZ8b3S
 ETq7KPAiuXfPH8mBvImleD+Oemw0urtvIGGxd2KWyflFiiL/AinndshQS6xbya/6RzTl Jw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 37471vrdsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Sat, 06 Mar 2021 13:11:19 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 6 Mar 2021
 18:56:15 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 6 Mar 2021 18:56:15 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 09C8A11CF;
 Sat,  6 Mar 2021 18:56:09 +0000 (UTC)
From: Lucas Tanure <tanureal@opensource.cirrus.com>
To: James Schulman <james.schulman@cirrus.com>, David Rhodes
 <david.rhodes@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>
Subject: [PATCH v3 00/15] Report jack and button detection + Capture Support
Date: Sat, 6 Mar 2021 18:55:38 +0000
Message-ID: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 adultscore=0
 malwarescore=0 mlxlogscore=973 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103060119
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Lucas Tanure <tanureal@opensource.cirrus.com>
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

Hi All,

Here is a patch series for reporting to user space jack and button events and
add the support for Capture. With some cleanups and fixes along the way.

Regards,

Lucas Tanure

Lucas Tanure (12):
  ASoC: cs42l42: Fix Bitclock polarity inversion
  ASoC: cs42l42: Fix channel width support
  ASoC: cs42l42: Fix mixer volume control
  ASoC: cs42l42: Don't enable/disable regulator at Bias Level
  ASoC: cs42l42: Always wait at least 3ms after reset
  ASoC: cs42l42: Remove power if the driver is being removed
  ASoC: cs42l42: Disable regulators if probe fails
  ASoC: cs42l42: Provide finer control on playback path
  ASoC: cs42l42: Set clock source for both ways of stream
  ASoC: cs42l42: Add Capture Support
  ASoC: cs42l42: Report jack and button detection
  ASoC: cs42l42: Use bclk from hw_params if set_sysclk was not called

Richard Fitzgerald (3):
  ASoC: cs42l42: Wait at least 150us after writing SCLK_PRESENT
  ASoC: cs42l42: Only start PLL if it is needed
  ASoC: cs42l42: Wait for PLL to lock before switching to it

 sound/soc/codecs/cs42l42.c | 435 +++++++++++++++++++++----------------
 sound/soc/codecs/cs42l42.h |  41 +++-
 2 files changed, 282 insertions(+), 194 deletions(-)

-- 
2.30.1

