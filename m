Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A71AC25B48
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Oct 2023 15:08:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E622846;
	Thu, 26 Oct 2023 17:07:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E622846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698332910;
	bh=oxy2iICOTDyY+ulcEfSaLp4k8kQ/tM24iXLBUXT7URY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hm5+pBoC9SffcEuGjJ1yqIkW/IsXKhyYiVuDphDcg4g1bzCPSf9H2l7GqzvGNUR8u
	 /oV+XEmkADkFaxCcM1p+cRWCyOoRpVZL7aZmbatAveJyrGqjicSAntUj4nut9/0aCE
	 eaSgwg/WRAtWwfnvP42PcHvHbK+ur1kjp2XITjWQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37837F8059F; Thu, 26 Oct 2023 17:06:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 244A0F8059F;
	Thu, 26 Oct 2023 17:06:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B457AF80567; Thu, 26 Oct 2023 17:06:25 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B757DF80165
	for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2023 17:06:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B757DF80165
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=F1bBjs5Z
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39Q5GUre011654;
	Thu, 26 Oct 2023 10:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=HEYmwSUimQpCUbn2HslBt1VQ9u6Os9uGPZpmdnfD33s=; b=
	F1bBjs5ZcxfAlLAroOAqoB85Ty66qD/8tHrHOu7Cp25fmktx9NhBye/T8YYKa2FF
	zIBSlmPyeLYFSWFgLY7oe8nwTYwhLl7XTiVjIkjDmV61f54jBXT8Bkt5tT8R99Jk
	wqP+P1j79+fu7BuM89XIXmxlvCwuaX7Y4tfsJoGMi1CcLoaKzklahlhiSrVYR2bT
	Rf+ySMxSPSr7/+8qTR8AezoiGo/S4WYFNq8YF1Jg2xKSahNpM7Z7afrNSojwIc4h
	o8S954+4vNSJT3JF1SdJ9YL+xL4JiA59Ok2kRuWmS2opWqWOB9bvRRIWcqQS0mRK
	RdEenZqxuL2yDxI2h3bXaQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tvc1x94k9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Oct 2023 10:06:10 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 16:06:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 26 Oct 2023 16:06:07 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.177])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5C64711AA;
	Thu, 26 Oct 2023 15:06:07 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mark
 Brown" <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/8] ALSA: hda: cs35l41: Use reset label to get GPIO for HP
 Zbook Fury 17 G9
Date: Thu, 26 Oct 2023 16:05:51 +0100
Message-ID: <20231026150558.2105827-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
References: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nUl2VjwxRNApK1UpUFXHASgEJ5J032wV
X-Proofpoint-ORIG-GUID: nUl2VjwxRNApK1UpUFXHASgEJ5J032wV
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: BAZVBJYCOKZ4BA2EYPDWYURPTSLAQBCR
X-Message-ID-Hash: BAZVBJYCOKZ4BA2EYPDWYURPTSLAQBCR
X-MailFrom: prvs=56633e4941=sbinding@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BAZVBJYCOKZ4BA2EYPDWYURPTSLAQBCR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This laptop has an incorrect setting in its _DSD for boost type, but
the rest of the _DSD is correct, and we can still use the reset label
to obtain the reset gpio.

Also fix channel map so that amp 0 is right, and amp 1 is left.

Fixes: 581523ee3652 ("ALSA: hda: cs35l41: Override the _DSD for HP Zbook Fury 17 G9 to correct boost type")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index b62a4e6968e2..c83328971728 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -58,9 +58,16 @@ static int hp_vision_acpi_fix(struct cs35l41_hda *cs35l41, struct device *physde
 
 	cs35l41->index = id;
 	cs35l41->channel_index = 0;
-	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 1, GPIOD_OUT_HIGH);
+
+	/*
+	 * This system has _DSD, it just contains an error, so we can still get the reset using
+	 * the "reset" label.
+	 */
+	cs35l41->reset_gpio = fwnode_gpiod_get_index(acpi_fwnode_handle(cs35l41->dacpi), "reset",
+						     cs35l41->index, GPIOD_OUT_LOW,
+						     "cs35l41-reset");
 	cs35l41->speaker_id = -ENOENT;
-	hw_cfg->spk_pos = cs35l41->index ? 1 : 0; // right:left
+	hw_cfg->spk_pos = cs35l41->index ? 0 : 1; // right:left
 	hw_cfg->gpio1.func = CS35L41_NOT_USED;
 	hw_cfg->gpio1.valid = true;
 	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
-- 
2.34.1

