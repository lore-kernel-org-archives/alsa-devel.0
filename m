Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855C4C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Mar 2022 15:57:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3DF61899;
	Fri, 18 Mar 2022 16:57:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3DF61899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647619075;
	bh=8xzvs2zsw7zUp/AqdsP0uCH10ap0sSSHzSvNz/0RjNA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sj4zUkAjOXLFyeo9KrvaAdwvAv4Q3lOfXBWQXDQzU+WtRFAeI+Ro+CeZX7CBky4gT
	 aBTpg/W2F4/B7TRlh5bXGfXYznLDglY2ccXKUjivfEioVocNnGZI6E7d1aB9hfQ5H5
	 jyP7hD/eq0I3Owpml2OAj5jgvQT6jaM882e8tGc4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DA72F8051F;
	Fri, 18 Mar 2022 16:56:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C606EF80518; Fri, 18 Mar 2022 16:56:09 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5823DF8026A
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2022 16:55:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5823DF8026A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="hLVcZWvR"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I4MHla013781;
 Fri, 18 Mar 2022 10:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=RLNYZa9UQSYGFio1Lh72vGHwbi2NTG9rHAVm+2NLYF4=;
 b=hLVcZWvRgKUGsPBQkxbtptbfaxZv5MTvWjNYsthZipZF7mjSvCEV481Eo34aWObva2nn
 CSMHqgkTzbCQwN7ZiRqKDBsuPODXiaAMwF1+BEQn384n55xjHHLa8UTPTegxEoHbUCJx
 tle7DxfcMYzyvlXa2TjHxbhe9osgjvC19mlICq1ofVhlmxfZacoDFOc3je6qvQ6hI4SR
 6jrGlHUwbjLpd2paK92lLZ7f7fpOaxSHP8284erZOdM2MB95pP39I5nXzl7lrBxzFyKn
 XvO2evesus8czoEiGe+gVcIPxo2uCRMur10e7w/geJiqSfBxRXItdTrB2SE4rp6azjEE jw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3et5yp65wt-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 18 Mar 2022 10:55:55 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 15:55:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via
 Frontend Transport; Fri, 18 Mar 2022 15:55:53 +0000
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.229])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 03AC17C;
 Fri, 18 Mar 2022 15:55:52 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 1/6] ALSA: hda/cs8409: Fix Warlock using dual mic configuration
Date: Fri, 18 Mar 2022 15:55:47 +0000
Message-ID: <20220318155552.24751-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
References: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MclKH3A3hirQnOnPfU1GyyCX2c4RpoJ8
X-Proofpoint-GUID: MclKH3A3hirQnOnPfU1GyyCX2c4RpoJ8
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Stefan Binding <sbinding@opensource.cirrus.com>
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

From: Stefan Binding <sbinding@opensource.cirrus.com>

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index aff2b5abb81e..1411e3845f16 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -907,8 +907,8 @@ static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
 	}
 
 	/* DMIC1_MO=00b, DMIC1/2_SR=1 */
-	if (codec->fixup_id == CS8409_WARLOCK || codec->fixup_id == CS8409_CYBORG)
-		cs8409_vendor_coef_set(codec, 0x09, 0x0003);
+	if (codec->fixup_id == CS8409_CYBORG)
+		cs8409_vendor_coef_set(codec, CS8409_DMIC_CFG, 0x0003);
 
 	cs42l42_resume(cs42l42);
 
-- 
2.25.1

