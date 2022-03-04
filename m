Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A77C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Mar 2022 15:11:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CD441EF7;
	Fri,  4 Mar 2022 16:10:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CD441EF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646406692;
	bh=Fyo+xMDsLWqBCb6v8g1jQ7NnLoY+k7PpmMZ0ki2M9Ko=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZEA3398p6Nm4MDuVV1kIKPwVorumoEBnQJLMmxv8n9h/boypoASzOGKtShXK1QZPk
	 AhdxMyo9TAuAgjOYIp3aTUytAMbfi+oNtXjgTTuSlo8YMzESyTmZu+t2QRmxbqur75
	 xYyQgS2D5mqFnQ4KHSSM78t2/CRSwgZ2/9Rt9fc4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 322FFF80559;
	Fri,  4 Mar 2022 16:07:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8ADE4F8053C; Fri,  4 Mar 2022 16:07:47 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF10DF80511
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2022 16:07:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF10DF80511
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="CVQ0NzWl"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2244w2hG013723;
 Fri, 4 Mar 2022 09:07:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=34C6kjTu8fIQ8hyCcYnZI1IqI0VSAE1mssJrdWJKQKE=;
 b=CVQ0NzWlLdNDXm6eF0nlL497j4SEydnyQS5dt64bA/tOdf5SpcXlq90tk3jAjlA3gnop
 t3GBv9z/Nnl78cP8xBUvtFrz8emdge/XQAoU2+vnY3zadv09NevNNgvxKa06O3l6J8yt
 2PRkh3kipuYO6fLVv3xzQ20uUVM+PfEWtkNxmnGHAv/T0WnUMxYSaCYLdu0Ws3XElHOh
 k+rOEw5CHmhebjZa615NsLP4rwQseJDHvq9rL23DXRJ+TfEmGxVfI7UxYDPutbWC3oBS
 D/35Wm8NpazL98i+aF/jqTyrssj7heP3cdE8FG882b0dGRPwdo9FsHsh0glBvZhEqgkK TA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h414-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 04 Mar 2022 09:07:27 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:07:24 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via
 Frontend Transport; Fri, 4 Mar 2022 15:07:24 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 16AA6B1A;
 Fri,  4 Mar 2022 15:07:24 +0000 (UTC)
From: Lucas Tanure <tanureal@opensource.cirrus.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 02/20] ASoC: cs35l41: Fix max number of TX channels
Date: Fri, 4 Mar 2022 15:07:03 +0000
Message-ID: <20220304150721.3802-3-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ySL-x5sdYQwrF9WiWIv-mbrd7nJGrX1Q
X-Proofpoint-ORIG-GUID: ySL-x5sdYQwrF9WiWIv-mbrd7nJGrX1Q
X-Proofpoint-Spam-Reason: safe
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Lucas Tanure <tanureal@opensource.cirrus.com>, patches@opensource.cirrus.com,
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

This device only has 4 TX channels.

Fixes: fe1024d50477b ("ASoC: cs35l41: Combine adjacent register writes")
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 90c91b00288b..f3787d77f892 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1091,7 +1091,7 @@ static struct snd_soc_dai_driver cs35l41_dai[] = {
 		.capture = {
 			.stream_name = "AMP Capture",
 			.channels_min = 1,
-			.channels_max = 8,
+			.channels_max = 4,
 			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = CS35L41_TX_FORMATS,
 		},
-- 
2.35.1

