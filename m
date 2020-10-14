Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B401C433E7
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:59:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA41212CC
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eRT3ZtyG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="eoVgEewy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA41212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFFBE1705;
	Wed, 14 Oct 2020 16:58:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFFBE1705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602687544;
	bh=ox6QdeShtbWGwf5pNYcNdJm9bsR70QfgSHQzDyeBshg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eRT3ZtyGqWIqAN9+70gxvhH3tSchoMvWBAGpl64kxXJlrC7S27Er7L2dWEHuSFiHZ
	 NCi7qsrrERbsU+GbMw+pOYs48eP6d4zKOwUlB2plI1OebYZyMQz79bfGtIOBG+arCn
	 iS2OQ9tI7M3YBlGBDEyd1BKmNuQUiYN8WB5Ksyng=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EA52F802D6;
	Wed, 14 Oct 2020 16:54:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA8F4F80296; Wed, 14 Oct 2020 16:54:53 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B32BF8021D
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 16:54:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B32BF8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="eoVgEewy"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 09EEpi86023902; Wed, 14 Oct 2020 09:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=NbuRtoi+iQyrOz1VZGTizLtn/VqJReoSWynFwYIAIsg=;
 b=eoVgEewyMaXaPElcE4qhIUvMuRcZHJuuzgblZ+UkA86T1S/gZhRKUffDAXAeleIf0CF8
 L8L3cU0f/xNQdb0OLghok3s/r5Gz2Qwzn5LrUNNFXks2k0118VgbZNHD1qD3454kg6Rt
 4q/s8xWICQToAPa3VzF/J1GdeKV8+iqbhuLSAQDlWVolIhX7Ud+3iJKFdTaPWO/giwrP
 sznPTYgpWqSw3hUv9AC9jwrayCAuFjRUQY2wCyIimYTsGTDFIZCeVj362t22otN/h0Lk
 Gdt9WaldBuj7RdNBpDs7PrKIfqFIKOoH6CxDuZLST0EXYDJzNzwL7G+1eAY7zJo8q4jp TQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 343ac1wbwc-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 14 Oct 2020 09:54:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 14 Oct
 2020 15:54:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 14 Oct 2020 15:54:36 +0100
Received: from AUSNPC0LSNW1-debian.ad.cirrus.com (ausnpc0lsnw1.ad.cirrus.com
 [198.61.64.143])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A1FEE2AA;
 Wed, 14 Oct 2020 14:54:35 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <nsaenzjulienne@suse.de>
Subject: [PATCH 7/7] MAINTAINERS: Add dts for Cirrus Logic Lochnagar on RPi4
Date: Wed, 14 Oct 2020 15:54:18 +0100
Message-ID: <20201014145418.31838-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014145418.31838-1-rf@opensource.cirrus.com>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140108
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

Update the Cirrus Logic driver maintainers to include the device
tree .dts for using the Lochnagar with a Raspberry Pi 4.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87ceaac748a4..09bc583a5b2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4199,6 +4199,7 @@ M:	Charles Keepax <ckeepax@opensource.cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
 L:	patches@opensource.cirrus.com
 S:	Supported
+F:	arch/arm/boot/dts/bcm2711-rpi4b-cirrus-lochnagar.dts
 F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
 F:	Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml
 F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
-- 
2.20.1

