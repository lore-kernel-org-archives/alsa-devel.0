Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A065C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Mar 2022 17:34:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA14D1B27;
	Thu,  3 Mar 2022 18:34:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA14D1B27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646328897;
	bh=/QQCP28GjHMO6pIgOyzNvBSnfRrRMh8cL43N4mVDRPQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EllNZtWwtP9wWgn+/Skw8YKHZYIdRkoazo9EssIy1Cd9eJbHb3j1ac7MFzdnGoQL7
	 IT3ek87WWtoFqYMSOoZBNdT4yoDo4V72bj7ldRYlL86lghsYKEHvI4azPj6rNkKLfC
	 PotngUov+mnRo4MA1wwxLQD7LZOmQ2UTDthue7Vg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7401CF80553;
	Thu,  3 Mar 2022 18:31:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FA17F8053E; Thu,  3 Mar 2022 18:31:24 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC44BF8051B
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2022 18:31:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC44BF8051B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="B4ptfMT4"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223509T8013880;
 Thu, 3 Mar 2022 11:31:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=S6u3GQtfaXIgPITm/HGCnkWxfKFOTDremsnnkLjeMOw=;
 b=B4ptfMT4GDXHj3CNHnjCMxC4P9I55mV37sy6BQkkclqc9rwfDqcEa4SwVowtV34sS9Gg
 L1Y/U9Ss/l6Fr5oqt0S32VJyBx2k1k80PEAE1eNm9ArDgvKNYd8Z1OT6ZOC9pNsoYLDv
 VHqHJiDsRzpNjy3xCfu/6NGLP74YoKSDlWFb3ahy+69/t/wdB6mg+eM+RfPfaP55RPda
 VaLdidsWe/nk/gF4Iy+AiFJqq7YorSYw0qOwaVp4409Q7xmcF83mmJPCE/ObeV1g4XEg
 BKByLAMxUyQLdV7c+jOSwMysjZGaGml1eAzZTRoyWwfFTkRTR0GJRN5pJZ1YGQU9k3xC qg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybn-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 03 Mar 2022 11:31:10 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:06 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via
 Frontend Transport; Thu, 3 Mar 2022 17:31:06 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 98E207C;
 Thu,  3 Mar 2022 17:31:06 +0000 (UTC)
From: Lucas Tanure <tanureal@opensource.cirrus.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 12/20] hda: cs35l41: Mute the device before shutdown
Date: Thu, 3 Mar 2022 17:30:51 +0000
Message-ID: <20220303173059.269657-13-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1LNFhf7yo1UP5oChga3AAQ90bqNPNoK0
X-Proofpoint-GUID: 1LNFhf7yo1UP5oChga3AAQ90bqNPNoK0
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Lucas Tanure <tanureal@opensource.cirrus.com>,
 devicetree@vger.kernel.org
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

Mute the device before shutdown to avoid pops
and clicks all types of boost.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 665f0b4e191a..75c5088cb224 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -28,6 +28,11 @@ static const struct reg_sequence cs35l41_hda_config[] = {
 	{ CS35L41_PWR_CTRL2,		0x00000001 }, // AMP_EN = 1
 };
 
+static const struct reg_sequence cs35l41_hda_mute[] = {
+	{ CS35L41_AMP_GAIN_CTRL,	0x00000000 }, // AMP_GAIN_PCM 0.5 dB
+	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_VOL_PCM Mute
+};
+
 static const struct reg_sequence cs35l41_hda_start_bst[] = {
 	{ CS35L41_PWR_CTRL2,		0x00000021 }, // BST_EN = 10, AMP_EN = 1
 	{ CS35L41_PWR_CTRL1,		0x00000001, 3000}, // set GLOBAL_EN = 1
@@ -89,7 +94,6 @@ static const struct reg_sequence cs35l41_active_to_safe[] = {
 	{ 0x00000040,			0x00000055 },
 	{ 0x00000040,			0x000000AA },
 	{ 0x00007438,			0x00585941 },
-	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_VOL_PCM Mute
 	{ CS35L41_PWR_CTRL2,		0x00000000 }, // AMP_EN = 0
 	{ CS35L41_PWR_CTRL1,		0x00000000 },
 	{ 0x0000742C,			0x00000009, 2000 },
@@ -146,6 +150,7 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 			ret = regmap_multi_reg_write(reg, reg_seq->prepare, reg_seq->num_prepare);
 		break;
 	case HDA_GEN_PCM_ACT_CLEANUP:
+		regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
 		if (reg_seq->cleanup)
 			ret = regmap_multi_reg_write(reg, reg_seq->cleanup, reg_seq->num_cleanup);
 		break;
-- 
2.35.1

