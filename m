Return-Path: <SRS0=quTn=OE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A52C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Sep 2021 16:53:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E3961164
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Sep 2021 16:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11E3961164
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3220017E0;
	Tue, 14 Sep 2021 18:52:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3220017E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631638416;
	bh=uzZoGJOJKIdwLMAfqIKSKKYLbMxygCPSjeBGOgtonNg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xlo++dTdrMdxGEZuANMxEzneKmRM9Cclz6o5UicV8piBxvINw0l6zDDRia0vZCls0
	 yh8OkxBGoYVRWdOaLo84LH8q++WkdW2n9B0+DZ+j2/GY1xXQUsQI95eB1qSYj4fZ5B
	 RFZzU6xIETKL9+x7gm8Ut8wHyzqbiH1+RT5vBKmY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB2D3F80117;
	Tue, 14 Sep 2021 18:52:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 615B6F8027B; Tue, 14 Sep 2021 18:52:44 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F5BEF80117
 for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2021 18:52:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F5BEF80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="PpnMEdel"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E503l9016778; 
 Tue, 14 Sep 2021 11:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=YkZHQj9k0tUUUprq2cdPeMN2UHIX44J1qBnShOtUP7U=;
 b=PpnMEdelvK7sUDdYt5wile+mmYipFsaYoHRLB0C95BMFNfgLmT3AlVPRnEv2kXsb5TTp
 Xl2VOqCzM1QYeYfbmiRFnhv8C2N2lOFqfuDKVK7SB70PnKgYlZ14FDVow9wHj8heMz5L
 9bOghnxirizbkOYsdtZEpsMIKuSdbAtQC+EBmmGb2z0EatB1pRlExbRsfsxUKTwbh28Z
 POzEdnWdM5YKirKUt+tGmKGx36VVzf/DwSB0V+5CKLORkBBMAPsVUktrUYDQCorU21VD
 P99qKHEEiu4vntmWiblgtCn5R1uPD0CDzw26LJ5iKXc7SoTLLlgLrHr1CZzuumvwQJ1y Gg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3b2gkx8xd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 14 Sep 2021 11:52:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 14 Sep
 2021 17:52:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Tue, 14 Sep 2021 17:52:33 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.230])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D29BEB10;
 Tue, 14 Sep 2021 16:52:32 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: James Schulman <james.schulman@cirrus.com>, David Rhodes
 <david.rhodes@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>
Subject: [PATCH 0/2] ASoC: cs42l42: Implement Manual Type detection as fallback
Date: Tue, 14 Sep 2021 17:52:18 +0100
Message-ID: <20210914165220.752498-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6YQcSsU3m-I6qvH5D-DuccFwtgawvVPB
X-Proofpoint-GUID: 6YQcSsU3m-I6qvH5D-DuccFwtgawvVPB
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

For some headsets CS42L42 autodetect mode is not working correctly. 
They will be detected as unknown types or as headphones. According 
to the CS42L42 datasheet, if the headset autodetect failed,
then the driver should switch to manual mode and perform a manual steps sequence.
These steps were missing in the current driver code. This patch will add manual
mode fallback steps in case autodetect failed. The default behavior is not affected,
manual mode runs only when autodetect failed.

Tested for regression with autodetect with all known headsets - no regression.
Tested with all headsets customers reported as false detected:
Gumdrop DropTech B1 - detected as headset OK
HUAWEI AM115 - detected as headset OK
UGREEN EP103 - detected as headset OK
HONOR AM116 - detected as headset OK

Also, fixes some errors reported by checkpatch.pl script.

Stefan Binding (1):
  ASoC: cs42l42: Implement Manual Type detection as fallback

Vitaly Rodionov (1):
  ASoC: cs42l42: Minor fix all errors reported by checkpatch.pl script

 sound/soc/codecs/cs42l42.c | 114 +++++++++++++++++++++++++++++++------
 sound/soc/codecs/cs42l42.h |  54 ++++++++++++++++++
 2 files changed, 151 insertions(+), 17 deletions(-)

-- 
2.25.1

