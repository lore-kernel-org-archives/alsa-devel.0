Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AA8C30653
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:56:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBD541605;
	Wed,  3 Jul 2024 11:56:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBD541605
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720000599;
	bh=esBEZWhMiBRliaM1qYn3jnE+yA8P72YVy85h047u40c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eQ0ltmeanr15D15qWlUNiRtiQN/nip/L31UPYDruGCMGPAQT93nwDmiDMAMMuIJyM
	 0jwlZnkKUdXb8zAgYERrJjWk/Pe3JbV3ZLR4VBRqK6hUemtT99uuRsgK0XXkiaebd2
	 vCDSJlR18kjATj7D5bJEy8fjxIhG8Hssgk3BiY+s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8411DF80604; Wed,  3 Jul 2024 11:55:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 206F8F805F8;
	Wed,  3 Jul 2024 11:55:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63EB7F8025E; Wed,  3 Jul 2024 11:55:29 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 30EDFF8014C
	for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2024 11:55:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30EDFF8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=V9VrI4AN
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id
 4637xDTR029630;
	Wed, 3 Jul 2024 04:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=RmlRDYIfTUKyUgfRgzYWrwMdS4KjZ1LZo4J4TljIXaY=; b=
	V9VrI4ANN3cLU6Ih6QiWqyyLuUyZ0krQoI9XQT9ssf46/R91mfDIzsFYzbroB9j1
	KttzOIpalgxE9pkxC11y6H44zruL6H76QK2UBLQZcoln++K7BMejoTHLs5I/DCTf
	35r96sh19IFciYdh+L+PhcOFMJFwbweeVa6G5JMHgOx6Q9w1fiB+SE0aEExVD7wS
	+N2pSh6ZuXiQoXvZJduHjYPpHQGEjIc3byor3NcguI3rSNMge9U1mMraAwmgmy9K
	A++US4AJUzlEmy3TZjrA2AHy9s8mwAGTD0EQGdWuws8jN6EZ0nevEPHzICZaO0w0
	4L5ZVdK7QJDIp5SJm4STcg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 402fnxcq1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 04:55:20 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 10:55:18 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 3 Jul 2024 10:55:18 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com
 [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 02BA282024D;
	Wed,  3 Jul 2024 09:55:18 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: cs35l56: Use header defines for Speaker Volume
 control definition
Date: Wed, 3 Jul 2024 10:55:16 +0100
Message-ID: <20240703095517.208077-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703095517.208077-1-rf@opensource.cirrus.com>
References: <20240703095517.208077-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JuavNmVy9FjEPBFVai9Kd07yRzthcEcE
X-Proofpoint-ORIG-GUID: JuavNmVy9FjEPBFVai9Kd07yRzthcEcE
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: Z7AETLZKAWW4CUJZJHU3U3ZO4IH2CLOY
X-Message-ID-Hash: Z7AETLZKAWW4CUJZJHU3U3ZO4IH2CLOY
X-MailFrom: prvs=4914b47104=rf@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z7AETLZKAWW4CUJZJHU3U3ZO4IH2CLOY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The "Speaker Volume" control was being defined using four hardcoded magic
numbers. There are #defines in the cs35l56.h header for these numbers, so
change the code to use the defined constants.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 7cac9812f5b5..84c34f5b1a51 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -71,7 +71,11 @@ static const struct snd_kcontrol_new cs35l56_controls[] = {
 		       cs35l56_dspwait_get_volsw, cs35l56_dspwait_put_volsw),
 	SOC_SINGLE_S_EXT_TLV("Speaker Volume",
 			     CS35L56_MAIN_RENDER_USER_VOLUME,
-			     6, -400, 400, 9, 0,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_SHIFT,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_MIN,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_MAX,
+			     CS35L56_MAIN_RENDER_USER_VOLUME_SIGNBIT,
+			     0,
 			     cs35l56_dspwait_get_volsw,
 			     cs35l56_dspwait_put_volsw,
 			     vol_tlv),
-- 
2.39.2

