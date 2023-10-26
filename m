Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA4FC25B48
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Oct 2023 15:08:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8D9184B;
	Thu, 26 Oct 2023 17:07:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8D9184B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698332891;
	bh=REXGi6Y0o+M4RoopNT2vlJgbk6MBGbQMYkhgCPtm+Rk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gVBxkF/AmdZ6/Mvrg2xd9POJthiZO3fUqHFt6sGuDA7lLc3l0iNE7kzLI0tjJz+1a
	 +q7pgE2haCBTTjB6vkj6vqU0w8lILcIRceK2zPDaj0Bg+WP/CpN3NvKF8gDjmNTFzP
	 QDpj3f7u17Otc5tBXZ7dr7JejRni2mP8YDgNc83Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D183EF805A0; Thu, 26 Oct 2023 17:06:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DFF53F8057D;
	Thu, 26 Oct 2023 17:06:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1BE4FF8055A; Thu, 26 Oct 2023 17:06:22 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B5F67F80152
	for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2023 17:06:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5F67F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=aoy8gLob
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39Q5GUrf011654;
	Thu, 26 Oct 2023 10:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=wdJIvP71kd5paaffy0gTBO9L9MC9c1x6VHLNrVDIlu8=; b=
	aoy8gLob0n1gsE5hx65kSnrRIzX7GY+l4uEKFt50502Nn3zHqPNsbTlVTlJedENh
	yXFqXGjsowQumsR8up5m9R8Quv82AVNPLJaA0ZUeJsJz0YFB6PQGZB+/U1kVlsHh
	okgtgrORXOsL9ujKuRmKgo2eDDUeCQMqepQJpqLPpkhy+9SvR0EAYQzg0mWcuZcF
	tcz02AZmTfCJcWQeTSfFhCfPMrdLceKJ+tYKDU+/cXKsxYMd9675duCu12lWNbv6
	dEEwr++VX4jfICoZ4bQaG2Nf8fAUSJ49NDD15CAWGlNxOx3/WfMIeyddJeoU3tf9
	fQ2C2wEnZVrv9GQGuJTAkA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tvc1x94k9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Oct 2023 10:06:11 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 16:06:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 26 Oct 2023 16:06:07 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.177])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 99D1A2A1;
	Thu, 26 Oct 2023 15:06:07 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mark
 Brown" <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 2/8] ALSA: hda: cs35l41: Assert reset before system suspend
Date: Thu, 26 Oct 2023 16:05:52 +0100
Message-ID: <20231026150558.2105827-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
References: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PrOE1fxLidsnV9ZeqmoNDjFQsX_MJZuV
X-Proofpoint-ORIG-GUID: PrOE1fxLidsnV9ZeqmoNDjFQsX_MJZuV
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: YT72SZPXX5ZJA5V5Z7PQXBJL6F22IIQ3
X-Message-ID-Hash: YT72SZPXX5ZJA5V5Z7PQXBJL6F22IIQ3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YT72SZPXX5ZJA5V5Z7PQXBJL6F22IIQ3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Some system suspend modes may remove power supplies.
To ensure we are not running during this time, we should assert reset.

Note: since the amps use a shared reset, asserting reset prior to
system suspend only works if the amps are suspended in the reverse
order to probe.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 28cb10ddd191..919e38213975 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -813,14 +813,17 @@ static int cs35l41_system_suspend(struct device *dev)
 
 	/* Shutdown DSP before system suspend */
 	ret = cs35l41_ready_for_reset(cs35l41);
-
 	if (ret)
 		dev_err(dev, "System Suspend Failed, not ready for Reset: %d\n", ret);
 
-	/*
-	 * Reset GPIO may be shared, so cannot reset here.
-	 * However beyond this point, amps may be powered down.
-	 */
+	if (cs35l41->reset_gpio) {
+		dev_info(cs35l41->dev, "Asserting Reset\n");
+		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
+		usleep_range(2000, 2100);
+	}
+
+	dev_dbg(cs35l41->dev, "System Suspended\n");
+
 	return ret;
 }
 
-- 
2.34.1

