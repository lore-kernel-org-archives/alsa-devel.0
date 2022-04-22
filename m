Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DEEC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Apr 2022 16:03:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 337B71749;
	Fri, 22 Apr 2022 18:02:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 337B71749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650643385;
	bh=AgtVY1LcImSDudnZMCP3+IjMV9+Ll6qOe7VQW183kyc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eoR9QyilHRHu5v14UkzeWA4z+mT3f5Hd3WDFmlmbEOGQjpvN82dvKXbVPsoOE4+TY
	 PEb+z8aN0PjtKLMXN3kWQz4cO3xbeJNDliJ9FMcfon5kzT5G2VVV+2fKI4Bfz7N7vy
	 IUXlzyre5vo7i9fhj0ldudmNbx+UqRqLwJDE1uVs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCED6F80134;
	Fri, 22 Apr 2022 18:01:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1195CF804F3; Fri, 22 Apr 2022 18:01:43 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B913F80125
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2022 18:01:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B913F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="LKm5tRjT"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MEIxDC004439;
 Fri, 22 Apr 2022 11:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=B+fAVScuRJvjR0vYP6PQpK/WVXd6VhFizgRnHYQuDNE=;
 b=LKm5tRjTpKaqMaxvnR3jOFrFaz7XfJW588D+zygNYxbEgQdXq7nlTOe3F5jSuhuLdkwp
 oGapUOgF48xc2n4K8EdCYZ8ZXLuWX+o/dgYHOeGQ0WdGuLib+b9sE2FHzUUT2DDS0V/1
 NrI+wHgZOzwDE4S4fe9K3iLBM+V5Fl9VNOlusIqHa0geJIe7EYaLjCxXCQyep98dddXu
 2juTR5yoOH5TC16HMc1gIOPa4kaBTW5ddNeWxdrhHUuowc5Kekpj4VYaAYELTxuWifLC
 GFKnKSN2KEpnsUZtqxts7oI7393tVCo8xAs6+pt60vtr8sY6ici+VperSZRQh7EIxFg6 MQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ffu70qb7b-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 22 Apr 2022 11:01:33 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 17:01:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Fri, 22 Apr 2022 17:01:19 +0100
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com
 [198.90.251.83])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CA23011D1;
 Fri, 22 Apr 2022 16:01:19 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: soc.h: Add SOC_SINGLE_S_EXT_TLV macro
Date: Fri, 22 Apr 2022 17:01:12 +0100
Message-ID: <20220422160112.3026542-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422160112.3026542-1-rf@opensource.cirrus.com>
References: <20220422160112.3026542-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZXsbG9M06rpT03qW-SFxDZZ5mPh0SxKv
X-Proofpoint-GUID: ZXsbG9M06rpT03qW-SFxDZZ5mPh0SxKv
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org
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

Add a SOC_SINGLE_S_EXT_TLV macro as a convenience wrapper
around SOC_DOUBLE_R_S_EXT_TLV for mono volume controls.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/soc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8368b69dfef8..f906e5a70830 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -293,6 +293,12 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_DOUBLE_R_S_VALUE(reg_left, reg_right, xshift, \
 					      xmin, xmax, xsign_bit, xinvert) }
+#define SOC_SINGLE_S_EXT_TLV(xname, xreg, xshift, xmin, xmax, \
+			     xsign_bit, xinvert, xhandler_get, xhandler_put, \
+			     tlv_array) \
+	SOC_DOUBLE_R_S_EXT_TLV(xname, xreg, xreg, xshift, xmin, xmax, \
+			       xsign_bit, xinvert, xhandler_get, xhandler_put, \
+			       tlv_array)
 #define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_bool_ext, \
-- 
2.30.2

