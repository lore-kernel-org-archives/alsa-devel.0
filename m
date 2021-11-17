Return-Path: <SRS0=ac5z=QE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9D7C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Nov 2021 13:27:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC5A61547
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Nov 2021 13:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EC5A61547
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10A7D18EF;
	Wed, 17 Nov 2021 14:26:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10A7D18EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637155618;
	bh=Az+FANuxkiRncwA1GTpUZQp4gvXNmhRAC3jkADYM+To=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k5IvSgHqV7TEViGnDeTGjB44DTxYF4FZ9zybja1LC2sGdQuREy4ruXluNVvWkj89k
	 Yg4mojC3Og6mTHCC467Iel+AkbHH5Ff1t5YaGw+jI5lP1xwxQj8Ip++nuHhkDxhypV
	 F8yixYUjpKJWDlpHdnAzP7d/2Se23CuMClFd+OL0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE36BF80524;
	Wed, 17 Nov 2021 14:23:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF26AF8051D; Wed, 17 Nov 2021 14:23:27 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E98CBF804BB
 for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2021 14:23:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E98CBF804BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="WblpsxbW"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AH4qhZd020405;
 Wed, 17 Nov 2021 07:23:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=yHc5l3+auSKkr5tL9aYk+lBzV8TZVhy1kR4vTylzKng=;
 b=WblpsxbWU6Y4cCAODTR8eyngH0Rkw97UXq9JCFoSaPOipdHa75EevnB3xMyltRiUkKgU
 9DIU3D+Af5PzrfN5Xsfc1KoGEx1QpQZdrM2Sl5RhUaep3c93erRn2G+YQW/O9J572r+8
 uLqVKe6sGctDZQvDdGFGzKOREOarCA130GwblZBPkab536TdhTVq8fn27LbuQZeQgjix
 pLJiBMiXn6K9k/WI4K0CiUb8+uHehwEhEKvQ9vdWxvUXpM8rBCybKtkuy9homtAjFeqh
 YkD5kd6MDbF05KGaee9QoC0M7JY97PTHgREZIJa3qPHNqIlvYfFzH8Ciz005ujhZ0/hA TA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ccgtn14sf-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 17 Nov 2021 07:23:04 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 13:23:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Wed, 17 Nov 2021 13:23:00 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D52D046D;
 Wed, 17 Nov 2021 13:23:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH v2 08/10] firmware: cs_dsp: Clarify some kernel doc comments
Date: Wed, 17 Nov 2021 13:22:58 +0000
Message-ID: <20211117132300.1290-8-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211117132300.1290-1-ckeepax@opensource.cirrus.com>
References: <20211117132300.1290-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: sjxtY13CWL5hvp5DRcgtah4hr0ObFiVy
X-Proofpoint-ORIG-GUID: sjxtY13CWL5hvp5DRcgtah4hr0ObFiVy
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com
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

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c       | 4 ++--
 include/linux/firmware/cirrus/cs_dsp.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 9eecd16265375..d1bcade2efe23 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -746,7 +746,7 @@ static int cs_dsp_coeff_write_ctrl_raw(struct cs_dsp_coeff_ctl *ctl,
  * cs_dsp_coeff_write_ctrl() - Writes the given buffer to the given coefficient control
  * @ctl: pointer to coefficient control
  * @buf: the buffer to write to the given control
- * @len: the length of the buffer
+ * @len: the length of the buffer in bytes
  *
  * Must be called with pwr_lock held.
  *
@@ -808,7 +808,7 @@ static int cs_dsp_coeff_read_ctrl_raw(struct cs_dsp_coeff_ctl *ctl, void *buf, s
  * cs_dsp_coeff_read_ctrl() - Reads the given coefficient control into the given buffer
  * @ctl: pointer to coefficient control
  * @buf: the buffer to store to the given control
- * @len: the length of the buffer
+ * @len: the length of the buffer in bytes
  *
  * Must be called with pwr_lock held.
  *
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 0bf849baeaa5a..1ad1b173417a0 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -76,8 +76,8 @@ struct cs_dsp_alg_region {
  * @enabled:		Flag indicating whether control is enabled
  * @list:		List node for internal use
  * @cache:		Cached value of the control
- * @offset:		Offset of control within alg_region
- * @len:		Length of the cached value
+ * @offset:		Offset of control within alg_region in words
+ * @len:		Length of the cached value in bytes
  * @set:		Flag indicating the value has been written by the user
  * @flags:		Bitfield of WMFW_CTL_FLAG_ control flags defined in wmfw.h
  * @type:		One of the WMFW_CTL_TYPE_ control types defined in wmfw.h
-- 
2.11.0

