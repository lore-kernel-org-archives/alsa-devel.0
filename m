Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CF8C4332F
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Nov 2022 10:07:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A414A852;
	Fri,  4 Nov 2022 11:06:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A414A852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667556460;
	bh=4kn6Qs+MI9TX3rkyxhzKuSzVnB4hYffYKTW7BcIjIoQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MKDDAnS0rpekgOfgZK4WssuSkSw/3kgrWllUmYnjghofOdn6DwaLdNL+jx/DuXcD7
	 s0/W/aWlWfQWqL8IaNbL03TCJexvVq+NIONbBWS36wRo1ZioRv692tWT3yqu7AR9EO
	 2dTWgYSrB/HodchWN/w9/DfHv5mjAYBhaU+BqVic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DF5CF80149;
	Fri,  4 Nov 2022 11:06:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B614CF80448; Fri,  4 Nov 2022 11:06:48 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACF4EF80149
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2022 11:06:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACF4EF80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="hUxE2vhD"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2A49TAQM012440; Fri, 4 Nov 2022 05:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=0pR3TOrHMf9AHUYqBblJTRAag2PL/OTVWGjwi52/bj4=;
 b=hUxE2vhD19xFJ1uLc3wc3uzsm51JVbUMxArrs1m68Vtv+67h+hktqAUP7nj5bBMMLzXp
 pN9vbhg18Twred/ilxxns1KptnLg8l4UMIt58w2agRgusmBACxEp0v4FQ2t+4Ec5LtEY
 mN7maTbd4nJnYiOqXHWTNB+3i797oV8VBIgp7CibObllaCT99025OO6eFsyDkxUOmsb6
 PTOVT0MlPbyDVpUV5MAXQFUmiQgL2XKPgdrLZcLO2oqz1Qehnm1Q0lZ8n7iR38UGZz/N
 f6pSjC0W3CSMaWlTYE9QnmdB62msus1RtAg7zisOKsR4YBqCKwsT1MxhJpMifOxiyrOw 2g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kmph3gmea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 05:06:39 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Fri, 4 Nov
 2022 05:06:37 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via
 Frontend Transport; Fri, 4 Nov 2022 05:06:37 -0500
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.212])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 86B862AA;
 Fri,  4 Nov 2022 10:06:37 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Sanjay R Mehta <sanju.mehta@amd.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] spi: amd: Fix SPI_SPD7 value
Date: Fri, 4 Nov 2022 10:06:37 +0000
Message-ID: <20221104100637.13376-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BWIpw-d5CSFly8m_iAhM2k8SG_jgY4NS
X-Proofpoint-GUID: BWIpw-d5CSFly8m_iAhM2k8SG_jgY4NS
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

According to data sheet SPI_SPD7 should be set to 7.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index e23121456c70..bfc3ab5f39ea 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -65,7 +65,7 @@ enum amd_spi_speed {
 	F_16_66MHz,
 	F_100MHz,
 	F_800KHz,
-	SPI_SPD7,
+	SPI_SPD7 = 0x7,
 	F_50MHz = 0x4,
 	F_4MHz = 0x32,
 	F_3_17MHz = 0x3F
-- 
2.34.1

