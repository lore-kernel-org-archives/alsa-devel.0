Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9978C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 23:01:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D5E60EFF
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 23:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98D5E60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4CD7828;
	Tue, 17 Aug 2021 01:00:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4CD7828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629154879;
	bh=i2ad8iQTltMdfxnYefRgjdo4D3sFI6KPoJma10uoHFo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oPbdG2GlUxMEbKfdhLNj7QxP7Bgm9nAt655bYJXxi8cUVCDHSqed+3DVTEIyG+huM
	 6mY0PFO8aQ1ijWcwpKmmiGIS4deKrmF1IcwEBIbTCf4rrr3/r9vQK591yt/70ntbc0
	 hfTiZGS7eNZVQ6EO3ppQHKTpUCGnNoTgGJmsBQI4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69A6EF80246;
	Tue, 17 Aug 2021 01:00:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B44EBF80249; Tue, 17 Aug 2021 01:00:13 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55ECEF800AF
 for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2021 01:00:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55ECEF800AF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="IQV6NobS"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17GMH11A010018; 
 Mon, 16 Aug 2021 18:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=KhkIL0a5tMDNUUmg02BWrUu4qUrxwlPyl/qc6Jugidw=;
 b=IQV6NobS4MbpNq4rcf6uX6wIa/PS/vuOufU56VdOKRMMEzoY49zyIeHHzDBgrCtbWpix
 sJCqa6w6M9gqKhwIXC6eYGlPDbgZVxFytaQfkcxWZrd/lCNhKZj5YV6ouuzQlqgYJ+um
 LcNSptbrJvBmcvC//HNvj1etKpdWyFxzxWYtvYt5m2nZhcnFUyeFuHeONVHZLKUa9am3
 Nx31QL12+/T2bxdhUc6cwYBsRvLeL/qeV2X2NBL/JQYeStGKOMWy+yv7ujUteJ+ONQY0
 RTw2ATIFZLLSrOpl1CyVPeYQJFS1ymGQD6LeGX7KhYDJ5JFuj8NxC0M6weuq1DNQ9eQR tQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3ag0ngg184-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 16 Aug 2021 18:00:04 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 23:45:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Mon, 16 Aug 2021 23:45:00 +0100
Received: from localhost.localdomain (unknown [141.131.77.62])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 09B802A9;
 Mon, 16 Aug 2021 22:44:58 +0000 (UTC)
From: David Rhodes <drhodes@opensource.cirrus.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <ckeepax@opensource.cirrus.com>, 
 <brian.austin@cirrus.com>, <patches@opensource.cirrus.com>,
 <alsa-devel@alsa-project.org>, <david.rhodes@cirrus.com>,
 <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v5 0/2] Cirrus Logic CS35L41 Amplifier
Date: Mon, 16 Aug 2021 17:43:08 -0500
Message-ID: <20210816224310.344931-1-drhodes@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bYbf7-VQFxESIlNoR7zQq7qqjlElDoEp
X-Proofpoint-ORIG-GUID: bYbf7-VQFxESIlNoR7zQq7qqjlElDoEp
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160143
Cc: David Rhodes <drhodes@opensource.cirrus.com>
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

ASoC driver and devicetree documentation for a new
Cirrus Logic amplifier CS35L41

v5 changes:
Reverse xmas-tree style for declarations
At probe, regulator enable before handle pdata
At probe, set pdata before component registration
Remove several DT properties and implement as mixer controls
Remove some unnecessary NULL inits in otp_unpack
Revise license header style

David Rhodes (2):
  ASoC: cs35l41: CS35L41 Boosted Smart Amplifier
  ASoC: cs35l41: Add bindings for CS35L41

 .../devicetree/bindings/sound/cs35l41.yaml    |  162 ++
 include/sound/cs35l41.h                       |   35 +
 sound/soc/codecs/Kconfig                      |   12 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/cs35l41-i2c.c                |  115 ++
 sound/soc/codecs/cs35l41-spi.c                |  144 ++
 sound/soc/codecs/cs35l41-tables.c             |  611 +++++++
 sound/soc/codecs/cs35l41.c                    | 1587 +++++++++++++++++
 sound/soc/codecs/cs35l41.h                    |  774 ++++++++
 9 files changed, 3444 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l41.yaml
 create mode 100644 include/sound/cs35l41.h
 create mode 100644 sound/soc/codecs/cs35l41-i2c.c
 create mode 100644 sound/soc/codecs/cs35l41-spi.c
 create mode 100644 sound/soc/codecs/cs35l41-tables.c
 create mode 100644 sound/soc/codecs/cs35l41.c
 create mode 100644 sound/soc/codecs/cs35l41.h

-- 
2.25.1

