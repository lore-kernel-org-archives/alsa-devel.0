Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1D3C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jun 2022 16:22:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9317A174E;
	Thu,  2 Jun 2022 18:21:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9317A174E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654186942;
	bh=0qPT9x0n+VulkXupE0BhFW8avfXnzVQTdwNxGUAAtKI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IseRS7OlczEpAM6nPGFX8mF5qX+X/QObHTuN7KPvbNyrfdwtU6etYnydyLJ0Mhq7+
	 R5A4fRa44zy87oJ4DASmdyqDbI3/wUgZY515sexLkVC7xMRfCWjDqEf8Ql1feWQi+3
	 ecAyPlsrRj/ElhNzEKrQeUot8cb6VamhTOTiWl/0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9467F80089;
	Thu,  2 Jun 2022 18:21:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32152F80526; Thu,  2 Jun 2022 18:21:29 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0F95F80149
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2022 18:21:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0F95F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="j6NXW34q"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252BrAOm027248;
 Thu, 2 Jun 2022 11:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=eXPtVBtb4bXkb6iXJoHU0bVquJu4DWKoCcD3Cb1LYzE=;
 b=j6NXW34qGPcrQW3GXvZzzutn8XKsvhldKm9KIoLyvFmYc4Dyk5gikMKaWwMwwOveSnZo
 rEKvdh1CyFpDcjIdlO8YKMkcxX/+fYnZeH+/TMFaqvQVY+5dY6wv7r0L1q+Suow8993G
 wcEyhpbtngDS69HLSZ7hSpfvscf10BsXKpGq0kJEyO4QZwyuxjEL7hrckZBPSON7TL1/
 jSBDiW+oisV0z8YTEFzsNdRz0ck7wj3iDL8EkpHTU6/LibvaYImEDtdzTPVD61S3BgKo
 dzSPDgHO/lEU+pIVVu4ptRuLhYxIZaV3dgQOf95hu4IPIU575M9eb/mbaOB39S+6sjTS og== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gbg5nnqyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 02 Jun 2022 11:21:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 17:21:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Thu, 2 Jun 2022 17:21:19 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1EF8311D1;
 Thu,  2 Jun 2022 16:21:19 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 1/6] ASoC: cs42l52: Fix TLV scales for mixer controls
Date: Thu, 2 Jun 2022 17:21:14 +0100
Message-ID: <20220602162119.3393857-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602162119.3393857-1-ckeepax@opensource.cirrus.com>
References: <20220602162119.3393857-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tlzIjbmDbtaxUJbkiWypFLDf1yTPOX0I
X-Proofpoint-GUID: tlzIjbmDbtaxUJbkiWypFLDf1yTPOX0I
X-Proofpoint-Spam-Reason: safe
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 lgirdwood@gmail.com, david.rhodes@cirrus.com, james.schulman@cirrus.com,
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

The datasheet specifies the range of the mixer volumes as between
-51.5dB and 12dB with a 0.5dB step. Update the TLVs for this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l52.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 9b182b585be4c..02c25399cf8a2 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -137,7 +137,7 @@ static DECLARE_TLV_DB_SCALE(mic_tlv, 1600, 100, 0);
 
 static DECLARE_TLV_DB_SCALE(pga_tlv, -600, 50, 0);
 
-static DECLARE_TLV_DB_SCALE(mix_tlv, -50, 50, 0);
+static DECLARE_TLV_DB_SCALE(mix_tlv, -5150, 50, 0);
 
 static DECLARE_TLV_DB_SCALE(beep_tlv, -56, 200, 0);
 
@@ -364,7 +364,7 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
 			      CS42L52_ADCB_VOL, 0, 0xA0, 0x78, ipd_tlv),
 	SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
 			     CS42L52_ADCA_MIXER_VOL, CS42L52_ADCB_MIXER_VOL,
-				0, 0x19, 0x7F, ipd_tlv),
+				0, 0x19, 0x7F, mix_tlv),
 
 	SOC_DOUBLE("ADC Switch", CS42L52_ADC_MISC_CTL, 0, 1, 1, 0),
 
-- 
2.30.2

