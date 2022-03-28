Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32306C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Mar 2022 11:58:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 655051878;
	Mon, 28 Mar 2022 13:57:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 655051878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648468717;
	bh=zoSxYZ4Oh6vv689nba8eNbveI9N8nSATFUwqcUdQ2U8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g43UEDcI+YmPJ1SSiKysoi9T/2YtCXwLsj5edbzBelCZ0g5HmCJltR8e1XoElRdfB
	 /Ykux2BzxRfsq99/US9s9wGLs3BI6w9HRgg6hM6kP4kDp9JxZsQ09XbZbRaIYrHHtA
	 DuwURCzMFUnTLyIQ+XNx6wCDIA1jLsoOOh6XASqw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D491F80525;
	Mon, 28 Mar 2022 13:56:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 518F5F8051D; Mon, 28 Mar 2022 13:56:32 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D850F8026D
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2022 13:56:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D850F8026D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="A9JEl25W"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S8AHvb030601;
 Mon, 28 Mar 2022 06:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=OLEzghvnn9gNLbQwwYzpsmkhYm8klpUyJxyvOaxpoqo=;
 b=A9JEl25WDBwJPzl2bd3tjKh0MM1fBuMMNDyu2GJmtiIGFtjR/AdFJHSAnP8QdMnfz6CQ
 eQqRNmJVdPNuewF+L4NhkZ6oBFTku7Tig5pc25o++eRHccFVLjtrbCUcY3WOufwgFdCB
 OqhNLilVBtywEKBxIyQXXkHoS3us1hywEuKrN5fuAMGOC0h08BXAkkctItlK5wq4rby/
 ksDSbs+D0ff8dt5B6khmKwffbCr7ELFCwb0hLpaq6X1K77yDtlfXiNvNLFXvpc2NSFAu
 lMr9jdAztJbhXMxMMPG7EMXu2lFSxmUHRBqqvjhJ8o9Drq9s0T7JBIDLgaU7QTR5iRbe wA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f2081apda-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 28 Mar 2022 06:56:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 12:56:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Mon, 28 Mar 2022 12:56:15 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.244])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 13DADB1A;
 Mon, 28 Mar 2022 11:56:15 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 1/6] ALSA: hda/cs8409: Fix Warlock to use mono mic
 configuration
Date: Mon, 28 Mar 2022 12:56:09 +0100
Message-ID: <20220328115614.15761-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328115614.15761-1-vitalyr@opensource.cirrus.com>
References: <20220328115614.15761-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PrqM8UFwgvvPaq0uEZi1ucSLTTz5umcS
X-Proofpoint-GUID: PrqM8UFwgvvPaq0uEZi1ucSLTTz5umcS
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

Warlock/Bullseye Laptops have a mono DMIC, Cyborg uses
a stereo DMIC, and the configuration should reflect this.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Changes in v2:
Add patch description in commit message.

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

