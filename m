Return-Path: <SRS0=vr1N=NB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F12C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 15:39:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA1261058
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 15:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3AA1261058
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F39D7846;
	Tue, 10 Aug 2021 17:38:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F39D7846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628609944;
	bh=VVIdU41jjZEfQXMRyLpvoaorJmCVNqO2GgeEJ/0QvMY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lzAnn52GVtAM5UzE8uv0RYlfBJmNKTsYf5YMZxQf9POkxM1qIpPhkLtaX16ZJD8f5
	 3ZP8l802VNhuaD9jmDPvNnBFiGhidLEvxoateYGRQu0DdJlDinx8AWNTPFgSbaW32T
	 fEZIEB/UvWBlRFE08FHseg23j0md1tqnTCs8nzwA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A0D6F804D2;
	Tue, 10 Aug 2021 17:38:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4AB73F804CF; Tue, 10 Aug 2021 17:38:11 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53DCEF8016B
 for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2021 17:38:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53DCEF8016B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Qb/uD1ot"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17A75fJN008310; 
 Tue, 10 Aug 2021 10:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=D9Z+B+6Uu9IJFjEF/0fUoIcheo5kTw9lcFbulYgfeS4=;
 b=Qb/uD1otAloGEiu/ytm6kNF1GVc23JbcFH3AQxk79LF81KkFHATKuI8HVLjOVpLIfp0X
 v5nSSZHdVyD/2mJKcrXPQ1Q9DBADLHmIn78fTZnsXetW+jKIDWtCClxD7wX+Ey/P+pue
 6momBOWuYPwJxJkaBB3HqMJGEjWc7kapQprhYnD0WKyQYOyDSbZPrhjl8HASqJqUOFpO
 k/j0lUSYdWkZJAhAh7S004Nt31dwNMsL8rnShvAKnIKdN37dJboOqLoCDv6xU8OlGrp4
 bbdZLRbkmH2A+dSD61HP2I3EeScqU2F1XrbDBQFR74BCpM/OZ1LUrhNF1jsMgwlL2cjX gw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3abmrkgkf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 10 Aug 2021 10:38:04 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 16:38:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Tue, 10 Aug 2021 16:38:02 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com
 [198.61.64.221])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DE39A2A9;
 Tue, 10 Aug 2021 15:38:01 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 00/12] ASoC: cs42l42: Series of bugfixes and improvements
Date: Tue, 10 Aug 2021 16:37:47 +0100
Message-ID: <20210810153759.24333-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7G79ot0PRhJVHNdHnY4DEPtdj217-NYX
X-Proofpoint-ORIG-GUID: 7G79ot0PRhJVHNdHnY4DEPtdj217-NYX
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=349 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100099
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

Various bugfixes and improvements to the cs42l42 codec driver.

Clocking bugfixes:
  - Remove any use of MCLK > 12.288 MHz because it isn't possible to switch
    between the low and high frequency ranges on-the-fly

  - Prevent the PLL configuration being written while the PLL is running
  - Correctly set the MCLK for the sample rate converters

ASP bugfixes:
  - Ensure the TX (capture) ASP is properly configured when recording
    mono audio.

Other bugfixes:
  - Prevent NULL pointer deref if there is an interrupt before soc
    component probe

Code cleanup:
  - Remove the unused runtime suspend/resume functions.
  - Remove some code made redundant by an earlier patch

Improvement:
  - Add ALSA control for HP path attenuation. Previously this was
    always set to -6dB with no way for the user to configure it.

  - Add ALSA control to disable the soft volume ramp at the start of
    audio.

Richard Fitzgerald (12):
  ASoC: cs42l42: Use PLL for SCLK > 12.188MHz
  ASoC: cs42l42: Don't claim to support 192k
  ASoC: cs42l42: Always configure both ASP TX channels
  ASoC: cs42l42: Don't reconfigure the PLL while it is running
  ASoC: cs42l42: Set correct SRC MCLK
  ASoC: cs42l42: Mark OSC_SWITCH_STATUS register volatile
  ASoC: cs42l42: Allow time for HP/ADC to power-up after enable
  ASoC: cs42l42: Prevent NULL pointer deref in interrupt handler
  ASoC: cs42l42: Remove runtime_suspend/runtime_resume callbacks
  ASoC: cs42l42: Remove redundant pll_divout member
  ASoC: cs42l42: Add HP Volume Scale control
  ASoC: cs42l42: Add control for audio slow-start switch

 sound/soc/codecs/cs42l42.c | 281 ++++++++++++++++++++++++---------------------
 sound/soc/codecs/cs42l42.h |   9 +-
 2 files changed, 156 insertions(+), 134 deletions(-)

-- 
2.11.0

