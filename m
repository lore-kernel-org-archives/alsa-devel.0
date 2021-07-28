Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649A2C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 13:48:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF30560F45
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 13:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF30560F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E3A618F8;
	Wed, 28 Jul 2021 15:47:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E3A618F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627480122;
	bh=Qtx13gGv2wCvBCe2VvGz9EbhOm52TgN8TYbO6R6iXS8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JopRttQLByKvc0cEcATs0h9/Sp0lM0O+remRkv3h8S3LiOkIO+dyz3ohjIhCz9WvZ
	 JN5CUXsW3EwH+1PXOwX8Pt+v2TYPGsTM3GGp7adQLGK2WKpATxBFMzF9l9hSvsPuPX
	 hC7ktfQfA8QVs8KOZjeXV0FuRjZ1vwDBbQiJsoMM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76FC1F8052E;
	Wed, 28 Jul 2021 15:45:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6DE8AF8051B; Wed, 28 Jul 2021 15:44:55 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68051F804CF
 for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2021 15:44:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68051F804CF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="cmnmoIGH"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16S5XUqo014335; 
 Wed, 28 Jul 2021 08:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=YdllO4dOaVEcV4spblJnXSctk/p1jkPBosuasafeUk0=;
 b=cmnmoIGHz09eBEXeRrWGh6XLI8tyY2J0DYBIHJXPTlglWh3sQ6XR2A01r7oPT2uDZJ7c
 V9Xt4Y+xX/P5JiMRxkJZpTpc7NJOhXJ1eStQfpThsNwU1iCfWYbC7WvB5EG2WkMyFplz
 eYBXgotr0NTaY5wArXtSW9FRLM+hRejwEfl/bq0USWruZ7u65aNp0Uz/EM44Qb/fN/3J
 NwA4VCNWx0FR7mnofr4+sUjnjfu0HYyPvboatVyrtGQOKwNj9WVd+m3vQoGGTWWjO5jN
 fx+VLypXmve2cztbNkrRDCismIf5sBzd0Tpfl7zJCUo0iSBegFrJbz30jA8SXS1URYBY pA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3a30q20fxa-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 28 Jul 2021 08:44:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Jul
 2021 14:44:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 28 Jul 2021 14:44:34 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 332EE46E;
 Wed, 28 Jul 2021 13:44:34 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 14/27] ALSA: hda/cs8409: Avoid setting the same I2C address
 for every access
Date: Wed, 28 Jul 2021 14:43:55 +0100
Message-ID: <20210728134408.369396-15-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
References: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dvLHFuyTpjtZeHLHgaoGObBWE5-mHP0t
X-Proofpoint-GUID: dvLHFuyTpjtZeHLHgaoGObBWE5-mHP0t
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=996 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280077
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Lucas Tanure <tanureal@opensource.cirrus.com>
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

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Changes in v2:
- No changes

---
 sound/pci/hda/patch_cs8409.c | 19 +++++++++++++++++--
 sound/pci/hda/patch_cs8409.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index fafc0f309e70..bd43c42d5c74 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -132,6 +132,21 @@ static int cs8409_i2c_wait_complete(struct hda_codec *codec)
 	return -1;
 }
 
+/**
+ * cs8409_set_i2c_dev_addr - Set i2c address for transaction
+ * @codec: the codec instance
+ * @addr: I2C Address
+ */
+static void cs8409_set_i2c_dev_addr(struct hda_codec *codec, unsigned int addr)
+{
+	struct cs8409_spec *spec = codec->spec;
+
+	if (spec->dev_addr != addr) {
+		cs8409_vendor_coef_set(codec, CS8409_I2C_ADDR, addr);
+		spec->dev_addr = addr;
+	}
+}
+
 /**
  * cs8409_i2c_read - CS8409 I2C Read.
  * @codec: the codec instance
@@ -153,7 +168,7 @@ static int cs8409_i2c_read(struct hda_codec *codec, unsigned int i2c_address, un
 		return -EPERM;
 
 	cs8409_enable_i2c_clock(codec);
-	cs8409_vendor_coef_set(codec, CS8409_I2C_ADDR, i2c_address);
+	cs8409_set_i2c_dev_addr(codec, i2c_address);
 
 	if (paged) {
 		cs8409_vendor_coef_set(codec, CS8409_I2C_QWRITE, i2c_reg >> 8);
@@ -199,7 +214,7 @@ static int cs8409_i2c_write(struct hda_codec *codec, unsigned int i2c_address, u
 		return -EPERM;
 
 	cs8409_enable_i2c_clock(codec);
-	cs8409_vendor_coef_set(codec, CS8409_I2C_ADDR, i2c_address);
+	cs8409_set_i2c_dev_addr(codec, i2c_address);
 
 	if (paged) {
 		cs8409_vendor_coef_set(codec, CS8409_I2C_QWRITE, i2c_reg >> 8);
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 542582c213d2..c2c208218e34 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -281,6 +281,7 @@ struct cs8409_spec {
 
 	struct mutex cs8409_i2c_mux;
 	unsigned int i2c_clck_enabled;
+	unsigned int dev_addr;
 	struct delayed_work i2c_clk_work;
 
 	/* verb exec op override */
-- 
2.25.1

